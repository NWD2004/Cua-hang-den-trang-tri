package DAO;

import Model.PasswordResetToken;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Optional;

public class PasswordResetTokenDAO {

    public void invalidateActiveTokens(int userId) {
        String sql = "UPDATE password_reset_tokens SET used = 1 WHERE user_id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public PasswordResetToken createToken(int userId, String code, LocalDateTime expiresAt) throws SQLException {
        String sql = "INSERT INTO password_reset_tokens(user_id, code, expires_at, verified, used) VALUES(?, ?, ?, 0, 0)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userId);
            ps.setString(2, code);
            ps.setTimestamp(3, Timestamp.valueOf(expiresAt));
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    int tokenId = rs.getInt(1);
                    return new PasswordResetToken(tokenId, userId, code, expiresAt, false, false, LocalDateTime.now());
                }
            }
        }
        throw new SQLException("Không thể tạo token đặt lại mật khẩu");
    }

    public Optional<PasswordResetToken> findByUserAndCode(int userId, String code) {
        String sql = "SELECT * FROM password_reset_tokens WHERE user_id = ? AND code = ? AND used = 0 ORDER BY token_id DESC LIMIT 1";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, code);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public Optional<PasswordResetToken> findById(int tokenId) {
        String sql = "SELECT * FROM password_reset_tokens WHERE token_id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, tokenId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public void markVerified(int tokenId) {
        String sql = "UPDATE password_reset_tokens SET verified = 1 WHERE token_id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, tokenId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void markUsed(int tokenId) {
        String sql = "UPDATE password_reset_tokens SET used = 1 WHERE token_id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, tokenId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private PasswordResetToken mapRow(ResultSet rs) throws SQLException {
        LocalDateTime expiresAt = rs.getTimestamp("expires_at").toLocalDateTime();
        Timestamp createdTs = rs.getTimestamp("created_at");
        LocalDateTime createdAt = createdTs != null ? createdTs.toLocalDateTime() : null;
        return new PasswordResetToken(
                rs.getInt("token_id"),
                rs.getInt("user_id"),
                rs.getString("code"),
                expiresAt,
                rs.getBoolean("verified"),
                rs.getBoolean("used"),
                createdAt
        );
    }
}


