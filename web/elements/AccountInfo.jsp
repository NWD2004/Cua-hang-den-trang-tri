<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Model.NguoiDung" %>
<!doctype html>
<html lang="en" data-pc-preset="preset-1" data-pc-sidebar-caption="true"
      data-pc-direction="ltr" dir="ltr" data-pc-theme="light">

    <head>
        <%@ include file="../layouts/head-page-meta-admin.html" %>
        <title>Thông tin tài khoản</title>

        <style>
            /* Thay đổi màu nền chung của body để phù hợp với sidebar tối */
            body {
                background-color: #f8f9fa; /* Màu nền sáng để tương phản với sidebar tối */
            }

            .profile-card {
                /* Thay đổi gradient để phù hợp với theme tối, ví dụ gradient từ xanh đậm sang tím */
                background: linear-gradient(135deg, #3f4d67 0%, #53668a 100%);
                color: white;
                border-radius: 15px;
                padding: 25px;
                margin-bottom: 25px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            }
            .profile-avatar {
                width: 80px;
                height: 80px;
                background: rgba(255,255,255,0.2);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 32px;
                margin: 0 auto 15px;
                border: 3px solid rgba(255,255,255,0.3);
            }
            .info-card {
                background: white;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            }
            .info-item {
                padding: 12px 20px;
                border-bottom: 1px solid #f0f0f0;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .stats-card {
                text-align: center;
                padding: 15px;
                border-radius: 10px;
                background: white;
                box-shadow: 0 5px 15px rgba(0,0,0,0.08);
                margin-bottom: 20px;
            }
            .main-content-wrapper {
                padding: 20px;
            }

            /* Modal styles */
            .modal-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 9999;
                justify-content: center;
                align-items: center;
            }
            .modal-content {
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 5px 25px rgba(0, 0, 0, 0.2);
                width: 90%;
                max-width: 500px;
                max-height: 90vh;
                overflow-y: auto;
            }
            .modal-header {
                padding: 15px 20px;
                border-bottom: 1px solid #eaeaea;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .modal-title {
                font-weight: 600;
                margin: 0;
            }
            .modal-close {
                background: none;
                border: none;
                font-size: 20px;
                cursor: pointer;
                color: #6c757d;
            }
            .modal-body {
                padding: 20px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            .form-label {
                display: block;
                margin-bottom: 5px;
                font-weight: 500;
            }
            .form-control {
                width: 100%;
                padding: 8px 12px;
                border: 1px solid #ced4da;
                border-radius: 4px;
                font-size: 14px;
                box-sizing: border-box;
            }
            .form-control:read-only {
                background-color: #f8f9fa;
                color: #6c757d;
                cursor: not-allowed;
            }
            .modal-footer {
                padding: 15px 20px;
                border-top: 1px solid #eaeaea;
                display: flex;
                justify-content: flex-end;
                gap: 10px;
            }
            .btn {
                padding: 8px 16px;
                border-radius: 4px;
                border: none;
                cursor: pointer;
                font-size: 14px;
                font-weight: 500;
                transition: all 0.2s;
            }
            .btn-primary {
                background-color: #3498db; /* Màu xanh để phù hợp với profile-card */
                color: white;
            }
            .btn-secondary {
                background-color: #6c757d;
                color: white;
            }
            .btn:hover {
                opacity: 0.9;
                transform: translateY(-1px);
            }
            .field-note {
                font-size: 12px;
                color: #6c757d;
                margin-top: 5px;
            }
            .alert {
                padding: 10px 15px;
                border-radius: 4px;
                margin-bottom: 15px;
            }
            .alert-success {
                background-color: #d1edff;
                color: #0c5460;
                border: 1px solid #b8daff;
            }
            .alert-error {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
        </style>
    </head>

    <body>
        <%@ include file="../layouts/loader-admin.html" %>
        <%@ include file="../layouts/sidebar-admin.html" %>
        <%@ include file="../layouts/header-content-admin.jsp" %>

        <%
            NguoiDung user = (NguoiDung) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/adminLogin.jsp");
                return;
            }

            String successMessage = (String) request.getAttribute("successMessage");
            String errorMessage = (String) request.getAttribute("errorMessage");
        %>

        <!-- ================= PC CONTAINER (BẮT BUỘC) ================= -->
        <div class="pc-container">
            <div class="pc-content">

                <!-- Title -->
                <div class="page-header">
                    <div class="page-block">
                        <h4 class="mb-0">Thông tin tài khoản</h4>
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/View/AdminHome.jsp">Trang chủ</a></li>
                            <li class="breadcrumb-item active">Thông tin tài khoản</li>
                        </ul>
                    </div>
                </div>

                <!-- MAIN CONTENT -->
                <div class="main-content-wrapper">

                    <!-- Hiển thị thông báo -->
                    <% if (successMessage != null) {%>
                    <div class="alert alert-success">
                        <%= successMessage%>
                    </div>
                    <% } %>

                    <% if (errorMessage != null) {%>
                    <div class="alert alert-error">
                        <%= errorMessage%>
                    </div>
                    <% }%>

                    <!-- Profile Card -->
                    <div class="profile-card">
                        <div class="text-center">
                            <div class="profile-avatar">
                                <%= user.getTenDangNhap().substring(0, 1).toUpperCase()%>
                            </div>
                            <h3><%= user.getTenDangNhap()%></h3>

                            <p class="mt-2">
                                <span class="badge <%= user.getVaiTro().equals("admin") ? "bg-danger" : "bg-success"%>">
                                    <%= user.getVaiTro().toUpperCase()%>
                                </span>
                            </p>

                            <p class="opacity-75">
                                <i class="fas fa-envelope me-2"></i><%= user.getEmail()%>
                            </p>
                        </div>
                    </div>

                    <div class="row">
                        <!-- Left -->
                        <div class="col-lg-8">
                            <div class="info-card">
                                <div class="card-header bg-transparent border-bottom">
                                    <h5 class="card-title mb-0">Thông tin chi tiết</h5>
                                </div>
                                <div class="card-body p-0">
                                    <div class="info-item">
                                        <span>Mã người dùng</span>
                                        <span>#<%= user.getMaND()%></span>
                                    </div>
                                    <div class="info-item">
                                        <span>Tên đăng nhập</span>
                                        <span><%= user.getTenDangNhap()%></span>
                                    </div>
                                    <div class="info-item">
                                        <span>Email</span>
                                        <span><%= user.getEmail()%></span>
                                    </div>
                                    <div class="info-item">
                                        <span>Vai trò</span>
                                        <span><%= user.getVaiTro()%></span>
                                    </div>
                                </div>
                            </div>

                            <div class="mt-3 d-flex gap-2">
                                <button id="editInfoBtn" class="btn btn-primary">Chỉnh sửa thông tin</button>
                                <button id="changePasswordBtn" class="btn btn-outline-secondary">Đổi mật khẩu</button>
                                <a href="<%=request.getContextPath()%>/LogoutServlet"
                                   class="btn btn-outline-danger ms-auto">Đăng xuất</a>
                            </div>
                        </div>

         
                    </div>

                </div>
            </div>
        </div>
        <!-- END PC CONTAINER -->

        <!-- Modal Chỉnh sửa thông tin -->
        <div id="editInfoModal" class="modal-overlay">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chỉnh sửa thông tin</h5>
                    <button class="modal-close">&times;</button>
                </div>
                <form id="editInfoForm" action="<%=request.getContextPath()%>/UpdateUserInfoServlet" method="POST">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="form-label" for="username">Tên đăng nhập</label>
                            <input type="text" class="form-control" id="username" name="username" value="<%= user.getTenDangNhap()%>" readonly>
                            <div class="field-note">Tên đăng nhập không thể thay đổi</div>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="email">Email *</label>
                            <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail()%>" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="role">Vai trò</label>
                            <input type="text" class="form-control" id="role" value="<%= user.getVaiTro()%>" readonly>
                            <div class="field-note">Vai trò không thể thay đổi</div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary modal-close">Hủy</button>
                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Modal Đổi mật khẩu -->
        <div id="changePasswordModal" class="modal-overlay">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Đổi mật khẩu</h5>
                    <button class="modal-close">&times;</button>
                </div>
                <form id="changePasswordForm" action="<%=request.getContextPath()%>/ChangePasswordServlet" method="POST">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="form-label" for="currentPassword">Mật khẩu hiện tại *</label>
                            <input type="password" class="form-control" id="currentPassword" name="currentPassword" placeholder="Nhập mật khẩu hiện tại" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="newPassword">Mật khẩu mới *</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Nhập mật khẩu mới" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="confirmPassword">Xác nhận mật khẩu mới *</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu mới" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary modal-close">Hủy</button>
                        <button type="submit" class="btn btn-primary">Lưu mật khẩu</button>
                    </div>
                </form>
            </div>
        </div>

        <%@ include file="../layouts/footer-block-admin.html" %>
        <%@ include file="../layouts/footer-js-admin.html" %>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const joinDays = <%= user.getMaND()%> + 10;
                let cur = 0;
                const el = document.getElementById("joinDays");
                let int = setInterval(() => {
                    cur++;
                    el.innerHTML = cur;
                    if (cur >= joinDays)
                        clearInterval(int);
                }, 20);

                // Modal functionality
                const editInfoBtn = document.getElementById('editInfoBtn');
                const changePasswordBtn = document.getElementById('changePasswordBtn');
                const editInfoModal = document.getElementById('editInfoModal');
                const changePasswordModal = document.getElementById('changePasswordModal');
                const closeButtons = document.querySelectorAll('.modal-close');

                // Mở modal chỉnh sửa thông tin
                editInfoBtn.addEventListener('click', function () {
                    editInfoModal.style.display = 'flex';
                });

                // Mở modal đổi mật khẩu
                changePasswordBtn.addEventListener('click', function () {
                    changePasswordModal.style.display = 'flex';
                });

                // Đóng modal khi click nút đóng
                closeButtons.forEach(button => {
                    button.addEventListener('click', function () {
                        editInfoModal.style.display = 'none';
                        changePasswordModal.style.display = 'none';
                    });
                });

                // Đóng modal khi click bên ngoài nội dung modal
                window.addEventListener('click', function (event) {
                    if (event.target === editInfoModal) {
                        editInfoModal.style.display = 'none';
                    }
                    if (event.target === changePasswordModal) {
                        changePasswordModal.style.display = 'none';
                    }
                });

                // Xử lý kiểm tra form đổi mật khẩu
                const changePasswordForm = document.getElementById('changePasswordForm');
                changePasswordForm.addEventListener('submit', function (e) {
                    const newPassword = document.getElementById('newPassword').value;
                    const confirmPassword = document.getElementById('confirmPassword').value;

                    if (newPassword !== confirmPassword) {
                        e.preventDefault();
                        alert('Mật khẩu mới và xác nhận mật khẩu không khớp');
                        return;
                    }

                    if (newPassword.length < 6) {
                        e.preventDefault();
                        alert('Mật khẩu mới phải có ít nhất 6 ký tự');
                        return;
                    }
                });
            });
        </script>

    </body>
</html>