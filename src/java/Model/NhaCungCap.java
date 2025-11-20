package Model;

public class NhaCungCap {
    private int maNCC;
    private String tenNCC;
    private String thongTinLienHe;

    public NhaCungCap() {
    }

    public NhaCungCap(int maNCC, String tenNCC, String thongTinLienHe) {
        this.maNCC = maNCC;
        this.tenNCC = tenNCC;
        this.thongTinLienHe = thongTinLienHe;
    }

    public int getMaNCC() {
        return maNCC;
    }

    public void setMaNCC(int maNCC) {
        this.maNCC = maNCC;
    }

    public String getTenNCC() {
        return tenNCC;
    }

    public void setTenNCC(String tenNCC) {
        this.tenNCC = tenNCC;
    }

    public String getThongTinLienHe() {
        return thongTinLienHe;
    }

    public void setThongTinLienHe(String thongTinLienHe) {
        this.thongTinLienHe = thongTinLienHe;
    }

    @Override
    public String toString() {
        return tenNCC;
    }
}
