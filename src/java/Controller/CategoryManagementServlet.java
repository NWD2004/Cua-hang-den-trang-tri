package Controller;

import DAO.LoaiDenDAO;
import Model.LoaiDen;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "CategoryManagementServlet", urlPatterns = {"/CategoryManagementServlet", "/admin/categories"})
public class CategoryManagementServlet extends HttpServlet {

    private LoaiDenDAO loaiDenDAO;

    @Override
    public void init() {
        loaiDenDAO = new LoaiDenDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/View/adminLogin.jsp");
            return;
        }

        // Forward đến JSP
        request.getRequestDispatcher("/elements/CategoryManagement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Kiểm tra admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/View/adminLogin.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tham số action");
            return;
        }

        try {
            switch (action) {
                case "add":
                    handleAdd(request, response);
                    break;
                case "update":
                    handleUpdate(request, response);
                    break;
                case "delete":
                    handleDelete(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action không hợp lệ");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi: " + e.getMessage());
        }
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String tenLoai = request.getParameter("tenLoai");
        String moTa = request.getParameter("moTa");

        if (tenLoai == null || tenLoai.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Tên loại đèn không được để trống");
            doGet(request, response);
            return;
        }

        LoaiDen loai = new LoaiDen();
        loai.setTenLoai(tenLoai.trim());
        loai.setMoTa(moTa != null ? moTa.trim() : "");

        boolean success = loaiDenDAO.insert(loai);
        if (success) {
            request.setAttribute("successMessage", "Thêm loại đèn thành công!");
        } else {
            request.setAttribute("errorMessage", "Thêm loại đèn thất bại. Có thể tên loại đã tồn tại.");
        }

        doGet(request, response);
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String maLoaiStr = request.getParameter("maLoai");
        String tenLoai = request.getParameter("tenLoai");
        String moTa = request.getParameter("moTa");

        if (maLoaiStr == null || tenLoai == null || tenLoai.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Thiếu thông tin cần thiết");
            doGet(request, response);
            return;
        }

        try {
            int maLoai = Integer.parseInt(maLoaiStr);
            LoaiDen loai = new LoaiDen();
            loai.setMaLoai(maLoai);
            loai.setTenLoai(tenLoai.trim());
            loai.setMoTa(moTa != null ? moTa.trim() : "");

            boolean success = loaiDenDAO.update(loai);
            if (success) {
                request.setAttribute("successMessage", "Cập nhật loại đèn thành công!");
            } else {
                request.setAttribute("errorMessage", "Cập nhật loại đèn thất bại.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Mã loại đèn không hợp lệ");
        }

        doGet(request, response);
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String maLoaiStr = request.getParameter("maLoai");

        if (maLoaiStr == null) {
            request.setAttribute("errorMessage", "Thiếu mã loại đèn");
            doGet(request, response);
            return;
        }

        try {
            int maLoai = Integer.parseInt(maLoaiStr);
            
            // Kiểm tra xem có sản phẩm nào đang sử dụng loại này không
            int productCount = loaiDenDAO.countProductsByCategory(maLoai);
            if (productCount > 0) {
                request.setAttribute("errorMessage", 
                    "Không thể xóa loại đèn này vì có " + productCount + " sản phẩm đang sử dụng.");
                doGet(request, response);
                return;
            }

            boolean success = loaiDenDAO.delete(maLoai);
            if (success) {
                request.setAttribute("successMessage", "Xóa loại đèn thành công!");
            } else {
                request.setAttribute("errorMessage", "Xóa loại đèn thất bại.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Mã loại đèn không hợp lệ");
        }

        doGet(request, response);
    }
}

