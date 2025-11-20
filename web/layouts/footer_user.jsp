<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Light Store - Footer</title>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }

        footer { background:#111; color:#ccc; font-size:14px; }

        /* ==================== NEWSLETTER ==================== */
        .newsletter {
            background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 100%);
            padding:45px 0;
            text-align:center;
            border-bottom: 1px solid #333;
        }
        .newsletter h3 {
            color:#fff;
            font-size:18px;
            text-transform:uppercase;
            margin-bottom:15px;
            letter-spacing: 1px;
        }
        .newsletter form {
            max-width:480px;
            margin:0 auto;
            display:flex;
            border-radius: 30px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }
        .newsletter input {
            flex:1;
            padding:13px 20px;
            border:none;
            font-size:14px;
            background: #2d2d2d;
            color: #fff;
        }
        .newsletter input:focus {
            outline: none;
        }
        .newsletter input::placeholder {
            color: #aaa;
        }
        .newsletter button {
            background: linear-gradient(135deg, #ffd700, #ffa500);
            color:#1a1a1a;
            border:none;
            padding:0 30px;
            cursor:pointer;
            font-weight:bold;
            text-transform:uppercase;
            transition: all 0.3s ease;
        }
        .newsletter button:hover {
            background: linear-gradient(135deg, #ffa500, #ffd700);
        }
        .social-icons {
            margin-top:20px;
        }
        .social-icons a {
            display:inline-block;
            width:40px; 
            height:40px;
            background:#333;
            color:#fff;
            line-height:40px;
            border-radius:50%;
            margin:0 8px;
            font-size:16px;
            transition: all 0.3s ease;
        }
        .social-icons a:hover {
            background: linear-gradient(135deg, #ffd700, #ffa500);
            color: #1a1a1a;
            transform: translateY(-3px);
        }

        /* ==================== FOOTER CHÍNH ==================== */
        .footer-main {
            background:#1a1a1a;
            padding:60px 0 40px;
        }
        .footer-container {
            max-width:1200px;
            margin:0 auto;
            padding:0 15px;
            display:flex;
            flex-wrap:wrap;
            gap:30px;
            align-items:flex-start;
        }
        .footer-col {
            flex:1;
            min-width:200px;
        }

        /* Cột Logo */
        .footer-logo-container {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .footer-logo-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #ffd700, #ffa500);
            border-radius: 6px;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 10px rgba(255, 215, 0, 0.3);
            margin-right: 12px;
            overflow: hidden;
        }
        
        .footer-logo-icon::before {
            content: "";
            position: absolute;
            width: 24px;
            height: 24px;
            background: #fff;
            border-radius: 50%;
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.7);
            opacity: 0.9;
        }
        
        .footer-logo-icon::after {
            content: "";
            position: absolute;
            width: 12px;
            height: 12px;
            background: #ffd700;
            border-radius: 50%;
            box-shadow: 0 0 8px rgba(255, 215, 0, 0.8);
            z-index: 2;
        }
        
        .footer-logo-text {
            display: flex;
            flex-direction: column;
        }
        
        .footer-logo-main {
            color: #fff;
            font-size: 24px;
            font-weight: 700;
            letter-spacing: 1px;
            line-height: 1;
        }
        
        .footer-logo-subtitle {
            color: #ffd700;
            font-size: 10px;
            letter-spacing: 2px;
            margin-top: 2px;
            font-weight: 500;
        }

        .logo-col p {
            color:#aaa;
            line-height:1.7;
            margin-bottom:25px;
            font-size: 14px;
        }
        .payment-methods img {
            height:32px;
            margin-right:10px;
            vertical-align:middle;
            filter: brightness(0.8);
        }

        /* Các tiêu đề cột */
        .footer-col h3 {
            color:#fff;
            font-size:15px;
            text-transform:uppercase;
            margin-bottom:20px;
            position:relative;
            padding-bottom:10px;
            letter-spacing: 0.5px;
        }
        .footer-col h3:after {
            content:'';
            position:absolute;
            left:0; bottom:0;
            width:40px;
            height:2px;
            background: linear-gradient(135deg, #ffd700, #ffa500);
        }

        /* Menu link */
        .footer-col ul { list-style:none; }
        .footer-col ul li { margin-bottom:10px; }
        .footer-col ul li a {
            color:#aaa;
            text-decoration:none;
            transition:0.3s;
            display: flex;
            align-items: center;
        }
        .footer-col ul li a:hover {
            color:#ffd700;
            padding-left:8px;
        }
        .footer-col ul li a:before {
            content:"›";
            color:#ffd700;
            margin-right: 8px;
            font-weight: bold;
        }

        /* PHẦN LIÊN HỆ */
        .contact-info h3 { margin-bottom:20px; }
        .contact-info p {
            margin-bottom:15px;
            color:#aaa;
            display:flex;
            align-items:center;
            gap:12px;
        }
        .contact-info-footer i {
            color:#ffd700;
            font-size:16px;
            width:20px;
            text-align:center;
        }

        /* Copyright */
        .copyright {
            background:#000;
            text-align:center;
            padding:25px 0;
            font-size:13px;
            color:#666;
            border-top:1px solid #333;
        }
        .copyright strong {
            color: #ffd700;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<footer>
    <!-- ĐĂNG KÝ NHẬN TIN -->
    <div class="newsletter">
        <h3>Đăng ký nhận tin khuyến mãi</h3>
        <form>
            <input type="email" placeholder="Nhập email của bạn...">
            <button type="submit">Đăng ký</button>
        </form>
        <div class="social-icons">
            <a href="#"><i class="fab fa-facebook-f"></i></a>
            <a href="#"><i class="fab fa-instagram"></i></a>
            <a href="#"><i class="fab fa-youtube"></i></a>
            <a href="#"><i class="fab fa-tiktok"></i></a>
        </div>
    </div>

    <!-- FOOTER CHÍNH -->
    <div class="footer-main">
        <div class="footer-container">
            <!-- Cột 1 -->
            <div class="footer-col logo-col">
                <div class="footer-logo-container">
                    <div class="footer-logo-icon"></div>
                    <div class="footer-logo-text">
                        <div class="footer-logo-main">LightStore</div>
                        <div class="footer-logo-subtitle">ÁNH SÁNG & NGHỆ THUẬT</div>
                    </div>
                </div>
                <p>
                    LightStore mang đến những mẫu đèn trang trí hiện đại, sang trọng - biến không gian sống thành tác phẩm nghệ thuật ánh sáng. Chúng tôi cam kết chất lượng và dịch vụ tốt nhất.
                </p>
                <div class="payment-methods">
                    <img src="//bizweb.dktcdn.net/thumb/thumb/100/037/441/themes/880432/assets/payment_1_image.png?1753172555362" alt="PayPal">
                    <img src="//bizweb.dktcdn.net/thumb/thumb/100/037/441/themes/880432/assets/payment_2_image.png?1753172555362" alt="Visa">
                    <img src="//bizweb.dktcdn.net/thumb/thumb/100/037/441/themes/880432/assets/payment_3_image.png?1753172555362" alt="MasterCard">
                </div>
            </div>

            <!-- Cột 2 -->
            <div class="footer-col">
                <h3>Về chúng tôi</h3>
                <ul>
                    <li><a href="#">Trang chủ</a></li>
                    <li><a href="#">Giới thiệu</a></li>
                    <li><a href="#">Bộ sưu tập</a></li>
                    <li><a href="#">Tin tức</a></li>
                    <li><a href="#">Tuyển dụng</a></li>
                </ul>
            </div>

            <!-- Cột 3 -->
            <div class="footer-col">
                <h3>Hỗ trợ</h3>
                <ul>
                    <li><a href="#">Hướng dẫn mua hàng</a></li>
                    <li><a href="#">Chính sách đổi trả</a></li>
                    <li><a href="#">Chính sách bảo hành</a></li>
                    <li><a href="#">Vận chuyển & Giao nhận</a></li>
                    <li><a href="#">Câu hỏi thường gặp</a></li>
                </ul>
            </div>

            <!-- Cột 4 -->
            <div class="footer-col">
                <h3>Chính sách</h3>
                <ul>
                    <li><a href="#">Chính sách bảo mật</a></li>
                    <li><a href="#">Điều khoản sử dụng</a></li>
                    <li><a href="#">Chính sách thanh toán</a></li>
                    <li><a href="#">Chính sách vận chuyển</a></li>
                    <li><a href="#">Bảo vệ người tiêu dùng</a></li>
                </ul>
            </div>

            <!-- Cột 5 - Liên hệ -->
            <div class="footer-col contact-info-footer">
                <h3>Liên hệ</h3>
                <p><i class="fas fa-map-marker-alt"></i> 266 Đội Cấn, Ba Đình, Hà Nội</p>
                <p><i class="fas fa-phone-alt"></i> 1900 6750</p>
                <p><i class="fas fa-envelope"></i> support@lightstore.vn</p>
                <p><i class="fas fa-clock"></i> 8:00 - 22:00 (T2 - CN)</p>
            </div>
        </div>
    </div>

    <!-- COPYRIGHT -->
    <div class="copyright">
        © Bản quyền thuộc về <strong>LightStore</strong> | Phát triển bởi <strong>Sinh viên UNETI</strong>
    </div>
</footer>

</body>
</html>