<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${product.name} - Chi Tiết Sản Phẩm</title>
</head>
<body>

    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-primary btn-sm fw-semibold">
            <i class="bi bi-arrow-left me-1"></i> Quay lại danh sách sản phẩm
        </a>
    </div>

    <!-- Product Detail Bootstrap 5 Card -->
    <div class="card shadow-sm border-0 rounded-3 p-4 bg-white">
        <div class="row g-4 align-items-center">
            <div class="col-md-5 text-center">
                <img src="${product.getImageUrl(pageContext.request.contextPath)}" alt="${product.name}" class="img-fluid rounded-3 shadow-sm" style="max-height: 380px; width: 100%; object-fit: cover;" />
            </div>

            <div class="col-md-7">
                <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-2 rounded-pill text-uppercase fw-bold mb-2">
                    <i class="bi bi-tag-fill me-1"></i>${product.category != null ? product.category.name : 'Chưa xếp danh mục'}
                </span>

                <h1 class="h3 text-dark fw-bold my-2">${product.name}</h1>

                <div class="my-3">
                    <span class="text-danger display-6 fw-bold">
                        <fmt:formatNumber value="${product.price}" pattern="#,###" /> VNĐ
                    </span>
                </div>

                <div class="bg-light p-3 rounded-3 border mb-4">
                    <div class="d-flex flex-wrap gap-4">
                        <div>
                            <span class="text-muted small">Tồn kho:</span>
                            <h6 class="mb-0 fw-bold text-dark"><i class="bi bi-box-seam text-primary me-1"></i>${product.quantity} sản phẩm</h6>
                        </div>
                        <div>
                            <span class="text-muted small">Đã bán:</span>
                            <h6 class="mb-0 fw-bold text-success"><i class="bi bi-graph-up-arrow me-1"></i>${product.sold} sản phẩm</h6>
                        </div>
                        <div>
                            <span class="text-muted small">Ngày nhập:</span>
                            <h6 class="mb-0 fw-semibold text-secondary">
                                <i class="bi bi-calendar3 me-1"></i><fmt:formatDate value="${product.createdAt}" pattern="dd/MM/yyyy" />
                            </h6>
                        </div>
                    </div>
                </div>

                <h5 class="h6 text-dark fw-bold mb-2">Mô tả sản phẩm:</h5>
                <p class="text-secondary leading-relaxed mb-4">
                    ${product.description != null && !product.description.isBlank() ? product.description : 'Sản phẩm chính hãng với đầy đủ chế độ bảo hành.'}
                </p>

                <div class="d-flex gap-3 flex-wrap">
                    <button type="button" class="btn btn-success btn-lg px-4 fw-bold shadow-sm">
                        <i class="bi bi-cart-plus me-2"></i> Thêm Vào Giỏ Hàng
                    </button>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary btn-lg px-4 fw-semibold">
                        <i class="bi bi-house me-1"></i> Trở về Trang chủ
                    </a>
                </div>
            </div>
        </div>
    </div>

</body>
</html>