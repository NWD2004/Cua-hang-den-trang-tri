package Controller;

import DAO.NguoiDungDAO;
import Model.NguoiDung;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/View/AdminHome.jsp",
    "/QuanLyDen.jsp",
    "/QuanLyNguoiDung.jsp",
    "/elements/accountinfo.jsp",
    "/ItemDetail/Accountinfo.jsp",
    "/ItemDetail/ItemDetail.jsp",
    "/ItemDetail/ShopItem.jsp",
     "/ItemDetail/UserAccount.jsp",
     "/ItemDetail/ProductStorage.jsp",
     "/ItemDetail/AdminAccount.jsp"
})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        
        boolean isAuthenticated = false;
        NguoiDung user = null;

        // Kiểm tra session trước
        if (session != null) {
            user = (NguoiDung) session.getAttribute("user");
            if (user != null && user.getVaiTro() != null && user.getVaiTro().equalsIgnoreCase("admin")) {
                isAuthenticated = true;
            }
        }
        
        // Nếu chưa có session, kiểm tra cookie
        if (!isAuthenticated) {
            Cookie[] cookies = req.getCookies();
            String email = null;
            String password = null;
            
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("adminEmail")) {
                        email = cookie.getValue();
                    }
                    if (cookie.getName().equals("adminPassword")) {
                        password = cookie.getValue();
                    }
                }
            }
            
            // Nếu có cookie, thử đăng nhập lại
            if (email != null && password != null) {
                NguoiDungDAO dao = new NguoiDungDAO();
                user = dao.checkLogin(email, password);
                
                if (user != null && user.getVaiTro() != null && user.getVaiTro().equalsIgnoreCase("admin")) {
                    // Tạo session mới từ cookie
                    session = req.getSession(true);
                    session.setAttribute("user", user);
                    session.setAttribute("admin", user);
                    isAuthenticated = true;
                }
            }
        }

        // Nếu chưa đăng nhập, chuyển hướng về trang đăng nhập
        if (!isAuthenticated) {
            res.sendRedirect(req.getContextPath() + "/View/adminLogin.jsp");
            return;
        }
        
        // Cho phép truy cập
        chain.doFilter(request, response);
    }
}
