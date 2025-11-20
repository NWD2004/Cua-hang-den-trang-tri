package DAO;

import Model.KichThuoc;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class KichThuocDAO {

    public List<KichThuoc> getAll() {
        List<KichThuoc> list = new ArrayList<>();
        String sql = "SELECT * FROM kich_thuoc";
        try (Connection conn = DBConnect.getConnection(); Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new KichThuoc(
                        rs.getInt("ma_kich_thuoc"),
                        rs.getString("ten_kich_thuoc")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public KichThuoc getById(int maKichThuoc) {
        String sql = "SELECT * FROM kich_thuoc WHERE ma_kich_thuoc=?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maKichThuoc);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new KichThuoc(
                        rs.getInt("ma_kich_thuoc"),
                        rs.getString("ten_kich_thuoc")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean insert(KichThuoc k) {
        String sql = "INSERT INTO kich_thuoc(ten_kich_thuoc) VALUES(?)";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, k.getTenKichThuoc());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Lỗi thêm kích thước: " + e.getMessage());
            return false;
        }
    }

    public boolean update(KichThuoc k) {
        String sql = "UPDATE kich_thuoc SET ten_kich_thuoc=? WHERE ma_kich_thuoc=?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, k.getTenKichThuoc());
            ps.setInt(2, k.getMaKichThuoc());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Lỗi cập nhật kích thước: " + e.getMessage());
            return false;
        }
    }

    public boolean delete(int maKichThuoc) {
        String sql = "DELETE FROM kich_thuoc WHERE ma_kich_thuoc=?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maKichThuoc);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("⚠️ Không thể xóa kích thước đang được sử dụng trong biến thể đèn.");
            return false;
        }
    }

    public String getTenKichThuocById(int maKichThuoc) {
        String ten = null;
        String sql = "SELECT ten_kich_thuoc FROM kich_thuoc WHERE ma_kich_thuoc = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maKichThuoc);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ten = rs.getString("ten_kich_thuoc");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ten != null ? ten : "-";
    }
}
