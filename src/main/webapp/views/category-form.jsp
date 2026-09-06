<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${category == null or category.id == 0 ? 'Thêm mới' : 'Chỉnh sửa'} Danh mục</title>
</head>
<body>

<div class="card shadow-sm border-0 rounded-3 max-w-600 mx-auto bg-white p-4" style="max-width: 600px;">
    <h3 class="h4 text-dark border-bottom pb-3 mb-4 fw-bold">
        <i class="bi bi-folder-plus text-primary me-2"></i>${category == null or category.id == 0 ? 'Thêm mới' : 'Chỉnh sửa'} Danh mục
    </h3>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i><c:out value="${error}" />
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <form method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
        <input type="hidden" name="id" value="${category != null ? category.id : 0}" />

        <div class="mb-3">
            <label for="name" class="form-label fw-semibold">Tên danh mục <span class="text-danger">*</span>:</label>
            <input type="text" id="name" name="name" class="form-control" value="<c:out value='${category != null ? category.name : ""}'/>" required minlength="2" placeholder="Nhập tên danh mục..." />
            <div class="invalid-feedback">
                Vui lòng nhập tên danh mục (tối thiểu 2 ký tự).
            </div>
        </div>

        <div class="mb-3">
            <label for="iconFile" class="form-label fw-semibold">Chọn tệp hình ảnh (Upload File):</label>
            <input type="file" id="iconFile" name="iconFile" class="form-control" accept="image/*" />
        </div>

        <div class="mb-4">
            <label for="icon" class="form-label fw-semibold">Hoặc nhập URL hình ảnh:</label>
            <input type="text" id="icon" name="icon" class="form-control" value="<c:out value='${category != null ? category.icon : ""}'/>" placeholder="https://example.com/image.png" />
            <c:if test="${not empty category.icon}">
                <div class="mt-2">
                    <small class="text-muted d-block mb-1">Hình ảnh hiện tại:</small>
                    <c:choose>
                        <c:when test="${category.icon.startsWith('http://') or category.icon.startsWith('https://')}">
                            <img src="<c:out value='${category.icon}'/>" alt="Current image" class="img-thumbnail" style="width: 80px; height: 80px; object-fit: cover;" />
                        </c:when>
                        <c:otherwise>
                            <c:url value="/image?fname=${category.icon}" var="imgUrl" />
                            <img src="${imgUrl}" alt="Current image" class="img-thumbnail" style="width: 80px; height: 80px; object-fit: cover;" />
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
        </div>

        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-success fw-bold px-4">
                <i class="bi bi-save me-1"></i> Lưu Danh mục
            </button>
            <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-secondary px-4">
                Hủy bỏ
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