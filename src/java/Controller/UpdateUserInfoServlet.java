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

@WebServlet("/UpdateUserInfoServlet")
public class UpdateUserInfoServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        NguoiDung user = (NguoiDung) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/elements/AccountInfo.jsp");
            return;
        }
        
        String email = request.getParameter("email");
        
        // Kiểm tra dữ liệu
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Email không được để trống");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/elements/AccountInfo.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        // Kiểm tra định dạng email
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        if (!email.matches(emailRegex)) {
            request.setAttribute("errorMessage", "Địa chỉ email không hợp lệ");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/elements/AccountInfo.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        try {
            NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
            boolean success = nguoiDungDAO.updateUserEmail(user.getMaND(), email);
            
            if (success) {
                // Cập nhật thông tin trong session
                user.setEmail(email);
                session.setAttribute("user", user);
                
                request.setAttribute("successMessage", "Cập nhật thông tin thành công!");
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật thông tin");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/elements/AccountInfo.jsp");
        dispatcher.forward(request, response);
    }
}