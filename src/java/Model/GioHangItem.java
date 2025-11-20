package Model;

public class GioHangItem {
    private int maDen;
    private Integer maBienThe; // Mã biến thể - quan trọng để xác định đúng variant
    private String tenDen;
    private String hinhAnh;
    private double gia;
    private int soLuong;
    private Integer maMau; // Có thể null
    private Integer maKichThuoc; // Có thể null
    private String tenMau; // Tên màu sắc
    private String tenKichThuoc; // Tên kích thước

    public GioHangItem() {
    }

    public GioHangItem(int maDen, String tenDen, String hinhAnh, double gia, int soLuong) {
        this.maDen = maDen;
        this.tenDen = tenDen;
        this.hinhAnh = hinhAnh;
        this.gia = gia;
        this.soLuong = soLuong;
    }

    public int getMaDen() {
        return maDen;
    }

    public void setMaDen(int maDen) {
        this.maDen = maDen;
    }

    public Integer getMaBienThe() {
        return maBienThe;
    }

    public void setMaBienThe(Integer maBienThe) {
        this.maBienThe = maBienThe;
    }

    public String getTenDen() {
        return tenDen;
    }

    public void setTenDen(String tenDen) {
        this.tenDen = tenDen;
    }

    public String getHinhAnh() {
        return hinhAnh;
    }

    public void setHinhAnh(String hinhAnh) {
        this.hinhAnh = hinhAnh;
    }

    public double getGia() {
        return gia;
    }

    public void setGia(double gia) {
        this.gia = gia;
    }

    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }

    public Integer getMaMau() {
        return maMau;
    }

    public void setMaMau(Integer maMau) {
        this.maMau = maMau;
    }

    public Integer getMaKichThuoc() {
        return maKichThuoc;
    }

    public void setMaKichThuoc(Integer maKichThuoc) {
        this.maKichThuoc = maKichThuoc;
    }

    public String getTenMau() {
        return tenMau;
    }

    public void setTenMau(String tenMau) {
        this.tenMau = tenMau;
    }

    public String getTenKichThuoc() {
        return tenKichThuoc;
    }

    public void setTenKichThuoc(String tenKichThuoc) {
        this.tenKichThuoc = tenKichThuoc;
    }

    // Tính tổng tiền cho item này
    public double getTongTien() {
        return gia * soLuong;
    }

    // Tạo key để so sánh items (để tránh trùng lặp)
    // Ưu tiên sử dụng maBienThe nếu có, nếu không thì dùng maDen_maMau_maKichThuoc
    public String getKey() {
        if (maBienThe != null) {
            return maDen + "_" + maBienThe;
        }
        return maDen + "_" + (maMau != null ? maMau : "null") + "_" + (maKichThuoc != null ? maKichThuoc : "null");
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        GioHangItem that = (GioHangItem) obj;
        return getKey().equals(that.getKey());
    }

    @Override
    public int hashCode() {
        return getKey().hashCode();
    }
}

