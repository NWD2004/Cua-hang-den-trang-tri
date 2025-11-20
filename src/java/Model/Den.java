package Model;

public class Den {
    private int maDen;
    private String tenDen;
    private int maLoai;
    private Integer maNCC;
    private String moTa;
    private double gia;
    private String hinhAnh;

    public Den() {
    }

    public Den(int maDen, String tenDen, int maLoai, Integer maNCC, String moTa, double gia, String hinhAnh) {
        this.maDen = maDen;
        this.tenDen = tenDen;
        this.maLoai = maLoai;
        this.maNCC = maNCC;
        this.moTa = moTa;
        this.gia = gia;
        this.hinhAnh = hinhAnh;
    }

    public int getMaDen() {
        return maDen;
    }

    public void setMaDen(int maDen) {
        this.maDen = maDen;
    }

    public String getTenDen() {
        return tenDen;
    }

    public void setTenDen(String tenDen) {
        this.tenDen = tenDen;
    }

    public int getMaLoai() {
        return maLoai;
    }

    public void setMaLoai(int maLoai) {
        this.maLoai = maLoai;
    }

    public Integer getMaNCC() {
        return maNCC;
    }

    public void setMaNCC(Integer maNCC) {
        this.maNCC = maNCC;
    }

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }

    public double getGia() {
        return gia;
    }

    public void setGia(double gia) {
        this.gia = gia;
    }

    public String getHinhAnh() {
        return hinhAnh;
    }

    public void setHinhAnh(String hinhAnh) {
        this.hinhAnh = hinhAnh;
    }

    @Override
    public String toString() {
        return tenDen;
    }
}
