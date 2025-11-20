<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en" data-pc-preset="preset-1" data-pc-sidebar-caption="true" data-pc-direction="ltr" dir="ltr" data-pc-theme="light">
    <head>
        <%@ include file="../layouts/head-page-meta-admin.html" %>
        <style>
            .search-section {
                background: white;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.06);
                margin-bottom: 20px;
                border: 1px solid #f0f0f0;
            }

            .search-results-info {
                background: #f8f9fa;
                padding: 6px 12px;
                border-radius: 20px;
                font-weight: 500;
                color: #6c757d;
            }

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

            .no-results {
                text-align: center;
                padding: 40px;
                color: #6c757d;
            }

            .no-results i {
                font-size: 48px;
                margin-bottom: 16px;
                color: #dee2e6;
            }

            .pagination-container {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 20px;
                padding: 15px 0;
                border-top: 1px solid #e9ecef;
            }

            .pagination-info {
                color: #6c757d;
                font-size: 14px;
                margin-right: 20px;
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

            .filter-controls {
                display: flex;
                gap: 15px;
                align-items: center;
                flex-wrap: wrap;
            }

            .filter-group {
                display: flex;
                flex-direction: column;
                gap: 5px;
            }

            .filter-label {
                font-weight: 500;
                color: #495057;
                font-size: 14px;
            }

            .filter-select {
                padding: 8px 12px;
                border: 1px solid #dee2e6;
                border-radius: 6px;
                background: white;
                min-width: 180px;
                font-size: 14px;
            }

            .filter-select:focus {
                border-color: #3f4d67;
                outline: none;
                box-shadow: 0 0 0 2px rgba(63, 77, 103, 0.1);
            }
        </style>
    </head>
    <body>
        <!-- [ Pre-loader ] start -->
        <%@ include file="../layouts/loader-admin.html" %>
        <!-- [ Pre-loader ] End -->

        <!-- [ Sidebar Menu ] start -->
        <%@ include file="../layouts/sidebar-admin.html" %>
        <!-- [ Sidebar Menu ] end -->

        <!-- [ Header Topbar ] start -->
        <%@ include file="../layouts/header-content-admin.jsp" %>
        <!-- [ Header ] end -->

        <!-- [ Main Content ] start -->
        <div class="pc-container">
            <div class="pc-content">
                <div class="card mt-8">
                    <div class="card-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Quản lý sản phẩm đèn</h5>
                            <span class="badge bg-light text-dark">
                                <i class="fas fa-cubes me-2"></i>
                                <%= new DAO.DenDAO().getAll().size()%> sản phẩm
                            </span>
                        </div>
                    </div>

                    <div class="card-body">
                        <%
                            // Khởi tạo DAO
                            DAO.DenDAO denDAO = new DAO.DenDAO();
                            DAO.LoaiDenDAO loaiDAO = new DAO.LoaiDenDAO();
                            DAO.NhaCungCapDAO nccDAO = new DAO.NhaCungCapDAO();
                            
                            // Lấy tham số phân trang
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
                            
                            // Lấy danh sách sản phẩm với phân trang
                            java.util.List<Model.Den> allProducts = denDAO.getAll();
                            int totalProducts = allProducts.size();
                            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
                            
                            // Đảm bảo currentPage hợp lệ
                            if (currentPage < 1) currentPage = 1;
                            if (currentPage > totalPages && totalPages > 0) currentPage = totalPages;
                            
                            int startIndex = (currentPage - 1) * pageSize;
                            int endIndex = Math.min(startIndex + pageSize, totalProducts);
                            
                            java.util.List<Model.Den> currentPageProducts = allProducts.subList(startIndex, endIndex);
                            
                            // Tính toán thống kê
                            double giaTrungBinh = allProducts.stream()
                                    .mapToDouble(Model.Den::getGia)
                                    .average()
                                    .orElse(0);
                            String giaTrungBinhFormatted = String.format("%,.0f", giaTrungBinh) + " ₫";
                        %>

                        <!-- Stats Cards -->
                        <div class="stats-cards">
                            <div class="stat-card">
                                <div class="stat-number"><%= totalProducts %></div>
                                <div class="stat-label">Tổng sản phẩm</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number"><%= loaiDAO.getAll().size() %></div>
                                <div class="stat-label">Loại sản phẩm</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number"><%= nccDAO.getAll().size() %></div>
                                <div class="stat-label">Nhà cung cấp</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number">
                                    <%= giaTrungBinhFormatted %>
                                </div>
                                <div class="stat-label">Giá trung bình</div>
                            </div>
                        </div>

                        <!-- Filter Section -->
                        <div class="search-section">
                            <div class="filter-controls">
                                <div class="filter-group">
                                    <label class="filter-label">Loại sản phẩm</label>
                                    <select class="filter-select" id="filterLoai">
                                        <option value="all">Tất cả loại</option>
                                        <% for (Model.LoaiDen loai : loaiDAO.getAll()) { %>
                                        <option value="<%= loai.getMaLoai()%>"><%= loai.getTenLoai()%></option>
                                        <% } %>
                                    </select>
                                </div>
                                
                                <div class="filter-group">
                                    <label class="filter-label">Nhà cung cấp</label>
                                    <select class="filter-select" id="filterNCC">
                                        <option value="all">Tất cả NCC</option>
                                        <% for (Model.NhaCungCap ncc : nccDAO.getAll()) { %>
                                        <option value="<%= ncc.getMaNCC()%>"><%= ncc.getTenNCC()%></option>
                                        <% } %>
                                    </select>
                                </div>
                                
                                <div class="filter-group">
                                    <label class="filter-label">Khoảng giá</label>
                                    <select class="filter-select" id="filterPrice">
                                        <option value="all">Tất cả giá</option>
                                        <option value="0-1000000">Dưới 1 triệu</option>
                                        <option value="1000000-5000000">1 - 5 triệu</option>
                                        <option value="5000000-10000000">5 - 10 triệu</option>
                                        <option value="10000000-999999999">Trên 10 triệu</option>
                                    </select>
                                </div>
                                
                                <div class="filter-group" style="align-self: flex-end;">
                                    <button type="button" class="btn btn-secondary" onclick="clearAllFilters()">
                                        <i class="fas fa-times me-1"></i>Xóa lọc
                                    </button>
                                </div>
                            </div>

                            <div class="row mt-3">
                                <div class="col-md-12">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div class="search-results-info">
                                            Hiển thị <span id="visibleProductsCount"><%= currentPageProducts.size() %></span>/<span><%= currentPageProducts.size() %></span> sản phẩm
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Bảng sản phẩm -->
                        <div class="table-responsive">
                            <table class="table table-hover" id="productsTable">
                                <thead>
                                    <tr>
                                        <th>Mã đèn</th>
                                        <th>Tên đèn</th>
                                        <th>Loại</th>
                                        <th>Nhà cung cấp</th>
                                        <th>Mô tả</th>
                                        <th>Giá</th>
                                        <th>Hình ảnh</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody id="productsTableBody">
                                    <% for (Model.Den den : currentPageProducts) {
                                        String tenLoai = loaiDAO.getTenLoaiById(den.getMaLoai());
                                        String tenNCC = nccDAO.getTenNCCById(den.getMaNCC());
                                    %>
                                    <tr data-ma-den="<%= den.getMaDen()%>" 
                                        data-ten-den="<%= den.getTenDen()%>"
                                        data-ma-loai="<%= den.getMaLoai()%>"
                                        data-ten-loai="<%= tenLoai%>"
                                        data-ma-ncc="<%= den.getMaNCC()%>"
                                        data-ten-ncc="<%= tenNCC%>"
                                        data-mo-ta="<%= den.getMoTa() != null ? den.getMoTa() : "" %>"
                                        data-gia="<%= den.getGia()%>">
                                        <td><strong><%= den.getMaDen()%></strong></td>
                                        <td><%= den.getTenDen()%></td>
                                        <td><span class="badge bg-light text-dark"><%= tenLoai%></span></td>
                                        <td><%= tenNCC%></td>
                                        <td>
                                            <div style="max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                                <%= den.getMoTa() != null ? den.getMoTa() : "Không có mô tả" %>
                                            </div>
                                        </td>
                                        <td><strong class="text-success"><%= String.format("%,d", (long) den.getGia())%> ₫</strong></td>
                                        <td>
                                            <% if (den.getHinhAnh() != null && !den.getHinhAnh().isEmpty()) { %>
                                            <img src="${pageContext.request.contextPath}/assets/images/product/<%= den.getHinhAnh()%>" 
                                                 alt="<%= den.getTenDen()%>" 
                                                 style="width:60px;height:60px;object-fit:cover;border-radius:6px;" 
                                                 onerror="this.src='${pageContext.request.contextPath}/assets/images/default-product.png'"/>
                                            <% } else { %>
                                            <div class="text-muted" style="width:60px;height:60px;display:flex;align-items:center;justify-content:center;background:#f8f9fa;border-radius:6px;">
                                                <i class="fas fa-image"></i>
                                            </div>
                                            <% } %>
                                        </td>
                                        <td>
                                            <div style="display: flex; justify-content: center; align-items: center; gap: 8px;">
                                                <a href="#" title="Sửa" class="text-warning btn-edit"
                                                   data-id="<%=den.getMaDen()%>"
                                                   data-ten="<%=den.getTenDen()%>"
                                                   data-loai="<%=den.getMaLoai()%>"
                                                   data-ncc="<%=den.getMaNCC()%>"
                                                   data-mota="<%=den.getMoTa()%>"
                                                   data-gia="<%=den.getGia()%>"
                                                   data-hinhanh="<%=den.getHinhAnh()%>">
                                                    <i data-feather="edit"></i>
                                                </a>
                                                <a href="#" title="Xóa" class="text-danger btn-delete" 
                                                   data-id="<%= den.getMaDen()%>"
                                                   data-ten="<%= den.getTenDen()%>">
                                                    <i data-feather="trash-2"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                            
                            <!-- Thông báo không có kết quả -->
                            <div id="noResults" class="no-results" style="display: none;">
                                <i class="fas fa-filter"></i>
                                <h5>Không tìm thấy sản phẩm nào</h5>
                                <p class="text-muted">Hãy thử điều chỉnh bộ lọc</p>
                                <button type="button" class="btn btn-primary mt-2" onclick="clearAllFilters()">
                                    <i class="fas fa-times me-2"></i>Xóa bộ lọc
                                </button>
                            </div>
                        </div>

                        <!-- Phân trang đơn giản -->
                        <% if (totalPages > 1) { %>
                        <div class="pagination-container">
                            <div class="pagination-info">
                                Hiển thị <%= startIndex + 1 %> - <%= endIndex %> của <%= totalProducts %> sản phẩm
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
                            
                            <!-- Chọn số sản phẩm mỗi trang -->
                            <div class="page-size-selector">
                                <select class="form-select form-select-sm" onchange="changePageSize(this.value)" style="width: auto;">
                                    <option value="10" <%= pageSize == 10 ? "selected" : "" %>>10 / trang</option>
                                    <option value="25" <%= pageSize == 25 ? "selected" : "" %>>25 / trang</option>
                                    <option value="50" <%= pageSize == 50 ? "selected" : "" %>>50 / trang</option>
                                </select>
                            </div>
                        </div>
                        <% } %>

                        <!-- Nút Thêm mới + Loại sản phẩm -->
                        <div class="mb-3 d-flex gap-2">
                            <button id="btnShowAddProduct" type="button" class="btn btn-primary d-flex align-items-center" style="gap: 6px;">
                                <i data-feather="plus"></i>
                                <span>Thêm sản phẩm</span>
                            </button>
                            <button id="btnShowLoaiSanPham" type="button" class="btn btn-info d-flex align-items-center" style="gap: 6px;">
                                <i data-feather="tag"></i>
                                <span>Loại sản phẩm</span>
                            </button>
                        </div>

                        <!-- Các modal giữ nguyên -->
                        <!-- Modal Thêm sản phẩm -->
                        <div id="addProductModal" class="modal-fade" style="display:none; position:fixed; z-index:1050; left:0; top:0; width:100vw; height:100vh; background:rgba(0,0,0,0.5); align-items:center; justify-content:center;">
                            <div style="background:#fff; border-radius:8px; max-width:500px; width:90vw; margin:auto; padding:24px; position:relative; box-shadow:0 10px 30px rgba(0,0,0,0.3);">
                                <h5 class="mb-3">Thêm sản phẩm mới</h5>
                                <form id="addProductForm" action="<%=request.getContextPath()%>/them-den" method="post" enctype="multipart/form-data">
                                    <div class="mb-3">
                                        <label for="tenDen" class="form-label">Tên đèn *</label>
                                        <input type="text" class="form-control" id="tenDen" name="tenDen" required />
                                    </div>
                                    <div class="mb-3">
                                        <label for="maLoai" class="form-label">Loại *</label>
                                        <select class="form-select" id="maLoai" name="maLoai" required>
                                            <option value="">-- Chọn loại đèn --</option>
                                            <% for (Model.LoaiDen loai : loaiDAO.getAll()) { %>
                                            <option value="<%= loai.getMaLoai()%>"><%= loai.getTenLoai()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="maNCC" class="form-label">Nhà cung cấp *</label>
                                        <select class="form-select" id="maNCC" name="maNCC" required>
                                            <option value="">-- Chọn nhà cung cấp --</option>
                                            <% for (Model.NhaCungCap ncc : nccDAO.getAll()) { %>
                                            <option value="<%= ncc.getMaNCC()%>"><%= ncc.getTenNCC()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="moTa" class="form-label">Mô tả *</label>
                                        <textarea class="form-control" id="moTa" name="moTa" rows="3" required></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="gia" class="form-label">Giá *</label>
                                        <input type="number" class="form-control" id="gia" name="gia" min="0" required />
                                    </div>
                                    <div class="mb-3">
                                        <label for="hinhAnh" class="form-label">Hình ảnh</label>
                                        <input type="file" class="form-control" id="hinhAnh" name="hinhAnh" accept="image/*" />
                                    </div>
                                    <div class="mt-4 d-flex justify-content-end gap-2">
                                        <button type="button" id="btnCloseAddProduct" class="btn btn-secondary">Hủy</button>
                                        <button type="submit" class="btn btn-primary">Thêm sản phẩm</button>
                                    </div>
                                </form>
                                <button id="btnCloseAddProductX" type="button" style="position:absolute; top:15px; right:15px; background:none; border:none; font-size:24px; color:#6c757d; cursor:pointer;">&times;</button>
                            </div>
                        </div>

                        <!-- Modal Sửa sản phẩm -->
                        <div id="editProductModal" class="modal-fade" style="display:none; position:fixed; z-index:1050; left:0; top:0; width:100vw; height:100vh; background:rgba(0,0,0,0.5); align-items:center; justify-content:center;">
                            <div style="background:#fff; border-radius:8px; max-width:500px; width:90vw; margin:auto; padding:24px; position:relative; box-shadow:0 10px 30px rgba(0,0,0,0.3);">
                                <h5 class="mb-3">Cập nhật sản phẩm</h5>
                                <form id="editProductForm" action="<%=request.getContextPath()%>/sua-den" method="post" enctype="multipart/form-data">
                                    <input type="hidden" id="editMaDen" name="maDen" />
                                    <input type="hidden" id="oldHinhAnh" name="oldHinhAnh" />
                                    <div class="mb-3">
                                        <label for="editTenDen" class="form-label">Tên đèn *</label>
                                        <input type="text" class="form-control" id="editTenDen" name="tenDen" required />
                                    </div>
                                    <div class="mb-3">
                                        <label for="editMaLoai" class="form-label">Loại *</label>
                                        <select class="form-select" id="editMaLoai" name="maLoai" required>
                                            <option value="">-- Chọn loại đèn --</option>
                                            <% for (Model.LoaiDen loai : loaiDAO.getAll()) { %>
                                            <option value="<%= loai.getMaLoai()%>"><%= loai.getTenLoai()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="editMaNCC" class="form-label">Nhà cung cấp *</label>
                                        <select class="form-select" id="editMaNCC" name="maNCC" required>
                                            <option value="">-- Chọn nhà cung cấp --</option>
                                            <% for (Model.NhaCungCap ncc : nccDAO.getAll()) { %>
                                            <option value="<%= ncc.getMaNCC()%>"><%= ncc.getTenNCC()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="editMoTa" class="form-label">Mô tả *</label>
                                        <textarea class="form-control" id="editMoTa" name="moTa" rows="3" required></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="editGia" class="form-label">Giá *</label>
                                        <input type="number" class="form-control" id="editGia" name="gia" min="0" required />
                                    </div>
                                    <div class="mb-3">
                                        <label for="editHinhAnh" class="form-label">Hình ảnh mới (nếu có)</label>
                                        <input type="file" class="form-control" id="editHinhAnh" name="hinhAnh" accept="image/*" />
                                    </div>
                                    <div class="mt-4 d-flex justify-content-end gap-2">
                                        <button type="button" id="btnCloseEditProduct" class="btn btn-secondary">Hủy</button>
                                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                                    </div>
                                </form>
                                <button id="btnCloseEditProductX" type="button" style="position:absolute; top:15px; right:15px; background:none; border:none; font-size:24px; color:#6c757d; cursor:pointer;">&times;</button>
                            </div>
                        </div>

                        <!-- Modal Loại sản phẩm -->
                        <div id="loaiSanPhamModal" class="modal-fade" style="display:none; position:fixed; z-index:1050; left:0; top:0; width:100vw; height:100vh; background:rgba(0,0,0,0.5); align-items:center; justify-content:center;">
                            <div style="background:#fff; border-radius:8px; max-width:750px; width:90vw; margin:auto; padding:24px; position:relative; box-shadow:0 10px 30px rgba(0,0,0,0.3);">
                                <h5 class="mb-3">Quản lý loại sản phẩm</h5>
                                <div class="d-flex justify-content-between mb-3">
                                    <button id="btnAddLoai" class="btn btn-success btn-sm">
                                        <i data-feather="plus"></i> Thêm loại mới
                                    </button>
                                </div>

                                <div class="table-responsive">
                                    <table class="table table-sm table-hover">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Mã loại</th>
                                                <th>Tên loại</th>
                                                <th>Mô tả</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody id="loaiListBody">
                                            <% for (Model.LoaiDen loai : loaiDAO.getAll()) { %>
                                            <tr data-id="<%= loai.getMaLoai()%>">
                                                <td><%= loai.getMaLoai()%></td>
                                                <td><%= loai.getTenLoai()%></td>
                                                <td><%= loai.getMoTa() != null ? loai.getMoTa() : ""%></td>
                                                <td>
                                                    <div style="display:flex; justify-content:center; align-items:center; gap:8px;">
                                                        <a href="#" title="Sửa" class="text-warning btn-edit-loai"
                                                           data-id="<%= loai.getMaLoai()%>"
                                                           data-ten="<%= loai.getTenLoai()%>"
                                                           data-mota="<%= loai.getMoTa() != null ? loai.getMoTa() : ""%>">
                                                            <i data-feather="edit"></i>
                                                        </a>
                                                        <a href="#" title="Xóa" class="text-danger btn-delete-loai"
                                                           data-id="<%= loai.getMaLoai()%>"
                                                           data-ten="<%= loai.getTenLoai()%>">
                                                            <i data-feather="trash-2"></i>
                                                        </a>
                                                    </div>
                                                </td>
                                            </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Form thêm/sửa loại -->
                                <div id="formLoaiContainer" style="display:none; margin-top:20px;">
                                    <form id="formLoai">
                                        <input type="hidden" id="loaiMa" name="maLoai" />
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Tên loại *</label>
                                                <input type="text" class="form-control" id="loaiTen" name="tenLoai" required />
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Mô tả</label>
                                                <input type="text" class="form-control" id="loaiMoTa" name="moTa" />
                                            </div>
                                        </div>
                                        <div class="d-flex justify-content-end gap-2">
                                            <button type="button" id="btnCancelLoai" class="btn btn-secondary btn-sm">Hủy</button>
                                            <button type="submit" class="btn btn-primary btn-sm" id="btnSaveLoai">Lưu</button>
                                        </div>
                                    </form>
                                </div>

                                <button id="btnCloseLoaiX" type="button" style="position:absolute; top:15px; right:15px; background:none; border:none; font-size:24px; color:#6c757d; cursor:pointer;">&times;</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // Biến lưu trữ trạng thái filter
            let currentFilters = {
                loai: 'all',
                ncc: 'all',
                price: 'all'
            };

            // Hàm lọc sản phẩm
            function filterProducts() {
                const filterLoai = currentFilters.loai;
                const filterNCC = currentFilters.ncc;
                const filterPrice = currentFilters.price;
                
                const rows = document.querySelectorAll('#productsTableBody tr');
                let visibleCount = 0;
                let hasVisibleRows = false;

                rows.forEach(row => {
                    const maLoai = row.getAttribute('data-ma-loai');
                    const maNCC = row.getAttribute('data-ma-ncc');
                    const gia = parseFloat(row.getAttribute('data-gia'));

                    let match = true;

                    // Lọc theo loại
                    if (filterLoai !== 'all') {
                        if (maLoai !== filterLoai) {
                            match = false;
                        }
                    }

                    // Lọc theo nhà cung cấp
                    if (match && filterNCC !== 'all') {
                        if (maNCC !== filterNCC) {
                            match = false;
                        }
                    }

                    // Lọc theo giá
                    if (match && filterPrice !== 'all') {
                        const [min, max] = filterPrice.split('-').map(Number);
                        if (gia < min || gia > max) {
                            match = false;
                        }
                    }

                    // Hiển thị/ẩn hàng
                    if (match) {
                        row.style.display = '';
                        visibleCount++;
                        hasVisibleRows = true;
                    } else {
                        row.style.display = 'none';
                    }
                });

                // Cập nhật thông tin kết quả
                document.getElementById('visibleProductsCount').textContent = visibleCount;

                // Hiển thị thông báo không có kết quả
                const noResults = document.getElementById('noResults');
                const tableBody = document.getElementById('productsTableBody');
                
                if (!hasVisibleRows) {
                    tableBody.style.display = 'none';
                    noResults.style.display = 'block';
                } else {
                    tableBody.style.display = '';
                    noResults.style.display = 'none';
                }
            }

            // Hàm xử lý thay đổi filter
            function handleFilterChange() {
                currentFilters.loai = document.getElementById('filterLoai').value;
                currentFilters.ncc = document.getElementById('filterNCC').value;
                currentFilters.price = document.getElementById('filterPrice').value;
                filterProducts();
            }

            // Hàm xóa tất cả filter
            function clearAllFilters() {
                document.getElementById('filterLoai').value = 'all';
                document.getElementById('filterNCC').value = 'all';
                document.getElementById('filterPrice').value = 'all';
                
                currentFilters = {
                    loai: 'all',
                    ncc: 'all',
                    price: 'all'
                };
                
                filterProducts();
            }

            // Hàm thay đổi số sản phẩm mỗi trang
            function changePageSize(size) {
                const url = new URL(window.location.href);
                url.searchParams.set('pageSize', size);
                url.searchParams.set('page', '1');
                window.location.href = url.toString();
            }

            // === QUẢN LÝ MODAL ===
            document.addEventListener('DOMContentLoaded', function () {
                // Khởi tạo Feather Icons
                if (typeof feather !== 'undefined') {
                    feather.replace();
                }

                // Xử lý thay đổi filter
                document.getElementById('filterLoai').addEventListener('change', handleFilterChange);
                document.getElementById('filterNCC').addEventListener('change', handleFilterChange);
                document.getElementById('filterPrice').addEventListener('change', handleFilterChange);

                // === MODAL THÊM SẢN PHẨM ===
                const addProductModal = document.getElementById('addProductModal');
                const btnShowAddProduct = document.getElementById('btnShowAddProduct');
                const btnCloseAddProduct = document.getElementById('btnCloseAddProduct');
                const btnCloseAddProductX = document.getElementById('btnCloseAddProductX');

                if (btnShowAddProduct && addProductModal) {
                    btnShowAddProduct.addEventListener('click', function() {
                        addProductModal.style.display = 'flex';
                    });
                }

                function closeAddProductModal() {
                    if (addProductModal) addProductModal.style.display = 'none';
                }

                if (btnCloseAddProduct) btnCloseAddProduct.addEventListener('click', closeAddProductModal);
                if (btnCloseAddProductX) btnCloseAddProductX.addEventListener('click', closeAddProductModal);

                // === MODAL SỬA SẢN PHẨM ===
                const editProductModal = document.getElementById('editProductModal');
                const btnCloseEditProduct = document.getElementById('btnCloseEditProduct');
                const btnCloseEditProductX = document.getElementById('btnCloseEditProductX');

                // Xử lý click nút sửa
                document.querySelectorAll('.btn-edit').forEach(btn => {
                    btn.addEventListener('click', function(e) {
                        e.preventDefault();
                        
                        const data = this.dataset;
                        document.getElementById('editMaDen').value = data.id || '';
                        document.getElementById('editTenDen').value = data.ten || '';
                        document.getElementById('editMaLoai').value = data.loai || '';
                        document.getElementById('editMaNCC').value = data.ncc || '';
                        document.getElementById('editMoTa').value = data.mota || '';
                        document.getElementById('editGia').value = data.gia || '';
                        document.getElementById('oldHinhAnh').value = data.hinhanh || '';
                        
                        if (editProductModal) {
                            editProductModal.style.display = 'flex';
                        }
                    });
                });

                function closeEditProductModal() {
                    if (editProductModal) editProductModal.style.display = 'none';
                }

                if (btnCloseEditProduct) btnCloseEditProduct.addEventListener('click', closeEditProductModal);
                if (btnCloseEditProductX) btnCloseEditProductX.addEventListener('click', closeEditProductModal);

                // === XÓA SẢN PHẨM ===
                document.querySelectorAll('.btn-delete').forEach(btn => {
                    btn.addEventListener('click', function(e) {
                        e.preventDefault();
                        const productId = this.dataset.id;
                        const productName = this.dataset.ten || 'sản phẩm này';
                        
                        if (confirm(`Bạn có chắc chắn muốn xóa sản phẩm "${productName}" (mã ${productId}) không?`)) {
                            window.location.href = `<%=request.getContextPath()%>/xoa-den?maDen=${productId}`;
                        }
                    });
                });

                // === MODAL LOẠI SẢN PHẨM ===
                const loaiModal = document.getElementById('loaiSanPhamModal');
                const btnShowLoai = document.getElementById('btnShowLoaiSanPham');
                const btnCloseLoaiX = document.getElementById('btnCloseLoaiX');

                if (btnShowLoai && loaiModal) {
                    btnShowLoai.addEventListener('click', function() {
                        loaiModal.style.display = 'flex';
                    });
                }

                if (btnCloseLoaiX) {
                    btnCloseLoaiX.addEventListener('click', function() {
                        loaiModal.style.display = 'none';
                    });
                }

                // Đóng modal khi click bên ngoài
                [addProductModal, editProductModal, loaiModal].forEach(modal => {
                    if (modal) {
                        modal.addEventListener('click', function(e) {
                            if (e.target === modal) {
                                modal.style.display = 'none';
                            }
                        });
                    }
                });
            });
        </script>

        <%@ include file="../layouts/footer-js-admin.html" %>
    </body>
</html>