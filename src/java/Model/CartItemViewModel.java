package Model;

/**
 * ViewModel cho Cart Item
 * Kết hợp thông tin từ:
 * - Den (sản phẩm chính): hình ảnh, mô tả, giá, tên sản phẩm
 * - BienTheDen (biến thể): màu sắc, kích thước
 * - MauSac, KichThuoc: tên màu, tên kích thước
 * - GioHangItem: số lượng, maBienThe
 */
public class CartItemViewModel {
    // Từ GioHangItem
    private int maDen;
    private Integer maBienThe; // Bắt buộc phải có
    private int soLuong;
    
    // Từ Den (sản phẩm chính)
    private String tenDen;
    private String hinhAnh;
    private String moTa;
    private double gia;
    
    // Từ BienTheDen (biến thể)
    private Integer maMau;
    private Integer maKichThuoc;
    
    // Từ MauSac và KichThuoc
    private String tenMau;
    private String tenKichThuoc;
    private String maHex; // Mã màu hex để hiển thị
    
    // Key để quản lý trong giỏ hàng
    private String key;

    public CartItemViewModel() {
    }

    public CartItemViewModel(GioHangItem item, Den product, BienTheDen variant, MauSac mau, KichThuoc kichThuoc) {
        // Từ GioHangItem
        this.maDen = item.getMaDen();
        this.maBienThe = item.getMaBienThe();
        this.soLuong = item.getSoLuong();
        this.key = item.getKey();
        
        // Từ Den (sản phẩm chính)
        if (product != null) {
            this.tenDen = product.getTenDen();
            this.hinhAnh = product.getHinhAnh();
            this.moTa = product.getMoTa();
            this.gia = product.getGia();
        }
        
        // Từ BienTheDen (biến thể)
        if (variant != null) {
            this.maMau = variant.getMaMau();
            this.maKichThuoc = variant.getMaKichThuoc();
        }
        
        // Từ MauSac
        if (mau != null) {
            this.tenMau = mau.getTenMau();
            this.maHex = mau.getMaHex();
        }
        
        // Từ KichThuoc
        if (kichThuoc != null) {
            this.tenKichThuoc = kichThuoc.getTenKichThuoc();
        }
    }

    // Getters và Setters
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

    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
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

    public String getMaHex() {
        return maHex;
    }

    public void setMaHex(String maHex) {
        this.maHex = maHex;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    // Tính tổng tiền cho item này
    public double getTongTien() {
        return gia * soLuong;
    }
}

