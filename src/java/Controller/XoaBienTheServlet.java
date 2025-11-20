package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/xoa-bien-the")
public class XoaBienTheServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        System.out.println("=== SERVLET XÓA BIẾN THỂ DEBUG ===");
        System.out.println("Servlet: ID nhận được từ request: '" + idStr + "'");
        
        if (idStr == null || idStr.trim().isEmpty()) {
            System.err.println("Servlet: Lỗi - ID là null hoặc rỗng");
            String error = URLEncoder.encode("Không tìm thấy mã biến thể!", "UTF-8");
            response.sendRedirect(request.getContextPath() + "/elements/ItemDetail.jsp?error=" + error);
            return;
        }

        try {
            int id = Integer.parseInt(idStr.trim());
            System.out.println("Servlet: ID sau khi parse: " + id);
            
            DAO.BienTheDenDAO btdDAO = new DAO.BienTheDenDAO();
            
            // KIỂM TRA TỒN TẠI TRƯỚC KHI XÓA
            Model.BienTheDen existing = btdDAO.getById(id);
            if (existing == null) {
                System.err.println("Servlet: Lỗi - Không tìm thấy biến thể với ID: " + id);
                String error = URLEncoder.encode("Không tìm thấy biến thể mã " + id, "UTF-8");
                response.sendRedirect(request.getContextPath() + "/elements/ItemDetail.jsp?error=" + error);
                return;
            }

            System.out.println("Servlet: Tìm thấy biến thể - Mã đèn: " + existing.getMaDen());
            
            // THỰC HIỆN XÓA
            boolean deleted = btdDAO.delete(id);
            System.out.println("Servlet: Kết quả xóa: " + deleted);

            if (deleted) {
                System.out.println("Servlet: Xóa thành công biến thể mã: " + id);
                response.sendRedirect(request.getContextPath() + "/elements/ItemDetail.jsp?msg=delete_success");
            } else {
                System.err.println("Servlet: Xóa thất bại: " + id);
                String error = URLEncoder.encode("Xóa thất bại: Không thể xóa biến thể mã " + id, "UTF-8");
                response.sendRedirect(request.getContextPath() + "/elements/ItemDetail.jsp?error=" + error);
            }
        } catch (NumberFormatException e) {
            System.err.println("Servlet: Lỗi NumberFormatException: '" + idStr + "'");
            String error = URLEncoder.encode("Mã biến thể không hợp lệ: " + idStr, "UTF-8");
            response.sendRedirect(request.getContextPath() + "/elements/ItemDetail.jsp?error=" + error);
        } catch (Exception e) {
            System.err.println("Servlet: Lỗi hệ thống: " + e.getMessage());
            e.printStackTrace();
            String error = URLEncoder.encode("Lỗi hệ thống: " + e.getMessage(), "UTF-8");
            response.sendRedirect(request.getContextPath() + "/elements/ItemDetail.jsp?error=" + error);
        }
    }
}