<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký thành công | LightStore Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container min-vh-100 d-flex align-items-center justify-content-center">
        <div class="card shadow border-0 p-4 text-center" style="max-width: 420px;">
            <h2 class="mb-3 text-success">Đăng ký thành công</h2>
            <p class="text-muted">
                Tài khoản của bạn đã được tạo. Vui lòng quay về trang đăng nhập để đăng nhập vào hệ thống.
            </p>
            <div class="mb-3">
                <strong><%= request.getAttribute("fullName") != null ? request.getAttribute("fullName") : "" %></strong><br>
                <span><%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %></span>
            </div>
            <a class="btn btn-primary w-100" href="${pageContext.request.contextPath}/View/adminLogin.jsp">Quay về trang đăng nhập</a>
        </div>
    </div>
</body>
</html>

