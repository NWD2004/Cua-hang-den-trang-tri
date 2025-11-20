<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/layouts/header_user.jsp" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Tin tức đèn trang trí LightStore - Cập nhật xu hướng đèn chùm pha lê, đèn thả trần, đèn LED 2025, mẹo chọn đèn phòng khách, phòng ngủ đẹp.">
    <title>Tin Tức - LightStore | Xu Hướng Đèn Trang Trí Mới Nhất</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #f8f9fa; color: #333; }

        /* Hero Tin tức */
        .news-hero {
            padding: 130px 0 90px;
            background: linear-gradient(rgba(26,26,26,0.93), rgba(40,40,40,0.96)),
                        url('https://images.unsplash.com/photo-1605158155829-4f2007e8c9ff?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80') center/cover no-repeat fixed;
            color: #fff;
            text-align: center;
        }
        .news-hero h1 {
            font-size: 54px;
            font-weight: 800;
            margin-bottom: 20px;
            background: linear-gradient(135deg, #ffd700, #ffa500);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .news-hero p {
            font-size: 19px;
            max-width: 800px;
            margin: 0 auto;
            opacity: 0.94;
            line-height: 1.7;
        }

        /* Main Content */
        .news-main {
            padding: 90px 0;
            max-width: 1300px;
            margin: 0 auto;
            padding-left: 20px;
            padding-right: 20px;
        }

        .news-grid {
            display: grid;
            grid-template-columns: 1fr 380px;
            gap: 50px;
        }

        /* Bài viết nổi bật */
        .featured-post {
            background: #fff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
            transition: all 0.4s ease;
        }
        .featured-post:hover {
            transform: translateY(-12px);
            box-shadow: 0 25px 60px rgba(0,0,0,0.18);
        }
        .featured-post img {
            width: 100%;
            height: 480px;
            object-fit: cover;
        }
        .featured-content {
            padding: 35px;
        }
        .post-meta {
            display: flex;
            gap: 20px;
            margin-bottom: 15px;
            font-size: 14.5px;
            color: #888;
        }
        .post-meta i { color: #ffd700; margin-right: 6px; }
        .featured-content h2 {
            font-size: 32px;
            margin: 15px 0 20px;
            line-height: 1.4;
            color: #1a1a1a;
        }
        .featured-content p {
            font-size: 16.5px;
            line-height: 1.8;
            color: #555;
            margin-bottom: 25px;
        }
        .read-more {
            display: inline-block;
            background: linear-gradient(135deg, #ffd700, #ffa500);
            color: #1a1a1a;
            padding: 14px 32px;
            border-radius: 50px;
            font-weight: 700;
            text-decoration: none;
            transition: all 0.3s;
        }
        .read-more:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(255,215,0,0.4);
        }

        /* Danh sách tin tức nhỏ */
        .news-list {
            display: flex;
            flex-direction: column;
            gap: 25px;
        }
        .news-item {
            display: flex;
            gap: 20px;
            background: #fff;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
            transition: all 0.3s;
        }
        .news-item:hover {
            transform: translateY(-6px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.12);
        }
        .news-item img {
            width: 140px;
            height: 140px;
            object-fit: cover;
            flex-shrink: 0;
        }
        .news-item-content {
            padding: 20px;
            flex: 1;
        }
        .news-item h3 {
            font-size: 18px;
            margin-bottom: 10px;
            line-height: 1.4;
            color: #1a1a1a;
        }
        .news-item p {
            font-size: 14.5px;
            color: #666;
            line-height: 1.6;
            margin-bottom: 12px;
        }
        .news-item .post-meta {
            font-size: 13.5px;
            color: #999;
        }

        /* Phần danh mục & tin nổi bật sidebar */
        .sidebar {
            background: #fff;
            padding: 35px;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
            height: fit-content;
        }
        .sidebar h3 {
            font-size: 24px;
            margin-bottom: 25px;
            color: #1a1a1a;
            padding-bottom: 15px;
            border-bottom: 3px solid #ffd700;
        }
        .categories {
            list-style: none;
        }
        .categories li {
            margin-bottom: 15px;
        }
        .categories a {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            color: #444;
            text-decoration: none;
            font-weight: 500;
            border-bottom: 1px dashed #eee;
            transition: all 0.3s;
        }
        .categories a:hover {
            color: #ffa500;
            padding-left: 8px;
        }
        .categories a span {
            background: #ffd700;
            color: #1a1a1a;
            width: 28px;
            height: 28px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            font-weight: bold;
        }

        /* Tin nổi bật */
        .popular-posts {
            margin-top: 40px;
        }
        .popular-posts h3 {
            font-size: 22px;
            margin-bottom: 25px;
            color: #1a1a1a;
            padding-bottom: 12px;
            border-bottom: 3px solid #ffd700;
        }
        .popular-item {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px dashed #eee;
        }
        .popular-item:last-child { border: none; margin-bottom: 0; padding-bottom: 0; }
        .popular-item img {
            width: 90px;
            height: 90px;
            object-fit: cover;
            border-radius: 12px;
            flex-shrink: 0;
        }
        .popular-item h4 {
            font-size: 15.5px;
            line-height: 1.5;
            color: #333;
            margin-bottom: 8px;
        }
        .popular-item .date {
            font-size: 13.5px;
            color: #999;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .news-grid { grid-template-columns: 1fr; gap: 40px; }
            .sidebar { order: -1; }
            .featured-post img { height: 380px; }
        }
        @media (max-width: 768px) {
            .news-hero { padding: 100px 20px 70px; }
            .news-hero h1 { font-size: 42px; }
            .news-main { padding: 70px 20px; }
            .featured-content { padding: 25px; }
            .featured-content h2 { font-size: 28px; }
            .news-item { flex-direction: column; }
            .news-item img { width: 100%; height: 200px; }
        }
    </style>
</head>
<body>

<!-- Hero Tin tức -->
<section class="news-hero">
    <h1>Tin Tức & Blog LightStore</h1>
    <p>Cập nhật xu hướng đèn trang trí mới nhất 2025 – Mẹo chọn đèn chùm, đèn thả, đèn ngủ giúp không gian sống thêm sang trọng và ấm cúng</p>
</section>

<!-- Nội dung chính -->
<section class="news-main">
    <div class="news-grid">

        <!-- Cột chính -->
        <div>

            <!-- Bài viết nổi bật -->
            <article class="featured-post">
                <img src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80" alt="Top 10 mẫu đèn chùm pha lê đẹp nhất 2025">
                <div class="featured-content">
                    <div class="post-meta">
                        <span><i class="far fa-calendar-alt"></i> 18/11/2025</span>
                        <span><i class="far fa-user"></i> LightStore Team</span>
                        <span><i class="far fa-comment"></i> 28 bình luận</span>
                    </div>
                    <h2>Top 10 Mẫu Đèn Chùm Pha Lê Sang Trọng Nhất 2025 – Đỉnh Cao Nghệ Thuật Ánh Sáng</h2>
                    <p>Khám phá ngay bộ sưu tập đèn chùm pha lê cao cấp đang làm mưa làm gió tại LightStore. Từ phong cách cổ điển châu Âu đến hiện đại tối giản – tất cả đều có tại đây...</p>
                    <a href="#" class="read-more">Đọc ngay</a>
                </div>
            </article>

            <!-- Danh sách tin tức nhỏ -->
            <div class="news-list">
                <div class="news-item">
                    <img src="https://images.unsplash.com/photo-1584622650111-993a4262ab63?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" alt="Cách chọn đèn phòng khách">
                    <div class="news-item-content">
                        <h3>Cách Chọn Đèn Phòng Khách Đẹp – 7 Bí Quyết Từ Chuyên Gia</h3>
                        <p>Phòng khách đẹp không chỉ nhờ nội thất mà còn nhờ ánh sáng. Tìm hiểu ngay cách phối đèn hợp phong thủy và thẩm mỹ...</p>
                        <div class="post-meta">
                            <span><i class="far fa-calendar"></i> 15/11/2025</span>
                            <span><i class="far fa-eye"></i> 8.2k lượt xem</span>
                        </div>
                    </div>
                </div>

                <div class="news-item">
                    <img src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" alt="Đèn LED tiết kiệm điện">
                    <div class="news-item-content">
                        <h3>Đèn LED 2025: Công Nghệ Mới – Tiết Kiệm 90% Điện, Tuổi Thọ 15 Năm</h3>
                        <p>So sánh đèn LED thông minh vs đèn truyền thống: Bạn sẽ bất ngờ với con số tiết kiệm thực tế...</p>
                        <div class="post-meta">
                            <span><i class="far fa-calendar"></i> 12/11/2025</span>
                            <span><i class="far fa-eye"></i> 12.5k lượt xem</span>
                        </div>
                    </div>
                </div>

                <div class="news-item">
                    <img src="https://images.unsplash.com/photo-1598300041005-7e7c9037e3e7?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" alt="Đèn ngủ cho trẻ em">
                    <div class="news-item-content">
                        <h3>Top 10 Mẫu Đèn Ngủ Cho Bé Yêu – An Toàn, Dễ Thương, Giá Tốt</h3>
                        <p>Gợi ý đèn ngủ hình thú, đèn chiếu sao – giúp bé ngủ ngon và phát triển trí tưởng tượng...</p>
                        <div class="post-meta">
                            <span><i class="far fa-calendar"></i> 10/11/2025</span>
                            <span><i class="far fa-eye"></i> 15.8k lượt xem</span>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <!-- Sidebar -->
        <aside class="sidebar">

            <!-- Danh mục tin tức -->
            <div class="categories-section">
                <h3>Danh Mục Tin Tức</h3>
                <ul class="categories">
                    <li><a href="#">Xu hướng đèn 2025 <span>18</span></a></li>
                    <li><a href="#">Mẹo chọn đèn đẹp <span>24</span></a></li>
                    <li><a href="#">Đèn phòng khách <span>15</span></a></li>
                    <li><a href="#">Đèn phòng ngủ <span>19</span></a></li>
                    <li><a href="#">Đèn LED tiết kiệm điện <span>12</span></a></li>
                    <li><a href="#">Khuyến mãi hot <span>8</span></a></li>
                </ul>
            </div>

            <!-- Tin nổi bật -->
            <div class="popular-posts">
                <h3>Tin Được Quan Tâm Nhất</h3>
                <div class="popular-item">
                    <img src="https://images.unsplash.com/photo-1513506003901-1e6a229e2d15?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" alt="Đèn chùm pha lê">
                    <div>
                        <h4>Đèn chùm pha lê nhập khẩu Ý có thực sự đáng tiền?</h4>
                        <div class="date"><i class="far fa-calendar"></i> 05/11/2025</div>
                    </div>
                </div>
                <div class="popular-item">
                    <img src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" alt="Đèn thả trần">
                    <div>
                        <h4>99+ Mẫu đèn thả trần hiện đại cho nhà phố 2025</h4>
                        <div class="date"><i class="far fa-calendar"></i> 01/11/2025</div>
                    </div>
                </div>
            </div>

        </aside>
    </div>
</section>

<%@ include file="/layouts/footer_user.jsp" %>
</body>
</html>