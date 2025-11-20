package Controller;

import Model.NguoiDung;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        processLogout(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        processLogout(request, response);
    }

    private void processLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        boolean isAdmin = false;
        
        // Kiểm tra xem là admin hay user
        if (session != null) {
            NguoiDung user = (NguoiDung) session.getAttribute("user");
            if (user != null && user.getVaiTro() != null && user.getVaiTro().equalsIgnoreCase("admin")) {
                isAdmin = true;
            }
            session.invalidate(); // xóa session
        }
        
        // Xóa cookies (cả admin và user)
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("adminEmail") || cookie.getName().equals("adminPassword") ||
                    cookie.getName().equals("userEmail") || cookie.getName().equals("userPassword")) {
                    cookie.setMaxAge(0); // Xóa cookie bằng cách set maxAge = 0
                    cookie.setPath("/");
                    response.addCookie(cookie);
                }
            }
        }
        
        String context = request.getContextPath();
        // Redirect đến trang phù hợp
        if (isAdmin) {
            response.sendRedirect(context + "/View/adminLogin.jsp");
        } else {
            response.sendRedirect(context + "/View/userHome.jsp");
        }
    }
}
