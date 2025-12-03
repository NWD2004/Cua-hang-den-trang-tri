package Service;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletContext;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.util.Properties;

public class EmailService {
    private final String host;
    private final String port;
    private final String username;
    private final String password;
    private final String fromName;

    public EmailService(ServletContext context) {
        this.host = getConfig(context, "mail.smtp.host", "smtp.gmail.com");
        this.port = getConfig(context, "mail.smtp.port", "587");
        this.username = getConfig(context, "mail.smtp.username", null);
        this.password = getConfig(context, "mail.smtp.password", null);
        this.fromName = getConfig(context, "mail.from.name", "LightStore Support");

        if (this.username == null || this.password == null) {
            throw new IllegalStateException("Thiếu cấu hình email SMTP. Vui lòng thiết lập username/password trong web.xml hoặc biến môi trường.");
        }
    }

    private String getConfig(ServletContext context, String key, String defaultValue) {
        String value = context.getInitParameter(key);
        if (value == null || value.isEmpty()) {
            value = System.getenv(key.toUpperCase().replace('.', '_'));
        }
        return value != null ? value : defaultValue;
    }

    public void sendPasswordResetCode(String toEmail, String code) throws MessagingException {
        String subject = "Mã xác thực đổi mật khẩu LightStore";
        String content = buildPasswordResetContent(code);
        sendHtmlEmail(toEmail, subject, content);
    }

    private String buildPasswordResetContent(String code) {
        return "<div style=\"font-family: Arial, sans-serif; line-height: 1.6; color: #1a1a1a;\">"
                + "<h2 style=\"color:#ffb300;\">Xin chào từ LightStore! 🔐</h2>"
                + "<p>Chúng tôi nhận được yêu cầu đổi mật khẩu cho tài khoản của bạn. "
                + "Hãy nhập mã xác thực dưới đây để tiếp tục:</p>"
                + "<div style=\"text-align:center; margin:30px 0;\">"
                + "<span style=\"display:inline-block;padding:16px 32px;font-size:28px;font-weight:700;"
                + "letter-spacing:6px;border-radius:12px;background:#1a1a1a;color:#ffd700;\">"
                + code + "</span></div>"
                + "<p>Mã có hiệu lực trong <strong>10 phút</strong>. "
                + "Nếu bạn không thực hiện yêu cầu này, hãy bỏ qua email.</p>"
                + "<p>Trân trọng,<br/>Đội ngũ LightStore</p>"
                + "</div>";
    }

    private void sendHtmlEmail(String toEmail, String subject, String htmlContent) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        MimeMessage message = new MimeMessage(session);
        try {
            message.setFrom(new InternetAddress(username, fromName, StandardCharsets.UTF_8.name()));
        } catch (UnsupportedEncodingException e) {
            message.setFrom(new InternetAddress(username));
        }
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(subject, StandardCharsets.UTF_8.name());
        message.setContent(htmlContent, "text/html; charset=UTF-8");

        Transport.send(message);
    }
}


