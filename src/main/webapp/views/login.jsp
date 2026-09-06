<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Linh Web</title>
    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>

<body class="bg-light d-flex align-items-center justify-content-center min-vh-100 py-4">

    <div class="card shadow-sm border-0 rounded-4 p-4 p-sm-5" style="max-width: 420px; width: 100%;">
        <div class="text-center mb-4">
            <div class="bg-primary bg-opacity-10 text-primary d-inline-flex p-3 rounded-circle mb-3">
                <i class="bi bi-box-arrow-in-right fs-2"></i>
            </div>
            <h2 class="h3 fw-bold text-dark mb-1">Đăng Nhập</h2>
            <p class="text-muted small">Chào mừng bạn quay trở lại Linh Web</p>
        </div>

        <c:if test="${param.msg == 'register_success'}">
            <div class="alert alert-success alert-dismissible fade show small" role="alert">
                <i class="bi bi-check-circle-fill me-1"></i> Đăng ký thành công! Vui lòng đăng nhập.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${param.msg == 'activated'}">
            <div class="alert alert-success alert-dismissible fade show small" role="alert">
                <i class="bi bi-check-circle-fill me-1"></i> Kích hoạt tài khoản thành công! Bạn có thể đăng nhập ngay.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${param.msg == 'reset_success'}">
            <div class="alert alert-success alert-dismissible fade show small" role="alert">
                <i class="bi bi-check-circle-fill me-1"></i> Đặt lại mật khẩu thành công! Vui lòng đăng nhập lại.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty alert}">
            <div class="alert alert-danger alert-dismissible fade show small" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-1"></i> ${alert}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post" class="needs-validation" novalidate>
            <div class="mb-3">
                <label for="username" class="form-label fw-semibold">Tên đăng nhập <span class="text-danger">*</span></label>
                <div class="input-group has-validation">
                    <span class="input-group-text bg-light text-muted"><i class="bi bi-person"></i></span>
                    <input type="text" id="username" name="username" class="form-control" placeholder="Nhập tên đăng nhập..." required />
                    <div class="invalid-feedback">
                        Vui lòng nhập tên đăng nhập.
                    </div>
                </div>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label fw-semibold">Mật khẩu <span class="text-danger">*</span></label>
                <div class="input-group has-validation">
                    <span class="input-group-text bg-light text-muted"><i class="bi bi-lock"></i></span>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Nhập mật khẩu..." required />
                    <div class="invalid-feedback">
                        Vui lòng nhập mật khẩu.
                    </div>
                </div>
            </div>

            <div class="d-flex justify-content-between align-items-center mb-4 small">
                <div class="form-check">
                    <input type="checkbox" id="remember" name="remember" class="form-check-input" />
                    <label for="remember" class="form-check-label text-muted">Ghi nhớ đăng nhập</label>
                </div>
                <a href="${pageContext.request.contextPath}/forgot-password" class="text-primary text-decoration-none fw-medium">Quên mật khẩu?</a>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2.5 fw-bold shadow-sm rounded-3">
                <i class="bi bi-box-arrow-in-right me-1"></i> Đăng nhập
            </button>
        </form>

        <div class="text-center mt-4 pt-3 border-top small text-muted">
            Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" class="text-primary text-decoration-none fw-bold">Đăng ký ngay</a>
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