package Model;

import java.time.LocalDateTime;

public class KhoDen {
    private int maKho;
    private int maBienThe;
    private int soLuongNhap;
    private int soLuongBan;
    private LocalDateTime capNhatGanNhat;

    public KhoDen() {
    }

    public KhoDen(int maKho, int maBienThe, int soLuongNhap, int soLuongBan, LocalDateTime capNhatGanNhat) {
        this.maKho = maKho;
        this.maBienThe = maBienThe;
        this.soLuongNhap = soLuongNhap;
        this.soLuongBan = soLuongBan;
        this.capNhatGanNhat = capNhatGanNhat;
    }

    public int getMaKho() {
        return maKho;
    }

    public void setMaKho(int maKho) {
        this.maKho = maKho;
    }

    public int getMaBienThe() {
        return maBienThe;
    }

    public void setMaBienThe(int maBienThe) {
        this.maBienThe = maBienThe;
    }

    public int getSoLuongNhap() {
        return soLuongNhap;
    }

    public void setSoLuongNhap(int soLuongNhap) {
        this.soLuongNhap = soLuongNhap;
    }

    public int getSoLuongBan() {
        return soLuongBan;
    }

    public void setSoLuongBan(int soLuongBan) {
        this.soLuongBan = soLuongBan;
    }

    public LocalDateTime getCapNhatGanNhat() {
        return capNhatGanNhat;
    }

    public void setCapNhatGanNhat(LocalDateTime capNhatGanNhat) {
        this.capNhatGanNhat = capNhatGanNhat;
    }
}
