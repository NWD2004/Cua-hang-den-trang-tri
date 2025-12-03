package Controller;

import Model.PasswordResetToken;
import Service.PasswordResetService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgot-password"})
public class ForgotPasswordServlet extends HttpServlet {

    private PasswordResetService passwordResetService;

    @Override
    public void init() {
        passwordResetService = new PasswordResetService(getServletContext());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if ("verify".equals(action)) {
            handleVerifyCode(request, response);
            return;
        }
        handleSendCode(request, response);
    }

    private void handleSendCode(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        try {
            passwordResetService.startResetFlow(email);
            request.setAttribute("successMessage", "Đã gửi mã xác thực tới email " + email + ". Vui lòng kiểm tra hộp thư (hoặc thư rác).");
            request.setAttribute("step", "verify");
            request.setAttribute("email", email);
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Không thể gửi mã xác thực. Vui lòng thử lại sau.");
        }
        forward(request, response);
    }

    private void handleVerifyCode(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String code = request.getParameter("otp");
        try {
            PasswordResetToken token = passwordResetService.verifyCode(email, code);
            HttpSession session = request.getSession(true);
            session.setAttribute("passwordResetTokenId", token.getTokenId());
            session.setAttribute("passwordResetEmail", email);
            response.sendRedirect(request.getContextPath() + "/reset-password");
            return;
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.setAttribute("step", "verify");
            request.setAttribute("email", email);
        } catch (Exception e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.setAttribute("step", "verify");
            request.setAttribute("email", email);
        }
        forward(request, response);
    }

    private void forward(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/View/forgot-password.jsp").forward(request, response);
    }
}


