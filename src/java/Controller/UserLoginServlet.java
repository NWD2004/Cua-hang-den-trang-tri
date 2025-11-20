package Controller;

import DAO.NguoiDungDAO;
import Model.NguoiDung;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "UserLoginServlet", urlPatterns = {"/UserLoginServlet", "/login"})
public class UserLoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng đến trang đăng nhập
        request.getRequestDispatcher("/View/userLogin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember"); // Lấy giá trị checkbox "Ghi nhớ đăng nhập"
        
        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("/View/userLogin.jsp").forward(request, response);
            return;
        }
        
        NguoiDungDAO dao = new NguoiDungDAO();
        NguoiDung user = dao.checkLogin(email, password);
        
        if (user != null) {
            // Kiểm tra vai trò - chỉ cho phép user (không phải admin) đăng nhập
            if (user.getVaiTro() != null && user.getVaiTro().equalsIgnoreCase("admin")) {
                // Nếu là admin, chuyển về trang admin login
                request.setAttribute("error", "Tài khoản và mật khẩu không đúng!");
                request.getRequestDispatcher("/View/userLogin.jsp").forward(request, response);
                return;
            }
            
            // Đăng nhập thành công → tạo session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            // Tạo cookie để lưu thông tin đăng nhập
            Cookie emailCookie = new Cookie("userEmail", email);
            Cookie passwordCookie = new Cookie("userPassword", password);
            
            // Nếu có checkbox "Ghi nhớ đăng nhập" được chọn
            if (remember != null && remember.equals("on")) {
                // Set cookie tồn tại 7 ngày
                emailCookie.setMaxAge(7 * 24 * 60 * 60); // 7 ngày
                passwordCookie.setMaxAge(7 * 24 * 60 * 60); // 7 ngày
            } else {
                // Set cookie tồn tại trong phiên làm việc (khi đóng trình duyệt sẽ mất)
                emailCookie.setMaxAge(-1);
                passwordCookie.setMaxAge(-1);
            }
            
            // Set path cho cookie
            emailCookie.setPath("/");
            passwordCookie.setPath("/");
            
            // Thêm cookie vào response
            response.addCookie(emailCookie);
            response.addCookie(passwordCookie);
            
            // Kiểm tra xem có pending add to cart không
            String pendingAddToCart = (String) session.getAttribute("pendingAddToCart");
            String returnUrl = (String) session.getAttribute("returnUrl");
            
            if ("true".equals(pendingAddToCart)) {
                // Lấy thông tin sản phẩm đang chờ
                String pendingProductId = (String) session.getAttribute("pendingProductId");
                String pendingQuantity = (String) session.getAttribute("pendingQuantity");
                String pendingColorId = (String) session.getAttribute("pendingColorId");
                String pendingSizeId = (String) session.getAttribute("pendingSizeId");
                
                // Xóa pending flags
                session.removeAttribute("pendingAddToCart");
                session.removeAttribute("pendingProductId");
                session.removeAttribute("pendingQuantity");
                session.removeAttribute("pendingColorId");
                session.removeAttribute("pendingSizeId");
                
                // Tự động thêm vào giỏ hàng
                if (pendingProductId != null) {
                    try {
                        // Tạo request để gọi AddToCartServlet
                        jakarta.servlet.RequestDispatcher dispatcher = request.getRequestDispatcher("/AddToCartServlet");
                        request.setAttribute("productId", pendingProductId);
                        request.setAttribute("quantity", pendingQuantity != null ? pendingQuantity : "1");
                        request.setAttribute("colorId", pendingColorId);
                        request.setAttribute("sizeId", pendingSizeId);
                        // Note: Không thể forward vì đã commit response, nên sẽ redirect đến AddToCartServlet
                        // Hoặc có thể gọi trực tiếp logic thêm vào giỏ ở đây
                    } catch (Exception e) {
                        System.err.println("❌ Lỗi khi tự động thêm vào giỏ hàng: " + e.getMessage());
                    }
                }
                
                // Nếu có returnUrl, chuyển về trang đó
                if (returnUrl != null && !returnUrl.isEmpty()) {
                    session.removeAttribute("returnUrl");
                    response.sendRedirect(returnUrl);
                    return;
                }
            }
            
            // Kiểm tra returnUrl từ request parameter (nếu có)
            String returnUrlParam = request.getParameter("returnUrl");
            if (returnUrlParam != null && !returnUrlParam.isEmpty()) {
                response.sendRedirect(returnUrlParam);
                return;
            }
            
            // Chuyển hướng đến trang chủ
            response.sendRedirect(request.getContextPath() + "/View/userHome.jsp");
            
        } else {
            // Sai email hoặc mật khẩu
            request.setAttribute("error", "Email hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/View/userLogin.jsp").forward(request, response);
        }
    }
}

