<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en" data-pc-preset="preset-1" data-pc-sidebar-caption="true" data-pc-direction="ltr" dir="ltr" data-pc-theme="light">
    <head>
        <title>Đăng nhập / Đăng ký | LightStore Admin</title>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>

        <style>
            /* ===== VARIABLES ===== */
            :root {
                --primary-color: #3f4d67;
                --primary-light: #53668a;
                --primary-dark: #2c384d;
                --accent-color: #6b7fa5;
                --text-primary: #333333;
                --text-secondary: #666666;
                --bg-light: #f8f9fa;
                --bg-white: #ffffff;
                --border-color: #e0e0e0;
                --shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                --transition: all 0.3s ease;
            }
            
            /* ===== RESET & BASE STYLES ===== */
            body {
                font-family: 'Open Sans', sans-serif;
                background-color: var(--bg-light);
                margin: 0;
                padding: 0;
                color: var(--text-primary);
            }
            
            /* ===== AUTH WRAPPER ===== */
            .auth-main {
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
                overflow: hidden;
            }
            
            .auth-wrapper {
                width: 100%;
                max-width: 1200px;
                margin: 0 auto;
                display: flex;
                min-height: 100vh;
            }
            
            .auth-bg-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: linear-gradient(135deg, rgba(63, 77, 103, 0.05) 0%, rgba(83, 102, 138, 0.05) 100%);
                z-index: -1;
            }
            
            .auth-bg-light {
                position: absolute;
                width: 300px;
                height: 300px;
                border-radius: 50%;
                background: radial-gradient(circle, var(--primary-light) 0%, transparent 70%);
                opacity: 0.15;
                filter: blur(40px);
                z-index: -1;
            }
            
            .auth-bg-light:nth-child(1) {
                top: -150px;
                right: -150px;
            }
            
            .auth-bg-light:nth-child(2) {
                bottom: -150px;
                left: -150px;
                background: radial-gradient(circle, var(--accent-color) 0%, transparent 70%);
            }
            
            /* ===== FORM CONTAINER ===== */
            .auth-form {
                flex: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 2rem;
                position: relative;
            }
            
            .auth-card {
                background-color: var(--bg-white);
                border-radius: 16px;
                box-shadow: var(--shadow);
                padding: 2.5rem;
                width: 100%;
                max-width: 400px;
                position: relative;
                overflow: hidden;
                transition: var(--transition);
                opacity: 0;
                transform: translateY(20px);
                transition: opacity 0.5s ease, transform 0.5s ease, visibility 0s 0.5s;
                visibility: hidden;
                position: absolute;
            }
            
            .auth-card.active {
                opacity: 1;
                transform: translateY(0);
                visibility: visible;
                transition: opacity 0.5s ease, transform 0.5s ease;
                position: relative;
            }
            
            .auth-card:hover {
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
            }
            
            .auth-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 4px;
                background: linear-gradient(90deg, var(--primary-color), var(--primary-light));
            }
            
            /* ===== LOGO & HEADINGS ===== */
            .auth-logo {
                max-width: 180px;
                margin-bottom: 1.5rem;
            }
            
            .auth-title {
                font-size: 1.75rem;
                font-weight: 600;
                text-align: center;
                margin-bottom: 0.5rem;
                color: var(--text-primary);
            }
            
            .auth-subtitle {
                text-align: center;
                color: var(--text-secondary);
                margin-bottom: 2rem;
                font-size: 0.95rem;
            }
            
            /* ===== FORM ELEMENTS ===== */
            .form-group {
                margin-bottom: 1.5rem;
            }
            
            .form-label {
                display: block;
                margin-bottom: 0.5rem;
                font-weight: 500;
                color: var(--text-primary);
                font-size: 0.9rem;
            }
            
            .form-control {
                width: 100%;
                padding: 0.75rem 1rem;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                font-size: 1rem;
                transition: var(--transition);
                background-color: var(--bg-white);
                box-sizing: border-box;
            }
            
            .form-control:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(63, 77, 103, 0.1);
            }
            
            .form-control::placeholder {
                color: #aaa;
            }
            
            /* ===== CHECKBOX & REMEMBER ME ===== */
            .form-check {
                display: flex;
                align-items: center;
                margin-bottom: 1rem;
            }
            
            .form-check-input {
                margin-right: 0.5rem;
                accent-color: var(--primary-color);
            }
            
            .form-check-label {
                font-size: 0.9rem;
                color: var(--text-secondary);
            }
            
            .forgot-link {
                color: var(--primary-color);
                text-decoration: none;
                font-size: 0.9rem;
                transition: var(--transition);
            }
            
            .forgot-link:hover {
                color: var(--primary-dark);
                text-decoration: underline;
            }
            
            /* ===== BUTTONS ===== */
            .btn {
                display: inline-block;
                padding: 0.75rem 1.5rem;
                border: none;
                border-radius: 8px;
                font-weight: 600;
                font-size: 1rem;
                cursor: pointer;
                transition: var(--transition);
                text-align: center;
                width: 100%;
            }
            
            .btn-primary {
                background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
                color: white;
                box-shadow: 0 4px 12px rgba(63, 77, 103, 0.3);
            }
            
            .btn-primary:hover {
                background: linear-gradient(135deg, var(--primary-dark), var(--primary-color));
                box-shadow: 0 6px 16px rgba(63, 77, 103, 0.4);
                transform: translateY(-2px);
            }
            
            .btn-primary:active {
                transform: translateY(0);
            }
            
            /* ===== TOGGLE LINK ===== */
            .toggle-container {
                text-align: center;
                margin-top: 1.5rem;
                font-size: 0.9rem;
                color: var(--text-secondary);
            }
            
            .toggle-link {
                color: var(--primary-color);
                cursor: pointer;
                font-weight: 600;
                transition: var(--transition);
                margin-left: 0.5rem;
            }
            
            .toggle-link:hover {
                color: var(--primary-dark);
                text-decoration: underline;
            }
            
            /* ===== ERROR MESSAGE ===== */
            .error-message {
                background-color: rgba(244, 67, 54, 0.1);
                color: #f44336;
                padding: 0.75rem 1rem;
                border-radius: 8px;
                margin-bottom: 1.5rem;
                text-align: center;
                font-size: 0.9rem;
                border-left: 4px solid #f44336;
            }
            
            /* ===== GRID LAYOUT ===== */
            .grid {
                display: grid;
                gap: 1rem;
            }
            
            .grid-cols-2 {
                grid-template-columns: repeat(2, 1fr);
            }
            
            /* ===== UTILITY CLASSES ===== */
            .hidden {
                display: none;
            }
            
            .text-center {
                text-align: center;
            }
            
            .flex-between {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            
            .mt-4 {
                margin-top: 1.5rem;
            }
            
            /* ===== RESPONSIVE DESIGN ===== */
            @media (max-width: 768px) {
                .auth-card {
                    padding: 2rem 1.5rem;
                }
                
                .grid-cols-2 {
                    grid-template-columns: 1fr;
                }
                
                .auth-title {
                    font-size: 1.5rem;
                }
            }
            
            @media (max-width: 480px) {
                .auth-form {
                    padding: 1rem;
                }
                
                .auth-card {
                    padding: 1.5rem 1rem;
                }
            }
        </style>
    </head>

    <body>
        <%
            Boolean showRegister = (Boolean) request.getAttribute("showRegister");
            String registerError = (String) request.getAttribute("registerError");
        %>
        <!-- [Preloader] -->
        <div class="loader-bg fixed inset-0 bg-white dark:bg-themedark-cardbg z-[1034]">
            <div class="loader-track h-[5px] w-full inline-block absolute overflow-hidden top-0">
                <div class="loader-fill w-[300px] h-[5px] bg-primary-500 absolute top-0 left-0 animate-[hitZak_0.6s_ease-in-out_infinite_alternate]"></div>
            </div>
        </div>

        <!-- [Main] -->
        <div class="auth-main">
            <div class="auth-wrapper">
                <div class="auth-bg-overlay"></div>
                <div class="auth-bg-light"></div>
                <div class="auth-bg-light"></div>
                
                <div class="auth-form">
                    <!-- ========== FORM LOGIN ========== -->
                    <div id="loginForm" class="auth-card active">
                        <div class="text-center mb-6">
                            <a href="#"><img src="${pageContext.request.contextPath}/assets/images/logo-dark.svg" alt="logo" class="auth-logo"/></a>
                        </div>
                        <h2 class="auth-title">Đăng nhập</h2>
                        <p class="auth-subtitle">Chào mừng trở lại với LightStore Admin</p>
                        
                        <!-- Hiển thị lỗi -->
                        <%
                            String error = (String) request.getAttribute("error");
                            if (error != null) {
                        %>
                        <div class="error-message">
                            <%= error%>
                        </div>
                        <%
                            }
                        %>
                        
                        <form action="${pageContext.request.contextPath}/AdminLoginServlet" method="post">
                            <div class="form-group">
                                <input type="email" class="form-control" name="email" placeholder="Địa chỉ Email" required/>
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control" name="password" placeholder="Mật khẩu" required/>
                            </div>
                            <div class="flex-between">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="remember" name="remember" checked/>
                                    <label class="form-check-label" for="remember">Ghi nhớ đăng nhập</label>
                                </div>
                                <a href="#" class="forgot-link">Quên mật khẩu?</a>
                            </div>
                            <div class="mt-4">
                                <button type="submit" class="btn btn-primary">Đăng nhập</button>
                            </div>
                        </form>
                        <div class="toggle-container">
                            <span>Chưa có tài khoản?</span>
                            <span class="toggle-link" onclick="toggleForm('registerForm', 'loginForm')">Đăng ký ngay</span>
                        </div>
                    </div>

                    <!-- ========== FORM REGISTER ========== -->
                    <div id="registerForm" class="auth-card">
                        <div class="text-center mb-6">
                            <a href="#"><img src="${pageContext.request.contextPath}/assets/images/logo-dark.svg" alt="logo" class="auth-logo"/></a>
                        </div>
                        <h2 class="auth-title">Tạo tài khoản mới</h2>
                        <p class="auth-subtitle">Tham gia cùng LightStore Admin</p>
                        <% if (registerError != null) { %>
                        <div class="error-message"><%= registerError %></div>
                        <% } %>
                        <form action="${pageContext.request.contextPath}/AdminRegisterServlet" method="post">
                            <div class="grid grid-cols-2">
                                <div class="form-group">
                                    <input type="text" class="form-control" name="firstName" placeholder="Họ" required>
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control" name="lastName" placeholder="Tên" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <input type="email" class="form-control" name="email" placeholder="Địa chỉ Email" required>
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control" name="password" placeholder="Mật khẩu" required>
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control" name="confirmPassword" placeholder="Xác nhận mật khẩu" required>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="terms" name="terms" required>
                                <label class="form-check-label" for="terms">Tôi đồng ý với điều khoản sử dụng</label>
                            </div>
                            <div class="mt-4">
                                <button type="submit" class="btn btn-primary">Đăng ký</button>
                            </div>
                        </form>
                        <div class="toggle-container">
                            <span>Đã có tài khoản?</span>
                            <span class="toggle-link" onclick="toggleForm('loginForm', 'registerForm')">Đăng nhập ngay</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
                        
        <script>
            // JS chuyển qua lại giữa 2 form với hiệu ứng fade
            function toggleForm(showId, hideId) {
                const showForm = document.getElementById(showId);
                const hideForm = document.getElementById(hideId);
                
                // Thêm hiệu ứng fade out cho form hiện tại
                hideForm.classList.remove('active');
                
                // Sau khi fade out hoàn tất, hiển thị form mới với fade in
                setTimeout(() => {
                    showForm.classList.add('active');
                }, 300); // Thời gian chờ bằng thời gian transition
            }
            
            const shouldShowRegister = '<%= (showRegister != null && showRegister) ? "true" : "false" %>' === 'true';
            if (shouldShowRegister) {
                toggleForm('registerForm', 'loginForm');
            }
        </script>
    </body>
</html>