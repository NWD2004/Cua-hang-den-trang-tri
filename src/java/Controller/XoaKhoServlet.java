package Controller;

import DAO.KhoDenDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "XoaKhoServlet", urlPatterns = {"/xoa-kho"})
public class XoaKhoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String id = request.getParameter("id");
            
            if (id == null || id.trim().isEmpty()) {
                response.sendRedirect("elements/ProductStorage.jsp?error=" + java.net.URLEncoder.encode("Không tìm thấy mã kho để xóa", "UTF-8"));
                return;
            }

            int maKho = Integer.parseInt(id);
            KhoDenDAO dao = new KhoDenDAO();
                
            if (dao.delete(maKho)) {
                response.sendRedirect("elements/ProductStorage.jsp?msg=delete_success");
            } else {
                response.sendRedirect("elements/ProductStorage.jsp?error=" + java.net.URLEncoder.encode("Xóa kho thất bại", "UTF-8"));
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("elements/ProductStorage.jsp?error=" + java.net.URLEncoder.encode("Mã kho không hợp lệ", "UTF-8"));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("elements/ProductStorage.jsp?error=" + java.net.URLEncoder.encode("Lỗi server: " + e.getMessage(), "UTF-8"));
        }
    }
}