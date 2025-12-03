package DAO;

import Model.ContactMessage;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ContactMessageDAO {

    public boolean insert(ContactMessage message) {
        String sql = "INSERT INTO contact_message(ho_ten, so_dien_thoai, email, chu_de, noi_dung, ngay_gui, da_doc) VALUES(?, ?, ?, ?, ?, NOW(), 0)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, message.getHoTen());
            ps.setString(2, message.getSoDienThoai());
            ps.setString(3, message.getEmail() != null ? message.getEmail() : "");
            ps.setString(4, message.getChuDe() != null ? message.getChuDe() : "");
            ps.setString(5, message.getNoiDung());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Lỗi thêm tin nhắn liên hệ: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public List<ContactMessage> getAll() {
        List<ContactMessage> list = new ArrayList<>();
        String sql = "SELECT * FROM contact_message ORDER BY ngay_gui DESC";
        try (Connection conn = DBConnect.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Timestamp ts = rs.getTimestamp("ngay_gui");
                list.add(new ContactMessage(
                        rs.getInt("ma_tin_nhan"),
                        rs.getString("ho_ten"),
                        rs.getString("so_dien_thoai"),
                        rs.getString("email"),
                        rs.getString("chu_de"),
                        rs.getString("noi_dung"),
                        ts != null ? ts.toLocalDateTime() : null,
                        rs.getBoolean("da_doc")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public ContactMessage getById(int maTinNhan) {
        String sql = "SELECT * FROM contact_message WHERE ma_tin_nhan=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maTinNhan);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Timestamp ts = rs.getTimestamp("ngay_gui");
                return new ContactMessage(
                        rs.getInt("ma_tin_nhan"),
                        rs.getString("ho_ten"),
                        rs.getString("so_dien_thoai"),
                        rs.getString("email"),
                        rs.getString("chu_de"),
                        rs.getString("noi_dung"),
                        ts != null ? ts.toLocalDateTime() : null,
                        rs.getBoolean("da_doc")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean markAsRead(int maTinNhan) {
        String sql = "UPDATE contact_message SET da_doc=1 WHERE ma_tin_nhan=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maTinNhan);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(int maTinNhan) {
        String sql = "DELETE FROM contact_message WHERE ma_tin_nhan=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maTinNhan);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

