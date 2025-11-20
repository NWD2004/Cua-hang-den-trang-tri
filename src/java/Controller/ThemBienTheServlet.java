package Controller;

import DAO.BienTheDenDAO;
import Model.BienTheDen;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ThemBienTheServlet", urlPatterns = {"/them-bien-the"})
public class ThemBienTheServlet extends HttpServlet {

    private final BienTheDenDAO btdDAO = new BienTheDenDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            // === LẤY DỮ LIỆU TỪ FORM (dạng String) ===
            String maDenStr = request.getParameter("maDen");
            String maMauStr = request.getParameter("maMau");
            String maKichThuocStr = request.getParameter("maKichThuoc");

            // === VALIDATE ===
            if (maDenStr == null || maDenStr.trim().isEmpty()) {
                redirectWithError(request, response, "Vui lòng chọn đèn!");
                return;
            }

            // === CHUYỂN ĐỔI SANG int / Integer ===
            int maDen = Integer.parseInt(maDenStr.trim());
            Integer maMau = isEmpty(maMauStr) ? null : Integer.valueOf(maMauStr.trim());
            Integer maKichThuoc = isEmpty(maKichThuocStr) ? null : Integer.valueOf(maKichThuocStr.trim());

            // === TẠO ĐỐI TƯỢNG BIẾN THỂ (theo model hiện tại) ===
            BienTheDen bt = new BienTheDen();
            bt.setMaDen(maDen);
            bt.setMaMau(maMau);
            bt.setMaKichThuoc(maKichThuoc);
            // Lưu ý: maBienThe sẽ do DB tự sinh (AUTO_INCREMENT)

            // === GỌI DAO ĐỂ THÊM ===
            boolean success = btdDAO.insert(bt);

            if (success) {
                response.sendRedirect(request.getContextPath() + "elements/ItemDetail.jsp?msg=add_success");
            } else {
                redirectWithError(request, response, "Thêm thất bại! Có thể đã tồn tại.");
            }

        } catch (NumberFormatException e) {
            redirectWithError(request, response, "Dữ liệu không hợp lệ! Vui lòng chọn đúng.");
        } catch (Exception e) {
            e.printStackTrace();
            redirectWithError(request, response, "Lỗi hệ thống: " + e.getMessage());
        }
    }

    // === HÀM HỖ TRỢ ===
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
