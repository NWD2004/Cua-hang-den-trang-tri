/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.NguoiDungDAO;
import Model.NguoiDung;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author PC
 */
@WebServlet(name = "AdminLoginServlet", urlPatterns = {"/AdminLoginServlet"})
public class AdminLoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminLoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminLoginServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember"); // Lấy giá trị checkbox "Ghi nhớ đăng nhập"
        
        NguoiDungDAO dao = new NguoiDungDAO();
        NguoiDung user = dao.checkLogin(email, password);
        
        if (user != null) {
            // Kiểm tra vai trò admin
            if (user.getVaiTro() != null && user.getVaiTro().equalsIgnoreCase("admin")) {
                // Đăng nhập thành công → tạo session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("admin", user); // Thêm attribute "admin" để filter kiểm tra
                
                // Tạo cookie để lưu thông tin đăng nhập
                Cookie emailCookie = new Cookie("adminEmail", email);
                Cookie passwordCookie = new Cookie("adminPassword", password);
                
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
                
                response.sendRedirect("View/AdminHome.jsp");
            } else {
                // Người dùng không phải admin
                request.setAttribute("error", "Bạn không có quyền truy cập trang quản trị!");
                request.getRequestDispatcher("View/adminLogin.jsp").forward(request, response);
            }
        } else {
            // Sai email hoặc mật khẩu
            request.setAttribute("error", "Email hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("View/adminLogin.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
