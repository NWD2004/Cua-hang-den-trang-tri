package Controller;

import Model.NguoiDung;
import DAO.NguoiDungDAO;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UserManagerServlet")
public class UserManagerServlet extends HttpServlet {
    private NguoiDungDAO nguoiDungDAO;

    @Override
    public void init() {
        nguoiDungDAO = new NguoiDungDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        String userType = request.getParameter("userType"); // admin hoặc user
        String redirectPage = getRedirectPage(userType);

        try {
            switch (action == null ? "list" : action) {
                case "add":
                    addUser(request, response, userType);
                    break;
                case "update":
                    updateUser(request, response, userType);
                    break;
                case "delete":
                    deleteUser(request, response, userType);
                    break;
                case "view":
                    viewUserDetail(request, response, userType);
                    break;
                default:
                    response.sendRedirect(redirectPage);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect(redirectPage);
        }
    }

    private String getRedirectPage(String userType) {
        return "admin".equals(userType) ? "elements/AdminAccount.jsp" : "elements/UserAccount.jsp";
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response, String userType)
            throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = "admin".equals(userType) ? "admin" : request.getParameter("role");

            // Kiểm tra dữ liệu đầu vào
            if (username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
                
                request.getSession().setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin bắt buộc");
                response.sendRedirect(getRedirectPage(userType));
                return;
            }

            // Kiểm tra xem username đã tồn tại chưa
            NguoiDung existingUser = nguoiDungDAO.getByUsername(username.trim());
            if (existingUser != null) {
                request.getSession().setAttribute("errorMessage", "Tên đăng nhập đã tồn tại");
                response.sendRedirect(getRedirectPage(userType));
                return;
            }

            NguoiDung newUser = new NguoiDung();
            newUser.setTenDangNhap(username.trim());
            newUser.setEmail(email.trim());
            newUser.setMatKhau(password.trim());
            newUser.setVaiTro(role != null ? role : "customer");

            boolean success = nguoiDungDAO.insert(newUser);

            if (success) {
                String successMsg = "admin".equals(userType) ? 
                    "Thêm quản trị viên thành công!" : "Thêm người dùng thành công!";
                request.getSession().setAttribute("successMessage", successMsg);
            } else {
                String errorMsg = "admin".equals(userType) ?
                    "Không thể thêm quản trị viên. Có thể tên đăng nhập hoặc email đã tồn tại." :
                    "Không thể thêm người dùng. Có thể tên đăng nhập hoặc email đã tồn tại.";
                request.getSession().setAttribute("errorMessage", errorMsg);
            }
        } catch (Exception e) {
            e.printStackTrace();
            String errorMsg = "admin".equals(userType) ?
                "Lỗi khi thêm quản trị viên: " + e.getMessage() :
                "Lỗi khi thêm người dùng: " + e.getMessage();
            request.getSession().setAttribute("errorMessage", errorMsg);
        }
        
        response.sendRedirect(getRedirectPage(userType));
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response, String userType)
            throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            // Vai trò không được sửa, giữ nguyên vai trò cũ

            if (idParam == null) {
                request.getSession().setAttribute("errorMessage", "ID không hợp lệ");
                response.sendRedirect(getRedirectPage(userType));
                return;
            }

            int userId = Integer.parseInt(idParam);

            // Lấy thông tin user hiện tại để giữ nguyên vai trò
            java.util.List<NguoiDung> allUsers = nguoiDungDAO.getAll();
            NguoiDung existingUser = null;
            for (NguoiDung user : allUsers) {
                if (user.getMaND() == userId) {
                    existingUser = user;
                    break;
                }
            }

            if (existingUser != null) {
                // Chỉ cập nhật username và email, giữ nguyên vai trò và mật khẩu
                existingUser.setTenDangNhap(username);
                existingUser.setEmail(email);

                boolean success = nguoiDungDAO.update(existingUser);

                if (success) {
                    String successMsg = "admin".equals(userType) ?
                        "Cập nhật quản trị viên thành công!" : "Cập nhật người dùng thành công!";
                    request.getSession().setAttribute("successMessage", successMsg);
                } else {
                    String errorMsg = "admin".equals(userType) ?
                        "Không thể cập nhật quản trị viên" : "Không thể cập nhật người dùng";
                    request.getSession().setAttribute("errorMessage", errorMsg);
                }
            } else {
                String errorMsg = "admin".equals(userType) ?
                    "Không tìm thấy quản trị viên để cập nhật" : "Không tìm thấy người dùng để cập nhật";
                request.getSession().setAttribute("errorMessage", errorMsg);
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "ID không hợp lệ");
        } catch (Exception e) {
            e.printStackTrace();
            String errorMsg = "admin".equals(userType) ?
                "Lỗi khi cập nhật quản trị viên: " + e.getMessage() :
                "Lỗi khi cập nhật người dùng: " + e.getMessage();
            request.getSession().setAttribute("errorMessage", errorMsg);
        }
        
        response.sendRedirect(getRedirectPage(userType));
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response, String userType)
            throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            
            if (idParam == null) {
                request.getSession().setAttribute("errorMessage", "ID không hợp lệ");
                response.sendRedirect(getRedirectPage(userType));
                return;
            }

            int userId = Integer.parseInt(idParam);
            boolean success = nguoiDungDAO.delete(userId);

            if (success) {
                String successMsg = "admin".equals(userType) ?
                    "Xóa quản trị viên thành công!" : "Xóa người dùng thành công!";
                request.getSession().setAttribute("successMessage", successMsg);
            } else {
                String errorMsg = "admin".equals(userType) ?
                    "Không thể xóa quản trị viên. Có thể tài khoản đang có dữ liệu liên quan." :
                    "Không thể xóa người dùng. Có thể người dùng đang có dữ liệu liên quan.";
                request.getSession().setAttribute("errorMessage", errorMsg);
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "ID không hợp lệ");
        } catch (Exception e) {
            e.printStackTrace();
            String errorMsg = "admin".equals(userType) ?
                "Lỗi khi xóa quản trị viên: " + e.getMessage() :
                "Lỗi khi xóa người dùng: " + e.getMessage();
            request.getSession().setAttribute("errorMessage", errorMsg);
        }
        
        response.sendRedirect(getRedirectPage(userType));
    }

    private void viewUserDetail(HttpServletRequest request, HttpServletResponse response, String userType)
            throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            int userId = Integer.parseInt(idParam);

            // Lấy thông tin chi tiết user
            java.util.List<NguoiDung> allUsers = nguoiDungDAO.getAll();
            NguoiDung userDetail = null;
            for (NguoiDung user : allUsers) {
                if (user.getMaND() == userId) {
                    userDetail = user;
                    break;
                }
            }

            if (userDetail != null) {
                String infoMsg = "admin".equals(userType) ?
                    "Xem chi tiết quản trị viên: " + userDetail.getTenDangNhap() :
                    "Xem chi tiết người dùng: " + userDetail.getTenDangNhap();
                request.getSession().setAttribute("infoMessage", infoMsg);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            String errorMsg = "admin".equals(userType) ?
                "Lỗi khi xem chi tiết quản trị viên" : "Lỗi khi xem chi tiết người dùng";
            request.getSession().setAttribute("errorMessage", errorMsg);
        }
        
        response.sendRedirect(getRedirectPage(userType));
    }
}