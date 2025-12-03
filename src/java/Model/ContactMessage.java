package Model;

import java.time.LocalDateTime;

public class ContactMessage {
    private int maTinNhan;
    private String hoTen;
    private String soDienThoai;
    private String email;
    private String chuDe;
    private String noiDung;
    private LocalDateTime ngayGui;
    private boolean daDoc;

    public ContactMessage() {
    }

    public ContactMessage(int maTinNhan, String hoTen, String soDienThoai, String email, 
                         String chuDe, String noiDung, LocalDateTime ngayGui, boolean daDoc) {
        this.maTinNhan = maTinNhan;
        this.hoTen = hoTen;
        this.soDienThoai = soDienThoai;
        this.email = email;
        this.chuDe = chuDe;
        this.noiDung = noiDung;
        this.ngayGui = ngayGui;
        this.daDoc = daDoc;
    }

    // Getters and Setters
    public int getMaTinNhan() {
        return maTinNhan;
    }

    public void setMaTinNhan(int maTinNhan) {
        this.maTinNhan = maTinNhan;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public String getSoDienThoai() {
        return soDienThoai;
    }

    public void setSoDienThoai(String soDienThoai) {
        this.soDienThoai = soDienThoai;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getChuDe() {
        return chuDe;
    }

    public void setChuDe(String chuDe) {
        this.chuDe = chuDe;
    }

    public String getNoiDung() {
        return noiDung;
    }

    public void setNoiDung(String noiDung) {
        this.noiDung = noiDung;
    }

    public LocalDateTime getNgayGui() {
        return ngayGui;
    }

    public void setNgayGui(LocalDateTime ngayGui) {
        this.ngayGui = ngayGui;
    }

    public boolean isDaDoc() {
        return daDoc;
    }

    public void setDaDoc(boolean daDoc) {
        this.daDoc = daDoc;
    }
}

