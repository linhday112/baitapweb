<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${product != null && product.id > 0 ? 'Chỉnh Sửa Sản Phẩm' : 'Thêm Sản Phẩm Mới'}</title>
</head>
<body>

    <div class="card shadow-sm border-0 rounded-3 max-w-650 mx-auto bg-white p-4" style="max-width: 650px;">
        <h3 class="h4 text-dark border-bottom pb-3 mb-4 fw-bold">
            <i class="bi bi-box-seam-fill text-primary me-2"></i>${product != null && product.id > 0 ? 'Chỉnh Sửa Sản Phẩm' : 'Thêm Sản Phẩm Mới'}
        </h3>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form action="${product != null && product.id > 0 ? pageContext.request.contextPath.concat('/admin/product/edit') : pageContext.request.contextPath.concat('/admin/product/add')}"
              method="post" enctype="multipart/form-data" class="needs-validation" novalidate>

            <input type="hidden" name="id" value="${product.id}" />

            <div class="mb-3">
                <label for="name" class="form-label fw-semibold">Tên sản phẩm <span class="text-danger">*</span>:</label>
                <input type="text" id="name" name="name" value="${product.name}" class="form-control" placeholder="Nhập tên sản phẩm..." required />
                <div class="invalid-feedback">
                    Vui lòng nhập tên sản phẩm.
                </div>
            </div>

            <div class="mb-3">
                <label for="categoryId" class="form-label fw-semibold">Danh mục sản phẩm <span class="text-danger">*</span>:</label>
                <select id="categoryId" name="categoryId" class="form-select" required>
                    <option value="">-- Chọn danh mục --</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.id}" ${product != null && product.category != null && product.category.id == cat.id ? 'selected' : ''}>
                            ${cat.name}
                        </option>
                    </c:forEach>
                </select>
                <div class="invalid-feedback">
                    Vui lòng chọn 1 danh mục cho sản phẩm.
                </div>
            </div>

            <div class="row g-3 mb-3">
                <div class="col-md-4">
                    <label for="price" class="form-label fw-semibold">Giá bán (VNĐ) <span class="text-danger">*</span>:</label>
                    <input type="number" id="price" name="price" value="${product.price}" min="1000" step="1000" class="form-control" required />
                    <div class="invalid-feedback">
                        Giá bán tối thiểu là 1,000 VNĐ.
                    </div>
                </div>
                <div class="col-md-4">
                    <label for="quantity" class="form-label fw-semibold">Tồn kho <span class="text-danger">*</span>:</label>
                    <input type="number" id="quantity" name="quantity" value="${product.quantity}" min="0" class="form-control" required />
                    <div class="invalid-feedback">
                        Số lượng tồn kho không được âm.
                    </div>
                </div>
                <div class="col-md-4">
                    <label for="sold" class="form-label fw-semibold">Đã bán <span class="text-danger">*</span>:</label>
                    <input type="number" id="sold" name="sold" value="${product != null ? product.sold : 0}" min="0" class="form-control" required />
                    <div class="invalid-feedback">
                        Số lượng đã bán không được âm.
                    </div>
                </div>
            </div>

            <div class="mb-3">
                <label for="description" class="form-label fw-semibold">Mô tả sản phẩm:</label>
                <textarea id="description" name="description" rows="4" class="form-control" placeholder="Nhập mô tả chi tiết sản phẩm...">${product.description}</textarea>
            </div>

            <div class="mb-4">
                <label for="imageFile" class="form-label fw-semibold">Chọn file ảnh sản phẩm (Upload File):</label>
                <input type="file" id="imageFile" name="imageFile" accept="image/*" class="form-control mb-2" />

                <label for="imageUrl" class="form-label fw-semibold text-muted small">Hoặc nhập URL hình ảnh:</label>
                <input type="text" id="imageUrl" name="imageUrl" value="${product.images}" placeholder="https://example.com/image.jpg" class="form-control" />

                <c:if test="${not empty product.images}">
                    <div class="mt-2">
                        <small class="text-muted d-block mb-1">Ảnh hiện tại:</small>
                        <img src="${product.getImageUrl(pageContext.request.contextPath)}" alt="Current Image" class="img-thumbnail" style="width: 100px; height: 100px; object-fit: cover;" />
                    </div>
                </c:if>
            </div>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-success fw-bold px-4">
                    <i class="bi bi-save me-1"></i> Lưu Sản Phẩm
                </button>
                <a href="${pageContext.request.contextPath}/admin/product/list" class="btn btn-secondary px-4">
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