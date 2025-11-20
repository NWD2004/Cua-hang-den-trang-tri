<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/layouts/header_user.jsp" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ | LightStore - Cửa hàng đèn trang trí cao cấp</title>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background:#f8f9fa; color:#333; }

        /* ===== HERO BANNER ===== */
        .hero {
            position: relative;
            height: 90vh;
            min-height: 600px;
            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.6)),
                        url('https://images.unsplash.com/photo-1513506003901-1e6a229e2d15?q=80&w=2070&auto=format&fit=crop') center/cover no-repeat;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: #fff;
        }
        .hero-content {
            max-width: 800px;
            padding: 20px;
        }
        .hero h1 {
            font-size: 56px;
            margin-bottom: 20px;
            font-weight: 700;
        }
        .hero h1 span {
            color: #ffd700;
            font-family: 'Dancing Script', cursive;
            font-size: 72px;
        }
        .hero p {
            font-size: 20px;
            margin-bottom: 30px;
            opacity: 0.9;
        }
        .btn {
            display: inline-block;
            background: linear-gradient(135deg, #ffd700, #ffa500);
            color: #1a1a1a;
            padding: 14px 40px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: bold;
            font-size: 18px;
            transition: 0.3s;
            box-shadow: 0 4px 15px rgba(255, 215, 0, 0.3);
        }
        .btn:hover { 
            background: linear-gradient(135deg, #ffa500, #ffd700); 
            transform: translateY(-3px); 
            box-shadow:0 10px 20px rgba(0,0,0,0.2); 
        }

        /* ===== SECTION TITLE ===== */
        .section-title {
            text-align: center;
            padding: 60px 20px 40px;
            font-size: 36px;
            color: #222;
            position: relative;
        }
        .section-title::after {
            content: '';
            width: 80px;
            height: 4px;
            background: linear-gradient(135deg, #ffd700, #ffa500);
            position: absolute;
            bottom: 25px;
            left: 50%;
            transform: translateX(-50%);
        }

        /* ===== PRODUCT GRID ===== */
        .product-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 15px;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(270px, 1fr));
            gap: 30px;
            margin-bottom: 80px;
        }
        .product-card {
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: 0.4s;
            position: relative;
        }
        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 30px rgba(0,0,0,0.15);
        }
        .product-img {
            height: 280px;
            overflow: hidden;
        }
        .product-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: 0.5s;
        }
        .product-card:hover .product-img img { transform: scale(1.1); }

        .product-info {
            padding: 20px;
            text-align: center;
        }
        .product-info h3 {
            font-size: 18px;
            margin-bottom: 10px;
            color: #333;
        }
        .price {
            font-size: 22px;
            color: #e74c3c;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .old-price {
            text-decoration: line-through;
            color: #999;
            font-size: 16px;
            margin-left: 8px;
        }
        .badge {
            position: absolute;
            top: 15px;
            left: 15px;
            background: #e74c3c;
            color: #fff;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 13px;
            font-weight: bold;
            z-index: 2;
        }
        .badge.new { background:#27ae60; }
        .badge.sale { background:#e67e22; }
        
        .add-to-cart {
            background: #1a1a1a;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 30px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
            margin-top: 10px;
            width: 100%;
        }
        .add-to-cart:hover {
            background: linear-gradient(135deg, #ffd700, #ffa500);
            color: #1a1a1a;
        }

        /* ===== FEATURES ===== */
        .features {
            background: #fff;
            padding: 50px 0;
            text-align: center;
            box-shadow: 0 -5px 20px rgba(0,0,0,0.05);
        }
        .features-container {
            max-width: 1000px;
            margin: 0 auto;
            display: flex;
            justify-content: center;
            gap: 60px;
            flex-wrap: wrap;
        }
        .feature {
            font-size: 16px;
        }
        .feature i {
            font-size: 42px;
            color: #ffd700;
            margin-bottom: 15px;
        }
        .feature h3 {
            font-size: 18px;
            margin-bottom: 8px;
        }
        
        /* ===== CATEGORIES ===== */
        .categories {
            background: #f5f5f5;
            padding: 60px 0;
        }
        .category-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 15px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
        }
        .category-card {
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: 0.4s;
            position: relative;
        }
        .category-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 25px rgba(0,0,0,0.15);
        }
        .category-img {
            height: 200px;
            overflow: hidden;
        }
        .category-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: 0.5s;
        }
        .category-card:hover .category-img img { transform: scale(1.1); }
        .category-info {
            padding: 20px;
            text-align: center;
        }
        .category-info h3 {
            font-size: 20px;
            margin-bottom: 10px;
            color: #333;
        }
        
        /* ===== STATS ===== */
        .stats {
            background: #1a1a1a;
            color: #fff;
            padding: 80px 0;
            text-align: center;
        }
        .stats-container {
            max-width: 1000px;
            margin: 0 auto;
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            gap: 40px;
        }
        .stat-item h2 {
            font-size: 48px;
            color: #ffd700;
            margin-bottom: 10px;
        }
        .stat-item p {
            font-size: 18px;
            opacity: 0.9;
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap" rel="stylesheet">
</head>
<body>

    <!-- HERO BANNER -->
    <section class="hero">
        <div class="hero-content">
            <h1>Chào mừng đến với <span>LightStore</span></h1>
            <p>Khám phá những mẫu đèn trang trí hiện đại, sang trọng – biến không gian sống thành nghệ thuật ánh sáng.</p>
            <a href="#featured-products" class="btn">Khám phá ngay</a>
        </div>
    </section>

    <!-- FEATURES -->
    <section class="features">
        <div class="features-container">
            <div class="feature">
                <i class="fa-solid fa-truck-fast"></i>
                <h3>Giao hàng nhanh chóng</h3>
                <p>Toàn quốc trong 2-5 ngày</p>
            </div>
            <div class="feature">
                <i class="fa-solid fa-shield-halved"></i>
                <h3>Bảo hành chính hãng</h3>
                <p>Đổi trả dễ dàng 1-1</p>
            </div>
            <div class="feature">
                <i class="fa-solid fa-headset"></i>
                <h3>Hỗ trợ 24/7</h3>
                <p>Tư vấn nhiệt tình mọi lúc</p>
            </div>
            <div class="feature">
                <i class="fa-solid fa-rotate-left"></i>
                <h3>Đổi trả miễn phí</h3>
                <p>Trong vòng 30 ngày</p>
            </div>
        </div>
    </section>

    <!-- DANH MỤC SẢN PHẨM -->
    <section class="categories">
        <h2 class="section-title">Danh mục sản phẩm</h2>
        <div class="category-container">
            <div class="category-card">
                <div class="category-img">
                    <img src="https://images.unsplash.com/photo-1581094794329-c4ebef0956e9?w=600" alt="Đèn thả trần">
                </div>
                <div class="category-info">
                    <h3>Đèn thả trần</h3>
                    <p>25+ sản phẩm</p>
                </div>
            </div>
            <div class="category-card">
                <div class="category-img">
                    <img src="https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=600" alt="Đèn bàn">
                </div>
                <div class="category-info">
                    <h3>Đèn bàn</h3>
                    <p>18+ sản phẩm</p>
                </div>
            </div>
            <div class="category-card">
                <div class="category-img">
                    <img src="https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?w=600" alt="Đèn tường">
                </div>
                <div class="category-info">
                    <h3>Đèn tường</h3>
                    <p>22+ sản phẩm</p>
                </div>
            </div>
            <div class="category-card">
                <div class="category-img">
                    <img src="https://images.unsplash.com/photo-1581094794329-c4ebef0956e9?w=600" alt="Đèn sàn">
                </div>
                <div class="category-info">
                    <h3>Đèn sàn</h3>
                    <p>15+ sản phẩm</p>
                </div>
            </div>
        </div>
    </section>

    <!-- SẢN PHẨM NỔI BẬT -->
    <section class="products-section" id="featured-products">
        <h2 class="section-title">Sản phẩm nổi bật</h2>
        <div class="product-container">
            <div class="product-card">
                <span class="badge sale">-25%</span>
                <div class="product-img">
                    <img src="https://images.unsplash.com/photo-1598300041005-7e7c9037e3e7?w=600" alt="Đèn thả trần pha lê">
                </div>
                <div class="product-info">
                    <h3>Đèn thả trần pha lê Royal</h3>
                    <p class="price">2.850.000đ <span class="old-price">3.800.000đ</span></p>
                    <button class="add-to-cart">Thêm vào giỏ hàng</button>
                </div>
            </div>

            <div class="product-card">
                <div class="product-img">
                    <img src="https://images.unsplash.com/photo-1585060722534-1d044f4f39c4?w=600" alt="Đèn bàn ngủ">
                </div>
                <div class="product-info">
                    <h3>Đèn bàn ngủ Nordic Moon</h3>
                    <p class="price">890.000đ</p>
                    <button class="add-to-cart">Thêm vào giỏ hàng</button>
                </div>
            </div>

            <div class="product-card">
                <span class="badge new">Mới</span>
                <div class="product-img">
                    <img src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=600" alt="Đèn LED thông minh">
                </div>
                <div class="product-info">
                    <h3>Đèn LED thông minh RGB</h3>
                    <p class="price">1.290.000đ</p>
                    <button class="add-to-cart">Thêm vào giỏ hàng</button>
                </div>
            </div>

            <div class="product-card">
                <div class="product-img">
                    <img src="https://images.unsplash.com/photo-1615529193722-2e0e6e6d7f6f?w=600" alt="Đèn tường nghệ thuật">
                </div>
                <div class="product-info">
                    <h3>Đèn tường nghệ thuật Feather</h3>
                    <p class="price">1.650.000đ</p>
                    <button class="add-to-cart">Thêm vào giỏ hàng</button>
                </div>
            </div>
        </div>
    </section>

    <!-- SẢN PHẨM MỚI -->
    <section class="products-section" style="background:#f5f5f5; padding-top:40px;">
        <h2 class="section-title">Sản phẩm mới</h2>
        <div class="product-container">
            <div class="product-card">
                <span class="badge new">Mới</span>
                <div class="product-img">
                    <img src="https://images.unsplash.com/photo-1591605182416-7bf5c10c3b7b?w=600" alt="Đèn chùm hiện đại">
                </div>
                <div class="product-info">
                    <h3>Đèn chùm hiện đại Crystal Wave</h3>
                    <p class="price">5.600.000đ</p>
                    <button class="add-to-cart">Thêm vào giỏ hàng</button>
                </div>
            </div>

            <div class="product-card">
                <span class="badge new">Mới</span>
                <div class="product-img">
                    <img src="https://images.unsplash.com/photo-1615529182850-9e6e7d6d9e9e?w=600" alt="Đèn sàn đứng">
                </div>
                <div class="product-info">
                    <h3>Đèn sàn đứng Luxury Gold</h3>
                    <p class="price">3.950.000đ</p>
                    <button class="add-to-cart">Thêm vào giỏ hàng</button>
                </div>
            </div>

            <div class="product-card">
                <div class="product-img">
                    <img src="https://images.unsplash.com/photo-1600585154363-67eb9e2f8241?w=600" alt="Đèn ngủ cảm ứng">
                </div>
                <div class="product-info">
                    <h3>Đèn ngủ cảm ứng Touch Light</h3>
                    <p class="price">620.000đ</p>
                    <button class="add-to-cart">Thêm vào giỏ hàng</button>
                </div>
            </div>

            <div class="product-card">
                <div class="product-img">
                    <img src="https://images.unsplash.com/photo-1615874954595-3cb80b9252ed?w=600" alt="Đèn trang trí vườn">
                </div>
                <div class="product-info">
                    <h3>Đèn năng lượng mặt trời sân vườn</h3>
                    <p class="price">1.180.000đ</p>
                    <button class="add-to-cart">Thêm vào giỏ hàng</button>
                </div>
            </div>
        </div>
    </section>

    <!-- KHUYẾN MÃI -->
    <section class="products-section">
        <h2 class="section-title">Khuyến mãi hot</h2>
        <div class="product-container">
            <div class="product-card">
                <span class="badge sale">-40%</span>
                <div class="product-img">
                    <img src="https://images.unsplash.com/photo-1598300059553-4048c29d85e8?w=600" alt="Bộ đèn trang trí phòng khách">
                </div>
                <div class="product-info">
                    <h3>Bộ đèn phòng khách 5 món</h3>
                    <p class="price">8.900.000đ <span class="old-price">14.800.000đ</span></p>
                    <button class="add-to-cart">Thêm vào giỏ hàng</button>
                </div>
            </div>

            <div class="product-card">
                <span class="badge sale">-30%</span>
                <div class="product-img">
                    <img src="https://images.unsplash.com/photo-1618220048045-10a6dbdf2e3e?w=600" alt="Đèn thả bàn ăn">
                </div>
                <div class="product-info">
                    <h3>Đèn thả bàn ăn Luxury Line</h3>
                    <p class="price">2.450.000đ <span class="old-price">3.500.000đ</span></p>
                    <button class="add-to-cart">Thêm vào giỏ hàng</button>
                </div>
            </div>

            <div class="product-card">
                <span class="badge sale">-20%</span>
                <div class="product-img">
                    <img src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=600" alt="Đèn LED dây">
                </div>
                <div class="product-info">
                    <h3>Đèn LED dây 10m đổi màu</h3>
                    <p class="price">399.000đ <span class="old-price">499.000đ</span></p>
                    <button class="add-to-cart">Thêm vào giỏ hàng</button>
                </div>
            </div>

            <div class="product-card">
                <span class="badge sale">-35%</span>
                <div class="product-img">
                    <img src="https://images.unsplash.com/photo-1591605182416-7bf5c10c3b7b?w=600" alt="Đèn chùm phòng ngủ">
                </div>
                <div class="product-info">
                    <h3>Đèn chùm phòng ngủ Dream</h3>
                    <p class="price">3.250.000đ <span class="old-price">5.000.000đ</span></p>
                    <button class="add-to-cart">Thêm vào giỏ hàng</button>
                </div>
            </div>
        </div>
    </section>

    <!-- THỐNG KÊ -->
    <section class="stats">
        <div class="stats-container">
            <div class="stat-item">
                <h2>500+</h2>
                <p>Sản phẩm đa dạng</p>
            </div>
            <div class="stat-item">
                <h2>10.000+</h2>
                <p>Khách hàng hài lòng</p>
            </div>
            <div class="stat-item">
                <h2>5 năm</h2>
                <p>Kinh nghiệm</p>
            </div>
            <div class="stat-item">
                <h2>63</h2>
                <p>Tỉnh thành phục vụ</p>
            </div>
        </div>
    </section>

<%@ include file="/layouts/footer_user.jsp" %>

<script>
    // Xử lý thêm vào giỏ hàng
    document.querySelectorAll('.add-to-cart').forEach(button => {
        button.addEventListener('click', function() {
            const productName = this.parentElement.querySelector('h3').textContent;
            // Kiểm tra đăng nhập trước khi thêm vào giỏ
            checkLoginBeforeAddToCart(null, 1);
        });
    });
    
    // Hàm kiểm tra đăng nhập trước khi thêm vào giỏ hàng
    function checkLoginBeforeAddToCart(productId, quantity) {
        // Tạm thời bỏ qua vì userHome.jsp chưa có product ID thật
        // Có thể thêm data-product-id vào các button sau
        if (!productId) {
            alert('Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng!');
            if (confirm('Bạn có muốn chuyển đến trang đăng nhập?')) {
                window.location.href = '${pageContext.request.contextPath}/View/userLogin.jsp?returnUrl=' + encodeURIComponent(window.location.href);
            }
            return;
        }
    }
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/js/all.min.js"></script>
</body>
</html>