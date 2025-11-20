package Controller;

import DAO.LoaiDenDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "XoaLoaiServlet", urlPatterns = {"/xoa-loai"})
public class XoaLoaiServlet extends HttpServlet {

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
            String maLoaiStr = request.getParameter("maLoai");
            System.out.println("DEBUG - maLoaiStr received: " + maLoaiStr);

            if (maLoaiStr == null || maLoaiStr.trim().isEmpty()) {
                message = "Không tìm thấy Mã loại để xóa.";
                System.out.println("DEBUG - maLoaiStr is null or empty");
            } else {
                int maLoai = Integer.parseInt(maLoaiStr);
                LoaiDenDAO dao = new LoaiDenDAO();
                
                // Kiểm tra xem loại có tồn tại không trước khi xóa
                String tenLoai = dao.getTenLoaiById(maLoai);
                System.out.println("DEBUG - tenLoai found: " + tenLoai);
                
                if (tenLoai == null || tenLoai.isEmpty()) {
                    message = "Không tìm thấy loại với mã: " + maLoai;
                } else if (dao.delete(maLoai)) {
                    success = true;
                    message = "Xóa loại sản phẩm '" + tenLoai + "' thành công.";
                } else {
                    message = "Xóa loại sản phẩm thất bại. Có thể loại này đang được sử dụng bởi các sản phẩm khác.";
                }
            }
        } catch (NumberFormatException e) {
            message = "Mã loại không hợp lệ: " + e.getMessage();
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
            message = "Lỗi server: " + e.getMessage();
        }

        String jsonResponse = String.format(
            "{\"success\": %b, \"message\": \"%s\"}",
            success,
            message.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r")
        );

        System.out.println("DEBUG - Sending response: " + jsonResponse);
        out.print(jsonResponse);
        out.flush();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}