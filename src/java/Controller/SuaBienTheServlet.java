package Controller;

import DAO.BienTheDenDAO;
import Model.BienTheDen;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "SuaBienTheServlet", urlPatterns = {"/sua-bien-the"})
public class SuaBienTheServlet extends HttpServlet {

    private final BienTheDenDAO btdDAO = new BienTheDenDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            // Lấy dữ liệu từ modal sửa
            String maBienTheStr = request.getParameter("maBienThe");
            String maDenStr = request.getParameter("maDen");
            String maMauStr = request.getParameter("maMau");
            String maKichThuocStr = request.getParameter("maKichThuoc");

            // Validate
            if (maBienTheStr == null || maDenStr == null || maDenStr.trim().isEmpty()) {
                redirectWithError(request, response, "Dữ liệu không hợp lệ!");
                return;
            }

            int maBienThe = Integer.parseInt(maBienTheStr.trim());
            int maDen = Integer.parseInt(maDenStr.trim());
            Integer maMau = isEmpty(maMauStr) ? null : Integer.parseInt(maMauStr.trim());
            Integer maKichThuoc = isEmpty(maKichThuocStr) ? null : Integer.parseInt(maKichThuocStr.trim());

            // Tạo đối tượng
            BienTheDen bt = new BienTheDen();
            bt.setMaBienThe(maBienThe);
            bt.setMaDen(maDen);
            bt.setMaMau(maMau);
            bt.setMaKichThuoc(maKichThuoc);

            // Cập nhật
            boolean success = btdDAO.update(bt);

            if (success) {
                response.sendRedirect(request.getContextPath() + "elements/ItemDetail.jsp?msg=edit_success");
            } else {
                redirectWithError(request, response, "Cập nhật thất bại!");
            }

        } catch (NumberFormatException e) {
            redirectWithError(request, response, "Dữ liệu số không hợp lệ!");
        } catch (Exception e) {
            e.printStackTrace();
            redirectWithError(request, response, "Lỗi hệ thống: " + e.getMessage());
        }
    }

    private boolean isEmpty(String s) {
        return s == null || s.trim().isEmpty();
    }

    private void redirectWithError(HttpServletRequest req, HttpServletResponse res, String msg)
            throws IOException {
        String encodedMsg = java.net.URLEncoder.encode(msg, "UTF-8");
        res.sendRedirect(req.getContextPath() + "elements/ItemDetail.jsp?error=" + encodedMsg);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "elements/ItemDetail.jsp");
    }
}
