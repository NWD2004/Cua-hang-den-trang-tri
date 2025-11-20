package Controller;

import DAO.KhoDenDAO;
import Model.KhoDen;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SuaKhoServlet", urlPatterns = {"/sua-kho"})
public class SuaKhoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        
        boolean success = false;
        String message = "";

        try {
            String maKhoStr = request.getParameter("maKho");
            String maBienTheStr = request.getParameter("maBienThe");
            String soLuongNhapStr = request.getParameter("soLuongNhap");
            String soLuongBanStr = request.getParameter("soLuongBan");
            
            if (maKhoStr == null || maBienTheStr == null || soLuongNhapStr == null || soLuongBanStr == null) {
                message = "Thiếu thông tin bắt buộc.";
            } else {
                int maKho = Integer.parseInt(maKhoStr);
                int maBienThe = Integer.parseInt(maBienTheStr);
                int soLuongNhap = Integer.parseInt(soLuongNhapStr);
                int soLuongBan = Integer.parseInt(soLuongBanStr);

                // Validate số lượng
                if (soLuongBan > soLuongNhap) {
                    message = "Số lượng bán không được lớn hơn số lượng nhập";
                } else {
                    KhoDen khoCapNhat = new KhoDen(maKho, maBienThe, soLuongNhap, soLuongBan, null);
                    KhoDenDAO dao = new KhoDenDAO();

                    if (dao.update(khoCapNhat)) {
                        success = true;
                        message = "Cập nhật kho thành công.";
                    } else {
                        message = "Cập nhật kho thất bại.";
                    }
                }
            }
        } catch (NumberFormatException e) {
            message = "Dữ liệu số không hợp lệ.";
        } catch (Exception e) {
            e.printStackTrace();
            message = "Lỗi server: " + e.getMessage();
        }

        String jsonResponse = String.format(
            "{\"success\": %b, \"message\": \"%s\"}",
            success,
            message.replace("\"", "\\\"").replace("\n", "\\n")
        );
        
        out.print(jsonResponse);
        out.flush();
    }
}