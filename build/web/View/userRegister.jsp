<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/layouts/header_user.jsp" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản | LightStore</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background: linear-gradient(rgba(10, 10, 40, 0.82), rgba(20, 5, 60, 0.88)),
                        url('https://images.unsplash.com/photo-1507473885765-e6ed057f782c?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80')
                        center/cover no-repeat fixed;
        }

        /* Bokeh ánh sáng lung linh */
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background: url('https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80') center/cover;
            opacity: 0.2;
            pointer-events: none;
            z-index: 1;
        }

        main {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
            position: relative;
            z-index: 2;
        }

        .register-wrapper {
            width: 1000px;
            max-width: 95%;
            height: 620px;
            background: rgba(255, 255, 255, 0.98);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 25px 80px rgba(0, 0, 0, 0.45);
            display: flex;
            border: 1px solid rgba(255,255,255,0.4);
            backdrop-filter: blur(12px);
        }

        /* TRÁI - FORM ĐĂNG KÝ */
        .register-left {
            width: 55%;
            padding: 50px 60px;
            background: #fff;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .register-left h3 { 
            font-size: 15px; 
            color: #777; 
            text-align: center; 
            margin-bottom: 8px; 
            font-weight: 400;
        }
        
        .register-left h2 {
            font-size: 28px;
            font-weight: 700;
            text-align: center;
            margin-bottom: 35px;
            color: #1a1a1a;
        }

        .input-box { 
            position: relative; 
            margin-bottom: 20px; 
        }
        
        .input-box i {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
            font-size: 18px;
        }
        
        .input-box input {
            width: 100%;
            padding: 16px 18px 16px 52px;
            border: 1px solid #e0e0e0;
            background: #fafafa;
            border-radius: 12px;
            font-size: 15px;
            transition: all 0.3s;
        }
        
        .input-box input:focus {
            background: #fff;
            border-color: #ffd700;
            box-shadow: 0 0 0 3px rgba(255, 215, 0, 0.15);
            outline: none;
        }

        .terms {
            font-size: 14px;
            color: #666;
            text-align: center;
            margin: 20px 0 15px;
            line-height: 1.5;
        }
        
        .terms a { 
            color: #ffa500; 
            text-decoration: none;
            font-weight: 500;
        }

        .btn-register-submit {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #ffd700, #ffa500);
            color: #1a1a1a;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 8px 20px rgba(255, 215, 0, 0.3);
            transition: all 0.3s;
        }
        
        .btn-register-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 25px rgba(255, 215, 0, 0.4);
        }

        .login-link {
            text-align: center;
            color: #666;
            font-size: 14px;
            margin-top: 20px;
        }
        
        .login-link a { 
            color: #ffa500; 
            font-weight: 600; 
            text-decoration: none; 
        }

        /* PHẢI - LỜI MỜI ĐĂNG NHẬP */
        .register-right {
            width: 45%;
            background: linear-gradient(135deg, rgba(255, 215, 0, 0.9), rgba(255, 165, 0, 0.85)),
                        url('https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80') center/cover;
            color: #1a1a1a;
            padding: 50px 45px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            text-align: center;
            position: relative;
        }
        
        .register-right::before {
            content: ''; 
            position: absolute; 
            inset: 0;
            background: linear-gradient(135deg, rgba(255, 215, 0, 0.85), rgba(255, 165, 0, 0.8));
            z-index: 1;
        }
        
        .register-right > * { 
            position: relative; 
            z-index: 2; 
        }

        .register-right h2 { 
            font-size: 32px; 
            font-weight: 700; 
            margin-bottom: 20px; 
            color: #1a1a1a;
        }
        
        .register-right p { 
            font-size: 16px; 
            line-height: 1.6; 
            margin-bottom: 30px; 
            color: #333;
        }

        .btn-login-now {
            padding: 14px 40px;
            background: transparent;
            color: #1a1a1a;
            border: 2px solid #1a1a1a;
            border-radius: 12px;
            font-weight: 600;
            font-size: 15px;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
        }
        
        .btn-login-now:hover {
            background: #1a1a1a;
            color: #ffd700;
            transform: translateY(-3px);
        }

        /* RESPONSIVE */
        @media (max-width: 900px) {
            .register-wrapper { 
                flex-direction: column; 
                height: auto; 
                max-width: 450px;
            }
            
            .register-left, .register-right { 
                width: 100%; 
                padding: 40px 35px;
            }
            
            .register-right {
                padding: 35px 30px;
            }
        }
    </style>
</head>
<body>

<main>
    <div class="register-wrapper">
        <!-- TRÁI - FORM ĐĂNG KÝ -->
        <div class="register-left">
            <h3>Tham gia cùng hàng ngàn khách hàng của</h3>
            <h2>LightStore</h2>

            <% 
                String error = (String) request.getAttribute("error");
                String fullname = (String) request.getAttribute("fullname");
                String email = (String) request.getAttribute("email");
                if (fullname == null) fullname = "";
                if (email == null) email = "";
            %>
            
            <% if (error != null) { %>
            <div style="background: #fee; color: #c33; padding: 12px; border-radius: 8px; margin-bottom: 20px; text-align: center; border: 1px solid #fcc;">
                <i class="fas fa-exclamation-circle"></i> <%= error %>
            </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/UserRegisterServlet" method="post">
                <div class="input-box">
                    <i class="fas fa-user"></i>
                    <input type="text" name="fullname" placeholder="Họ và tên" 
                           value="<%= fullname %>" required>
                </div>
                <div class="input-box">
                    <i class="fas fa-envelope"></i>
                    <input type="email" name="email" placeholder="Email của bạn" 
                           value="<%= email %>" required>
                </div>
            
                <div class="input-box">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="password" placeholder="Mật khẩu" required>
                </div>
                <div class="input-box">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="confirm_password" placeholder="Nhập lại mật khẩu" required>
                </div>

                <div class="terms">
                    Tôi đồng ý với <a href="#">Điều khoản dịch vụ</a> và <a href="#">Chính sách bảo mật</a>
                </div>

                <button type="submit" class="btn-register-submit">Đăng ký ngay</button>
            </form>

            <div class="login-link">
                Đã có tài khoản? <a href="${pageContext.request.contextPath}/View/userLogin.jsp">Đăng nhập</a>
            </div>
        </div>

        <!-- PHẢI - LỜI MỜI ĐĂNG NHẬP -->
        <div class="register-right">
            <h2>Chào mừng trở lại!</h2>
            <p>Đã là thành viên LightStore?<br>Đăng nhập ngay để tiếp tục mua sắm và nhận ưu đãi riêng!</p>
            <a href="${pageContext.request.contextPath}/View/userLogin.jsp">
                <button class="btn-login-now">Đăng nhập ngay</button>
            </a>
        </div>
    </div>
</main>

<%@ include file="/layouts/footer_user.jsp" %>
</body>
</html>