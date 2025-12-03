<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="Model.*"%>
<%@page import="DAO.*"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý loại sản phẩm - LightShop Admin</title>
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="../assets/css/admin-main-content.css">
    <link rel="stylesheet" href="../assets/css/admin-animations.css">
    <link rel="stylesheet" href="../assets/css/admin-dashboard.css">

    <style>
        .category-hero {
            background: linear-gradient(135deg, #0f172a, #1e293b);
            border-radius: 18px;
            padding: 28px;
            margin-bottom: 28px;
            color: #fff;
            box-shadow: 0 20px 35px rgba(15, 23, 42, 0.35);
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 24px;
            flex-wrap: wrap;
        }

        .category-hero h1 {
            font-size: 26px;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .category-hero p {
            margin: 6px 0 0;
            opacity: .85;
        }

        .table-container {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 12px 24px rgba(15, 23, 42, 0.05);
            border: 1px solid rgba(226, 232, 240, 0.7);
            overflow: hidden;
        }

        .table-header {
            padding: 20px 24px;
            border-bottom: 1px solid rgba(226, 232, 240, 0.7);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #f8fafc;
        }

        .table-header h3 {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
            color: #0f172a;
        }

        .categories-table {
            width: 100%;
            border-collapse: collapse;
        }

        .categories-table thead {
            background: #f8fafc;
        }

        .categories-table th {
            padding: 14px 16px;
            text-align: left;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #64748b;
            border-bottom: 2px solid #e2e8f0;
        }

        .categories-table td {
            padding: 16px;
            border-bottom: 1px solid #e2e8f0;
            color: #334155;
        }

        .categories-table tbody tr:hover {
            background: #f8fafc;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn-action {
            padding: 6px 12px;
            border: none;
            border-radius: 8px;
            font-size: 13px;
            cursor: pointer;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-edit {
            background: rgba(59, 130, 246, 0.1);
            color: #3b82f6;
        }

        .btn-edit:hover {
            background: rgba(59, 130, 246, 0.2);
        }

        .btn-delete {
            background: rgba(239, 68, 68, 0.1);
            color: #ef4444;
        }

        .btn-delete:hover {
            background: rgba(239, 68, 68, 0.2);
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 2000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background: rgba(15, 23, 42, 0.6);
            backdrop-filter: blur(4px);
        }

        .modal-content {
            background: #fff;
            margin: 5% auto;
            padding: 0;
            border-radius: 16px;
            width: 90%;
            max-width: 600px;
            box-shadow: 0 25px 50px rgba(15, 23, 42, 0.25);
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from {
                transform: translateY(-20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .modal-header {
            padding: 24px;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h2 {
            margin: 0;
            font-size: 20px;
            font-weight: 600;
            color: #0f172a;
        }

        .modal-body {
            padding: 24px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #334155;
            font-size: 14px;
        }

        .form-control {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.2s;
        }

        .form-control:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        textarea.form-control {
            resize: vertical;
            min-height: 100px;
        }

        .modal-footer {
            padding: 20px 24px;
            border-top: 1px solid #e2e8f0;
            display: flex;
            justify-content: flex-end;
            gap: 12px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #3b82f6, #2563eb);
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(59, 130, 246, 0.3);
        }

        .btn-secondary {
            background: #64748b;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
        }

        .btn-secondary:hover {
            background: #475569;
        }

        .close {
            background: none;
            border: none;
            font-size: 24px;
            color: #94a3b8;
            cursor: pointer;
            padding: 0;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            transition: all 0.2s;
        }

        .close:hover {
            background: #f1f5f9;
            color: #0f172a;
        }

        .alert {
            padding: 14px 18px;
            border-radius: 12px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-success {
            background: #ecfdf5;
            color: #047857;
            border: 1px solid #bbf7d0;
        }

        .alert-error {
            background: #fef2f2;
            color: #b91c1c;
            border: 1px solid #fecaca;
        }

        .badge {
            padding: 4px 10px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-info {
            background: rgba(59, 130, 246, 0.1);
            color: #3b82f6;
        }

        .no-data {
            text-align: center;
            padding: 60px 20px;
            color: #94a3b8;
        }

        .no-data i {
            font-size: 48px;
            margin-bottom: 16px;
            opacity: 0.5;
        }
    </style>
</head>
<body>
<%
    LoaiDenDAO loaiDenDAO = new LoaiDenDAO();
    List<LoaiDen> loaiDenList = loaiDenDAO.getAll();
    if (loaiDenList == null) {
        loaiDenList = new ArrayList<>();
    }

    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<jsp:include page="../layouts/sidebar-admin.html"/>
<jsp:include page="../layouts/header-content-admin.jsp"/>

<div class="pc-container">
    <section class="category-hero">
        <div>
            <h1>
                <i class="fas fa-tags"></i>
                Quản lý loại sản phẩm
            </h1>
            <p>Thêm, sửa, xóa và quản lý các loại đèn trong hệ thống</p>
        </div>
        <button class="btn-primary" onclick="showAddModal()">
            <i class="fas fa-plus-circle"></i>
            Thêm loại mới
        </button>
    </section>

    <% if (successMessage != null) { %>
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i>
        <%= successMessage %>
    </div>
    <% } %>

    <% if (errorMessage != null) { %>
    <div class="alert alert-error">
        <i class="fas fa-exclamation-circle"></i>
        <%= errorMessage %>
    </div>
    <% } %>

    <div class="table-container">
        <div class="table-header">
            <h3>Danh sách loại sản phẩm</h3>
            <span class="badge badge-info"><%= loaiDenList.size() %> loại</span>
        </div>

        <% if (loaiDenList.isEmpty()) { %>
        <div class="no-data">
            <i class="fas fa-inbox"></i>
            <p>Chưa có loại sản phẩm nào</p>
        </div>
        <% } else { %>
        <table class="categories-table">
            <thead>
                <tr>
                    <th>Mã loại</th>
                    <th>Tên loại</th>
                    <th>Mô tả</th>
                    <th>Số sản phẩm</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <% for (LoaiDen loai : loaiDenList) { 
                    int productCount = loaiDenDAO.countProductsByCategory(loai.getMaLoai());
                %>
                <tr>
                    <td><strong>#<%= loai.getMaLoai() %></strong></td>
                    <td><strong><%= loai.getTenLoai() %></strong></td>
                    <td><%= loai.getMoTa() != null && !loai.getMoTa().isEmpty() ? loai.getMoTa() : "<span style='color:#94a3b8;'>Chưa có mô tả</span>" %></td>
                    <td>
                        <span class="badge badge-info"><%= productCount %> sản phẩm</span>
                    </td>
                    <td>
                        <div class="action-buttons">
                            <button class="btn-action btn-edit" onclick="showEditModal(<%= loai.getMaLoai() %>, '<%= loai.getTenLoai().replace("'", "\\'") %>', '<%= (loai.getMoTa() != null ? loai.getMoTa().replace("'", "\\'") : "").replace("\"", "\\\"") %>')">
                                <i class="fas fa-edit"></i>
                                Sửa
                            </button>
                            <button class="btn-action btn-delete" onclick="confirmDelete(<%= loai.getMaLoai() %>, '<%= loai.getTenLoai().replace("'", "\\'") %>', <%= productCount %>)">
                                <i class="fas fa-trash"></i>
                                Xóa
                            </button>
                        </div>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } %>
    </div>
</div>

<!-- Modal Thêm/Sửa -->
<div id="categoryModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2 id="modalTitle">Thêm loại sản phẩm mới</h2>
            <button class="close" onclick="closeModal()">&times;</button>
        </div>
        <form id="categoryForm" method="POST" action="${pageContext.request.contextPath}/CategoryManagementServlet">
            <input type="hidden" name="action" id="formAction" value="add">
            <input type="hidden" name="maLoai" id="formMaLoai">
            <div class="modal-body">
                <div class="form-group">
                    <label class="form-label" for="tenLoai">Tên loại sản phẩm <span style="color:#ef4444;">*</span></label>
                    <input type="text" class="form-control" id="tenLoai" name="tenLoai" required 
                           placeholder="Ví dụ: Đèn trần, Đèn bàn, Đèn sân vườn...">
                </div>
                <div class="form-group">
                    <label class="form-label" for="moTa">Mô tả</label>
                    <textarea class="form-control" id="moTa" name="moTa" 
                              placeholder="Nhập mô tả về loại sản phẩm này (tùy chọn)"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-secondary" onclick="closeModal()">Hủy</button>
                <button type="submit" class="btn-primary">
                    <i class="fas fa-save"></i>
                    Lưu
                </button>
            </div>
        </form>
    </div>
</div>

<script>
function showAddModal() {
    document.getElementById('modalTitle').textContent = 'Thêm loại sản phẩm mới';
    document.getElementById('formAction').value = 'add';
    document.getElementById('formMaLoai').value = '';
    document.getElementById('tenLoai').value = '';
    document.getElementById('moTa').value = '';
    document.getElementById('categoryModal').style.display = 'block';
}

function showEditModal(maLoai, tenLoai, moTa) {
    document.getElementById('modalTitle').textContent = 'Sửa loại sản phẩm';
    document.getElementById('formAction').value = 'update';
    document.getElementById('formMaLoai').value = maLoai;
    document.getElementById('tenLoai').value = tenLoai;
    document.getElementById('moTa').value = moTa || '';
    document.getElementById('categoryModal').style.display = 'block';
}

function closeModal() {
    document.getElementById('categoryModal').style.display = 'none';
}

function confirmDelete(maLoai, tenLoai, productCount) {
    if (productCount > 0) {
        alert('Không thể xóa loại "' + tenLoai + '" vì có ' + productCount + ' sản phẩm đang sử dụng loại này.\n\nVui lòng xóa hoặc chuyển các sản phẩm trước khi xóa loại.');
        return;
    }
    
    if (confirm('Bạn có chắc chắn muốn xóa loại "' + tenLoai + '"?')) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/CategoryManagementServlet';
        
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'delete';
        form.appendChild(actionInput);
        
        const maLoaiInput = document.createElement('input');
        maLoaiInput.type = 'hidden';
        maLoaiInput.name = 'maLoai';
        maLoaiInput.value = maLoai;
        form.appendChild(maLoaiInput);
        
        document.body.appendChild(form);
        form.submit();
    }
}

// Đóng modal khi click bên ngoài
window.onclick = function(event) {
    const modal = document.getElementById('categoryModal');
    if (event.target == modal) {
        closeModal();
    }
}
</script>

</body>
</html>

