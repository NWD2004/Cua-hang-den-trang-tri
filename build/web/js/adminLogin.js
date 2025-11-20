// Toggle hiển thị/ẩn mật khẩu
document.addEventListener('DOMContentLoaded', function() {
    // Toggle password cho Login form
    const eyeIcon = document.getElementById('eye');
    const passwordInput = document.getElementById('pwd');
    
    if (eyeIcon && passwordInput) {
        eyeIcon.addEventListener('click', function() {
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                eyeIcon.classList.remove('fa-eye');
                eyeIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                eyeIcon.classList.remove('fa-eye-slash');
                eyeIcon.classList.add('fa-eye');
            }
        });
    }
    
    // Toggle password cho Signup form
    const eyeIconSignup = document.getElementById('eyeSignup');
    const passwordInputSignup = document.getElementById('pwdSignup');
    
    if (eyeIconSignup && passwordInputSignup) {
        eyeIconSignup.addEventListener('click', function() {
            if (passwordInputSignup.type === 'password') {
                passwordInputSignup.type = 'text';
                eyeIconSignup.classList.remove('fa-eye');
                eyeIconSignup.classList.add('fa-eye-slash');
            } else {
                passwordInputSignup.type = 'password';
                eyeIconSignup.classList.remove('fa-eye-slash');
                eyeIconSignup.classList.add('fa-eye');
            }
        });
    }
    
    // Toggle giữa Login và Signup form
    const btnSignUp = document.getElementById('btnSignUp');
    const btnSignIn = document.getElementById('btnSignIn');
    const loginForm = document.getElementById('loginForm');
    const signupForm = document.getElementById('signupForm');
    
    if (btnSignUp && signupForm && loginForm) {
        btnSignUp.addEventListener('click', function() {
            loginForm.style.display = 'none';
            signupForm.style.display = 'block';
        });
    }
    
    if (btnSignIn && loginForm && signupForm) {
        btnSignIn.addEventListener('click', function() {
            signupForm.style.display = 'none';
            loginForm.style.display = 'block';
        });
    }
});
