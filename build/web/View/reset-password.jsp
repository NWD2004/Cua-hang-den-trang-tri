<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/layouts/header_user.jsp" %>
<%
    String email = (String) request.getAttribute("email");
    if (email == null) {
        response.sendRedirect(request.getContextPath() + "/forgot-password");
        return;
    }
    String errorMessage = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt lại mật khẩu | LightStore</title>
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #eef2ff; }
        .container { max-width: 540px; margin: 50px auto; padding: 0 20px; }
        .card { background: #fff; border-radius: 16px; padding: 32px; box-shadow: 0 15px 40px rgba(15,23,42,.1); }
        h1 { font-size: 26px; color: #0f172a; margin-bottom: 8px; }
        p { color: #475569; }
        label { font-weight: 600; display: block; margin-top: 20px; margin-bottom: 8px; color: #0f172a; }
        input { width: 100%; border-radius: 12px; border: 2px solid #e2e8f0; padding: 14px 16px; font-size: 16px; }
        input:focus { outline: none; border-color: #6366f1; box-shadow: 0 0 0 3px rgba(99,102,241,.2); }
        button { margin-top: 25px; width: 100%; padding: 14px; border: none; border-radius: 12px; font-size: 16px; font-weight: 600; background: linear-gradient(135deg,#4338ca,#6366f1); color: #fff; cursor: pointer; transition: transform .2s, box-shadow .2s; }
        button:hover { transform: translateY(-2px); box-shadow: 0 12px 24px rgba(99,102,241,.35); }
        .alert { padding: 14px 16px; border-radius: 12px; margin-bottom: 15px; font-size: 15px; }
        .alert-error { background: #fef2f2; color: #b91c1c; border: 1px solid #fecaca; }
        .note { font-size: 14px; color: #94a3b8; margin-top: 6px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <h1>Đặt lại mật khẩu</h1>
            <p>Đang xác thực cho tài khoản: <strong><%= email %></strong></p>

            <% if (errorMessage != null) { %>
                <div class="alert alert-error"><i class="fas fa-exclamation-triangle"></i> <%= errorMessage %></div>
            <% } %>

            <form method="post" action="${pageContext.request.contextPath}/reset-password">
                <label>Mật khẩu mới</label>
                <input type="password" name="newPassword" minlength="6" required placeholder="Nhập mật khẩu mới">
                <div class="note">Ít nhất 6 ký tự, nên kết hợp chữ hoa, chữ thường và số.</div>

                <label>Xác nhận mật khẩu</label>
                <input type="password" name="confirmPassword" minlength="6" required placeholder="Nhập lại mật khẩu mới">

                <button type="submit"><i class="fas fa-save"></i> Lưu mật khẩu</button>
            </form>
        </div>
    </div>
    <%@ include file="/layouts/footer_user.jsp" %>
</body>
</html>

