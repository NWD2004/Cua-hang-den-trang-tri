package Controller;

import DAO.LoaiDenDAO;
import Model.LoaiDen;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SuaLoaiServlet", urlPatterns = {"/sua-loai"})
@MultipartConfig
public class SuaLoaiServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Thiết lập Content Type và Character Encoding
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        
        boolean success = false;
        String message = "";

        try {
            String maLoaiStr = request.getParameter("maLoai");
            String tenLoai = request.getParameter("tenLoai");
            String moTa = request.getParameter("moTa");
            
            if (maLoaiStr == null || maLoaiStr.trim().isEmpty() || tenLoai == null || tenLoai.trim().isEmpty()) {
                message = "Mã loại và Tên loại không được để trống.";
            } else {
                int maLoai = Integer.parseInt(maLoaiStr);
                LoaiDen loaiCapNhat = new LoaiDen(maLoai, tenLoai, moTa);
                LoaiDenDAO dao = new LoaiDenDAO();

                if (dao.update(loaiCapNhat)) {
                    success = true;
                    message = "Cập nhật loại sản phẩm thành công.";
                } else {
                    message = "Cập nhật loại sản phẩm thất bại (Lỗi DB hoặc không tìm thấy mã loại).";
                }
            }
        } catch (NumberFormatException e) {
            message = "Mã loại không hợp lệ.";
        } catch (Exception e) {
            e.printStackTrace();
            message = "Lỗi server: " + e.getMessage();
        }

        // Tự tạo JSON response
        String jsonResponse = String.format(
            "{\"success\": %b, \"message\": \"%s\"}",
            success,
            message.replace("\"", "\\\"").replace("\n", "\\n")
        );
        
        out.print(jsonResponse);
        out.flush();
    }
}