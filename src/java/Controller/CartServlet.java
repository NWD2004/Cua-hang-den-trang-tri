package Controller;

import DAO.*;
import Model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CartServlet", urlPatterns = {"/CartServlet", "/cart", "/gio-hang"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/View/userLogin.jsp");
            return;
        }
        
        NguoiDung user = (NguoiDung) session.getAttribute("user");
        if (user == null || (user.getVaiTro() != null && user.getVaiTro().equalsIgnoreCase("admin"))) {
            response.sendRedirect(request.getContextPath() + "/View/userLogin.jsp");
            return;
        }
        
        // Lấy giỏ hàng từ session
        GioHang cart = (GioHang) session.getAttribute("cart");
        if (cart == null) {
            cart = new GioHang();
            session.setAttribute("cart", cart);
        }
        
        // Tạo ViewModel list từ giỏ hàng
        // Load đầy đủ thông tin từ database: Den, BienTheDen, MauSac, KichThuoc
        List<CartItemViewModel> cartItems = new ArrayList<>();
        DenDAO denDAO = new DenDAO();
        BienTheDenDAO bienTheDenDAO = new BienTheDenDAO();
        MauSacDAO mauSacDAO = new MauSacDAO();
        KichThuocDAO kichThuocDAO = new KichThuocDAO();
        
        for (GioHangItem item : cart.getItems()) {
            // Lấy thông tin sản phẩm chính (Den)
            Den product = null;
            try {
                product = denDAO.getById(item.getMaDen());
            } catch (Exception e) {
                System.err.println("❌ Lỗi khi lấy sản phẩm maDen=" + item.getMaDen() + ": " + e.getMessage());
            }
            
            // Lấy thông tin biến thể (BienTheDen)
            BienTheDen variant = null;
            if (item.getMaBienThe() != null) {
                try {
                    variant = bienTheDenDAO.getById(item.getMaBienThe());
                } catch (Exception e) {
                    System.err.println("❌ Lỗi khi lấy biến thể maBienThe=" + item.getMaBienThe() + ": " + e.getMessage());
                }
            }
            
            // Lấy thông tin màu sắc (MauSac)
            MauSac mau = null;
            if (variant != null && variant.getMaMau() != null) {
                try {
                    mau = mauSacDAO.getById(variant.getMaMau());
                } catch (Exception e) {
                    System.err.println("❌ Lỗi khi lấy màu sắc maMau=" + variant.getMaMau() + ": " + e.getMessage());
                }
            }
            
            // Lấy thông tin kích thước (KichThuoc)
            KichThuoc kichThuoc = null;
            if (variant != null && variant.getMaKichThuoc() != null) {
                try {
                    kichThuoc = kichThuocDAO.getById(variant.getMaKichThuoc());
                } catch (Exception e) {
                    System.err.println("❌ Lỗi khi lấy kích thước maKichThuoc=" + variant.getMaKichThuoc() + ": " + e.getMessage());
                }
            }
            
            // Tạo ViewModel
            CartItemViewModel viewModel = new CartItemViewModel(item, product, variant, mau, kichThuoc);
            cartItems.add(viewModel);
        }
        
        // Set attributes để JSP sử dụng
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cart", cart);
        
        // Forward đến trang giỏ hàng
        request.getRequestDispatcher("/elements/Cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/View/userLogin.jsp");
            return;
        }
        
        NguoiDung user = (NguoiDung) session.getAttribute("user");
        if (user == null || (user.getVaiTro() != null && user.getVaiTro().equalsIgnoreCase("admin"))) {
            response.sendRedirect(request.getContextPath() + "/View/userLogin.jsp");
            return;
        }
        
        GioHang cart = (GioHang) session.getAttribute("cart");
        if (cart == null) {
            cart = new GioHang();
            session.setAttribute("cart", cart);
        }
        
        if ("update".equals(action)) {
            // Cập nhật số lượng
            String key = request.getParameter("key");
            String quantityStr = request.getParameter("quantity");
            try {
                int quantity = Integer.parseInt(quantityStr);
                cart.updateQuantity(key, quantity);
            } catch (NumberFormatException e) {
                // Ignore
            }
        } else if ("remove".equals(action)) {
            // Xóa item
            String key = request.getParameter("key");
            cart.removeItem(key);
        } else if ("clear".equals(action)) {
            // Xóa tất cả
            cart.clear();
        }
        
        // Redirect về trang giỏ hàng
        response.sendRedirect(request.getContextPath() + "/CartServlet");
    }
}

