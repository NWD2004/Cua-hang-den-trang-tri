<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Model.NguoiDung" %>
<%@ page import="java.util.List" %>
<%@ page import="DAO.NguoiDungDAO" %>
<!doctype html>
<html lang="en" data-pc-preset="preset-1" data-pc-sidebar-caption="true" data-pc-direction="ltr" dir="ltr" data-pc-theme="light">
    <head>
        <%@ include file="../layouts/head-page-meta-admin.html" %>
        <title>Quản lý tài khoản người dùng</title>

        <style>
            .user-table {
                background: white;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.08);
                overflow: hidden;
            }
            .table-header {
                background: linear-gradient(135deg, #3f4d67 0%, #53668a 100%);
                color: white;
                padding: 15px 20px;
            }
            .table-actions {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px 20px;
                background: #f8f9fa;
                border-bottom: 1px solid #dee2e6;
            }
            .search-box {
                max-width: 300px;
            }
            .status-badge {
                padding: 5px 10px;
                border-radius: 15px;
                font-size: 12px;
                font-weight: 500;
            }
            .badge-active {
                background: #d1ffd1;
                color: #28a745;
            }
            .badge-inactive {
                background: #ffe0e0;
                color: #dc3545;
            }
            .action-buttons {
                display: flex;
                gap: 5px;
            }
            .btn-sm {
                padding: 4px 8px;
                font-size: 12px;
            }
            .add-user-btn {
                background: linear-gradient(135deg, #3f4d67 0%, #53668a 100%);
                border: none;
                color: white;
            }
            .user-avatar {
                width: 35px;
                height: 35px;
                border-radius: 50%;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: bold;
                margin-right: 10px;
            }
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
            .modal-body {
                padding: 20px;
            }
            .modal-footer {
                padding: 15px 20px;
                border-top: 1px solid #eaeaea;
                display: flex;
                justify-content: flex-end;
                gap: 10px;
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
            .alert-info {
                background-color: #d1ecf1;
                color: #0c5460;
                border: 1px solid #bee5eb;
            }

            /* Thêm style cho form readonly */
            .form-control[readonly] {
                background-color: #f8f9fa;
                cursor: not-allowed;
            }
        </style>
    </head>

    <body>
        <%@ include file="../layouts/loader-admin.html" %>
        <%@ include file="../layouts/sidebar-admin.html" %>
        <%@ include file="../layouts/header-content-admin.jsp" %>

        <%
            // Khởi tạo DAO
            NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
            List<NguoiDung> listUser = null;
            
            // Lấy thông báo từ session
            String successMessage = (String) session.getAttribute("successMessage");
            String errorMessage = (String) session.getAttribute("errorMessage");
            String infoMessage = (String) session.getAttribute("infoMessage");
            
            // Xóa thông báo khỏi session sau khi đã lấy
            if (successMessage != null) {
                session.removeAttribute("successMessage");
            }
            if (errorMessage != null) {
                session.removeAttribute("errorMessage");
            }
            if (infoMessage != null) {
                session.removeAttribute("infoMessage");
            }

            try {
                // Lấy danh sách người dùng
                listUser = nguoiDungDAO.getAll();

            } catch (Exception e) {
                e.printStackTrace();
                errorMessage = "Lỗi hệ thống: " + e.getMessage();
            }
        %>

        <!-- Main Content -->
        <div class="pc-container">
            <div class="pc-content">
                <!-- Page Header -->
                <div class="page-header">
                    <div class="page-block">
                        <h4 class="mb-0">Quản lý tài khoản người dùng</h4>
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/View/AdminHome.jsp">Trang chủ</a></li>
                            <li class="breadcrumb-item active">Tài khoản người dùng</li>
                        </ul>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="main-content-wrapper">
                    <!-- Hiển thị thông báo -->
                    <% if (successMessage != null) { %>
                    <div class="alert alert-success">
                        <%= successMessage %>
                    </div>
                    <% } %>

                    <% if (errorMessage != null) { %>
                    <div class="alert alert-error">
                        <%= errorMessage %>
                    </div>
                    <% } %>

                    <% if (infoMessage != null) { %>
                    <div class="alert alert-info">
                        <%= infoMessage %>
                    </div>
                    <% } %>

                    <div class="user-table">
                        <!-- Table Header -->
                        <div class="table-header">
                            <h5 class="mb-0 text-white"><i class="fas fa-users me-2"></i>Danh sách tài khoản khách hàng</h5>
                        </div>

                        <!-- Table Actions -->
                        <div class="table-actions">
                            <div class="search-box">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Tìm kiếm người dùng..." id="searchInput">
                                    <button class="btn btn-outline-secondary" type="button">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>
                            </div>
                            <div>
                                <button class="btn add-user-btn" onclick="showAddUserModal()">
                                    <i class="fas fa-plus me-2"></i>Thêm người dùng
                                </button>
                            </div>
                        </div>

                        <!-- Users Table -->
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th width="50">#</th>
                                        <th>Người dùng</th>
                                        <th>Email</th>
                                        <th>Vai trò</th>
                                        <th>Trạng thái</th>
                                        <th width="150" class="text-center">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if (listUser != null && !listUser.isEmpty()) {
                                            int count = 0;
                                            for (NguoiDung user : listUser) {
                                                // Chỉ hiển thị người dùng có vai trò khách hàng
                                                if ("customer".equals(user.getVaiTro()) || "user".equals(user.getVaiTro())) {
                                                    count++;
                                    %>
                                    <tr>
                                        <td><%= count%></td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="user-avatar">
                                                    <%= user.getTenDangNhap() != null ? user.getTenDangNhap().substring(0, 1).toUpperCase() : "U"%>
                                                </div>
                                                <div>
                                                    <div class="fw-bold"><%= user.getTenDangNhap() != null ? user.getTenDangNhap() : "N/A"%></div>
                                                    <small class="text-muted">ID: #<%= user.getMaND()%></small>
                                                </div>
                                            </div>
                                        </td>
                                        <td><%= user.getEmail() != null ? user.getEmail() : "N/A"%></td>
                                        <td>
                                            <span class="badge 
                                                  <%= "admin".equals(user.getVaiTro()) ? "bg-danger"
                                                          : "customer".equals(user.getVaiTro()) ? "bg-success"
                                                          : "user".equals(user.getVaiTro()) ? "bg-info" : "bg-warning"%>">
                                                <%= user.getVaiTro() != null ? user.getVaiTro() : "N/A"%>
                                            </span>
                                        </td>
                                        <td>
                                            <span class="status-badge badge-active">Đang hoạt động</span>
                                        </td>
                                        <td>
                                            <div style="display: flex; justify-content: center; align-items: center; gap: 8px;">
                                                <a href="#" title="Xem chi tiết" class="text-primary" 
                                                   onclick="viewUserDetail(<%= user.getMaND()%>)">
                                                    <i data-feather="eye"></i>
                                                </a>
                                                <a href="#" title="Chỉnh sửa" class="text-warning btn-edit-user"
                                                   data-id="<%= user.getMaND()%>"
                                                   data-username="<%= user.getTenDangNhap()%>"
                                                   data-email="<%= user.getEmail()%>"
                                                   data-role="<%= user.getVaiTro()%>">
                                                    <i data-feather="edit"></i>
                                                </a>
                                                <a href="#" title="Xóa người dùng" class="text-danger btn-delete-user" 
                                                   data-id="<%= user.getMaND()%>"
                                                   data-username="<%= user.getTenDangNhap()%>">
                                                    <i data-feather="trash-2"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                    <%
                                            }
                                        }
                                    } else {
                                    %>
                                    <tr>
                                        <td colspan="6" class="text-center py-4">
                                            <div class="text-muted">
                                                <i class="fas fa-users fa-2x mb-3"></i>
                                                <p>Không có người dùng nào</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <% }%>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <div class="d-flex justify-content-between align-items-center p-3 border-top">
                            <div class="text-muted">
                            </div>
                            <nav>
                                <nav>
                                    <ul class="pagination mb-0" style="display: flex; flex-direction: row; list-style: none; padding: 0;">
                                        <li class="page-item disabled">
                                            <a class="page-link" href="#">Trước</a>
                                        </li>
                                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                                        <li class="page-item">
                                            <a class="page-link" href="#">Tiếp</a>
                                        </li>
                                    </ul>
                                </nav>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Add User Modal -->
        <div class="modal-overlay" id="addUserModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thêm người dùng mới</h5>
                    <button class="modal-close">&times;</button>
                </div>
                <form id="addUserForm" action="<%=request.getContextPath()%>/UserManagerServlet" method="POST">                    
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="userType" value="user">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="form-label" for="username">Tên đăng nhập *</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="email">Email *</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="password">Mật khẩu *</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="role">Vai trò</label>
                            <select class="form-control" id="role" name="role">
                                <option value="customer" selected>Khách hàng</option>
                                <option value="user">Người dùng</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary modal-close">Hủy</button>
                        <button type="submit" class="btn btn-primary">Thêm người dùng</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Edit User Modal -->
        <div class="modal-overlay" id="editUserModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chỉnh sửa người dùng</h5>
                    <button class="modal-close">&times;</button>
                </div>
                <form id="editUserForm" action="<%=request.getContextPath()%>/UserManagerServlet" method="POST">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="userType" value="user">
                    <input type="hidden" id="editUserId" name="id">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="form-label" for="editUsername">Tên đăng nhập *</label>
                            <input type="text" class="form-control" id="editUsername" name="username" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="editEmail">Email *</label>
                            <input type="email" class="form-control" id="editEmail" name="email" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Vai trò</label>
                            <input type="text" class="form-control" id="editRoleDisplay" readonly style="background-color: #f8f9fa;">
                            <input type="hidden" id="editRole" name="role">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary modal-close">Hủy</button>
                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Footer Section -->
        <div class="footer-section">
            <%@ include file="../layouts/footer-block-admin.html" %>
        </div>

        <%@ include file="../layouts/footer-js-admin.html" %>

        <script>
            // Modal functionality
            function showAddUserModal() {
                document.getElementById('addUserModal').style.display = 'flex';
            }

            function showEditUserModal() {
                document.getElementById('editUserModal').style.display = 'flex';
            }

            // Đóng modal
            document.querySelectorAll('.modal-close').forEach(button => {
                button.addEventListener('click', function () {
                    document.getElementById('addUserModal').style.display = 'none';
                    document.getElementById('editUserModal').style.display = 'none';
                });
            });

            // Đóng modal khi click bên ngoài
            window.addEventListener('click', function (event) {
                if (event.target === document.getElementById('addUserModal')) {
                    document.getElementById('addUserModal').style.display = 'none';
                }
                if (event.target === document.getElementById('editUserModal')) {
                    document.getElementById('editUserModal').style.display = 'none';
                }
            });

            // Tìm kiếm người dùng
            document.getElementById('searchInput').addEventListener('input', function (e) {
                const searchTerm = e.target.value.toLowerCase();
                const rows = document.querySelectorAll('tbody tr');

                rows.forEach(row => {
                    const username = row.cells[1].textContent.toLowerCase();
                    const email = row.cells[2].textContent.toLowerCase();

                    if (username.includes(searchTerm) || email.includes(searchTerm)) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            });

            // Hàm chuyển đổi tên vai trò
            function getRoleDisplayName(role) {
                switch(role) {
                    case 'customer': return 'Khách hàng';
                    case 'user': return 'Người dùng';
                    case 'admin': return 'Quản trị viên';
                    default: return role;
                }
            }

            // Hàm xem chi tiết người dùng
            function viewUserDetail(userId) {
                window.location.href = '${pageContext.request.contextPath}/UserManagerServlet?action=delete&userType=user&id=' + userId;
            }

            // Xử lý sự kiện cho các nút
            document.addEventListener('DOMContentLoaded', function() {
                // Nút chỉnh sửa
                document.querySelectorAll('.btn-edit-user').forEach(btn => {
                    btn.addEventListener('click', function(e) {
                        e.preventDefault();
                        const userId = this.getAttribute('data-id');
                        const username = this.getAttribute('data-username');
                        const email = this.getAttribute('data-email');
                        const role = this.getAttribute('data-role');
                        editUser(userId, username, email, role);
                    });
                });

                // Nút xóa
                document.querySelectorAll('.btn-delete-user').forEach(btn => {
                    btn.addEventListener('click', function(e) {
                        e.preventDefault();
                        const userId = this.getAttribute('data-id');
                        const username = this.getAttribute('data-username');
                        deleteUser(userId, username);
                    });
                });
            });

            // Hàm chỉnh sửa người dùng
            function editUser(userId, username, email, role) {
                document.getElementById('editUserId').value = userId;
                document.getElementById('editUsername').value = username;
                document.getElementById('editEmail').value = email;
                // Hiển thị vai trò nhưng không cho sửa
                document.getElementById('editRoleDisplay').value = getRoleDisplayName(role);
                document.getElementById('editRole').value = role;
                showEditUserModal();
            }

            // Hàm xóa người dùng
            function deleteUser(userId, username) {
                if (confirm('Bạn có chắc chắn muốn xóa người dùng "' + username + '"?')) {
                    window.location.href = '${pageContext.request.contextPath}/UserManagerServlet?action=delete&userType=user&id=' + userId;
                }
            }

            // Tự động ẩn thông báo sau 5 giây
            setTimeout(function() {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(alert => {
                    alert.style.display = 'none';
                });
            }, 5000);

            // Khởi tạo Feather Icons
            if (typeof feather !== 'undefined') {
                feather.replace();
            }
        </script>
    </body>
</html>