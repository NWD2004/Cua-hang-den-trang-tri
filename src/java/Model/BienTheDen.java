package Model;

public class BienTheDen {
    private int maBienThe;
    private int maDen;
    private Integer maMau;
    private Integer maKichThuoc;

    public BienTheDen() {
    }

    public BienTheDen(int maBienThe, int maDen, Integer maMau, Integer maKichThuoc) {
        this.maBienThe = maBienThe;
        this.maDen = maDen;
        this.maMau = maMau;
        this.maKichThuoc = maKichThuoc;
    }

    public int getMaBienThe() {
        return maBienThe;
    }

    public void setMaBienThe(int maBienThe) {
        this.maBienThe = maBienThe;
    }

    public int getMaDen() {
        return maDen;
    }

    public void setMaDen(int maDen) {
        this.maDen = maDen;
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


}
