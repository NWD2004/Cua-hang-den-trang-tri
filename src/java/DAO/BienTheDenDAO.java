package DAO;

import Model.BienTheDen;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BienTheDenDAO {

    // === LẤY TẤT CẢ BIẾN THỂ ===
    public List<BienTheDen> getAll() {
        List<BienTheDen> list = new ArrayList<>();
        String sql = "SELECT ma_bien_the, ma_den, ma_mau, ma_kich_thuoc FROM bien_the_den";

        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                BienTheDen bt = new BienTheDen();
                bt.setMaBienThe(rs.getInt("ma_bien_the"));
                bt.setMaDen(rs.getInt("ma_den"));
                bt.setMaMau(rs.getObject("ma_mau") != null ? rs.getInt("ma_mau") : null);
                bt.setMaKichThuoc(rs.getObject("ma_kich_thuoc") != null ? rs.getInt("ma_kich_thuoc") : null);
                list.add(bt);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi getAll(): " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    // === LẤY THEO ID ===
    public BienTheDen getById(int maBienThe) {
        String sql = "SELECT ma_bien_the, ma_den, ma_mau, ma_kich_thuoc FROM bien_the_den WHERE ma_bien_the = ?";

        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, maBienThe);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    BienTheDen bt = new BienTheDen();
                    bt.setMaBienThe(rs.getInt("ma_bien_the"));
                    bt.setMaDen(rs.getInt("ma_den"));
                    bt.setMaMau(rs.getObject("ma_mau") != null ? rs.getInt("ma_mau") : null);
                    bt.setMaKichThuoc(rs.getObject("ma_kich_thuoc") != null ? rs.getInt("ma_kich_thuoc") : null);
                    return bt;
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi getById(" + maBienThe + "): " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // === THÊM MỚI ===
    public boolean insert(BienTheDen b) {
        String sql = "INSERT INTO bien_the_den (ma_den, ma_mau, ma_kich_thuoc) VALUES (?, ?, ?)";

        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, b.getMaDen());
            setNullableInt(ps, 2, b.getMaMau());
            setNullableInt(ps, 3, b.getMaKichThuoc());

            int rows = ps.executeUpdate();
            System.out.println("INSERT thành công: " + rows + " dòng.");
            return rows > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi insert(): " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // === CẬP NHẬT ===
    public boolean update(BienTheDen b) {
        String sql = "UPDATE bien_the_den SET ma_den = ?, ma_mau = ?, ma_kich_thuoc = ? WHERE ma_bien_the = ?";

        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, b.getMaDen());
            setNullableInt(ps, 2, b.getMaMau());
            setNullableInt(ps, 3, b.getMaKichThuoc());
            ps.setInt(4, b.getMaBienThe());

            int rows = ps.executeUpdate();
            System.out.println("UPDATE thành công: " + rows + " dòng.");
            return rows > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi update(ma_bien_the=" + b.getMaBienThe() + "): " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // === XÓA - ĐÃ THÊM LOG DEBUG ===
    public boolean delete(int maBienThe) {
        String sql = "DELETE FROM bien_the_den WHERE ma_bien_the = ?";
        System.out.println("=== DAO DELETE DEBUG ===");
        System.out.println("DAO: Xóa biến thể mã: " + maBienThe);
        
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maBienThe);
            int result = ps.executeUpdate();
            System.out.println("DAO: Số dòng bị ảnh hưởng: " + result);
            return result > 0;
        } catch (Exception e) {
            System.err.println("DAO: Lỗi khi xóa biến thể " + maBienThe + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // === LẤY THEO MÃ ĐÈN ===
    public List<BienTheDen> getByMaDen(int maDen) {
        List<BienTheDen> list = new ArrayList<>();
        String sql = "SELECT ma_bien_the, ma_den, ma_mau, ma_kich_thuoc FROM bien_the_den WHERE ma_den = ?";
        
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maDen);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BienTheDen bt = new BienTheDen();
                    bt.setMaBienThe(rs.getInt("ma_bien_the"));
                    bt.setMaDen(rs.getInt("ma_den"));
                    bt.setMaMau(rs.getObject("ma_mau") != null ? rs.getInt("ma_mau") : null);
                    bt.setMaKichThuoc(rs.getObject("ma_kich_thuoc") != null ? rs.getInt("ma_kich_thuoc") : null);
                    list.add(bt);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi getByMaDen(" + maDen + "): " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }
    
    // === TÌM BIẾN THỂ DỰA TRÊN MÃ ĐÈN, MÀU SẮC VÀ KÍCH THƯỚC ===
    public BienTheDen findByMaDenAndVariant(int maDen, Integer maMau, Integer maKichThuoc) {
        // Xây dựng SQL query động dựa trên các tham số có giá trị
        StringBuilder sql = new StringBuilder("SELECT ma_bien_the, ma_den, ma_mau, ma_kich_thuoc FROM bien_the_den WHERE ma_den = ?");
        
        if (maMau != null) {
            sql.append(" AND ma_mau = ?");
        } else {
            sql.append(" AND ma_mau IS NULL");
        }
        
        if (maKichThuoc != null) {
            sql.append(" AND ma_kich_thuoc = ?");
        } else {
            sql.append(" AND ma_kich_thuoc IS NULL");
        }
        
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            ps.setInt(paramIndex++, maDen);
            
            if (maMau != null) {
                ps.setInt(paramIndex++, maMau);
            }
            
            if (maKichThuoc != null) {
                ps.setInt(paramIndex++, maKichThuoc);
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    BienTheDen bt = new BienTheDen();
                    bt.setMaBienThe(rs.getInt("ma_bien_the"));
                    bt.setMaDen(rs.getInt("ma_den"));
                    bt.setMaMau(rs.getObject("ma_mau") != null ? rs.getInt("ma_mau") : null);
                    bt.setMaKichThuoc(rs.getObject("ma_kich_thuoc") != null ? rs.getInt("ma_kich_thuoc") : null);
                    return bt;
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi findByMaDenAndVariant(maDen=" + maDen + ", maMau=" + maMau + ", maKichThuoc=" + maKichThuoc + "): " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    // === HÀM HỖ TRỢ: SET NULL CHO INTEGER ===
    private void setNullableInt(PreparedStatement ps, int parameterIndex, Integer value) throws SQLException {
        if (value != null) {
            ps.setInt(parameterIndex, value);
        } else {
            ps.setNull(parameterIndex, Types.INTEGER);
        }
    }
}