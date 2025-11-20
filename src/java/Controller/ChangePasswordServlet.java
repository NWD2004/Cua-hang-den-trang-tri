package Controller;

import Model.NguoiDung;
import DAO.NguoiDungDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        NguoiDung user = (NguoiDung) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "//elements/AccountInfo.jsp");
            return;
        }
        
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Kiểm tra dữ liệu
        if (currentPassword == null || currentPassword.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/elements/AccountInfo.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        // Kiểm tra mật khẩu mới và xác nhận mật khẩu
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu mới và xác nhận mật khẩu không khớp");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/elements/AccountInfo.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        // Kiểm tra độ dài mật khẩu mới
        if (newPassword.length() < 6) {
            request.setAttribute("errorMessage", "Mật khẩu mới phải có ít nhất 6 ký tự");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/elements/AccountInfo.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        try {
            NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
            
            // Kiểm tra mật khẩu hiện tại
            if (!nguoiDungDAO.checkCurrentPassword(user.getMaND(), currentPassword)) {
                request.setAttribute("errorMessage", "Mật khẩu hiện tại không đúng");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/elements/AccountInfo.jsp");
                dispatcher.forward(request, response);
                return;
            }
            
            // Cập nhật mật khẩu mới
            boolean success = nguoiDungDAO.updatePassword(user.getMaND(), newPassword);
            
            if (success) {
                // Cập nhật thông tin trong session
                user.setMatKhau(newPassword);
                session.setAttribute("user", user);
                
                request.setAttribute("successMessage", "Đổi mật khẩu thành công!");
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi đổi mật khẩu");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/elements/AccountInfo.jsp");
        dispatcher.forward(request, response);
    }
}