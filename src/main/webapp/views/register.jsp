<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản - Linh Web</title>
    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>

<body class="bg-light d-flex align-items-center justify-content-center min-vh-100 py-4">

    <div class="card shadow-sm border-0 rounded-4 p-4 p-sm-5" style="max-width: 460px; width: 100%;">
        <div class="text-center mb-4">
            <div class="bg-success bg-opacity-10 text-success d-inline-flex p-3 rounded-circle mb-3">
                <i class="bi bi-person-plus-fill fs-2"></i>
            </div>
            <h2 class="h3 fw-bold text-dark mb-1">Đăng Ký Tài Khoản</h2>
            <p class="text-muted small">Tạo tài khoản mới để trải nghiệm dịch vụ của Linh Web</p>
        </div>

        <c:if test="${not empty alert}">
            <div class="alert alert-danger alert-dismissible fade show small" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-1"></i> ${alert}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post" class="needs-validation" id="registerForm" novalidate>
            <div class="mb-3">
                <label for="username" class="form-label fw-semibold">Tên đăng nhập <span class="text-danger">*</span></label>
                <div class="input-group has-validation">
                    <span class="input-group-text bg-light text-muted"><i class="bi bi-person"></i></span>
                    <input type="text" id="username" name="username" value="${username}" class="form-control" placeholder="Tối thiểu 3 ký tự..." minlength="3" required />
                    <div class="invalid-feedback">
                        Tên đăng nhập bắt buộc và phải có ít nhất 3 ký tự.
                    </div>
                </div>
            </div>

            <div class="mb-3">
                <label for="fullName" class="form-label fw-semibold">Họ và tên</label>
                <div class="input-group">
                    <span class="input-group-text bg-light text-muted"><i class="bi bi-card-heading"></i></span>
                    <input type="text" id="fullName" name="fullName" value="${fullName}" class="form-control" placeholder="Nhập họ và tên đầy đủ..." />
                </div>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label fw-semibold">Email (để nhận OTP) <span class="text-danger">*</span></label>
                <div class="input-group has-validation">
                    <span class="input-group-text bg-light text-muted"><i class="bi bi-envelope"></i></span>
                    <input type="email" id="email" name="email" value="${email}" class="form-control" placeholder="user@gmail.com" required />
                    <div class="invalid-feedback">
                        Vui lòng nhập địa chỉ Email hợp lệ.
                    </div>
                </div>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label fw-semibold">Mật khẩu <span class="text-danger">*</span></label>
                <div class="input-group has-validation">
                    <span class="input-group-text bg-light text-muted"><i class="bi bi-lock"></i></span>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Ít nhất 6 ký tự..." minlength="6" required />
                    <div class="invalid-feedback">
                        Mật khẩu bắt buộc và phải có ít nhất 6 ký tự.
                    </div>
                </div>
            </div>

            <div class="mb-4">
                <label for="repassword" class="form-label fw-semibold">Xác nhận mật khẩu <span class="text-danger">*</span></label>
                <div class="input-group has-validation">
                    <span class="input-group-text bg-light text-muted"><i class="bi bi-shield-lock"></i></span>
                    <input type="password" id="repassword" name="repassword" class="form-control" placeholder="Nhập lại mật khẩu..." required />
                    <div class="invalid-feedback" id="repasswordFeedback">
                        Mật khẩu xác nhận không trùng khớp.
                    </div>
                </div>
            </div>

            <button type="submit" class="btn btn-success w-100 py-2.5 fw-bold shadow-sm rounded-3">
                <i class="bi bi-send-check me-1"></i> Đăng Ký &amp; Nhận Mã OTP
            </button>
        </form>

        <div class="text-center mt-4 pt-3 border-top small text-muted">
            Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="text-primary text-decoration-none fw-bold">Đăng nhập ngay</a>
        </div>
    </div>

    <!-- Bootstrap 5 JS & Validation Script -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        (() => {
            'use strict';
            const form = document.getElementById('registerForm');
            const passwordInput = document.getElementById('password');
            const repasswordInput = document.getElementById('repassword');
            const repasswordFeedback = document.getElementById('repasswordFeedback');

            function validatePasswordMatch() {
                if (repasswordInput.value !== passwordInput.value) {
                    repasswordInput.setCustomValidity("Mật khẩu xác nhận không trùng khớp.");
                    repasswordFeedback.textContent = "Mật khẩu xác nhận không trùng khớp.";
                } else {
                    repasswordInput.setCustomValidity("");
                }
            }

            passwordInput.addEventListener('input', validatePasswordMatch);
            repasswordInput.addEventListener('input', validatePasswordMatch);

            form.addEventListener('submit', event => {
                validatePasswordMatch();
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        })();
    </script>
</body>
</html>