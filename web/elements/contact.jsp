<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/layouts/header_user.jsp" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Liên hệ LightStore - Tư vấn đèn trang trí cao cấp, đèn chùm pha lê, đèn thả trần. Hotline 1900 6750 - Hỗ trợ 24/7, giao hàng & lắp đặt tận nơi.">
    <meta name="keywords" content="liên hệ lightstore, đèn trang trí, đèn chùm, đèn ngủ, tư vấn ánh sáng">
    <title>Liên Hệ - LightStore | Đèn Trang Trí Cao Cấp</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #f8f9fa; color: #333; }

        /* Hero Section - Đẹp lung linh */
        .contact-hero {
            padding: 120px 0 80px;
            background: linear-gradient(rgba(26,26,26,0.92), rgba(40,40,40,0.95)),
                        url('https://images.unsplash.com/photo-1513506003901-1e6a229e2d15?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80') center/cover no-repeat fixed;
            color: #fff;
            text-align: center;
            position: relative;
        }
        .contact-hero h1 {
            font-size: 52px;
            font-weight: 800;
            margin-bottom: 20px;
            background: linear-gradient(135deg, #ffd700, #ffa500);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .contact-hero p {
            font-size: 19px;
            max-width: 800px;
            margin: 0 auto;
            opacity: 0.95;
            line-height: 1.7;
        }

        /* Main Contact Section */
        .contact-main {
            padding: 90px 0;
            max-width: 1200px;
            margin: 0 auto;
            padding-left: 20px;
            padding-right: 20px;
        }

        .contact-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 70px;
            align-items: start;
        }

        /* Thông tin liên hệ */
        .contact-info {
            background: #fff;
            padding: 45px;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
            border-left: 6px solid #ffd700;
            height: fit-content;
        }
        .contact-info h2 {
            font-size: 32px;
            margin-bottom: 35px;
            color: #1a1a1a;
            background: linear-gradient(135deg, #ffd700, #ffa500);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .contact-item {
            display: flex;
            align-items: flex-start;
            gap: 20px;
            margin-bottom: 35px;
            padding-bottom: 25px;
            border-bottom: 1px dashed #eee;
        }
        .contact-item:last-child { border-bottom: none; margin-bottom: 0; padding-bottom: 0; }

        .contact-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #ffd700, #ffa500);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #1a1a1a;
            font-size: 24px;
            flex-shrink: 0;
            box-shadow: 0 8px 25px rgba(255,215,0,0.3);
        }

        .contact-details h4 {
            font-size: 19px;
            margin-bottom: 10px;
            color: #1a1a1a;
            font-weight: 700;
        }
        .contact-details p {
            color: #555;
            line-height: 1.7;
            margin: 5px 0;
            font-size: 15.5px;
        }
        .contact-details a {
            color: #e74c3c;
            text-decoration: none;
            font-weight: 600;
        }
        .contact-details a:hover { text-decoration: underline; }

        /* Giờ làm việc */
        .business-hours {
            margin-top: 35px;
            padding: 25px;
            background: linear-gradient(135deg, #fff9e6, #fff3cd);
            border-radius: 16px;
            border: 1px solid #ffd700;
        }
        .business-hours h4 {
            margin-bottom: 18px;
            color: #b8860b;
            font-size: 20px;
        }
        .hours-list {
            list-style: none;
        }
        .hours-list li {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            font-size: 15px;
            border-bottom: 1px dotted #ccc;
        }
        .hours-list li:last-child { border: none; }
        .hours-list li span:first-child { font-weight: 600; color: #1a1a1a; }

        /* Form liên hệ */
        .contact-form {
            background: #fff;
            padding: 45px;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
        }
        .contact-form h2 {
            font-size: 32px;
            margin-bottom: 15px;
            color: #1a1a1a;
        }
        .contact-form p {
            color: #666;
            margin-bottom: 35px;
            font-size: 16px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 25px;
        }
        .form-group {
            margin-bottom: 25px;
        }
        .form-group label {
            display: block;
            margin-bottom: 10px;
            font-weight: 600;
            color: #333;
            font-size: 15px;
        }
        .form-control {
            width: 100%;
            padding: 16px 18px;
            border: 2px solid #eee;
            border-radius: 12px;
            font-size: 15.5px;
            transition: all 0.3s ease;
            background: #fdfdfd;
        }
        .form-control:focus {
            outline: none;
            border-color: #ffd700;
            background: #fff;
            box-shadow: 0 0 0 4px rgba(255,215,0,0.15);
        }
        textarea.form-control {
            min-height: 140px;
            resize: vertical;
        }

        .btn-submit {
            background: linear-gradient(135deg, #ffd700, #ffa500);
            color: #1a1a1a;
            border: none;
            padding: 18px 50px;
            border-radius: 12px;
            font-size: 17px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.4s ease;
            width: 100%;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .btn-submit:hover {
            transform: translateY(-4px);
            box-shadow: 0 15px 35px rgba(255,215,0,0.4);
        }

        /* Map */
        .map-section {
            padding: 80px 0;
            background: #111;
            text-align: center;
        }
        .map-section h2 {
            font-size: 38px;
            color: #ffd700;
            margin-bottom: 40px;
        }
        .map-wrapper {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 20px 50px rgba(0,0,0,0.4);
        }

        /* Responsive */
        @media (max-width: 992px) {
            .contact-container { grid-template-columns: 1fr; gap: 50px; }
            .contact-hero h1 { font-size: 44px; }
        }
        @media (max-width: 768px) {
            .contact-hero { padding: 100px 20px 70px; }
            .contact-hero h1 { font-size: 38px; }
            .contact-main { padding: 70px 20px; }
            .contact-info, .contact-form { padding: 35px 25px; }
            .form-row { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<!-- Hero Liên hệ -->
<section class="contact-hero">
    <h1>Liên Hệ LightStore</h1>
    <p>Chúng tôi luôn sẵn sàng hỗ trợ bạn chọn được chiếc đèn hoàn hảo nhất cho ngôi nhà.  
       Hãy liên hệ ngay hôm nay để được tư vấn miễn phí!</p>
</section>

<!-- Nội dung chính -->
<section class="contact-main">
    <div class="contact-container">

        <!-- Thông tin liên hệ -->
        <div class="contact-info">
            <h2>Thông Tin Liên Hệ</h2>

            <div class="contact-item">
                <div class="contact-icon">
                    <i class="fas fa-map-marker-alt"></i>
                </div>
                <div class="contact-details">
                    <h4>Showroom Chính</h4>
                    <p><strong>Hà Nội:</strong> 266 Đội Cấn, Ba Đình</p>
                    <p><strong>TP.HCM:</strong> 123 Nguyễn Văn Linh, Quận 7</p>
                </div>
            </div>

            <div class="contact-item">
                <div class="contact-icon">
                    <i class="fas fa-phone-alt"></i>
                </div>
                <div class="contact-details">
                    <h4>Hotline Miễn Phí</h4>
                    <p><a href="tel:19006750">1900 6750</a> (Hà Nội)</p>
                    <p><a href="tel:19006751">1900 6751</a> (TP.HCM)</p>
                    <p><a href="tel:0987654321">0987 654 321</a> (24/7)</p>
                </div>
            </div>

            <div class="contact-item">
                <div class="contact-icon">
                    <i class="fas fa-envelope"></i>
                </div>
                <div class="contact-details">
                    <h4>Email Hỗ Trợ</h4>
                    <p><a href="mailto:info@lightstore.vn">info@lightstore.vn</a></p>
                    <p><a href="mailto:support@lightstore.vn">support@lightstore.vn</a></p>
                </div>
            </div>

            <div class="business-hours">
                <h4>Giờ Làm Việc</h4>
                <ul class="hours-list">
                    <li><span>Thứ 2 - Thứ 6</span> <span>8:00 - 22:00</span></li>
                    <li><span>Thứ 7</span> <span>8:00 - 20:00</span></li>
                    <li><span>Chủ nhật</span> <span>8:00 - 18:00</span></li>
                </ul>
            </div>
        </div>

        <!-- Form liên hệ -->
        <div class="contact-form">
            <h2>Gửi Tin Nhắn Cho Chúng Tôi</h2>
            <p>Điền thông tin để nhận tư vấn thiết kế ánh sáng miễn phí trong 30 phút!</p>

            <% 
                String success = (String) request.getAttribute("success");
                String error = (String) request.getAttribute("error");
            %>
            
            <% if (success != null) { %>
            <div style="background: #d4edda; color: #155724; padding: 15px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #c3e6cb;">
                <i class="fas fa-check-circle"></i> <%= success %>
            </div>
            <% } %>
            
            <% if (error != null) { %>
            <div style="background: #f8d7da; color: #721c24; padding: 15px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #f5c6cb;">
                <i class="fas fa-exclamation-circle"></i> <%= error %>
            </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/contact" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label>Họ và tên *</label>
                        <input type="text" name="name" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Số điện thoại *</label>
                        <input type="tel" name="phone" class="form-control" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Chủ đề</label>
                        <input type="text" name="subject" class="form-control" placeholder="Ví dụ: Tư vấn đèn phòng khách">
                    </div>
                </div>

                <div class="form-group">
                    <label>Nội dung tin nhắn *</label>
                    <textarea name="message" class="form-control" placeholder="Bạn cần tư vấn loại đèn nào? Diện tích phòng bao nhiêu m²?..." required></textarea>
                </div>

                <button type="submit" class="btn-submit">
                    Gửi Tin Nhắn Ngay
                </button>
            </form>
        </div>
    </div>
</section>

<!-- Google Maps -->
<section class="map-section">
    <h2>Thăm Showroom Gần Nhất</h2>
    <div class="map-wrapper">
        <iframe 
            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.088243564623!2d105.82578261532832!3d21.02973898599942!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ab8f147f0a1f%3A0x7e9f1d1e6258b11!2s266%20%C4%90%E1%BB%99i%20C%E1%BA%A5n%2C%20Ba%20%C4%90%C3%ACnh%2C%20H%C3%A0%20N%E1%BB%99i!5e0!3m2!1svi!2s!4v1733000000000" 
            width="100%" 
            height="500" 
            style="border:0;" 
            allowfullscreen="" 
            loading="lazy">
        </iframe>
    </div>
</section>

<%@ include file="/layouts/footer_user.jsp" %>
</body>
</html>