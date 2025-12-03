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
import java.time.LocalDateTime;

@WebServlet("/add-review")
public class AddReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra đăng nhập
        NguoiDung user = (NguoiDung) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Bạn cần đăng nhập để đánh giá sản phẩm");
            return;
        }
        
        try {
            // Lấy thông tin từ form
            String maDenStr = request.getParameter("maDen");
            String soSaoStr = request.getParameter("soSao");
            String binhLuan = request.getParameter("binhLuan");
            
            if (maDenStr == null || soSaoStr == null || binhLuan == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu thông tin đánh giá");
                return;
            }
            
            int maDen = Integer.parseInt(maDenStr);
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
            
            // Tạo đối tượng đánh giá
            DanhGia danhGia = new DanhGia();
            danhGia.setMaND(user.getMaND());
            danhGia.setMaDen(maDen);
            danhGia.setSoSao(soSao);
            danhGia.setBinhLuan(binhLuan.trim());
            danhGia.setNgayDanhGia(LocalDateTime.now());
            
            // Thêm vào database
            DanhGiaDAO danhGiaDAO = new DanhGiaDAO();
            boolean success = danhGiaDAO.insert(danhGia);
            
            if (success) {
                // Redirect về trang chi tiết sản phẩm với thông báo thành công
                response.sendRedirect(request.getContextPath() + "/product-detail?id=" + maDen + "&reviewSuccess=true");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể thêm đánh giá");
            }
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dữ liệu không hợp lệ");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi server");
        }
    }
}

