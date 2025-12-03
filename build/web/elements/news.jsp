<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/layouts/header_user.jsp" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Nhật ký ánh sáng LightStore - cập nhật xu hướng đèn, case study và công nghệ chiếu sáng thời gian thực.">
    <title>Tin tức LightStore | Lighting Intelligence</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/news.css?v=1.0">
</head>
<body class="news-page">

<main>
    <section class="news-hero">
        <div class="container">
            <span class="news-chip">Realtime newsroom</span>
            <h1 id="newsHeroTitle">Đang tải dữ liệu mới nhất...</h1>
            <p id="newsHeroSubtitle">LightStore tổng hợp insight, nghiên cứu vật liệu và câu chuyện ánh sáng mỗi ngày.</p>
            <div class="news-hero__chips" id="newsHeroTags">
                <span class="news-chip">Lighting</span>
                <span class="news-chip">Insights</span>
            </div>
        </div>
    </section>

    <section class="news-main">
        <div class="news-grid">
            <div>
                <div id="featuredArticle" class="featured-card">
                    <div class="featured-media">
                        <div class="skeleton" style="height:360px;border-radius:20px;"></div>
                    </div>
                    <div class="featured-body">
                        <div class="skeleton" style="width:60%;height:18px;"></div>
                        <div class="skeleton" style="width:80%;height:22px;margin-top:12px;"></div>
                        <div class="skeleton" style="width:90%;height:22px;margin-top:8px;"></div>
                    </div>
                </div>

                <div class="news-list" id="latestList">
                    <article class="news-card">
                        <div class="skeleton" style="width:140px;height:140px;border-radius:16px;"></div>
                        <div class="news-card__content">
                            <div class="skeleton" style="width:40%;height:16px;"></div>
                            <div class="skeleton" style="width:90%;height:18px;margin-top:10px;"></div>
                            <div class="skeleton" style="width:70%;height:18px;margin-top:6px;"></div>
                        </div>
                    </article>
                </div>
            </div>

            <aside class="news-sidebar">
                <div class="widget">
                    <h3>Danh mục nội dung</h3>
                    <ul class="category-list" id="categoryList">
                        <li><div class="skeleton"></div></li>
                        <li><div class="skeleton"></div></li>
                    </ul>
                </div>

                <div class="widget">
                    <h3>Được quan tâm</h3>
                    <div class="popular-list" id="popularList">
                        <div class="skeleton" style="height:70px;"></div>
                        <div class="skeleton" style="height:70px;"></div>
                    </div>
                </div>

                <div class="widget">
                    <h3>Insight độc giả</h3>
                    <div class="insights-grid" id="insightsList">
                        <div class="skeleton" style="height:80px;"></div>
                        <div class="skeleton" style="height:80px;"></div>
                    </div>
                </div>
            </aside>
        </div>
    </section>
</main>

<%@ include file="/layouts/footer_user.jsp" %>

<script>
    window.LIGHTSTORE = window.LIGHTSTORE || {};
    window.LIGHTSTORE.contextPath = '<%=request.getContextPath()%>';
</script>
<script src="${pageContext.request.contextPath}/assets/js/news-page.js?v=1.0"></script>
</body>
</html>