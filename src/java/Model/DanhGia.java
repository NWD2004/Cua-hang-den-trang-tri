package Model;

import java.time.LocalDateTime;

public class DanhGia {
    private int maDG;
    private int maND;
    private int maDen;
    private int soSao;
    private String binhLuan;
    private LocalDateTime ngayDanhGia;

    public DanhGia() {
    }

    public DanhGia(int maDG, int maND, int maDen, int soSao, String binhLuan, LocalDateTime ngayDanhGia) {
        this.maDG = maDG;
        this.maND = maND;
        this.maDen = maDen;
        this.soSao = soSao;
        this.binhLuan = binhLuan;
        this.ngayDanhGia = ngayDanhGia;
    }

    public int getMaDG() {
        return maDG;
    }

    public void setMaDG(int maDG) {
        this.maDG = maDG;
    }

    public int getMaND() {
        return maND;
    }

    public void setMaND(int maND) {
        this.maND = maND;
    }

    public int getMaDen() {
        return maDen;
    }

    public void setMaDen(int maDen) {
        this.maDen = maDen;
    }

    public int getSoSao() {
        return soSao;
    }

    public void setSoSao(int soSao) {
        this.soSao = soSao;
    }

    public String getBinhLuan() {
        return binhLuan;
    }

    public void setBinhLuan(String binhLuan) {
        this.binhLuan = binhLuan;
    }

    public LocalDateTime getNgayDanhGia() {
        return ngayDanhGia;
    }

    public void setNgayDanhGia(LocalDateTime ngayDanhGia) {
        this.ngayDanhGia = ngayDanhGia;
    }
}
