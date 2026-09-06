<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Sản Phẩm - Linh Web</title>
</head>
<body>

    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <h2 class="h4 text-dark border-start border-4 border-primary ps-2 mb-0 fw-bold">
            <i class="bi bi-grid-3x3-gap text-primary me-1"></i> Danh Sách Sản Phẩm (Phân trang 6sp/trang)
        </h2>
        
        <!-- Bộ lọc sắp xếp Bootstrap 5 Nav Pills -->
        <div class="d-flex align-items-center gap-2">
            <span class="small text-muted fw-bold">Sắp xếp:</span>
            <ul class="nav nav-pills small">
                <li class="nav-item">
                    <a class="nav-link py-1 px-3 fw-bold ${sort == 'sold' || empty sort ? 'active bg-warning text-dark' : 'bg-light text-dark border'}" 
                       href="${pageContext.request.contextPath}/product?page=1&sort=sold">
                       <i class="bi bi-fire text-danger me-1"></i> Bán chạy nhất
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link py-1 px-3 fw-bold ${sort == 'newest' ? 'active bg-primary text-white' : 'bg-light text-dark border'}" 
                       href="${pageContext.request.contextPath}/product?page=1&sort=newest">
                       <i class="bi bi-clock-history me-1"></i> Mới nhất
                    </a>
                </li>
            </ul>
            <span class="badge bg-secondary rounded-pill ms-2">Tổng: ${totalCount} sản phẩm</span>
        </div>
    </div>

    <!-- Danh sách sản phẩm Bootstrap Grid -->
    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 mb-4">
        <c:forEach var="p" items="${products}">
            <div class="col">
                <div class="card h-100 shadow-sm border-0 rounded-3 overflow-hidden">
                    <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}">
                        <img src="${p.getImageUrl(pageContext.request.contextPath)}" alt="${p.name}" class="card-img-top" style="height: 200px; object-fit: cover;" />
                    </a>
                    <div class="card-body d-flex flex-column p-3">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="badge bg-primary-subtle text-primary border border-primary-subtle text-uppercase fw-semibold" style="font-size: 11px;">
                                ${p.category != null ? p.category.name : 'Danh mục'}
                            </span>
                            <span class="badge bg-success-subtle text-success border border-success-subtle fw-bold" style="font-size: 11px;">
                                <i class="bi bi-graph-up-arrow me-1"></i>Đã bán: ${p.sold}
                            </span>
                        </div>

                        <h5 class="card-title text-truncate-2 text-dark mb-2" style="height: 44px; line-height: 1.3;">
                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" class="text-decoration-none text-dark fw-semibold">${p.name}</a>
                        </h5>
                        <p class="card-text text-muted small mb-3" style="height: 38px; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;">
                            ${p.description != null ? p.description : 'Không có mô tả sản phẩm'}
                        </p>
                        
                        <div class="mt-auto d-flex justify-content-between align-items-center pt-2 border-top">
                            <span class="text-danger fw-bold fs-5">
                                <fmt:formatNumber value="${p.price}" pattern="#,###" /> VNĐ
                            </span>
                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" class="btn btn-primary btn-sm px-3 fw-semibold">
                                <i class="bi bi-eye me-1"></i> Chi tiết
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Bootstrap 5 Pagination Controls -->
    <c:if test="${totalPages > 1}">
        <nav aria-label="Product pagination" class="my-4">
            <ul class="pagination pagination-md justify-content-center mb-0">
                <c:if test="${currentPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="${pageContext.request.contextPath}/product?page=${currentPage - 1}&sort=${sort}">
                            &laquo; Trước
                        </a>
                    </li>
                </c:if>

                <c:forEach var="i" begin="1" end="${totalPages}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <li class="page-item active"><span class="page-link">${i}</span></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/product?page=${i}&sort=${sort}">${i}</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <li class="page-item">
                        <a class="page-link" href="${pageContext.request.contextPath}/product?page=${currentPage + 1}&sort=${sort}">
                            Sau &raquo;
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </c:if>

</body>
</html>