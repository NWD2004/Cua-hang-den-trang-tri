package DAO;

import Model.DanhGia;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class DanhGiaDAO {

    public List<DanhGia> getAll() {
        List<DanhGia> list = new ArrayList<>();
        String sql = "SELECT * FROM danh_gia ORDER BY ngay_danh_gia DESC";
        try (Connection conn = DBConnect.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Timestamp ts = rs.getTimestamp("ngay_danh_gia");
                list.add(new DanhGia(
                        rs.getInt("ma_dg"),
                        rs.getInt("ma_nd"),
                        rs.getInt("ma_den"),
                        rs.getInt("so_sao"),
                        rs.getString("binh_luan"),
                        ts != null ? ts.toLocalDateTime() : null
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<DanhGia> getByProduct(int maDen) {
        List<DanhGia> list = new ArrayList<>();
        String sql = "SELECT * FROM danh_gia WHERE ma_den=? ORDER BY ngay_danh_gia DESC";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maDen);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Timestamp ts = rs.getTimestamp("ngay_danh_gia");
                list.add(new DanhGia(
                        rs.getInt("ma_dg"),
                        rs.getInt("ma_nd"),
                        rs.getInt("ma_den"),
                        rs.getInt("so_sao"),
                        rs.getString("binh_luan"),
                        ts != null ? ts.toLocalDateTime() : null
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insert(DanhGia dg) {
        String sql = "INSERT INTO danh_gia(ma_nd, ma_den, so_sao, binh_luan) VALUES(?, ?, ?, ?)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, dg.getMaND());
            ps.setInt(2, dg.getMaDen());
            ps.setInt(3, dg.getSoSao());
            ps.setString(4, dg.getBinhLuan());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Lỗi thêm đánh giá: " + e.getMessage());
            return false;
        }
    }

    public DanhGia getById(int maDG) {
        String sql = "SELECT * FROM danh_gia WHERE ma_dg=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maDG);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Timestamp ts = rs.getTimestamp("ngay_danh_gia");
                return new DanhGia(
                        rs.getInt("ma_dg"),
                        rs.getInt("ma_nd"),
                        rs.getInt("ma_den"),
                        rs.getInt("so_sao"),
                        rs.getString("binh_luan"),
                        ts != null ? ts.toLocalDateTime() : null
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public DanhGia getByUserAndProduct(int maND, int maDen) {
        String sql = "SELECT * FROM danh_gia WHERE ma_nd=? AND ma_den=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maND);
            ps.setInt(2, maDen);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Timestamp ts = rs.getTimestamp("ngay_danh_gia");
                return new DanhGia(
                        rs.getInt("ma_dg"),
                        rs.getInt("ma_nd"),
                        rs.getInt("ma_den"),
                        rs.getInt("so_sao"),
                        rs.getString("binh_luan"),
                        ts != null ? ts.toLocalDateTime() : null
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean update(DanhGia dg) {
        String sql = "UPDATE danh_gia SET so_sao=?, binh_luan=?, ngay_danh_gia=NOW() WHERE ma_dg=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, dg.getSoSao());
            ps.setString(2, dg.getBinhLuan());
            ps.setInt(3, dg.getMaDG());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Lỗi cập nhật đánh giá: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(int maDG) {
        String sql = "DELETE FROM danh_gia WHERE ma_dg=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maDG);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
