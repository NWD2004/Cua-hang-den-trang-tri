package Controller;

import DAO.DanhGiaDAO;
import Model.DanhGia;
import Model.NguoiDung;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/update-review")
public class UpdateReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra đăng nhập
        NguoiDung user = (NguoiDung) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Bạn cần đăng nhập để chỉnh sửa đánh giá");
            return;
        }
        
        try {
            // Lấy thông tin từ form
            String maDGStr = request.getParameter("maDG");
            String maDenStr = request.getParameter("maDen");
            String soSaoStr = request.getParameter("soSao");
            String binhLuan = request.getParameter("binhLuan");
            
            if (maDGStr == null || soSaoStr == null || binhLuan == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu thông tin đánh giá");
                return;
            }
            
            int maDG = Integer.parseInt(maDGStr);
            int soSao = Integer.parseInt(soSaoStr);
            
            // Validate
            if (soSao < 1 || soSao > 5) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Số sao phải từ 1 đến 5");
                return;
            }
            
            if (binhLuan.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Vui lòng nhập bình luận");
                return;
            }
            
            // Kiểm tra đánh giá có thuộc về user này không
            DanhGiaDAO danhGiaDAO = new DanhGiaDAO();
            DanhGia existingReview = danhGiaDAO.getById(maDG);
            
            if (existingReview == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy đánh giá");
                return;
            }
            
            if (existingReview.getMaND() != user.getMaND()) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền chỉnh sửa đánh giá này");
                return;
            }
            
            // Cập nhật đánh giá
            existingReview.setSoSao(soSao);
            existingReview.setBinhLuan(binhLuan.trim());
            
            boolean success = danhGiaDAO.update(existingReview);
            
            if (success) {
                int maDen = maDenStr != null ? Integer.parseInt(maDenStr) : existingReview.getMaDen();
                response.sendRedirect(request.getContextPath() + "/product-detail?id=" + maDen + "&reviewUpdated=true");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể cập nhật đánh giá");
            }
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dữ liệu không hợp lệ");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi server");
        }
    }
}

