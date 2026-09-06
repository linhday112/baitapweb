<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ cá nhân - Linh Web</title>
</head>
<body>

<div class="card shadow-sm border-0 rounded-4 max-w-650 mx-auto bg-white p-4 p-sm-5 my-3" style="max-width: 650px;">

    <c:if test="${param.msg == 'update_success'}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm mb-4" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i> <strong>Thành công!</strong> Thông tin cá nhân và ảnh đại diện đã được cập nhật.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm mb-4" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="d-flex align-items-center gap-4 pb-4 border-bottom mb-4 flex-wrap flex-sm-nowrap">
        <div class="position-relative flex-shrink-0 mx-auto mx-sm-0">
            <c:choose>
                <c:when test="${not empty user.images}">
                    <c:choose>
                        <c:when test="${user.images.startsWith('http')}">
                            <img src="${user.images}" alt="avatar" class="rounded-circle border border-3 border-primary shadow-sm" style="width: 100px; height: 100px; object-fit: cover;" />
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/image?fname=${user.images}" alt="avatar" class="rounded-circle border border-3 border-primary shadow-sm" style="width: 100px; height: 100px; object-fit: cover;" />
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="avatar" class="rounded-circle border border-3 border-primary shadow-sm" style="width: 100px; height: 100px; object-fit: cover;" />
                </c:otherwise>
            </c:choose>
        </div>
        <div>
            <h3 class="h4 fw-bold text-dark mb-1">${user.fullName}</h3>
            <div class="text-muted small">
                <span class="me-2"><i class="bi bi-person me-1"></i>${user.username}</span>
                <span class="badge ${user.role == 'ADMIN' || user.roleId == 1 ? 'bg-danger' : 'bg-success'} rounded-pill px-2.5 py-1">${user.role}</span>
            </div>
            <c:if test="${not empty user.email}">
                <div class="text-secondary small mt-1">
                    <i class="bi bi-envelope me-1"></i>${user.email}
                </div>
            </c:if>
        </div>
    </div>

    <!-- Form cập nhật thông tin User -->
    <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
        
        <div class="mb-3">
            <label for="usernameDisplay" class="form-label fw-semibold">Tên đăng nhập (Username):</label>
            <input type="text" id="usernameDisplay" class="form-control bg-light text-muted" value="${user.username}" readonly />
        </div>

        <div class="mb-3">
            <label for="fullName" class="form-label fw-semibold">Họ và tên (Full Name) <span class="text-danger">*</span>:</label>
            <input type="text" id="fullName" name="fullName" class="form-control" value="${user.fullName}" required placeholder="Nhập họ và tên..." />
            <div class="invalid-feedback">
                Vui lòng nhập họ và tên của bạn.
            </div>
        </div>

        <div class="mb-3">
            <label for="phone" class="form-label fw-semibold">Số điện thoại (Phone):</label>
            <input type="tel" id="phone" name="phone" class="form-control" value="${user.phone}" pattern="^0[0-9]{9}$" placeholder="Ví dụ: 0912345678" />
            <div class="invalid-feedback">
                Số điện thoại không hợp lệ (phải bắt đầu bằng số 0 và gồm 10 chữ số).
            </div>
        </div>

        <div class="mb-4">
            <label for="imageFile" class="form-label fw-semibold">Thay đổi ảnh đại diện mới:</label>
            <input type="file" id="imageFile" name="imageFile" class="form-control" accept="image/*" />
            <div class="form-text text-muted">
                Định dạng hỗ trợ: JPG, PNG, WEBP, GIF. Dung lượng tối đa: 10MB.
            </div>
        </div>

        <div class="d-flex gap-2 pt-2">
            <button type="submit" class="btn btn-primary fw-bold px-4 py-2 shadow-sm rounded-3">
                <i class="bi bi-save me-1"></i> Lưu thay đổi
            </button>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary px-4 py-2 rounded-3">
                Quay lại Trang chủ
            </a>
        </div>

    </form>

</div>

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