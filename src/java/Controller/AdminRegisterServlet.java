package Controller;

import DAO.NguoiDungDAO;
import Model.NguoiDung;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AdminRegisterServlet")
public class AdminRegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Đặt encoding UTF-8 để xử lý tiếng Việt
        request.setCharacterEncoding("UTF-8");
        
        // 1. Lấy dữ liệu từ form
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String terms = request.getParameter("terms");

        String errorMessage = null;
        
        if (isBlank(firstName) || isBlank(lastName) || isBlank(email)
                || isBlank(password) || isBlank(confirmPassword)) {
            errorMessage = "Vui lòng điền đầy đủ tất cả các trường.";
        } else if (!password.equals(confirmPassword)) {
            errorMessage = "Mật khẩu xác nhận không khớp.";
        } else if (terms == null) {
            errorMessage = "Bạn phải đồng ý với điều khoản sử dụng.";
        }
        NguoiDungDAO dao = new NguoiDungDAO();
        if (errorMessage == null && dao.getByEmail(email) != null) {
            errorMessage = "Email đã tồn tại trong hệ thống.";
        }

        if (errorMessage != null) {
            request.setAttribute("registerError", errorMessage);
            request.setAttribute("showRegister", true);
            request.getRequestDispatcher("/View/adminLogin.jsp").forward(request, response);
            return;
        }

        NguoiDung admin = new NguoiDung();
        admin.setTenDangNhap((firstName + " " + lastName).trim());
        admin.setEmail(email.trim());
        admin.setMatKhau(password);
        // Đảm bảo vai trò luôn là "admin" khi đăng ký từ admin
        admin.setVaiTro("admin"); // Sử dụng lowercase để đồng nhất với database
        
        // Kiểm tra lại để đảm bảo vai_tro không null hoặc empty
        if (admin.getVaiTro() == null || admin.getVaiTro().trim().isEmpty()) {
            admin.setVaiTro("admin");
        }

        System.out.println("🔍 Bắt đầu đăng ký admin: " + email);
        System.out.println("   - Tên: " + admin.getTenDangNhap());
        System.out.println("   - Vai trò: " + admin.getVaiTro());

        boolean inserted = dao.insert(admin);

        if (!inserted) {
            request.setAttribute("registerError", "Không thể tạo tài khoản, vui lòng thử lại.");
            request.setAttribute("showRegister", true);
            request.getRequestDispatcher("/View/adminLogin.jsp").forward(request, response);
            return;
        }

        request.setAttribute("fullName", firstName + " " + lastName);
        request.setAttribute("email", email);
        request.getRequestDispatcher("/elements/adminRegisterSuccess.jsp").forward(request, response);
    }
    
    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}