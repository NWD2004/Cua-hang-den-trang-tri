package Model;

public class MauSac {
    private int maMau;
    private String tenMau;
    private String maHex;

    public MauSac() {
    }

    public MauSac(int maMau, String tenMau, String maHex) {
        this.maMau = maMau;
        this.tenMau = tenMau;
        this.maHex = maHex;
    }

    public int getMaMau() {
        return maMau;
    }

    public void setMaMau(int maMau) {
        this.maMau = maMau;
    }

    public String getTenMau() {
        return tenMau;
    }

    public void setTenMau(String tenMau) {
        this.tenMau = tenMau;
    }

    public String getMaHex() {
        return maHex;
    }

    public void setMaHex(String maHex) {
        this.maHex = maHex;
    }

    @Override
    public String toString() {
        return tenMau;
    }
}
