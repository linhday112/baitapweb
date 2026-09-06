<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - Linh Room Web</title>
</head>
<body>

    <!-- User Welcome Banner -->
    <div class="card shadow-sm border-0 mb-4 bg-white">
        <div class="card-body p-4">
            <h2 class="h4 text-primary font-weight-bold mb-3">
                <i class="bi bi-stars text-warning me-2"></i>Chào mừng đến với Linh Room Web
            </h2>

            <div class="d-flex align-items-center gap-3 p-3 bg-light rounded-3 mb-3 border">
                <c:choose>
                    <c:when test="${not empty sessionScope.account.images}">
                        <c:choose>
                            <c:when test="${sessionScope.account.images.startsWith('http')}">
                                <img src="${sessionScope.account.images}" alt="avatar" class="rounded-circle border border-primary border-2" style="width: 64px; height: 64px; object-fit: cover;" />
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/image?fname=${sessionScope.account.images}" alt="avatar" class="rounded-circle border border-primary border-2" style="width: 64px; height: 64px; object-fit: cover;" />
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <img src="https://via.placeholder.com/64?text=User" alt="avatar" class="rounded-circle" style="width: 64px; height: 64px; object-fit: cover;" />
                    </c:otherwise>
                </c:choose>

                <div>
                    <h5 class="mb-1 text-dark">Xin chào <strong>${sessionScope.account.fullName}</strong> <span class="text-muted fs-6">(${sessionScope.account.username})</span></h5>
                    <p class="text-secondary small mb-1">
                        <i class="bi bi-envelope me-1"></i>Email: <strong>${sessionScope.account.email != null ? sessionScope.account.email : 'Chưa cập nhật'}</strong> | 
                        <i class="bi bi-telephone me-1"></i>SĐT: <strong>${sessionScope.account.phone != null ? sessionScope.account.phone : 'Chưa cập nhật'}</strong>
                    </p>
                    <div>
                        <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-pill">
                            Vai trò: ${sessionScope.account.role}
                        </span>
                    </div>
                </div>
            </div>

            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/profile" class="btn btn-primary btn-sm px-3 shadow-sm">
                    <i class="bi bi-pencil-square me-1"></i> Chỉnh sửa hồ sơ cá nhân
                </a>
                <a href="${pageContext.request.contextPath}/product" class="btn btn-success btn-sm px-3 shadow-sm">
                    <i class="bi bi-grid-3x3-gap me-1"></i> Xem tất cả sản phẩm
                </a>
            </div>
        </div>
    </div>

    <!-- Section 1: Top 10 Sản Phẩm Bán Chạy Nhất -->
    <div class="mb-5">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3 class="h5 text-danger border-start border-4 border-warning ps-2 mb-0 fw-bold">
                <i class="bi bi-fire text-warning me-1"></i> Top 10 Sản Phẩm Bán Chạy Nhất
            </h3>
            <a href="${pageContext.request.contextPath}/product?sort=sold" class="text-decoration-none fw-bold small text-warning-emphasis">
                Xem tất cả top bán chạy <i class="bi bi-arrow-right"></i>
            </a>
        </div>

        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-3">
            <c:forEach var="p" items="${top10SoldProducts}" varStatus="status">
                <div class="col">
                    <div class="card h-100 shadow-sm border-0 rounded-3 overflow-hidden position-relative card-hover">
                        <!-- Badge Top Rank -->
                        <span class="position-absolute top-0 start-0 m-2 badge bg-warning text-dark shadow-sm">
                            <i class="bi bi-trophy-fill text-danger me-1"></i>Top #${status.index + 1}
                        </span>

                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}">
                            <img src="${p.getImageUrl(pageContext.request.contextPath)}" alt="${p.name}" class="card-img-top" style="height: 160px; object-fit: cover;" />
                        </a>
                        <div class="card-body d-flex flex-column p-3">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <span class="badge bg-light text-secondary border text-uppercase" style="font-size: 10px;">${p.category != null ? p.category.name : 'Danh mục'}</span>
                                <span class="badge bg-success-subtle text-success border border-success-subtle fw-bold" style="font-size: 11px;">Đã bán: ${p.sold}</span>
                            </div>
                            <h6 class="card-title text-truncate-2 text-dark mb-2" style="height: 38px; line-height: 1.3;">
                                <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" class="text-decoration-none text-dark fw-semibold">${p.name}</a>
                            </h6>
                            <div class="mt-auto">
                                <p class="text-danger fw-bold fs-6 mb-2">
                                    <fmt:formatNumber value="${p.price}" pattern="#,###" /> VNĐ
                                </p>
                                <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" class="btn btn-warning btn-sm w-100 text-dark fw-semibold">
                                    <i class="bi bi-eye me-1"></i> Xem chi tiết
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Section 2: 10 Sản Phẩm Mới Nhất -->
    <div class="mb-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3 class="h5 text-dark border-start border-4 border-primary ps-2 mb-0 fw-bold">
                <i class="bi bi-box-seam text-primary me-1"></i> 10 Sản Phẩm Mới Nhất
            </h3>
            <a href="${pageContext.request.contextPath}/product?sort=newest" class="text-decoration-none fw-bold small text-primary">
                Xem tất cả <i class="bi bi-arrow-right"></i>
            </a>
        </div>

        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-3">
            <c:forEach var="p" items="${top10Products}">
                <div class="col">
                    <div class="card h-100 shadow-sm border-0 rounded-3 overflow-hidden">
                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}">
                            <img src="${p.getImageUrl(pageContext.request.contextPath)}" alt="${p.name}" class="card-img-top" style="height: 160px; object-fit: cover;" />
                        </a>
                        <div class="card-body d-flex flex-column p-3">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <span class="badge bg-light text-secondary border text-uppercase" style="font-size: 10px;">${p.category != null ? p.category.name : 'Danh mục'}</span>
                                <span class="text-muted small" style="font-size: 11px;">Đã bán: ${p.sold}</span>
                            </div>
                            <h6 class="card-title text-truncate-2 text-dark mb-2" style="height: 38px; line-height: 1.3;">
                                <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" class="text-decoration-none text-dark fw-semibold">${p.name}</a>
                            </h6>
                            <div class="mt-auto">
                                <p class="text-danger fw-bold fs-6 mb-2">
                                    <fmt:formatNumber value="${p.price}" pattern="#,###" /> VNĐ
                                </p>
                                <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" class="btn btn-outline-primary btn-sm w-100 fw-semibold">
                                    <i class="bi bi-eye me-1"></i> Xem chi tiết
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

</body>
</html>