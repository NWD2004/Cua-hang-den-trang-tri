<%@page import="Model.KhoDen"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Model.NguoiDung" %>
<%@ page import="DAO.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<!doctype html>
<html lang="en" data-pc-preset="preset-1" data-pc-sidebar-caption="true"
      data-pc-direction="ltr" dir="ltr" data-pc-theme="light">

    <head>
        <%@ include file="../layouts/head-page-meta-admin.html" %>
        <title>Trang chủ | LightShop</title>
        <style>
            .dashboard-container {
                padding: 24px;
                background: #f5f7fa;
                min-height: calc(100vh - 120px);
            }

            .welcome-section {
                background: linear-gradient(135deg, #3f4d67 0%, #53668a 100%);
                color: white;
                padding: 30px;
                border-radius: 16px;
                margin-bottom: 30px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            }

            .welcome-title {
                font-size: 28px;
                font-weight: 700;
                margin-bottom: 8px;
            }

            .welcome-subtitle {
                font-size: 16px;
                opacity: 0.9;
            }

            .stats-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                grid-template-rows: repeat(2, auto);
                gap: 24px;
                margin-bottom: 30px;
            }

            .quick-actions {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-card {
                background: white;
                border-radius: 16px;
                padding: 24px;
                box-shadow: 0 4px 20px rgba(63, 77, 103, 0.1);
                border-left: 5px solid;
                transition: all 0.3s ease;
                border: 1px solid #e8ecf1;
            }

            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 25px rgba(63, 77, 103, 0.15);
            }

            .stat-card.primary { border-left-color: #3f4d67; background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%); }
            .stat-card.success { border-left-color: #4a657c; background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%); }
            .stat-card.warning { border-left-color: #5d7b9c; background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%); }
            .stat-card.danger { border-left-color: #3f4d67; background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%); }
            .stat-card.info { border-left-color: #53668a; background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%); }
            .stat-card.purple { border-left-color: #4a5c7a; background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%); }

            .stat-icon {
                width: 60px;
                height: 60px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 24px;
                margin-bottom: 16px;
            }

            .stat-icon.primary { background: #e8ecf1; color: #3f4d67; }
            .stat-icon.success { background: #e8ecf1; color: #4a657c; }
            .stat-icon.warning { background: #e8ecf1; color: #5d7b9c; }
            .stat-icon.danger { background: #e8ecf1; color: #3f4d67; }
            .stat-icon.info { background: #e8ecf1; color: #53668a; }
            .stat-icon.purple { background: #e8ecf1; color: #4a5c7a; }

            .stat-value {
                font-size: 28px;
                font-weight: 700;
                color: #3f4d67;
                margin: 8px 0;
            }

            .stat-label {
                color: #5d6b82;
                font-size: 14px;
                font-weight: 500;
            }

            .action-card {
                background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%);
                border-radius: 12px;
                padding: 20px;
                text-align: center;
                box-shadow: 0 4px 15px rgba(63, 77, 103, 0.08);
                transition: all 0.3s ease;
                cursor: pointer;
                border: 1px solid #e8ecf1;
            }

            .action-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 6px 20px rgba(63, 77, 103, 0.12);
                border-color: #3f4d67;
                background: linear-gradient(135deg, #ffffff 0%, #f0f4f8 100%);
            }

            .action-icon {
                width: 50px;
                height: 50px;
                border-radius: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 20px;
                margin: 0 auto 12px;
                background: #3f4d67;
                color: white;
            }

            .action-title {
                font-weight: 600;
                color: #3f4d67;
                margin-bottom: 4px;
            }

            .action-desc {
                font-size: 12px;
                color: #5d6b82;
            }

            .recent-section {
                background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%);
                border-radius: 16px;
                padding: 24px;
                box-shadow: 0 4px 20px rgba(63, 77, 103, 0.08);
                margin-bottom: 30px;
                border: 1px solid #e8ecf1;
            }

            .section-title {
                font-size: 20px;
                font-weight: 600;
                color: #3f4d67;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .section-title i {
                color: #3f4d67;
            }

            .inventory-alert {
                background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
                color: white;
                padding: 20px;
                border-radius: 12px;
                margin-bottom: 20px;
                border: 1px solid #e8ecf1;
            }

            .alert-title {
                font-weight: 600;
                margin-bottom: 8px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .alert-content {
                opacity: 0.9;
                font-size: 14px;
            }

            .summary-box {
                background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%);
                padding: 16px;
                border-radius: 8px;
                border: 1px solid #e8ecf1;
            }

            .summary-title {
                font-weight: 600;
                color: #3f4d67;
                margin-bottom: 8px;
            }

            .summary-item {
                display: flex;
                justify-content: space-between;
                padding: 4px 0;
                font-size: 14px;
                color: #5d6b82;
            }

            .summary-value {
                font-weight: 600;
                color: #3f4d67;
            }

            @media (max-width: 1024px) {
                .stats-grid {
                    grid-template-columns: repeat(2, 1fr);
                    grid-template-rows: repeat(3, auto);
                }
            }

            @media (max-width: 768px) {
                .dashboard-container {
                    padding: 16px;
                }
                
                .stats-grid {
                    grid-template-columns: 1fr;
                    grid-template-rows: repeat(6, auto);
                }
                
                .quick-actions {
                    grid-template-columns: 1fr;
                }
                
                .welcome-section {
                    padding: 20px;
                }
                
                .welcome-title {
                    font-size: 24px;
                }
            }
        </style>
    </head>

    <body>
        <%@ include file="../layouts/loader-admin.html" %>
        <%@ include file="../layouts/sidebar-admin.html" %>
        <%@ include file="../layouts/header-content-admin.jsp" %>

        <%
            // Khởi tạo các DAO
            DenDAO denDAO = new DenDAO();
            BienTheDenDAO bienTheDenDAO = new BienTheDenDAO();
            MauSacDAO mauSacDAO = new MauSacDAO();
            KichThuocDAO kichThuocDAO = new KichThuocDAO();
            NhaCungCapDAO nhaCungCapDAO = new NhaCungCapDAO();
            LoaiDenDAO loaiDenDAO = new LoaiDenDAO();
            KhoDenDAO khoDenDAO = new KhoDenDAO();
            NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();

            // Lấy dữ liệu thật từ database
            int totalProducts = denDAO.getAll().size();
            int totalVariants = bienTheDenDAO.getAll().size();
            int totalColors = mauSacDAO.getAll().size();
            int totalSizes = kichThuocDAO.getAll().size();
            int totalSuppliers = nhaCungCapDAO.getAll().size();
            int totalCategories = loaiDenDAO.getAll().size();
            int totalUsers = nguoiDungDAO.getAll().size();

            // Tính tổng tồn kho thật
            int totalStock = 0;
            List<KhoDen> khoList = khoDenDAO.getAll();
            for (KhoDen kho : khoList) {
                totalStock += (kho.getSoLuongNhap() - kho.getSoLuongBan());
            }

            // Tính số lượng sản phẩm sắp hết hàng (tồn kho < 10)
            int lowStockCount = 0;
            for (KhoDen kho : khoList) {
                int currentStock = kho.getSoLuongNhap() - kho.getSoLuongBan();
                if (currentStock > 0 && currentStock < 10) {
                    lowStockCount++;
                }
            }

            NumberFormat nf = NumberFormat.getNumberInstance(new Locale("vi", "VN"));
        %>

        <div class="pc-container">
            <div class="pc-content">
                <div class="dashboard-container">
                    
                    <!-- Welcome Section -->
                    <div class="welcome-section">
                        <div class="welcome-title">Chào mừng trở lại! 👋</div>
                        <div class="welcome-subtitle">
                            Quản lý cửa hàng đèn
                        </div>
                    </div>

                    <!-- Inventory Alert -->
                    <% if (lowStockCount > 0) { %>
                    <div class="inventory-alert">
                        <div class="alert-title">
                            <i class="fas fa-exclamation-triangle"></i>
                            Cảnh báo tồn kho
                        </div>
                        <div class="alert-content">
                            Có <%= lowStockCount %> sản phẩm sắp hết hàng. Vui lòng kiểm tra và nhập thêm.
                        </div>
                    </div>
                    <% } %>

                    <!-- Statistics Grid -->
                    <div class="stats-grid">
                        <div class="stat-card primary">
                            <div class="stat-icon primary">
                                <i class="fas fa-lightbulb"></i>
                            </div>
                            <div class="stat-value"><%= nf.format(totalProducts) %></div>
                            <div class="stat-label">Tổng sản phẩm</div>
                        </div>

                        <div class="stat-card success">
                            <div class="stat-icon success">
                                <i class="fas fa-layer-group"></i>
                            </div>
                            <div class="stat-value"><%= nf.format(totalVariants) %></div>
                            <div class="stat-label">Biến thể sản phẩm</div>
                        </div>

                        <div class="stat-card warning">
                            <div class="stat-icon warning">
                                <i class="fas fa-boxes"></i>
                            </div>
                            <div class="stat-value"><%= nf.format(totalStock) %></div>
                            <div class="stat-label">Tổng tồn kho</div>
                        </div>

                        <div class="stat-card danger">
                            <div class="stat-icon danger">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="stat-value"><%= nf.format(totalUsers) %></div>
                            <div class="stat-label">Người dùng</div>
                        </div>

                        <div class="stat-card info">
                            <div class="stat-icon info">
                                <i class="fas fa-truck"></i>
                            </div>
                            <div class="stat-value"><%= nf.format(totalSuppliers) %></div>
                            <div class="stat-label">Nhà cung cấp</div>
                        </div>

                        <div class="stat-card purple">
                            <div class="stat-icon purple">
                                <i class="fas fa-palette"></i>
                            </div>
                            <div class="stat-value"><%= nf.format(totalColors) %></div>
                            <div class="stat-label">Màu sắc</div>
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <div class="quick-actions">
                        <div class="action-card" onclick="window.location.href='../elements/ShopItem.jsp'">
                            <div class="action-icon">
                                <i class="fas fa-lightbulb"></i>
                            </div>
                            <div class="action-title">Quản lý Sản phẩm</div>
                            <div class="action-desc">Thêm, sửa, xóa đèn</div>
                        </div>

                        <div class="action-card" onclick="window.location.href='../elements/ItemDetail.jsp'">
                            <div class="action-icon">
                                <i class="fas fa-cubes"></i>
                            </div>
                            <div class="action-title">Biến thể Sản phẩm</div>
                            <div class="action-desc">Quản lý màu sắc, kích thước</div>
                        </div>

                        <div class="action-card" onclick="window.location.href='../elements/ProductStorage.jsp'">
                            <div class="action-icon">
                                <i class="fas fa-warehouse"></i>
                            </div>
                            <div class="action-title">Quản lý Kho</div>
                            <div class="action-desc">Theo dõi tồn kho</div>
                        </div>

                        <div class="action-card" onclick="window.location.href='../elements/statistics.jsp'">
                            <div class="action-icon">
                                <i class="fas fa-user-cog"></i>
                            </div>
                            <div class="action-title">Thống kê</div>
                            <div class="action-desc">Thống kê doanh thu</div>
                        </div>
                    </div>

                    <!-- Recent Activity & Summary -->
                    <div class="recent-section">
                        <div class="section-title">
                            <i class="fas fa-chart-bar"></i>
                            Tổng quan Cửa hàng
                        </div>
                        
                        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px;">
                            <div class="summary-box">
                                <div class="summary-title">Phân loại Sản phẩm</div>
                                <div>
                                    <div class="summary-item">
                                        <span>Danh mục:</span>
                                        <span class="summary-value"><%= totalCategories %> loại</span>
                                    </div>
                                    <div class="summary-item">
                                        <span>Kích thước:</span>
                                        <span class="summary-value"><%= totalSizes %> loại</span>
                                    </div>
                                    <div class="summary-item">
                                        <span>Biến thể trung bình:</span>
                                        <span class="summary-value"><%= totalProducts > 0 ? String.format("%.1f", (double)totalVariants/totalProducts) : 0 %> / sp</span>
                                    </div>
                                </div>
                            </div>

                            <div class="summary-box">
                                <div class="summary-title">Tình trạng Kho</div>
                                <div>
                                    <div class="summary-item">
                                        <span>Tổng tồn kho:</span>
                                        <span class="summary-value"><%= nf.format(totalStock) %> sản phẩm</span>
                                    </div>
                                    <div class="summary-item">
                                        <span>Sản phẩm sắp hết:</span>
                                        <span class="summary-value" style="color: <%= lowStockCount > 0 ? "#dc2626" : "#16a34a" %>">
                                            <%= lowStockCount %> sản phẩm
                                        </span>
                                    </div>
                                    <div class="summary-item">
                                        <span>Tình trạng:</span>
                                        <span class="summary-value" style="color: <%= totalStock > 50 ? "#16a34a" : "#dc2626" %>">
                                            <%= totalStock > 50 ? "Ổn định" : "Cần nhập thêm" %>
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <div class="summary-box">
                                <div class="summary-title">Hệ thống</div>
                                <div>
                                    <div class="summary-item">
                                        <span>Người dùng:</span>
                                        <span class="summary-value"><%= totalUsers %> tài khoản</span>
                                    </div>
                                    <div class="summary-item">
                                        <span>Nhà cung cấp:</span>
                                        <span class="summary-value"><%= totalSuppliers %> đối tác</span>
                                    </div>
                                    <div class="summary-item">
                                        <span>Màu sắc:</span>
                                        <span class="summary-value"><%= totalColors %> màu</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <%@ include file="../layouts/footer-block-admin.html" %>
        <%@ include file="../layouts/footer-js-admin.html" %>

        <script>
            // Xử lý sự kiện click cho các action card
            document.addEventListener('DOMContentLoaded', function() {
                // Thêm hiệu ứng loading khi click vào action card
                document.querySelectorAll('.action-card').forEach(card => {
                    card.addEventListener('click', function() {
                        this.style.opacity = '0.7';
                        setTimeout(() => {
                            this.style.opacity = '1';
                        }, 300);
                    });
                });

                // Kiểm tra và hiển thị thông báo nếu có sản phẩm sắp hết hàng
                const lowStockCount = <%= lowStockCount %>;
                if (lowStockCount > 0) {
                    console.log(`Có ${lowStockCount} sản phẩm sắp hết hàng, cần kiểm tra kho.`);
                }
            });
        </script>

    </body>
</html>