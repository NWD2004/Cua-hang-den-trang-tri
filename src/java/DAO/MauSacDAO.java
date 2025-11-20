package DAO;

import Model.MauSac;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MauSacDAO {

    public List<MauSac> getAll() {
        List<MauSac> list = new ArrayList<>();
        String sql = "SELECT * FROM mau_sac";
        try (Connection conn = DBConnect.getConnection(); Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new MauSac(
                        rs.getInt("ma_mau"),
                        rs.getString("ten_mau"),
                        rs.getString("ma_hex")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public MauSac getById(int maMau) {
        String sql = "SELECT * FROM mau_sac WHERE ma_mau=?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maMau);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new MauSac(
                        rs.getInt("ma_mau"),
                        rs.getString("ten_mau"),
                        rs.getString("ma_hex")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean insert(MauSac m) {
        String sql = "INSERT INTO mau_sac(ten_mau, ma_hex) VALUES(?, ?)";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, m.getTenMau());
            ps.setString(2, m.getMaHex());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Lỗi thêm màu sắc: " + e.getMessage());
            return false;
        }
    }

    public boolean update(MauSac m) {
        String sql = "UPDATE mau_sac SET ten_mau=?, ma_hex=? WHERE ma_mau=?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, m.getTenMau());
            ps.setString(2, m.getMaHex());
            ps.setInt(3, m.getMaMau());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Lỗi cập nhật màu sắc: " + e.getMessage());
            return false;
        }
    }

    public boolean delete(int maMau) {
        String sql = "DELETE FROM mau_sac WHERE ma_mau=?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maMau);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("⚠️ Không thể xóa màu đang được sử dụng ở biến thể đèn.");
            return false;
        }
    }

    public String getTenMauById(int maMau) {
        String ten = null;
        String sql = "SELECT ten_mau FROM mau_sac WHERE ma_mau = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maMau);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ten = rs.getString("ten_mau");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ten != null ? ten : "-";
    }
}
