<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Thực Mã OTP - Linh Web</title>
    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>

<body class="bg-light d-flex align-items-center justify-content-center min-vh-100 py-4">

    <div class="card shadow-sm border-0 rounded-4 p-4 p-sm-5" style="max-width: 420px; width: 100%;">
        <div class="text-center mb-4">
            <div class="bg-info bg-opacity-15 text-info-emphasis d-inline-flex p-3 rounded-circle mb-3">
                <i class="bi bi-shield-check fs-2"></i>
            </div>
            <h2 class="h3 fw-bold text-dark mb-1">Xác Thực Mã OTP</h2>
            <p class="text-muted small">Mã OTP 6 chữ số đã được gửi tới Email của bạn. Mã có hiệu lực trong 10 phút.</p>
        </div>

        <c:if test="${not empty alert}">
            <div class="alert alert-danger alert-dismissible fade show small" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-1"></i> ${alert}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty msg}">
            <div class="alert alert-success alert-dismissible fade show small" role="alert">
                <i class="bi bi-check-circle-fill me-1"></i> ${msg}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/verify-otp" method="post" class="needs-validation" novalidate>
            <div class="mb-3">
                <label for="username" class="form-label fw-semibold">Tên đăng nhập <span class="text-danger">*</span></label>
                <input type="text" id="username" name="username" value="${username}" class="form-control" placeholder="Tên đăng nhập..." required />
                <div class="invalid-feedback">
                    Vui lòng nhập tên đăng nhập.
                </div>
            </div>

            <div class="mb-4">
                <label for="otp" class="form-label fw-semibold">Mã OTP 6 chữ số <span class="text-danger">*</span></label>
                <input type="text" id="otp" name="otp" placeholder="VD: 123456" maxlength="6" pattern="[0-9]{6}" class="form-control form-control-lg text-center fw-bold text-primary tracking-widest" style="letter-spacing: 6px; font-size: 24px;" required />
                <div class="invalid-feedback">
                    Vui lòng nhập chính xác 6 chữ số OTP.
                </div>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2.5 fw-bold shadow-sm rounded-3">
                <i class="bi bi-check2-circle me-1"></i> Kích Hoạt Tài Khoản
            </button>
        </form>

        <form action="${pageContext.request.contextPath}/verify-otp" method="post" class="mt-2">
            <input type="hidden" name="username" value="${username}" />
            <input type="hidden" name="action" value="resend" />
            <button type="submit" class="btn btn-outline-secondary btn-sm w-100 py-2 fw-semibold">
                <i class="bi bi-arrow-clockwise me-1"></i> Gửi lại mã OTP qua Email
            </button>
        </form>

        <div class="text-center mt-4 pt-3 border-top small text-muted">
            <a href="${pageContext.request.contextPath}/login" class="text-primary text-decoration-none fw-semibold">
                <i class="bi bi-arrow-left me-1"></i> Quay lại Đăng nhập
            </a>
            <div class="mt-2 pt-2 border-top">
                Quay lại <a href="${pageContext.request.contextPath}/register?username=${username}" class="text-primary text-decoration-none fw-bold">chỉnh sửa thông tin đăng ký</a>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS & Validation Script -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        (() => {
            'use strict';
            const forms = document.querySelectorAll('.needs-validation');
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        })();
    </script>
</body>
</html>