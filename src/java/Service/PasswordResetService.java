package Service;

import DAO.NguoiDungDAO;
import DAO.PasswordResetTokenDAO;
import Model.NguoiDung;
import Model.PasswordResetToken;
import jakarta.mail.MessagingException;
import jakarta.servlet.ServletContext;
import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.util.Optional;

public class PasswordResetService {
    private final NguoiDungDAO nguoiDungDAO;
    private final PasswordResetTokenDAO tokenDAO;
    private final EmailService emailService;
    private final SecureRandom secureRandom = new SecureRandom();

    public PasswordResetService(ServletContext context) {
        this.nguoiDungDAO = new NguoiDungDAO();
        this.tokenDAO = new PasswordResetTokenDAO();
        this.emailService = new EmailService(context);
    }

    public PasswordResetToken startResetFlow(String email) throws Exception {
        NguoiDung user = nguoiDungDAO.getByEmail(email);
        if (user == null) {
            throw new IllegalArgumentException("Email chưa được đăng ký trong hệ thống.");
        }
        tokenDAO.invalidateActiveTokens(user.getMaND());
        String code = generateVerificationCode();
        LocalDateTime expiresAt = LocalDateTime.now().plusMinutes(10);
        PasswordResetToken token = tokenDAO.createToken(user.getMaND(), code, expiresAt);
        try {
            emailService.sendPasswordResetCode(email, code);
        } catch (MessagingException ex) {
            throw new IllegalStateException("Không thể gửi email xác thực. Vui lòng thử lại sau.", ex);
        }
        return token;
    }

    public PasswordResetToken verifyCode(String email, String code) throws Exception {
        NguoiDung user = nguoiDungDAO.getByEmail(email);
        if (user == null) {
            throw new IllegalArgumentException("Email không hợp lệ.");
        }
        Optional<PasswordResetToken> tokenOpt = tokenDAO.findByUserAndCode(user.getMaND(), code);
        PasswordResetToken token = tokenOpt.orElseThrow(() ->
                new IllegalArgumentException("Mã xác thực không đúng hoặc đã được sử dụng."));

        if (token.isUsed()) {
            throw new IllegalStateException("Mã xác thực đã được dùng. Vui lòng yêu cầu mã mới.");
        }
        if (token.getExpiresAt().isBefore(LocalDateTime.now())) {
            tokenDAO.markUsed(token.getTokenId());
            throw new IllegalStateException("Mã xác thực đã hết hạn. Vui lòng yêu cầu mã mới.");
        }
        tokenDAO.markVerified(token.getTokenId());
        return token;
    }

    public void resetPassword(int tokenId, String newPassword) throws Exception {
        PasswordResetToken token = tokenDAO.findById(tokenId).orElseThrow(() ->
                new IllegalStateException("Phiên đặt lại mật khẩu không hợp lệ."));

        if (token.isUsed()) {
            throw new IllegalStateException("Token đã được sử dụng.");
        }
        if (!token.isVerified()) {
            throw new IllegalStateException("Bạn chưa xác thực mã OTP.");
        }
        if (token.getExpiresAt().isBefore(LocalDateTime.now())) {
            tokenDAO.markUsed(token.getTokenId());
            throw new IllegalStateException("Mã xác thực đã hết hạn. Vui lòng yêu cầu mã mới.");
        }

        boolean updated = nguoiDungDAO.updatePassword(token.getUserId(), newPassword);
        if (!updated) {
            throw new IllegalStateException("Không thể cập nhật mật khẩu. Vui lòng thử lại.");
        }
        tokenDAO.markUsed(token.getTokenId());
    }

    private String generateVerificationCode() {
        int number = secureRandom.nextInt(999_999);
        return String.format("%06d", number);
    }
}


