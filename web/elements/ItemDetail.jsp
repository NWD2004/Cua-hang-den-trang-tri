<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en" data-pc-preset="preset-1" data-pc-sidebar-caption="true" data-pc-direction="ltr" dir="ltr" data-pc-theme="light">
    <head>
        <%@ include file="../layouts/head-page-meta-admin.html" %>
        <style>
            /* CSS cho phần lọc mới */
            .search-section {
                background: white;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.06);
                margin-bottom: 20px;
                border: 1px solid #f0f0f0;
            }
            
            .filter-section {
                display: flex;
                align-items: center;
                flex-wrap: wrap;
                gap: 15px;
            }
            
            .search-results-info {
                background: #f8f9fa;
                padding: 6px 12px;
                border-radius: 20px;
                font-weight: 500;
                color: #6c757d;
            }
            
            .filter-buttons {
                display: flex;
                gap: 8px;
                flex-wrap: wrap;
            }
            
            .filter-btn {
                border: 1px solid #dee2e6;
                background: white;
                color: #6c757d;
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 14px;
                transition: all 0.2s ease;
            }
            
            .filter-btn.active {
                background: #3f4d67;
                color: white;
                border-color: #3f4d67;
            }
            
            .filter-btn:hover {
                background: #f8f9fa;
                color: #3f4d67;
            }
            
            .filter-label {
                font-weight: 500;
                color: #495057;
                white-space: nowrap;
            }
            
            .modal-fade {
                opacity: 0;
                pointer-events: none;
                transition: opacity 0.3s ease;
            }
            .modal-fade.show {
                opacity: 1;
                pointer-events: auto;
            }

            /* Phân trang */
            .pagination-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 20px;
                padding: 15px 0;
                border-top: 1px solid #e9ecef;
            }

            .pagination-info {
                color: #6c757d;
                font-size: 14px;
            }

            .pagination {
                margin: 0;
                display: flex;
                gap: 5px;
            }

            .page-item {
                list-style: none;
            }

            .page-link {
                display: block;
                padding: 8px 12px;
                border: 1px solid #dee2e6;
                border-radius: 6px;
                color: #3f4d67;
                text-decoration: none;
                transition: all 0.2s ease;
            }

            .page-link:hover {
                background-color: #f8f9fa;
                border-color: #dee2e6;
            }

            .page-item.active .page-link {
                background-color: #3f4d67;
                border-color: #3f4d67;
                color: white;
            }

            .page-item.disabled .page-link {
                color: #6c757d;
                background-color: #f8f9fa;
                border-color: #dee2e6;
                cursor: not-allowed;
            }

            .page-size-selector {
                margin-left: 20px;
            }

            .page-size-selector select {
                padding: 6px 10px;
                border: 1px solid #dee2e6;
                border-radius: 6px;
                background: white;
            }

            /* Stats Cards */
            .stats-cards {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 15px;
                margin-bottom: 20px;
            }

            .stat-card {
                background: white;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.06);
                text-align: center;
                border-left: 4px solid #3f4d67;
            }

            .stat-number {
                font-size: 24px;
                font-weight: 700;
                color: #3f4d67;
                margin-bottom: 5px;
            }

            .stat-label {
                color: #6c757d;
                font-size: 14px;
            }

            /* Action buttons */
            .action-buttons {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 8px;
            }

            .action-buttons a {
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 32px;
                height: 32px;
                border-radius: 6px;
                transition: all 0.2s ease;
            }

            .action-buttons a:hover {
                transform: translateY(-2px);
            }

            .btn-edit:hover {
                background-color: rgba(255, 193, 7, 0.1);
            }

            .btn-delete:hover {
                background-color: rgba(220, 53, 69, 0.1);
            }

            .btn-add:hover {
                background-color: rgba(25, 135, 84, 0.1);
            }
        </style>
    </head>
    <body>
        <%@ include file="../layouts/loader-admin.html" %>
        <%@ include file="../layouts/sidebar-admin.html" %>
        <%@ include file="../layouts/header-content-admin.jsp" %>
        <div class="pc-container">
            <div class="pc-content">
                <div class="card mt-8">
                    <div class="card-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Danh sách biến thể đèn</h5>
                            <span class="badge bg-light text-dark">
                                <i class="fas fa-cubes me-2"></i>
                                <%= new DAO.BienTheDenDAO().getAll().size() %> biến thể
                            </span>
                        </div>
                    </div>
                    <div class="card-body">

                        <%
                            String msg = request.getParameter("msg");
                            String error = request.getParameter("error");
                            
                            DAO.BienTheDenDAO btdDAO = new DAO.BienTheDenDAO();
                            DAO.DenDAO denDAO = new DAO.DenDAO();
                            DAO.MauSacDAO mauDAO = new DAO.MauSacDAO();
                            DAO.KichThuocDAO ktDAO = new DAO.KichThuocDAO();
                            DAO.LoaiDenDAO ldDAO = new DAO.LoaiDenDAO();

                            // Phân trang
                            int pageSize = 10;
                            String pageSizeParam = request.getParameter("pageSize");
                            if (pageSizeParam != null && !pageSizeParam.isEmpty()) {
                                try {
                                    pageSize = Integer.parseInt(pageSizeParam);
                                } catch (NumberFormatException e) {
                                    pageSize = 10;
                                }
                            }
                            
                            int currentPage = 1;
                            String pageParam = request.getParameter("page");
                            if (pageParam != null && !pageParam.isEmpty()) {
                                try {
                                    currentPage = Integer.parseInt(pageParam);
                                } catch (NumberFormatException e) {
                                    currentPage = 1;
                                }
                            }
                            
                            // Lấy toàn bộ danh sách
                            java.util.List<Model.BienTheDen> allBienThes = btdDAO.getAll();
                            int totalBienThes = allBienThes.size();
                            int totalPages = (int) Math.ceil((double) totalBienThes / pageSize);
                            
                            // Đảm bảo currentPage hợp lệ
                            if (currentPage < 1) currentPage = 1;
                            if (currentPage > totalPages && totalPages > 0) currentPage = totalPages;
                            
                            int startIndex = (currentPage - 1) * pageSize;
                            int endIndex = Math.min(startIndex + pageSize, totalBienThes);
                            
                            java.util.List<Model.BienTheDen> currentPageBienThes = allBienThes.subList(startIndex, endIndex);
                            
                            java.util.List<Model.Den> listDen = denDAO.getAll();
                            java.util.List<Model.MauSac> listMau = mauDAO.getAll();
                            java.util.List<Model.KichThuoc> listKT = ktDAO.getAll();
                            java.util.List<Model.LoaiDen> listLd = ldDAO.getAll();

                            // Thống kê
                            int totalColors = listMau.size();
                            int totalSizes = listKT.size();
                            int totalLamps = listDen.size();

                            // Tạo map để lưu mã loại theo mã đèn
                            java.util.Map<Integer, Integer> denToLoaiMap = new java.util.HashMap<>();
                            for (Model.Den den : listDen) {
                                denToLoaiMap.put(den.getMaDen(), den.getMaLoai());
                            }
                        %>
                        
                        <% if ("add_success".equals(msg)) { %>
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            Thêm biến thể thành công!
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <% } else if ("edit_success".equals(msg)) { %>
                        <div class="alert alert-info alert-dismissible fade show" role="alert">
                            Cập nhật thành công!
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <% } else if ("delete_success".equals(msg)) { %>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            Xóa thành công!
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <% } else if (error != null) {%>
                        <div class="alert alert-warning alert-dismissible fade show" role="alert">
                            <%= java.net.URLDecoder.decode(error, "UTF-8")%>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <% } %>

                        <!-- Stats Cards -->
                        <div class="stats-cards">
                            <div class="stat-card">
                                <div class="stat-number"><%= totalBienThes %></div>
                                <div class="stat-label">Tổng biến thể</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number"><%= totalLamps %></div>
                                <div class="stat-label">Loại đèn</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number"><%= totalColors %></div>
                                <div class="stat-label">Màu sắc</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number"><%= totalSizes %></div>
                                <div class="stat-label">Kích thước</div>
                            </div>
                        </div>

                        <!-- PHẦN LỌC MỚI - ĐÃ SỬA -->
                        <div class="search-section">
                            <!-- Search Row -->
                            <div class="row mb-3">
                                <div class="col-md-8">
                                    <div class="search-box">
                                        <label for="searchInput" class="form-label fw-medium text-muted mb-2">Tìm kiếm biến thể</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-light border-end-0">
                                                <i class="fas fa-search"></i>
                                            </span>
                                            <input type="text" class="form-control border-start-0" 
                                                   id="searchInput" placeholder="Nhập tên đèn, màu sắc, kích thước...">
                                            <button class="btn btn-outline-secondary" type="button" id="clearSearch">
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Filter Row - ĐÃ SỬA -->
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="d-flex justify-content-between align-items-center">
                                        
                                        <!-- Hiển thị số kết quả -->
                                        <div class="search-results-info">
                                            <span id="searchResultsCount"><%= currentPageBienThes.size() %></span> biến thể / trang
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Bảng dữ liệu - ĐÃ THÊM data-loai -->
                        <div class="table-responsive">
                            <table class="table table-hover" id="bienTheTable">
                                <thead class="table-light">
                                    <tr>
                                        <th>Mã biến thể</th>
                                        <th>Đèn</th>
                                        <th>Màu sắc</th>
                                        <th>Kích thước</th>
                                        <th style="width: 120px; text-align: center;">Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (currentPageBienThes.isEmpty()) { %>
                                    <tr>
                                        <td colspan="5" class="text-center text-muted py-4">
                                            <i class="fas fa-inbox fa-2x mb-2"></i><br>
                                            Không có biến thể nào
                                        </td>
                                    </tr>
                                    <% } else { 
                                        for (Model.BienTheDen btd : currentPageBienThes) {
                                            String tenDen = denDAO.getTenDenById(btd.getMaDen());
                                            String tenMau = (btd.getMaMau() != null && btd.getMaMau() != 0) ? mauDAO.getTenMauById(btd.getMaMau()) : "-";
                                            String tenKT = (btd.getMaKichThuoc() != null && btd.getMaKichThuoc() != 0) ? ktDAO.getTenKichThuocById(btd.getMaKichThuoc()) : "-";

                                            // Lấy mã loại từ map
                                            Integer maLoai = denToLoaiMap.get(btd.getMaDen());
                                            String dataLoai = maLoai != null ? "loai-" + maLoai : "";

                                            String safeIdStr = String.valueOf(btd.getMaBienThe());
                                    %>
                                    <tr data-den="<%= btd.getMaDen() %>" data-loai="<%= dataLoai %>">
                                        <td><strong><%= btd.getMaBienThe()%></strong></td>
                                        <td>
                                            <div>
                                                <div><strong><%= tenDen%></strong></div>
                                                <small class="text-muted">Mã đèn: <%= btd.getMaDen()%></small>
                                            </div>
                                        </td>
                                        <td>
                                            <% if (!"-".equals(tenMau)) { %>
                                            <span class="badge bg-light text-dark">
                                                <i class="fas fa-palette me-1"></i>
                                                <%= tenMau%>
                                            </span>
                                            <% } else { %>
                                            <span class="text-muted">-</span>
                                            <% } %>
                                        </td>
                                        <td>
                                            <% if (!"-".equals(tenKT)) { %>
                                            <span class="badge bg-info text-white">
                                                <i class="fas fa-ruler me-1"></i>
                                                <%= tenKT%>
                                            </span>
                                            <% } else { %>
                                            <span class="text-muted">-</span>
                                            <% } %>
                                        </td>
                                        <td style="text-align: center; vertical-align: middle;">
                                            <div class="action-buttons">
                                                <a href="#" title="Sửa" class="text-warning btn-edit"
                                                   data-id="<%= safeIdStr%>"
                                                   data-den="<%= btd.getMaDen()%>"
                                                   data-mau="<%= btd.getMaMau() != null ? btd.getMaMau() : ""%>"
                                                   data-kt="<%= btd.getMaKichThuoc() != null ? btd.getMaKichThuoc() : ""%>">
                                                    <i data-feather="edit"></i>
                                                </a>
                                                <a href="#" title="Xóa" class="text-danger btn-delete"
                                                   data-id="<%= safeIdStr%>"
                                                   data-ten="<%= tenDen %>">
                                                    <i data-feather="trash-2"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                    <% } 
                                    } %>
                                </tbody>
                            </table>
                        </div>

                        <!-- Phân trang -->
                        <% if (totalPages > 1) { %>
                        <div class="pagination-container">
                            <div class="pagination-info">
                                Hiển thị <%= startIndex + 1 %> - <%= endIndex %> của <%= totalBienThes %> biến thể
                            </div>
                            
                            <ul class="pagination">
                                <!-- Nút Previous -->
                                <% if (currentPage > 1) { %>
                                <li class="page-item">
                                    <a class="page-link" href="?page=<%= currentPage - 1 %>&pageSize=<%= pageSize %>">&laquo;</a>
                                </li>
                                <% } else { %>
                                <li class="page-item disabled">
                                    <span class="page-link">&laquo;</span>
                                </li>
                                <% } %>
                                
                                <!-- Các trang -->
                                <% 
                                int startPage = Math.max(1, currentPage - 2);
                                int endPage = Math.min(totalPages, currentPage + 2);
                                
                                for (int i = startPage; i <= endPage; i++) { 
                                %>
                                <li class="page-item <%= i == currentPage ? "active" : "" %>">
                                    <a class="page-link" href="?page=<%= i %>&pageSize=<%= pageSize %>"><%= i %></a>
                                </li>
                                <% } %>
                                
                                <!-- Nút Next -->
                                <% if (currentPage < totalPages) { %>
                                <li class="page-item">
                                    <a class="page-link" href="?page=<%= currentPage + 1 %>&pageSize=<%= pageSize %>">&raquo;</a>
                                </li>
                                <% } else { %>
                                <li class="page-item disabled">
                                    <span class="page-link">&raquo;</span>
                                </li>
                                <% } %>
                            </ul>
                            
                            <!-- Chọn số biến thể mỗi trang -->
                            <div class="page-size-selector">
                                <select class="form-select form-select-sm" onchange="changePageSize(this.value)" style="width: auto;">
                                    <option value="10" <%= pageSize == 10 ? "selected" : "" %>>10 / trang</option>
                                    <option value="25" <%= pageSize == 25 ? "selected" : "" %>>25 / trang</option>
                                    <option value="50" <%= pageSize == 50 ? "selected" : "" %>>50 / trang</option>
                                </select>
                            </div>
                        </div>
                        <% } %>

                        <!-- NÚT THÊM MỚI -->
                        <div class="mb-3">
                            <button id="btnShowAddBienThe" type="button" class="btn btn-primary d-flex align-items-center" style="display: inline-flex; align-items: center; gap: 6px;">
                                <i data-feather="plus"></i>
                                <span>Thêm biến thể mới</span>
                            </button>
                        </div>

                        <!-- MODAL THÊM MỚI -->
                        <div id="addBienTheModal" class="modal-fade" style="display:none; position:fixed; z-index:1050; left:0; top:0; width:100vw; height:100vh; background:rgba(0,0,0,0.5); align-items:center; justify-content:center;">
                            <div style="background:#fff; border-radius:8px; max-width:500px; width:90vw; padding:30px; position:relative; box-shadow:0 10px 30px rgba(0,0,0,0.3);">
                                <h5 class="mb-4">Thêm biến thể mới</h5>
                                <form id="addBienTheForm" action="<%=request.getContextPath()%>/them-bien-the" method="post">
                                    <div class="mb-3">
                                        <label for="addMaDen" class="form-label">Đèn *</label>
                                        <select class="form-select" id="addMaDen" name="maDen" required>
                                            <option value="">-- Chọn đèn --</option>
                                            <% for (Model.Den d : listDen) {%>
                                            <option value="<%= d.getMaDen()%>"><%= d.getTenDen()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="addMaMau" class="form-label">Màu sắc</label>
                                        <select class="form-select" id="addMaMau" name="maMau">
                                            <option value="">-- Chọn màu (tùy chọn) --</option>
                                            <% for (Model.MauSac m : listMau) {%>
                                            <option value="<%= m.getMaMau()%>"><%= m.getTenMau()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="addMaKT" class="form-label">Kích thước</label>
                                        <select class="form-select" id="addMaKT" name="maKichThuoc">
                                            <option value="">-- Chọn kích thước (tùy chọn) --</option>
                                            <% for (Model.KichThuoc k : listKT) {%>
                                            <option value="<%= k.getMaKichThuoc()%>"><%= k.getTenKichThuoc()%></option>
                                            <% }%>
                                        </select>
                                    </div>
                                    <div class="mt-4 d-flex justify-content-end" style="gap:12px;">
                                        <button type="button" id="btnCloseAddBienThe" class="btn btn-secondary">Hủy</button>
                                        <button type="submit" class="btn btn-primary">Thêm biến thể</button>
                                    </div>
                                </form>
                                <button id="btnCloseAddBienTheX" type="button" style="position:absolute; top:15px; right:15px; background:none; border:none; font-size:24px; color:#6c757d; cursor:pointer;">×</button>
                            </div>
                        </div>

                        <!-- MODAL SỬA -->
                        <div id="editBienTheModal" class="modal-fade" style="display:none; position:fixed; z-index:1050; left:0; top:0; width:100vw; height:100vh; background:rgba(0,0,0,0.5); align-items:center; justify-content:center;">
                            <div style="background:#fff; border-radius:8px; max-width:500px; width:90vw; padding:30px; position:relative; box-shadow:0 10px 30px rgba(0,0,0,0.3);">
                                <h5 class="mb-4">Cập nhật biến thể</h5>
                                <form id="editBienTheForm" action="<%=request.getContextPath()%>/sua-bien-the" method="post">
                                    <input type="hidden" id="editMaBienThe" name="maBienThe" />
                                    <div class="mb-3">
                                        <label for="editMaDen" class="form-label">Đèn *</label>
                                        <select class="form-select" id="editMaDen" name="maDen" required>
                                            <option value="">-- Chọn đèn --</option>
                                            <% for (Model.Den d : listDen) {%>
                                            <option value="<%= d.getMaDen()%>"><%= d.getTenDen()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="editMaMau" class="form-label">Màu sắc</label>
                                        <select class="form-select" id="editMaMau" name="maMau">
                                            <option value="">-- Chọn màu (tùy chọn) --</option>
                                            <% for (Model.MauSac m : listMau) {%>
                                            <option value="<%= m.getMaMau()%>"><%= m.getTenMau()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="editMaKT" class="form-label">Kích thước</label>
                                        <select class="form-select" id="editMaKT" name="maKichThuoc">
                                            <option value="">-- Chọn kích thước (tùy chọn) --</option>
                                            <% for (Model.KichThuoc k : listKT) {%>
                                            <option value="<%= k.getMaKichThuoc()%>"><%= k.getTenKichThuoc()%></option>
                                            <% }%>
                                        </select>
                                    </div>
                                    <div class="mt-4 d-flex justify-content-end" style="gap:12px;">
                                        <button type="button" id="btnCloseEditBienThe" class="btn btn-secondary">Hủy</button>
                                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                                    </div>
                                </form>
                                <button id="btnCloseEditBienTheX" type="button" style="position:absolute; top:15px; right:15px; background:none; border:none; font-size:24px; color:#6c757d; cursor:pointer;">×</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@ include file="../layouts/footer-block-admin.html" %>

        <script>
            // Hàm thay đổi số biến thể mỗi trang
            function changePageSize(size) {
                const url = new URL(window.location.href);
                url.searchParams.set('pageSize', size);
                url.searchParams.set('page', '1'); // Reset về trang 1
                window.location.href = url.toString();
            }

            document.addEventListener('DOMContentLoaded', function () {
                // === PHẦN LỌC MỚI - ĐÃ SỬA ===
                const searchInput = document.getElementById('searchInput');
                const clearSearch = document.getElementById('clearSearch');
                const bienTheTable = document.getElementById('bienTheTable');
                const searchResultsCount = document.getElementById('searchResultsCount');
                
                // TÌM KIẾM BIẾN THỂ
                if (searchInput) {
                    searchInput.addEventListener('input', function(e) {
                        const searchTerm = e.target.value.toLowerCase().trim();
                        const rows = bienTheTable.querySelectorAll('tbody tr');
                        let visibleCount = 0;
                        
                        rows.forEach(row => {
                            const denName = row.cells[1].textContent.toLowerCase();
                            const mauSac = row.cells[2].textContent.toLowerCase();
                            const kichThuoc = row.cells[3].textContent.toLowerCase();
                            
                            if (denName.includes(searchTerm) || 
                                mauSac.includes(searchTerm) || 
                                kichThuoc.includes(searchTerm)) {
                                row.style.display = '';
                                visibleCount++;
                            } else {
                                row.style.display = 'none';
                            }
                        });
                        
                        // Cập nhật số kết quả
                        if (searchResultsCount) {
                            searchResultsCount.textContent = visibleCount + ' biến thể / trang';
                        }
                    });
                }
                
                if (clearSearch) {
                    clearSearch.addEventListener('click', function() {
                        searchInput.value = '';
                        searchInput.dispatchEvent(new Event('input'));
                        searchInput.focus();
                    });
                }
                
                // LỌC THEO LOẠI ĐÈN - ĐÃ SỬA HOÀN TOÀN
                const filterButtons = document.querySelectorAll('.filter-btn');
                filterButtons.forEach(btn => {
                    btn.addEventListener('click', function() {
                        // Xóa active class từ tất cả buttons
                        filterButtons.forEach(b => b.classList.remove('active'));
                        // Thêm active class cho button được click
                        this.classList.add('active');
                        
                        const filterValue = this.getAttribute('data-filter');
                        const rows = bienTheTable.querySelectorAll('tbody tr');
                        let visibleCount = 0;
                        
                        rows.forEach(row => {
                            if (filterValue === 'all') {
                                row.style.display = '';
                                visibleCount++;
                            } else {
                                const rowLoai = row.getAttribute('data-loai');
                                if (rowLoai === filterValue) {
                                    row.style.display = '';
                                    visibleCount++;
                                } else {
                                    row.style.display = 'none';
                                }
                            }
                        });
                        
                        // Cập nhật số kết quả
                        if (searchResultsCount) {
                            searchResultsCount.textContent = visibleCount + ' biến thể / trang';
                        }
                    });
                });

                // === QUẢN LÝ MODAL ===
                const addModal = document.getElementById('addBienTheModal');
                const editModal = document.getElementById('editBienTheModal');
                const btnShowAdd = document.getElementById('btnShowAddBienThe');
                const btnCloseAdd = document.getElementById('btnCloseAddBienThe');
                const btnCloseAddX = document.getElementById('btnCloseAddBienTheX');
                const btnCloseEdit = document.getElementById('btnCloseEditBienThe');
                const btnCloseEditX = document.getElementById('btnCloseEditBienTheX');

                function showModal(modal) {
                    modal.style.display = 'flex';
                    setTimeout(() => modal.classList.add('show'), 10);
                }

                function hideModal(modal) {
                    modal.classList.remove('show');
                    setTimeout(() => modal.style.display = 'none', 300);
                }

                // 1. NÚT "THÊM BIẾN THỂ MỚI" (dưới bảng)
                if (btnShowAdd) {
                    btnShowAdd.onclick = () => showModal(addModal);
                }

                // 2. NÚT "SỬA"
                document.querySelectorAll('.btn-edit').forEach(btn => {
                    btn.addEventListener('click', function (e) {
                        e.preventDefault();
                        const data = this.dataset;
                        document.getElementById('editMaBienThe').value = data.id;
                        document.getElementById('editMaDen').value = data.den;
                        document.getElementById('editMaMau').value = data.mau || '';
                        document.getElementById('editMaKT').value = data.kt || '';
                        showModal(editModal);
                    });
                });

                // 3. NÚT "XÓA"
                document.querySelectorAll('.btn-delete').forEach(btn => {
                    btn.addEventListener('click', function (e) {
                        e.preventDefault();
                        const id = this.dataset.id;
                        const tenDen = this.dataset.ten || 'biến thể này';

                        // KIỂM TRA KỸ: Không được rỗng và phải là số hợp lệ
                        if (!id || id.trim() === '' || isNaN(parseInt(id))) {
                            alert('Lỗi: Không tìm thấy Mã Biến Thể hợp lệ để xóa. ID: ' + id);
                            return;
                        }

                        // Hiển thị popup xác nhận
                        if (confirm('Bạn có chắc muốn xóa biến thể mã ' + id + ' (' + tenDen + ') không?')) {
                            // Dẫn đến Servlet xóa
                            window.location.href = '<%= request.getContextPath()%>/xoa-bien-the?id=' + encodeURIComponent(id);
                        }
                    });
                });

                // ĐÓNG MODAL
                if (btnCloseAdd)
                    btnCloseAdd.onclick = () => hideModal(addModal);
                if (btnCloseAddX)
                    btnCloseAddX.onclick = () => hideModal(addModal);
                if (btnCloseEdit)
                    btnCloseEdit.onclick = () => hideModal(editModal);
                if (btnCloseEditX)
                    btnCloseEditX.onclick = () => hideModal(editModal);

                // Đóng khi click ngoài modal
                if (addModal) {
                    addModal.onclick = e => {
                        if (e.target === addModal)
                            hideModal(addModal);
                    };
                }
                if (editModal) {
                    editModal.onclick = e => {
                        if (e.target === editModal)
                            hideModal(editModal);
                    };
                }

                // KHỞI TẠO FEATHER ICONS
                if (typeof feather !== 'undefined') {
                    feather.replace();
                }
            });
        </script>

        <%@ include file="../layouts/footer-js-admin.html" %>
    </body>
</html> 