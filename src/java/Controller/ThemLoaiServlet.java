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

@WebServlet(name = "ThemLoaiServlet", urlPatterns = {"/them-loai"})
@MultipartConfig
public class ThemLoaiServlet extends HttpServlet {

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
            String tenLoai = request.getParameter("tenLoai");
            String moTa = request.getParameter("moTa");

            if (tenLoai == null || tenLoai.trim().isEmpty()) {
                message = "Tên loại không được để trống.";
            } else {
                LoaiDen loaiMoi = new LoaiDen(0, tenLoai, moTa);
                LoaiDenDAO dao = new LoaiDenDAO();

                if (dao.insert(loaiMoi)) {
                    success = true;
                    message = "Thêm loại sản phẩm thành công.";
                } else {
                    message = "Thêm loại sản phẩm thất bại (Lỗi DB).";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "Lỗi server: " + e.getMessage();
        }

        // Tự tạo JSON response
        String jsonResponse = String.format(
            "{\"success\": %b, \"message\": \"%s\"}",
            success,
            // Đảm bảo escape các ký tự đặc biệt trong chuỗi message
            message.replace("\"", "\\\"").replace("\n", "\\n")
        );
        
        out.print(jsonResponse);
        out.flush();
    }
}