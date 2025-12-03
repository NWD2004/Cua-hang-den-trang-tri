<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ include file="/layouts/header_user.jsp" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập | LightStore</title>
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

        .login-wrapper {
            width: 1000px;
            max-width: 95%;
            height: 580px;
            background: rgba(255, 255, 255, 0.98);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 25px 80px rgba(0, 0, 0, 0.45);
            display: flex;
            border: 1px solid rgba(255,255,255,0.4);
            backdrop-filter: blur(12px);
        }

        /* === PHẦN TRÁI - FORM === */
        .login-left {
            width: 55%;
            padding: 50px 60px;
            background: #fff;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-left h3 { 
            font-size: 15px; 
            color: #777; 
            text-align: center; 
            margin-bottom: 8px; 
            font-weight: 400;
        }
        
        .login-left h2 {
            font-size: 28px;
            font-weight: 700;
            text-align: center;
            margin-bottom: 35px;
            color: #1a1a1a;
        }

        .input-box { 
            position: relative; 
            margin-bottom: 22px; 
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

        .options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 20px 0;
            font-size: 14px;
        }
        
        .options label {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #666;
            cursor: pointer;
        }
        
        .options input[type="checkbox"] {
            width: 16px;
            height: 16px;
            accent-color: #ffd700;
        }
        
        .options a { 
            color: #ffa500; 
            text-decoration: none; 
            font-weight: 500;
        }

        .btn-login {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #ffd700, #ffa500);
            color: #1a1a1a;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            margin: 18px 0;
            box-shadow: 0 8px 20px rgba(255, 215, 0, 0.3);
            transition: all 0.3s;
        }
        
        .btn-login:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 12px 25px rgba(255, 215, 0, 0.4); 
        }

        .social-login { 
            text-align: center; 
            color: #777; 
            margin: 22px 0; 
            font-size: 14px; 
        }
        
        .social-icons { 
            display: flex; 
            justify-content: center; 
            gap: 18px; 
            margin-top: 15px; 
        }
        
        .social-btn {
            width: 46px; 
            height: 46px; 
            border-radius: 50%;
            display: flex; 
            align-items: center; 
            justify-content: center;
            color: #fff; 
            font-size: 20px; 
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            transition: all 0.3s;
            cursor: pointer;
        }
        
        .social-btn:hover {
            transform: translateY(-3px);
        }
        
        .google { background: #ea4335; }
        .facebook { background: #3b5998; }

        .register-link {
            text-align: center;
            color: #666;
            font-size: 14px;
            margin-top: 20px;
        }
        
        .register-link a { 
            color: #ffa500; 
            font-weight: 600; 
            text-decoration: none; 
        }

        /* === PHẦN PHẢI - CHÀO MỪNG === */
        .login-right {
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
        
        .login-right::before {
            content: ''; 
            position: absolute; 
            inset: 0;
            background: linear-gradient(135deg, rgba(255, 215, 0, 0.85), rgba(255, 165, 0, 0.8));
            z-index: 1;
        }
        
        .login-right > * { 
            position: relative; 
            z-index: 2; 
        }

        .login-right h2 { 
            font-size: 32px; 
            font-weight: 700; 
            margin-bottom: 20px; 
            color: #1a1a1a;
        }
        
        .login-right p { 
            font-size: 16px; 
            line-height: 1.6; 
            margin-bottom: 30px; 
            color: #333;
        }

        .btn-register {
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
        
        .btn-register:hover {
            background: #1a1a1a;
            color: #ffd700;
            transform: translateY(-3px);
        }

        /* RESPONSIVE */
        @media (max-width: 900px) {
            .login-wrapper { 
                flex-direction: column; 
                height: auto; 
                max-width: 450px;
            }
            
            .login-left, .login-right { 
                width: 100%; 
                padding: 40px 35px;
            }
            
            .login-right {
                padding: 35px 30px;
            }
        }
    </style>
</head>
<body>

<main>
    <div class="login-wrapper">
        <!-- TRÁI -->
        <div class="login-left">
            <h3>Đăng nhập để tiếp tục mua sắm tại</h3>
            <h2>LightStore</h2>

            <% 
                String error = (String) request.getAttribute("error");
                String success = (String) request.getAttribute("success");
                String registeredEmail = (String) request.getAttribute("registeredEmail");
                
                // Kiểm tra pending add to cart
                String pendingAddToCart = null;
                if (session != null) {
                    pendingAddToCart = (String) session.getAttribute("pendingAddToCart");
                }
            %>
            
            <% if (error != null) { %>
            <div style="background: #fee; color: #c33; padding: 12px; border-radius: 8px; margin-bottom: 20px; text-align: center; border: 1px solid #fcc;">
                <i class="fas fa-exclamation-circle"></i> <%= error %>
            </div>
            <% } %>
            
            <% if (success != null) { %>
            <div style="background: #efe; color: #3c3; padding: 12px; border-radius: 8px; margin-bottom: 20px; text-align: center; border: 1px solid #cfc;">
                <i class="fas fa-check-circle"></i> <%= success %>
            </div>
            <% } %>
            
            <% if ("true".equals(pendingAddToCart)) { %>
            <div style="background: #fff3cd; color: #856404; padding: 12px; border-radius: 8px; margin-bottom: 20px; text-align: center; border: 1px solid #ffc107;">
                <i class="fas fa-shopping-cart"></i> Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng!
            </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/UserLoginServlet" method="post">
                <div class="input-box">
                    <i class="fas fa-envelope"></i>
                    <input type="email" name="email" placeholder="Email của bạn" 
                           value="<%= registeredEmail != null ? registeredEmail : "" %>" required>
                </div>
                <div class="input-box">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="password" placeholder="Mật khẩu" required>
                </div>

                <div class="options">
                    <label><input type="checkbox" name="remember"> Ghi nhớ đăng nhập</label>
                    <a href="${pageContext.request.contextPath}/forgot-password">Quên mật khẩu?</a>
                </div>

                <button type="submit" class="btn-login">Đăng nhập</button>
            </form>

            <div class="social-login">
                Hoặc đăng nhập bằng
                <div class="social-icons">
                    <div class="social-btn google"><i class="fab fa-google"></i></div>
                    <div class="social-btn facebook"><i class="fab fa-facebook-f"></i></div>
                </div>
            </div>

            <div class="register-link">
                Chưa có tài khoản? <a href="${pageContext.request.contextPath}/View/userRegister.jsp">Đăng ký ngay</a>
            </div>
        </div>

        <!-- PHẢI -->
        <div class="login-right">
            <h2>Xin chào, bạn mới!</h2>
            <p>Đăng ký hôm nay nhận ngay<br><strong>VOUCHER 300.000đ</strong> cho đơn đầu tiên!</p>
            <a href="${pageContext.request.contextPath}/View/userRegister.jsp">
                <button class="btn-register">Đăng ký</button>
            </a>
        </div>
    </div>
</main>

<%@ include file="/layouts/footer_user.jsp" %>
</body>
</html> 