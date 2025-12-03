<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/layouts/header_user.jsp" %>
<%
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
    String emailValue = (String) request.getAttribute("email");
    String step = (String) request.getAttribute("step");
    if (step == null) step = "request";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu | LightStore</title>
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #f6f7fb; color: #1a1a1a; }
        .wrapper { max-width: 900px; margin: 40px auto; padding: 0 20px; }
        .card { background: #fff; border-radius: 16px; box-shadow: 0 15px 40px rgba(15,23,42,.12); padding: 40px; }
        h1 { font-size: 28px; margin-bottom: 10px; color: #0f172a; }
        p.lead { color: #475569; margin-bottom: 30px; }
        .alert { padding: 16px 20px; border-radius: 12px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px; }
        .alert-success { background: #ecfdf5; color: #047857; border: 1px solid #bbf7d0; }
        .alert-error { background: #fef2f2; color: #b91c1c; border: 1px solid #fecaca; }
        form { margin-top: 25px; }
        label { display: block; font-weight: 600; margin-bottom: 8px; color: #0f172a; }
        input { width: 100%; padding: 14px 16px; border-radius: 12px; border: 2px solid #e2e8f0; font-size: 16px; transition: border-color .2s; }
        input:focus { outline: none; border-color: #fbbf24; box-shadow: 0 0 0 3px rgba(251,191,36,.2); }
        .btn { margin-top: 20px; width: 100%; padding: 14px; border: none; border-radius: 12px; font-size: 16px; font-weight: 600; cursor: pointer; transition: transform .2s, box-shadow .2s; }
        .btn-primary { background: linear-gradient(135deg, #ffd700, #ffa500); color: #1a1a1a; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 12px 24px rgba(251,191,36,.3); }
        .btn-link { margin-top: 15px; background: transparent; color: #2563eb; text-decoration: none; display: inline-block; }
        .step { margin-top: 40px; padding: 25px; border-radius: 16px; background: #f8fafc; border: 1px solid #e2e8f0; }
        .step h3 { margin-bottom: 15px; color: #0f172a; }
        .resend { font-size: 14px; color: #64748b; margin-top: 12px; }
        .resend button { background: none; border: none; color: #f97316; font-weight: 600; cursor: pointer; }
    </style>
</head>
<body>
    <div class="wrapper">
        <div class="card">
            <h1>Quên mật khẩu?</h1>
            <p class="lead">Nhập email bạn đã đăng ký để nhận mã xác thực. Sau khi xác nhận, bạn sẽ được chuyển tới trang đặt lại mật khẩu.</p>

            <% if (successMessage != null) { %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> <%= successMessage %>
                </div>
            <% } %>
            <% if (errorMessage != null) { %>
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-triangle"></i> <%= errorMessage %>
                </div>
            <% } %>

            <form method="post" action="${pageContext.request.contextPath}/forgot-password">
                <input type="hidden" name="action" value="sendCode">
                <label>Email đã đăng ký</label>
                <input type="email" name="email" placeholder="example@email.com" required value="<%= emailValue != null ? emailValue : "" %>">
                <button type="submit" class="btn btn-primary"><i class="fas fa-paper-plane"></i> Gửi mã xác thực</button>
            </form>

            <% if ("verify".equals(step) && emailValue != null) { %>
            <div class="step">
                <h3>Bước 2: Nhập mã xác thực</h3>
                <p>Vui lòng nhập 6 chữ số được gửi tới email <strong><%= emailValue %></strong>.</p>
                <form method="post" action="${pageContext.request.contextPath}/forgot-password">
                    <input type="hidden" name="action" value="verify">
                    <input type="hidden" name="email" value="<%= emailValue %>">
                    <label>Mã xác thực (OTP)</label>
                    <input type="text" name="otp" pattern="\\d{6}" maxlength="6" placeholder="Nhập 6 chữ số" required>
                    <button type="submit" class="btn btn-primary"><i class="fas fa-check"></i> Xác thực mã</button>
                </form>
                <p class="resend">
                    Chưa nhận được email? <button type="button" onclick="document.querySelector('form').submit()">Gửi lại mã</button>
                </p>
            </div>
            <% } %>

            <a class="btn-link" href="${pageContext.request.contextPath}/View/userLogin.jsp">
                <i class="fas fa-angle-left"></i> Quay lại trang đăng nhập
            </a>
        </div>
    </div>

    <%@ include file="/layouts/footer_user.jsp" %>
</body>
</html>

