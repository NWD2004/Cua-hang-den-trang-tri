package Controller;

import DAO.NguoiDungDAO;
import Model.NguoiDung;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UserRegisterServlet", urlPatterns = {"/UserRegisterServlet", "/register"})
public class UserRegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng đến trang đăng ký
        request.getRequestDispatcher("/View/userRegister.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        
        // Kiểm tra dữ liệu đầu vào
        if (fullname == null || email == null || password == null || confirmPassword == null ||
            fullname.trim().isEmpty() || email.trim().isEmpty() || 
            password.trim().isEmpty() || confirmPassword.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("/View/userRegister.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra mật khẩu xác nhận
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.setAttribute("fullname", fullname);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/View/userRegister.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra độ dài mật khẩu
        if (password.length() < 6) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự!");
            request.setAttribute("fullname", fullname);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/View/userRegister.jsp").forward(request, response);
            return;
        }
        
        NguoiDungDAO dao = new NguoiDungDAO();
        
        // Kiểm tra email đã tồn tại chưa
        NguoiDung existingUser = dao.getByEmail(email);
        if (existingUser != null) {
            request.setAttribute("error", "Email này đã được sử dụng! Vui lòng chọn email khác.");
            request.setAttribute("fullname", fullname);
            request.getRequestDispatcher("/View/userRegister.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra username đã tồn tại chưa (nếu có) - nhưng cho phép trùng tên vì có thể nhiều người cùng tên
        // Chỉ kiểm tra email là unique
        
        // Tạo tài khoản mới với vai trò "customer" (mặc định, không phải admin)
        // Database sử dụng "customer" thay vì "user"
        NguoiDung newUser = new NguoiDung();
        newUser.setTenDangNhap(fullname.trim());
        newUser.setEmail(email.trim());
        newUser.setMatKhau(password);
        // Đảm bảo vai trò luôn là "customer" khi đăng ký từ user (phù hợp với database)
        newUser.setVaiTro("customer");
        
        // Kiểm tra lại để đảm bảo vai_tro không null hoặc empty
        if (newUser.getVaiTro() == null || newUser.getVaiTro().trim().isEmpty()) {
            newUser.setVaiTro("customer");
        }
        
        // Thêm người dùng mới
        try {
            System.out.println("🔍 Bắt đầu đăng ký user: " + email);
            System.out.println("   - Tên: " + fullname);
            System.out.println("   - Vai trò: " + newUser.getVaiTro());
            
            boolean insertSuccess = dao.insert(newUser);
            
            if (insertSuccess) {
                // Đăng ký thành công - chuyển đến trang đăng nhập với thông báo
                System.out.println("✅ Đăng ký thành công cho: " + email);
                request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
                request.setAttribute("registeredEmail", email);
                request.getRequestDispatcher("/View/userLogin.jsp").forward(request, response);
            } else {
                // Lỗi khi thêm người dùng
                System.err.println("❌ Đăng ký thất bại cho: " + email);
                request.setAttribute("error", "Đăng ký thất bại! Vui lòng kiểm tra lại thông tin hoặc thử lại sau. Nếu vấn đề vẫn tiếp tục, vui lòng liên hệ admin.");
                request.setAttribute("fullname", fullname);
                request.setAttribute("email", email);
                request.getRequestDispatcher("/View/userRegister.jsp").forward(request, response);
            }
        } catch (Exception e) {
            // Lỗi exception
            System.err.println("❌ Lỗi exception khi đăng ký user: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Đăng ký thất bại! Lỗi hệ thống. Vui lòng thử lại sau hoặc liên hệ admin.");
            request.setAttribute("fullname", fullname);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/View/userRegister.jsp").forward(request, response);
        }
    }
}

