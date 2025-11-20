<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký thành công - LightStore Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body{font-family:'Open Sans',sans-serif;background:linear-gradient(135deg,#f5f7fa 0%,#c3cfe2 100%);margin:0;height:100vh;display:flex;align-items:center;justify-content:center;}
        .success-container{background:white;padding:3rem 2.5rem;border-radius:16px;box-shadow:0 10px 30px rgba(0,0,0,.1);text-align:center;max-width:480px;width:90%;}
        .success-icon{font-size:72px;color:#4caf50;margin-bottom:1rem;}
        h1{color:#3f4d67;margin-bottom:.5rem;}
        p{color:#666;margin-bottom:2rem;font-size:1.1rem;}
        .btn-home{background:#3f4d67;color:white;padding:.9rem 2rem;border:none;border-radius:8px;font-size:1rem;cursor:pointer;text-decoration:none;display:inline-block;transition:.3s;}
        .btn-home:hover{background:#2c384d;transform:translateY(-2px);}
    </style>
</head>
<body>
    <div class="success-container">
        <div class="success-icon">Checkmark</div>
        <h1>Đăng ký thành công!</h1>
        <p>
            Chào mừng <strong>${sessionScope.registeredEmail}</strong>!<br>
            Tài khoản của bạn đã được tạo thành công.
        </p>
        <a href="${pageContext.request.contextPath}/auth.jsp" class="btn-home">
            Quay lại đăng nhập
        </a>
    </div>

    <%-- Xóa session sau khi hiển thị --%>
    <%
        session.removeAttribute("registeredEmail");
        session.removeAttribute("successMessage");
    %>
</body>
</html>