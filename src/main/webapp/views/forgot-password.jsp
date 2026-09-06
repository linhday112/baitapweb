<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên Mật Khẩu - Linh Web</title>
    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>

<body class="bg-light d-flex align-items-center justify-content-center min-vh-100 py-4">

    <div class="card shadow-sm border-0 rounded-4 p-4 p-sm-5" style="max-width: 420px; width: 100%;">
        <div class="text-center mb-4">
            <div class="bg-warning bg-opacity-15 text-warning-emphasis d-inline-flex p-3 rounded-circle mb-3">
                <i class="bi bi-key-fill fs-2"></i>
            </div>
            <h2 class="h3 fw-bold text-dark mb-1">Quên Mật Khẩu</h2>
            <p class="text-muted small">Nhập Tên đăng nhập hoặc Email đăng ký để nhận mã OTP khôi phục qua Email.</p>
        </div>

        <c:if test="${not empty alert}">
            <div class="alert alert-danger alert-dismissible fade show small" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-1"></i> ${alert}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/forgot-password" method="post" class="needs-validation" novalidate>
            <div class="mb-4">
                <label for="accountInput" class="form-label fw-semibold">Tên đăng nhập hoặc Email <span class="text-danger">*</span></label>
                <div class="input-group has-validation">
                    <span class="input-group-text bg-light text-muted"><i class="bi bi-person-bounding-box"></i></span>
                    <input type="text" id="accountInput" name="accountInput" value="${accountInput}" class="form-control" placeholder="Username hoặc Email..." required />
                    <div class="invalid-feedback">
                        Vui lòng nhập tên đăng nhập hoặc địa chỉ email.
                    </div>
                </div>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2.5 fw-bold shadow-sm rounded-3">
                <i class="bi bi-envelope-paper me-1"></i> Gửi Mã OTP Khôi Phục
            </button>
        </form>

        <div class="text-center mt-4 pt-3 border-top small text-muted">
            Đã nhớ mật khẩu? <a href="${pageContext.request.contextPath}/login" class="text-primary text-decoration-none fw-bold">Đăng nhập tại đây</a>
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