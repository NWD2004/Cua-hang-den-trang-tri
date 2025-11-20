package DAO;

import Model.KhoDen;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class KhoDenDAO {

    public List<KhoDen> getAll() {
        List<KhoDen> list = new ArrayList<>();
        String sql = "SELECT * FROM kho_den ORDER BY ma_kho DESC";
        try (Connection conn = DBConnect.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Timestamp ts = rs.getTimestamp("cap_nhat_gan_nhat");
                list.add(new KhoDen(
                        rs.getInt("ma_kho"),
                        rs.getInt("ma_bien_the"),
                        rs.getInt("so_luong_nhap"),
                        rs.getInt("so_luong_ban"),
                        ts != null ? ts.toLocalDateTime() : null
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insert(KhoDen k) {
        // Kiểm tra trùng mã biến thể trước khi insert
        if (isBienTheExists(k.getMaBienThe())) {
            System.err.println("Lỗi: Mã biến thể " + k.getMaBienThe() + " đã tồn tại trong kho");
            return false;
        }

        String sql = "INSERT INTO kho_den(ma_bien_the, so_luong_nhap, so_luong_ban) VALUES(?, ?, ?)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, k.getMaBienThe());
            ps.setInt(2, k.getSoLuongNhap());
            ps.setInt(3, k.getSoLuongBan());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            // Xử lý lỗi duplicate entry từ database
            if (e.getErrorCode() == 1062 || e.getMessage().contains("Duplicate entry")) {
                System.err.println("Lỗi trùng mã biến thể từ database: " + e.getMessage());
                return false;
            }
            e.printStackTrace();
            return false;
        }
    }

    public boolean update(KhoDen k) {
        // Kiểm tra trùng mã biến thể (trừ bản ghi hiện tại)
        if (isBienTheExistsExceptCurrent(k.getMaBienThe(), k.getMaKho())) {
            System.err.println("Lỗi: Mã biến thể " + k.getMaBienThe() + " đã tồn tại trong kho khác");
            return false;
        }

        String sql = "UPDATE kho_den SET ma_bien_the=?, so_luong_nhap=?, so_luong_ban=?, cap_nhat_gan_nhat=NOW() WHERE ma_kho=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, k.getMaBienThe());
            ps.setInt(2, k.getSoLuongNhap());
            ps.setInt(3, k.getSoLuongBan());
            ps.setInt(4, k.getMaKho());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            // Xử lý lỗi duplicate entry từ database
            if (e.getErrorCode() == 1062 || e.getMessage().contains("Duplicate entry")) {
                System.err.println("Lỗi trùng mã biến thể từ database: " + e.getMessage());
                return false;
            }
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(int maKho) {
        String sql = "DELETE FROM kho_den WHERE ma_kho=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maKho);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Kiểm tra xem biến thể đã tồn tại trong kho chưa
    public boolean isBienTheExists(int maBienThe) {
        String sql = "SELECT COUNT(*) FROM kho_den WHERE ma_bien_the = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maBienThe);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra xem biến thể đã tồn tại trong kho (trừ mã kho hiện tại)
    public boolean isBienTheExistsExceptCurrent(int maBienThe, int maKho) {
        String sql = "SELECT COUNT(*) FROM kho_den WHERE ma_bien_the = ? AND ma_kho != ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maBienThe);
            ps.setInt(2, maKho);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy thông tin kho theo mã biến thể
    public KhoDen getByMaBienThe(int maBienThe) {
        String sql = "SELECT * FROM kho_den WHERE ma_bien_the = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maBienThe);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Timestamp ts = rs.getTimestamp("cap_nhat_gan_nhat");
                return new KhoDen(
                        rs.getInt("ma_kho"),
                        rs.getInt("ma_bien_the"),
                        rs.getInt("so_luong_nhap"),
                        rs.getInt("so_luong_ban"),
                        ts != null ? ts.toLocalDateTime() : null
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public int getTongSoLuongTon() {
    String sql = "SELECT SUM(so_luong_nhap - so_luong_ban) FROM kho_den";
    try (Connection conn = DBConnect.getConnection();
         Statement st = conn.createStatement();
         ResultSet rs = st.executeQuery(sql)) {
        if (rs.next()) {
            return rs.getInt(1);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return 0;
}
}