<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Lại Mật Khẩu - Linh Web</title>
    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>

<body class="bg-light d-flex align-items-center justify-content-center min-vh-100 py-4">

    <div class="card shadow-sm border-0 rounded-4 p-4 p-sm-5" style="max-width: 440px; width: 100%;">
        <div class="text-center mb-4">
            <div class="bg-danger bg-opacity-10 text-danger d-inline-flex p-3 rounded-circle mb-3">
                <i class="bi bi-shield-lock-fill fs-2"></i>
            </div>
            <h2 class="h3 fw-bold text-dark mb-1">Đặt Lại Mật Khẩu</h2>
            <p class="text-muted small">Mã OTP đã được gửi đến Email. Nhập mã OTP và mật khẩu mới để cài lại.</p>
        </div>

        <c:if test="${not empty alert}">
            <div class="alert alert-danger alert-dismissible fade show small" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-1"></i> ${alert}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/reset-password" method="post" class="needs-validation" id="resetPasswordForm" novalidate>
            <div class="mb-3">
                <label for="username" class="form-label fw-semibold">Tên đăng nhập <span class="text-danger">*</span></label>
                <input type="text" id="username" name="username" value="${username}" class="form-control" placeholder="Tên đăng nhập..." required />
                <div class="invalid-feedback">
                    Vui lòng nhập tên đăng nhập.
                </div>
            </div>

            <div class="mb-3">
                <label for="otp" class="form-label fw-semibold">Mã OTP 6 chữ số <span class="text-danger">*</span></label>
                <input type="text" id="otp" name="otp" placeholder="VD: 123456" maxlength="6" pattern="[0-9]{6}" class="form-control text-center fw-bold text-primary" style="letter-spacing: 4px; font-size: 20px;" required />
                <div class="invalid-feedback">
                    Mã OTP phải đúng 6 chữ số.
                </div>
            </div>

            <div class="mb-3">
                <label for="newPassword" class="form-label fw-semibold">Mật khẩu mới <span class="text-danger">*</span></label>
                <input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="Tối thiểu 6 ký tự..." minlength="6" required />
                <div class="invalid-feedback">
                    Mật khẩu mới phải có ít nhất 6 ký tự.
                </div>
            </div>

            <div class="mb-4">
                <label for="confirmPassword" class="form-label fw-semibold">Xác nhận mật khẩu mới <span class="text-danger">*</span></label>
                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu mới..." required />
                <div class="invalid-feedback" id="confirmFeedback">
                    Mật khẩu xác nhận không trùng khớp.
                </div>
            </div>

            <button type="submit" class="btn btn-success w-100 py-2.5 fw-bold shadow-sm rounded-3">
                <i class="bi bi-arrow-repeat me-1"></i> Cập Nhật Mật Khẩu
            </button>
        </form>

        <div class="text-center mt-4 pt-3 border-top small text-muted">
            <a href="${pageContext.request.contextPath}/login" class="text-primary text-decoration-none fw-semibold">
                <i class="bi bi-arrow-left me-1"></i> Quay lại Đăng nhập
            </a>
        </div>
    </div>

    <!-- Bootstrap 5 JS & Validation Script -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        (() => {
            'use strict';
            const form = document.getElementById('resetPasswordForm');
            const newPassword = document.getElementById('newPassword');
            const confirmPassword = document.getElementById('confirmPassword');
            const confirmFeedback = document.getElementById('confirmFeedback');

            function validatePasswordMatch() {
                if (confirmPassword.value !== newPassword.value) {
                    confirmPassword.setCustomValidity("Mật khẩu xác nhận không trùng khớp.");
                    confirmFeedback.textContent = "Mật khẩu xác nhận không trùng khớp.";
                } else {
                    confirmPassword.setCustomValidity("");
                }
            }

            newPassword.addEventListener('input', validatePasswordMatch);
            confirmPassword.addEventListener('input', validatePasswordMatch);

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