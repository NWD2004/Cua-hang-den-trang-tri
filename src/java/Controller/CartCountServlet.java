package Controller;

import Model.GioHang;
import Model.NguoiDung;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "CartCountServlet", urlPatterns = {"/CartCountServlet", "/cart-count"})
public class CartCountServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        int count = 0;
        
        if (session != null) {
            NguoiDung user = (NguoiDung) session.getAttribute("user");
            // Chỉ đếm nếu là user (không phải admin)
            if (user != null && (user.getVaiTro() == null || !user.getVaiTro().equalsIgnoreCase("admin"))) {
                GioHang cart = (GioHang) session.getAttribute("cart");
                if (cart != null) {
                    count = cart.getTotalItems();
                }
            }
        }
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"count\": " + count + "}");
    }
}

