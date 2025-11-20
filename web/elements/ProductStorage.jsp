<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en" data-pc-preset="preset-1" data-pc-sidebar-caption="true" data-pc-direction="ltr" dir="ltr" data-pc-theme="light">
    <head>
        <%@ include file="../layouts/head-page-meta-admin.html" %>
        <style>
            /* Đảm bảo body và html chiếm toàn bộ chiều cao */
            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
            }

            /* Layout chính sử dụng flexbox */
            body {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            /* Main content chiếm toàn bộ không gian còn lại */
            .main-content-wrapper {
                flex: 1 0 auto;
                display: flex;
                flex-direction: column;
            }

            /* Đảm bảo pc-container chiếm hết chiều cao */
            .pc-container {
                flex: 1;
                display: flex;
                flex-direction: column;
            }

            .pc-content {
                flex: 1;
            }

            /* Footer luôn ở dưới cùng */
            .footer-section {
                flex-shrink: 0;
                margin-top: auto;
            }

            /* Đảm bảo card trong kho có chiều cao phù hợp */
            .card {
                margin-bottom: 1rem;
            }

            /* Table responsive */
            .table-responsive {
                max-height: 60vh;
                overflow-y: auto;
            }

            /* Style cho action icons */
            .action-icons {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 12px;
            }

            .action-icons a {
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                justify-content: center;
            }

            .action-icons i {
                width: 18px;
                height: 18px;
            }

            /* Modal styles */
            .modal-fade {
                opacity: 0;
                pointer-events: none;
                transition: opacity 0.3s ease;
                position: fixed;
                top: 0;
                left: 0;
                width: 100vw;
                height: 100vh;
                background: rgba(0,0,0,0.5);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 1050;
                backdrop-filter: blur(4px);
            }

            .modal-fade.show {
                opacity: 1;
                pointer-events: auto;
            }

            .modal-content {
                background: #fff;
                border-radius: 12px;
                max-width: 600px;
                width: 90vw;
                margin: auto;
                padding: 30px;
                position: relative;
                box-shadow: 0 10px 40px rgba(0,0,0,0.3);
            }

            .modal-header {
                border-bottom: 1px solid #e9ecef;
                padding-bottom: 15px;
                margin-bottom: 20px;
            }

            .modal-header h5 {
                margin: 0;
                font-weight: 600;
                color: #3f4d67;
            }

            .close-btn {
                position: absolute;
                top: 15px;
                right: 15px;
                background: none;
                border: none;
                font-size: 24px;
                color: #6c757d;
                cursor: pointer;
            }

            .close-btn:hover {
                color: #495057;
            }

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
        </style>
    </head>

    <body>
        <%@ include file="../layouts/loader-admin.html" %>
        <%@ include file="../layouts/sidebar-admin.html" %>
        <%@ include file="../layouts/header-content-admin.jsp" %>

        <!-- Main Content Wrapper -->
        <div class="main-content-wrapper">
            <!-- [ Main Content ] start -->
            <div class="pc-container">
                <div class="pc-content">
                    <!-- Card Quản lý kho -->
                    <div class="card">
                        <div class="card-header">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Quản lý kho sản phẩm</h5>
                                <span class="badge bg-light text-dark">
                                    <i class="fas fa-warehouse me-2"></i>
                                    <%= new DAO.KhoDenDAO().getAll().size() %> sản phẩm trong kho
                                </span>
                            </div>
                        </div>
                        <div class="card-body">

                            <%
                                String msg = request.getParameter("msg");
                                String error = request.getParameter("error");

                                // Khai báo các DAO
                                DAO.KhoDenDAO khoDAO = new DAO.KhoDenDAO();
                                DAO.BienTheDenDAO bienTheDAO = new DAO.BienTheDenDAO();
                                DAO.DenDAO denDAO = new DAO.DenDAO();
                                DAO.MauSacDAO mauDAO = new DAO.MauSacDAO();
                                DAO.KichThuocDAO kichThuocDAO = new DAO.KichThuocDAO();

                                // Lấy danh sách biến thể để hiển thị trong combobox
                                java.util.List<Model.BienTheDen> listBienThe = bienTheDAO.getAll();
                                java.util.List<Model.KhoDen> listKho = khoDAO.getAll();

                                // Tính toán thống kê
                                int tongSanPham = listKho.size();
                                int tongSoLuongNhap = listKho.stream().mapToInt(Model.KhoDen::getSoLuongNhap).sum();
                                int tongSoLuongBan = listKho.stream().mapToInt(Model.KhoDen::getSoLuongBan).sum();
                                int tongTonKho = tongSoLuongNhap - tongSoLuongBan;
                                int soSanPhamTonKhoThap = (int) listKho.stream()
                                    .filter(kho -> (kho.getSoLuongNhap() - kho.getSoLuongBan()) <= 5)
                                    .count();
                            %>
                            <% if ("add_success".equals(msg)) { %>
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                Thêm kho thành công!
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
                            <% }%>

                            <!-- Stats Cards -->
                            <div class="stats-cards">
                                <div class="stat-card">
                                    <div class="stat-number"><%= tongSanPham %></div>
                                    <div class="stat-label">Tổng sản phẩm</div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-number"><%= tongSoLuongNhap %></div>
                                    <div class="stat-label">SL nhập</div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-number"><%= tongSoLuongBan %></div>
                                    <div class="stat-label">SL bán</div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-number <%= tongTonKho <= 10 ? "text-danger" : "text-success" %>">
                                        <%= tongTonKho %>
                                    </div>
                                    <div class="stat-label">Tồn kho</div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-number <%= soSanPhamTonKhoThap > 0 ? "text-warning" : "text-success" %>">
                                        <%= soSanPhamTonKhoThap %>
                                    </div>
                                    <div class="stat-label">SP tồn ít</div>
                                </div>
                            </div>

                            <!-- PHẦN LỌC MỚI -->
                            <div class="search-section">
                                <!-- Search Row -->
                                <div class="row mb-3">
                                    <div class="col-md-8">
                                        <div class="search-box">
                                            <label for="searchInput" class="form-label fw-medium text-muted mb-2">Tìm kiếm sản phẩm trong kho</label>
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
                                
                                <!-- Filter Row -->
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div class="filter-section">
                                                <span class="filter-label">Lọc theo:</span>
                                                <div class="filter-buttons">
                                                    <button class="filter-btn active" data-filter="all">Tất cả</button>
                                                    <button class="filter-btn" data-filter="ton-cao">Tồn kho cao</button>
                                                    <button class="filter-btn" data-filter="ton-trung-binh">Tồn kho TB</button>
                                                    <button class="filter-btn" data-filter="ton-thap">Tồn kho thấp</button>
                                                    <button class="filter-btn" data-filter="het-hang">Hết hàng</button>
                                                </div>
                                            </div>
                                            
                                            <!-- Hiển thị số kết quả -->
                                            <div class="search-results-info">
                                                <span id="searchResultsCount"><%= listKho.size() %></span> sản phẩm
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Nút Thêm kho mới - GIỮ NGUYÊN -->
                            <div class="mb-3">
                                <button id="btnThemKhoMoi" type="button" class="btn btn-success d-flex align-items-center" style="gap: 6px;">
                                    <i data-feather="plus"></i>
                                    <span>Thêm kho mới</span>
                                </button>
                            </div>

                            <!-- Bảng danh sách kho -->
                            <div class="table-responsive">
                                <table class="table table-hover table-striped" id="khoTable">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Mã kho</th>
                                            <th>Biến thể sản phẩm</th>
                                            <th>Số lượng nhập</th>
                                            <th>Số lượng bán</th>
                                            <th>Tồn kho</th>
                                            <th>Cập nhật gần nhất</th>
                                            <th style="width: 120px; text-align: center;">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            for (Model.KhoDen kho : listKho) {
                                                int tonKho = kho.getSoLuongNhap() - kho.getSoLuongBan();
                                                String safeIdStr = String.valueOf(kho.getMaKho());

                                                // Lấy thông tin biến thể để hiển thị tên
                                                Model.BienTheDen bienThe = bienTheDAO.getById(kho.getMaBienThe());
                                                String tenBienThe = "Không tìm thấy";

                                                if (bienThe != null) {
                                                    String tenDen = denDAO.getTenDenById(bienThe.getMaDen());
                                                    String tenMau = (bienThe.getMaMau() != null && bienThe.getMaMau() != 0)
                                                            ? mauDAO.getTenMauById(bienThe.getMaMau()) : "Không màu";
                                                    String tenKichThuoc = (bienThe.getMaKichThuoc() != null && bienThe.getMaKichThuoc() != 0)
                                                            ? kichThuocDAO.getTenKichThuocById(bienThe.getMaKichThuoc()) : "Không kích thước";

                                                    tenBienThe = tenDen + " - Màu: " + tenMau + " - KT: " + tenKichThuoc;
                                                }

                                                // Xác định trạng thái tồn kho để lọc
                                                String tonKhoClass = "";
                                                if (tonKho <= 0) {
                                                    tonKhoClass = "het-hang";
                                                } else if (tonKho <= 5) {
                                                    tonKhoClass = "ton-thap";
                                                } else if (tonKho <= 20) {
                                                    tonKhoClass = "ton-trung-binh";
                                                } else {
                                                    tonKhoClass = "ton-cao";
                                                }
                                        %>
                                        <tr data-tonkho="<%= tonKhoClass %>" data-search="<%= tenBienThe.toLowerCase() %>">
                                            <td><strong><%= kho.getMaKho()%></strong></td>
                                            <td>
                                                <div>
                                                    <div><strong><%= tenBienThe%></strong></div>
                                                    <small class="text-muted">Mã biến thể: <%= kho.getMaBienThe()%></small>
                                                </div>
                                            </td>
                                            <td><span class="badge bg-primary"><%= kho.getSoLuongNhap()%></span></td>
                                            <td><span class="badge bg-info"><%= kho.getSoLuongBan()%></span></td>
                                            <td>
                                                <span class="badge <%= tonKho > 10 ? "bg-success" : (tonKho > 0 ? "bg-warning" : "bg-danger")%>">
                                                    <%= tonKho%>
                                                </span>
                                            </td>
                                            <td><small><%= kho.getCapNhatGanNhat() != null ? kho.getCapNhatGanNhat().toString() : "Chưa cập nhật"%></small></td>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <div class="action-icons">
                                                    <!-- Sử dụng icon giống hệt mẫu -->
                                                    <a href="#" title="Sửa" class="text-warning btn-edit-kho"
                                                       data-id="<%= safeIdStr%>"
                                                       data-mabienthe="<%= kho.getMaBienThe()%>"
                                                       data-slnhap="<%= kho.getSoLuongNhap()%>"
                                                       data-slban="<%= kho.getSoLuongBan()%>">
                                                        <i data-feather="edit"></i>
                                                    </a>
                                                    <a href="#" title="Xóa" class="text-danger btn-delete-kho"
                                                       data-id="<%= safeIdStr%>">
                                                        <i data-feather="trash-2"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                        <% }%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- [ Main Content ] end -->
        </div>

        <!-- Footer Section -->
        <div class="footer-section">
            <%@ include file="../layouts/footer-block-admin.html" %>
        </div>

        <!-- Modal Thêm/Sửa Kho -->
        <div id="khoModal" class="modal-fade">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 id="modalTitle">Thêm kho mới</h5>
                    <button type="button" class="close-btn" id="btnCloseModal">&times;</button>
                </div>
                <form id="khoForm" action="<%=request.getContextPath()%>/them-kho" method="post">
                    <input type="hidden" id="maKho" name="maKho" />
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label for="maBienThe" class="form-label">Biến thể sản phẩm</label>
                            <select class="form-select" id="maBienThe" name="maBienThe" required>
                                <option value="">-- Chọn biến thể --</option>
                                <%
                                    DAO.KhoDenDAO khoDenDAO = new DAO.KhoDenDAO();
                                    for (Model.BienTheDen bienThe : listBienThe) {
                                        // Kiểm tra xem biến thể đã có trong kho chưa
                                        if (!khoDenDAO.isBienTheExists(bienThe.getMaBienThe())) {
                                            // Lấy thông tin chi tiết của biến thể
                                            String tenDen = denDAO.getTenDenById(bienThe.getMaDen());
                                            String tenMau = (bienThe.getMaMau() != null && bienThe.getMaMau() != 0)
                                                    ? mauDAO.getTenMauById(bienThe.getMaMau()) : "Không màu";
                                            String tenKichThuoc = (bienThe.getMaKichThuoc() != null && bienThe.getMaKichThuoc() != 0)
                                                    ? kichThuocDAO.getTenKichThuocById(bienThe.getMaKichThuoc()) : "Không kích thước";

                                            String displayText = tenDen + " - Màu: " + tenMau + " - KT: " + tenKichThuoc;
                                %>
                                <option value="<%= bienThe.getMaBienThe()%>">
                                    <%= displayText%>
                                </option>
                                <%
                                        } // end if
                                    } // end for
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="soLuongNhap" class="form-label">Số lượng nhập</label>
                            <input type="number" class="form-control" id="soLuongNhap" name="soLuongNhap" required min="0" />
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="soLuongBan" class="form-label">Số lượng bán</label>
                            <input type="number" class="form-control" id="soLuongBan" name="soLuongBan" required min="0" />
                        </div>
                    </div>
                    <div class="mt-4 d-flex justify-content-end gap-2">
                        <button type="button" class="btn btn-secondary" id="btnCancel">Hủy</button>
                        <button type="submit" class="btn btn-primary" id="btnSubmit">Thêm mới</button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // === PHẦN LỌC MỚI ===
                const searchInput = document.getElementById('searchInput');
                const clearSearch = document.getElementById('clearSearch');
                const khoTable = document.getElementById('khoTable');
                const searchResultsCount = document.getElementById('searchResultsCount');
                
                // TÌM KIẾM SẢN PHẨM TRONG KHO
                if (searchInput) {
                    searchInput.addEventListener('input', function(e) {
                        const searchTerm = e.target.value.toLowerCase().trim();
                        const rows = khoTable.querySelectorAll('tbody tr');
                        let visibleCount = 0;
                        
                        rows.forEach(row => {
                            const searchData = row.getAttribute('data-search');
                            
                            if (searchData.includes(searchTerm)) {
                                row.style.display = '';
                                visibleCount++;
                            } else {
                                row.style.display = 'none';
                            }
                        });
                        
                        // Cập nhật số kết quả
                        if (searchResultsCount) {
                            searchResultsCount.textContent = visibleCount;
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
                
                // LỌC THEO TÌNH TRẠNG TỒN KHO
                const filterButtons = document.querySelectorAll('.filter-btn');
                filterButtons.forEach(btn => {
                    btn.addEventListener('click', function() {
                        // Xóa active class từ tất cả buttons
                        filterButtons.forEach(b => b.classList.remove('active'));
                        // Thêm active class cho button được click
                        this.classList.add('active');
                        
                        const filterValue = this.getAttribute('data-filter');
                        const rows = khoTable.querySelectorAll('tbody tr');
                        let visibleCount = 0;
                        
                        rows.forEach(row => {
                            if (filterValue === 'all') {
                                row.style.display = '';
                                visibleCount++;
                            } else {
                                const rowTonKho = row.getAttribute('data-tonkho');
                                if (rowTonKho === filterValue) {
                                    row.style.display = '';
                                    visibleCount++;
                                } else {
                                    row.style.display = 'none';
                                }
                            }
                        });
                        
                        // Cập nhật số kết quả
                        if (searchResultsCount) {
                            searchResultsCount.textContent = visibleCount;
                        }
                    });
                });

                // === PHẦN CODE HIỆN CỦA BẠN - GIỮ NGUYÊN ===
                const khoModal = document.getElementById('khoModal');
                const modalTitle = document.getElementById('modalTitle');
                const khoForm = document.getElementById('khoForm');
                const btnThemKhoMoi = document.getElementById('btnThemKhoMoi');
                const btnSubmit = document.getElementById('btnSubmit');
                const btnCancel = document.getElementById('btnCancel');
                const btnCloseModal = document.getElementById('btnCloseModal');
                const maKhoInput = document.getElementById('maKho');
                const maBienTheSelect = document.getElementById('maBienThe');
                const soLuongNhapInput = document.getElementById('soLuongNhap');
                const soLuongBanInput = document.getElementById('soLuongBan');

                // === HÀM HIỂN THỊ MODAL ===
                function showModal() {
                    khoModal.classList.add('show');
                }

                // === HÀM ẨN MODAL ===
                function hideModal() {
                    khoModal.classList.remove('show');
                }

                // === HÀM RESET FORM ===
                function resetForm() {
                    khoForm.reset();
                    maKhoInput.value = '';
                    modalTitle.textContent = 'Thêm kho mới';
                    btnSubmit.textContent = 'Thêm mới';
                    khoForm.action = '<%=request.getContextPath()%>/them-kho';

                    // Xóa validation states
                    soLuongNhapInput.classList.remove('is-invalid');
                    soLuongBanInput.classList.remove('is-invalid');
                }

                // === 1. NÚT "THÊM KHO MỚI" - GIỮ NGUYÊN ===
                if (btnThemKhoMoi) {
                    btnThemKhoMoi.addEventListener('click', function () {
                        resetForm();
                        showModal();
                    });
                }

                // === 2. NÚT "SỬA" - GIỮ NGUYÊN ===
                document.querySelectorAll('.btn-edit-kho').forEach(btn => {
                    btn.addEventListener('click', function (e) {
                        e.preventDefault();
                        const data = this.dataset;

                        // Điền dữ liệu vào form
                        maKhoInput.value = data.id;
                        maBienTheSelect.value = data.mabienthe;
                        soLuongNhapInput.value = data.slnhap;
                        soLuongBanInput.value = data.slban;

                        // Thay đổi form thành chế độ sửa
                        modalTitle.textContent = 'Sửa thông tin kho - Mã: ' + data.id;
                        btnSubmit.textContent = 'Cập nhật';
                        khoForm.action = '<%=request.getContextPath()%>/sua-kho';

                        // Hiển thị modal
                        showModal();
                    });
                });

                // === 3. NÚT "XÓA" - GIỮ NGUYÊN ===
                document.querySelectorAll('.btn-delete-kho').forEach(btn => {
                    btn.addEventListener('click', function (e) {
                        e.preventDefault();
                        const id = this.dataset.id;
                        const row = this.closest('tr');
                        const tenBienThe = row.cells[1].querySelector('div > strong').textContent;

                        if (!id || id.trim() === '' || isNaN(parseInt(id))) {
                            alert('Lỗi: Không tìm thấy Mã Kho hợp lệ để xóa. ID: ' + id);
                            return;
                        }

                        if (confirm('Bạn có chắc muốn xóa kho mã ' + id + ' (' + tenBienThe + ') không?')) {
                            window.location.href = '<%= request.getContextPath()%>/xoa-kho?id=' + encodeURIComponent(id);
                        }
                    });
                });

                // === 4. NÚT "HỦY" VÀ ĐÓNG MODAL ===
                if (btnCancel) {
                    btnCancel.addEventListener('click', function () {
                        resetForm();
                        hideModal();
                    });
                }

                if (btnCloseModal) {
                    btnCloseModal.addEventListener('click', function () {
                        resetForm();
                        hideModal();
                    });
                }

                // Đóng modal khi click bên ngoài
                khoModal.addEventListener('click', function (e) {
                    if (e.target === khoModal) {
                        resetForm();
                        hideModal();
                    }
                });

                // === 5. VALIDATE SỐ LƯỢNG ===
                function validateSoLuong() {
                    const slNhap = parseInt(soLuongNhapInput.value) || 0;
                    const slBan = parseInt(soLuongBanInput.value) || 0;

                    if (slBan > slNhap) {
                        soLuongBanInput.classList.add('is-invalid');
                        return false;
                    } else {
                        soLuongBanInput.classList.remove('is-invalid');
                        return true;
                    }
                }

                // === 6. XỬ LÝ SUBMIT FORM ===
                if (khoForm) {
                    khoForm.addEventListener('submit', function (e) {
                        e.preventDefault();

                        // Validate số lượng
                        if (!validateSoLuong()) {
                            alert('Lỗi: Số lượng bán không được lớn hơn số lượng nhập!');
                            return;
                        }

                        // Validate chọn biến thể
                        if (!maBienTheSelect.value) {
                            alert('Vui lòng chọn biến thể sản phẩm!');
                            maBienTheSelect.focus();
                            return;
                        }

                        // Nếu đang thêm mới, submit bình thường
                        if (khoForm.action.includes('them-kho')) {
                            khoForm.submit();
                            return;
                        }

                        // Nếu đang sửa, sử dụng fetch để không reload trang
                        const formData = new FormData(khoForm);
                        const params = new URLSearchParams();

                        for (const [key, value] of formData) {
                            params.append(key, value);
                        }

                        fetch(khoForm.action, {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: params
                        })
                                .then(response => {
                                    if (!response.ok) {
                                        throw new Error('Lỗi kết nối: ' + response.status);
                                    }
                                    return response.json();
                                })
                                .then(data => {
                                    if (data.success) {
                                        // Reload trang để cập nhật dữ liệu
                                        window.location.href = '<%= request.getContextPath()%>/quan-ly-kho?msg=edit_success';
                                    } else {
                                        alert('Lỗi: ' + (data.message || 'Cập nhật thất bại'));
                                    }
                                })
                                .catch(error => {
                                    console.error('Error:', error);
                                    alert('Lỗi kết nối: ' + error.message);
                                });
                    });
                }

                // === 7. VALIDATE REAL-TIME ===
                soLuongNhapInput.addEventListener('input', validateSoLuong);
                soLuongBanInput.addEventListener('input', validateSoLuong);

                // === 8. KHỞI TẠO FEATHER ICONS ===
                if (typeof feather !== 'undefined') {
                    feather.replace();
                }
            });
        </script>

        <%@ include file="../layouts/footer-js-admin.html" %>
    </body>
</html>