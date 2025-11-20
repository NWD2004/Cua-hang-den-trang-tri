package Model;

public class KichThuoc {
    private int maKichThuoc;
    private String tenKichThuoc;

    public KichThuoc() {
    }

    public KichThuoc(int maKichThuoc, String tenKichThuoc) {
        this.maKichThuoc = maKichThuoc;
        this.tenKichThuoc = tenKichThuoc;
    }

    public int getMaKichThuoc() {
        return maKichThuoc;
    }

    public void setMaKichThuoc(int maKichThuoc) {
        this.maKichThuoc = maKichThuoc;
    }

    public String getTenKichThuoc() {
        return tenKichThuoc;
    }

    public void setTenKichThuoc(String tenKichThuoc) {
        this.tenKichThuoc = tenKichThuoc;
    }

    @Override
    public String toString() {
        return tenKichThuoc;
    }
}
