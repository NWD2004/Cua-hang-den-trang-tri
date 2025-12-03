package Model;

import java.time.LocalDateTime;

public class PasswordResetToken {
    private int tokenId;
    private int userId;
    private String code;
    private LocalDateTime expiresAt;
    private boolean verified;
    private boolean used;
    private LocalDateTime createdAt;

    public PasswordResetToken() {
    }

    public PasswordResetToken(int tokenId, int userId, String code, LocalDateTime expiresAt,
                              boolean verified, boolean used, LocalDateTime createdAt) {
        this.tokenId = tokenId;
        this.userId = userId;
        this.code = code;
        this.expiresAt = expiresAt;
        this.verified = verified;
        this.used = used;
        this.createdAt = createdAt;
    }

    public int getTokenId() {
        return tokenId;
    }

    public void setTokenId(int tokenId) {
        this.tokenId = tokenId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public LocalDateTime getExpiresAt() {
        return expiresAt;
    }

    public void setExpiresAt(LocalDateTime expiresAt) {
        this.expiresAt = expiresAt;
    }

    public boolean isVerified() {
        return verified;
    }

    public void setVerified(boolean verified) {
        this.verified = verified;
    }

    public boolean isUsed() {
        return used;
    }

    public void setUsed(boolean used) {
        this.used = used;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}


