<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/layouts/header_user.jsp" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="LightStore - Địa chỉ cung cấp đèn trang trí cao cấp: đèn chùm pha lê, đèn thả trần, đèn ngủ, đèn LED hiện đại. Bảo hành chính hãng 2-5 năm, miễn phí vận chuyển toàn quốc.">
    <title>Giới thiệu - LightStore | Đèn Trang Trí Cao Cấp</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* PHẦN GIỚI THIỆU CHÍNH */
        .about-section {
            padding: 100px 0;
            background: linear-gradient(rgba(26, 26, 26, 0.9), rgba(40, 40, 40, 0.95)),
                        url('https://images.unsplash.com/photo-1513506003901-1e6a229e2d15?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80') center/cover no-repeat fixed;
            color: #fff;
            text-align: center;
            position: relative;
        }

        .about-section h1 {
            font-size: 52px;
            font-weight: 800;
            margin-bottom: 25px;
            background: linear-gradient(135deg, #ffd700, #ffa500);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 4px 15px rgba(0,0,0,0.3);
        }

        .about-section p {
            font-size: 18px;
            max-width: 800px;
            margin: 0 auto 50px;
            line-height: 1.8;
            opacity: 0.95;
            color: #e0e0e0;
        }

        .stats {
            display: flex;
            justify-content: center;
            gap: 50px;
            flex-wrap: wrap;
            margin: 60px 0 30px;
        }

        .stat-item {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(15px);
            padding: 30px 35px;
            border-radius: 16px;
            min-width: 160px;
            border: 1px solid rgba(255, 215, 0, 0.3);
            transition: transform 0.3s ease;
        }

        .stat-item:hover {
            transform: translateY(-5px);
            background: rgba(255, 215, 0, 0.15);
        }

        .stat-item strong {
            font-size: 42px;
            display: block;
            color: #ffd700;
            font-weight: 800;
            margin-bottom: 8px;
        }

        .stat-item div {
            font-size: 15px;
            color: #ccc;
            font-weight: 500;
        }

        /* CÁC PHẦN NỘI DUNG */
        .story, .mission, .why-choose {
            padding: 90px 0;
            max-width: 1200px;
            margin: 0 auto;
        }

        .story {
            background: #fff;
            color: #333;
        }

        .mission {
            background: #f8f9fa;
        }

        .why-choose {
            background: linear-gradient(135deg, #1a1a1a, #2a2a2a);
            color: #fff;
        }

        .section-title {
            font-size: 36px;
            text-align: center;
            margin-bottom: 50px;
            position: relative;
            padding-bottom: 20px;
            font-weight: 700;
        }

        .story .section-title, .mission .section-title {
            color: #1a1a1a;
        }

        .why-choose .section-title {
            color: #fff;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(135deg, #ffd700, #ffa500);
            border-radius: 2px;
        }

        .grid-2 {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 60px;
            align-items: center;
        }

        .grid-3 {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 35px;
            margin-top: 50px;
        }

        .feature-card {
            background: rgba(255, 255, 255, 0.08);
            padding: 40px 30px;
            border-radius: 16px;
            text-align: center;
            transition: all 0.4s ease;
            border: 1px solid rgba(255, 215, 0, 0.2);
            backdrop-filter: blur(10px);
        }

        .feature-card:hover {
            transform: translateY(-10px);
            background: rgba(255, 215, 0, 0.12);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.25);
            border-color: rgba(255, 215, 0, 0.4);
        }

        .feature-card i {
            font-size: 48px;
            color: #ffd700;
            margin-bottom: 25px;
        }

        .feature-card h3 {
            font-size: 22px;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .feature-card p {
            font-size: 15px;
            line-height: 1.6;
            color: #ccc;
        }

        .story .feature-card p {
            color: #666;
        }

        img.about-img {
            border-radius: 16px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.25);
            max-width: 100%;
            height: auto;
            transition: transform 0.3s ease;
        }

        img.about-img:hover {
            transform: scale(1.02);
        }

        .content-text {
            font-size: 17px;
            line-height: 1.8;
            color: #555;
        }

        .content-text strong {
            color: #1a1a1a;
            font-weight: 700;
        }

        .mission-text {
            text-align: center;
            font-size: 18px;
            line-height: 1.9;
            color: #444;
            max-width: 900px;
            margin: 0 auto;
        }

        .mission-text p {
            margin-bottom: 25px;
        }

        .highlight {
            background: linear-gradient(135deg, #ffd700, #ffa500);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 700;
        }

        /* RESPONSIVE */
        @media (max-width: 968px) {
            .grid-2 {
                grid-template-columns: 1fr;
                gap: 40px;
            }
            
            .about-section h1 {
                font-size: 42px;
            }
            
            .stats {
                gap: 30px;
            }
            
            .stat-item {
                padding: 25px 30px;
                min-width: 140px;
            }
            
            .stat-item strong {
                font-size: 36px;
            }
        }

        @media (max-width: 768px) {
            .about-section {
                padding: 80px 0;
            }
            
            .about-section h1 {
                font-size: 36px;
            }
            
            .section-title {
                font-size: 30px;
            }
            
            .grid-3 {
                grid-template-columns: 1fr;
                gap: 25px;
            }
            
            .story, .mission, .why-choose {
                padding: 70px 20px;
            }
        }
    </style>
</head>
<body>

<!-- PHẦN GIỚI THIỆU CHÍNH -->
<section class="about-section">
    <h1>LightStore – Nghệ Thuật Ánh Sáng Cho Mọi Nhà</h1>
    <p>Khám phá bộ sưu tập đèn trang trí cao cấp được chọn lọc kỹ lưỡng, mang đến vẻ đẹp tinh tế và không gian sống hoàn hảo cho ngôi nhà của bạn</p>
    
    <div class="stats">
        <div class="stat-item">
            <strong>8+</strong>
            <div>Năm kinh nghiệm</div>
        </div>
        <div class="stat-item">
            <strong>25.000+</strong>
            <div>Sản phẩm đã bán</div>
        </div>
        <div class="stat-item">
            <strong>15.000+</strong>
            <div>Khách hàng hài lòng</div>
        </div>
        <div class="stat-item">
            <strong>5 năm</strong>
            <div>Bảo hành tối ưu</div>
        </div>
    </div>
</section>

<!-- CÂU CHUYỆN LIGHTSTORE -->
<section class="story">
    <div style="max-width:1200px; margin:0 auto; padding:0 20px;">
        <h2 class="section-title">Hành Trình Ánh Sáng Của Chúng Tôi</h2>
        <div class="grid-2">
            <div>
                <div class="content-text">
                    <p>Từ năm 2016, LightStore bắt đầu với sứ mệnh mang đến những chiếc đèn không chỉ chiếu sáng mà còn tạo nên điểm nhấn nghệ thuật cho không gian sống.</p>
                    <p style="margin-top:20px;">Chúng tôi tin rằng <strong>ánh sáng chính là linh hồn của ngôi nhà</strong> - nó có khả năng biến đổi hoàn toàn cảm xúc và thẩm mỹ của không gian.</p>
                    <p style="margin-top:20px;">Qua từng năm, LightStore không ngừng phát triển, mang đến những thiết kế đèn độc đáo từ phong cách cổ điển sang trọng đến hiện đại tối giản, đáp ứng mọi nhu cầu và sở thích của khách hàng.</p>
                </div>
            </div>
            <div>
                  <img src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Showroom LightStore" class="about-img">
            </div>
        </div>
    </div>
</section>

<!-- SỨ MỆNH & TẦM NHÌN -->
<section class="mission">
    <div style="max-width:1200px; margin:0 auto; padding:0 20px;">
        <h2 class="section-title">Sứ Mệnh Ánh Sáng</h2>
        <div class="mission-text">
            <p><strong class="highlight">"Mang đến giải pháp chiếu sáng thông minh - Biến mọi không gian thành tác phẩm nghệ thuật"</strong></p>
            <p>Chúng tôi không chỉ cung cấp đèn trang trí, mà còn mang đến <strong>giải pháp chiếu sáng toàn diện</strong> cho ngôi nhà bạn. Mỗi sản phẩm đều được tuyển chọn kỹ lưỡng về chất lượng, thẩm mỹ và tính an toàn.</p>
            <p>Đội ngũ chuyên gia của chúng tôi luôn sẵn sàng tư vấn để bạn tìm được chiếc đèn hoàn hảo nhất cho từng không gian riêng biệt.</p>
        </div>
    </div>
</section>

<!-- TẠI SAO CHỌN LIGHTSTORE -->
<section class="why-choose">
    <div style="max-width:1200px; margin:0 auto; padding:0 20px;">
        <h2 class="section-title">Tại Sao Nên Chọn LightStore?</h2>
        <div class="grid-3">
            <div class="feature-card">
                <i class="fas fa-gem"></i>
                <h3>Chất Lượng Cao Cấp</h3>
                <p>Sản phẩm chính hãng với vật liệu cao cấp, đảm bảo độ bền và tính thẩm mỹ vượt trội</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-award"></i>
                <h3>Thiết Kế Độc Đáo</h3>
                <p>Bộ sưu tập đa dạng từ cổ điển sang trọng đến hiện đại, phù hợp mọi phong cách</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-shield-alt"></i>
                <h3>Bảo Hành Dài Hạn</h3>
                <p>Bảo hành lên đến 5 năm cho đèn chùm pha lê, 3 năm cho đèn LED công nghệ cao</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-truck"></i>
                <h3>Giao Hàng Tận Nơi</h3>
                <p>Miễn phí vận chuyển toàn quốc, lắp đặt chuyên nghiệp tại Hà Nội & TP.HCM</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-headset"></i>
                <h3>Hỗ Trợ 24/7</h3>
                <p>Đội ngũ tư vấn chuyên nghiệp, sẵn sàng hỗ trợ mọi lúc bạn cần</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-lightbulb"></i>
                <h3>Giải Pháp Sáng Tạo</h3>
                <p>Tư vấn thiết kế ánh sáng phù hợp với từng không gian và nhu cầu cụ thể</p>
            </div>
        </div>
    </div>
</section>

<%@ include file="/layouts/footer_user.jsp" %>
</body>
</html>