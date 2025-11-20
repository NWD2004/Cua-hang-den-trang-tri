package DAO;

import Model.NhaCungCap;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NhaCungCapDAO {

    public List<NhaCungCap> getAll() {
        List<NhaCungCap> list = new ArrayList<>();
        String sql = "SELECT * FROM nha_cung_cap";
        try (Connection conn = DBConnect.getConnection(); Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new NhaCungCap(
                        rs.getInt("ma_ncc"),
                        rs.getString("ten_ncc"),
                        rs.getString("thong_tin_lien_he")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insert(NhaCungCap ncc) {
        String sql = "INSERT INTO nha_cung_cap(ten_ncc, thong_tin_lien_he) VALUES(?, ?)";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, ncc.getTenNCC());
            ps.setString(2, ncc.getThongTinLienHe());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean update(NhaCungCap ncc) {
        String sql = "UPDATE nha_cung_cap SET ten_ncc=?, thong_tin_lien_he=? WHERE ma_ncc=?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, ncc.getTenNCC());
            ps.setString(2, ncc.getThongTinLienHe());
            ps.setInt(3, ncc.getMaNCC());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(int maNCC) {
        String sql = "DELETE FROM nha_cung_cap WHERE ma_ncc=?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maNCC);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("⚠️ Không thể xóa NCC vì đang được sử dụng trong bảng đèn.");
            return false;
        }
    }

// NhaCungCapDAO
    public String getTenNCCById(int maNCC) {
        String tenNCC = "";
        String sql = "SELECT ten_ncc FROM nha_cung_cap WHERE ma_ncc = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maNCC);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                tenNCC = rs.getString("ten_ncc");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tenNCC;
    }

}
