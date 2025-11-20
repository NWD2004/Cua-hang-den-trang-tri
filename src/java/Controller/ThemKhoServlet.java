package Controller;

import DAO.KhoDenDAO;
import Model.KhoDen;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ThemKhoServlet", urlPatterns = {"/them-kho"})
public class ThemKhoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        try {
            String maBienTheStr = request.getParameter("maBienThe");
            String soLuongNhapStr = request.getParameter("soLuongNhap");
            String soLuongBanStr = request.getParameter("soLuongBan");

            // Validate dữ liệu đầu vào
            if (maBienTheStr == null || maBienTheStr.trim().isEmpty() ||
                soLuongNhapStr == null || soLuongNhapStr.trim().isEmpty() ||
                soLuongBanStr == null || soLuongBanStr.trim().isEmpty()) {
                
                response.sendRedirect("elements/ProductStorage.jsp?error=" + 
                    java.net.URLEncoder.encode("Vui lòng điền đầy đủ thông tin", "UTF-8"));
                return;
            }

            int maBienThe = Integer.parseInt(maBienTheStr);
            int soLuongNhap = Integer.parseInt(soLuongNhapStr);
            int soLuongBan = Integer.parseInt(soLuongBanStr);

            // Validate số lượng
            if (soLuongNhap < 0 || soLuongBan < 0) {
                response.sendRedirect("elements/ProductStorage.jsp?error=" + 
                    java.net.URLEncoder.encode("Số lượng không được âm", "UTF-8"));
                return;
            }

            if (soLuongBan > soLuongNhap) {
                response.sendRedirect("elements/ProductStorage.jsp?error=" + 
                    java.net.URLEncoder.encode("Số lượng bán không được lớn hơn số lượng nhập", "UTF-8"));
                return;
            }

            KhoDenDAO dao = new KhoDenDAO();

            // KIỂM TRA TRÙNG MÃ BIẾN THỂ TRƯỚC KHI THÊM
            if (dao.isBienTheExists(maBienThe)) {
                // Lấy thông tin kho hiện có để hiển thị thông báo chi tiết
                KhoDen khoHienCo = dao.getByMaBienThe(maBienThe);
                String errorMsg = "Biến thể này đã tồn tại trong kho (Mã kho: " + khoHienCo.getMaKho() + 
                                 ", Số lượng nhập: " + khoHienCo.getSoLuongNhap() + 
                                 ", Số lượng bán: " + khoHienCo.getSoLuongBan() + ")";
                
                response.sendRedirect("elements/ProductStorage.jsp?error=" + java.net.URLEncoder.encode(errorMsg, "UTF-8"));
                return;
            }

            // Tạo đối tượng kho mới
            KhoDen khoMoi = new KhoDen(0, maBienThe, soLuongNhap, soLuongBan, null);

            if (dao.insert(khoMoi)) {
                response.sendRedirect("elements/ProductStorage.jsp?msg=add_success");
            } else {
                response.sendRedirect("elements/ProductStorage.jsp?error=" + 
                    java.net.URLEncoder.encode("Thêm kho thất bại. Có thể biến thể đã tồn tại trong kho", "UTF-8"));
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("elements/ProductStorage.jsp?error=" + 
                java.net.URLEncoder.encode("Dữ liệu số không hợp lệ", "UTF-8"));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("elements/ProductStorage.jsp?error=" + 
                java.net.URLEncoder.encode("Lỗi server: " + e.getMessage(), "UTF-8"));
        }
    }
}