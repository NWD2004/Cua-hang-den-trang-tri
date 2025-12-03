package Controller;

import DAO.ContactMessageDAO;
import Model.ContactMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/elements/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Lấy thông tin từ form
            String hoTen = request.getParameter("name");
            String soDienThoai = request.getParameter("phone");
            String email = request.getParameter("email");
            String chuDe = request.getParameter("subject");
            String noiDung = request.getParameter("message");
            
            // Validate
            if (hoTen == null || hoTen.trim().isEmpty() || 
                soDienThoai == null || soDienThoai.trim().isEmpty() ||
                noiDung == null || noiDung.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc!");
                request.getRequestDispatcher("/elements/contact.jsp").forward(request, response);
                return;
            }
            
            // Tạo đối tượng ContactMessage
            ContactMessage message = new ContactMessage();
            message.setHoTen(hoTen.trim());
            message.setSoDienThoai(soDienThoai.trim());
            message.setEmail(email != null ? email.trim() : "");
            message.setChuDe(chuDe != null ? chuDe.trim() : "");
            message.setNoiDung(noiDung.trim());
            
            // Lưu vào database
            ContactMessageDAO dao = new ContactMessageDAO();
            boolean success = dao.insert(message);
            
            if (success) {
                // Gửi email thông báo (tùy chọn - có thể implement sau)
                // sendEmailNotification(message);
                
                request.setAttribute("success", "Cảm ơn bạn đã liên hệ! Chúng tôi sẽ phản hồi sớm nhất có thể.");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi gửi tin nhắn. Vui lòng thử lại sau!");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra. Vui lòng thử lại sau!");
        }
        
        request.getRequestDispatcher("/elements/contact.jsp").forward(request, response);
    }
}

