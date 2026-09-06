<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Sản Phẩm - Admin Panel</title>
</head>
<body>

    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <h2 class="h4 text-dark border-start border-4 border-primary ps-2 mb-0 fw-bold">
            <i class="bi bi-box-seam text-primary me-1"></i> Quản Lý Sản Phẩm
        </h2>
        <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-success fw-bold shadow-sm">
            <i class="bi bi-plus-lg me-1"></i> Thêm Sản Phẩm Mới
        </a>
    </div>

    <!-- Thông báo kết quả -->
    <c:if test="${param.msg == 'added'}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm mb-3" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>Thêm sản phẩm mới thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${param.msg == 'updated'}">
        <div class="alert alert-info alert-dismissible fade show shadow-sm mb-3" role="alert">
            <i class="bi bi-info-circle-fill me-2"></i>Cập nhật sản phẩm thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${param.msg == 'deleted'}">
        <div class="alert alert-secondary alert-dismissible fade show shadow-sm mb-3" role="alert">
            <i class="bi bi-trash-fill me-2"></i>Đã xóa sản phẩm thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Ô tìm kiếm -->
    <form action="${pageContext.request.contextPath}/admin/product/list" method="get" class="mb-4">
        <div class="input-group" style="max-width: 450px;">
            <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Tìm kiếm sản phẩm theo tên..." />
            <button type="submit" class="btn btn-primary fw-semibold">
                <i class="bi bi-search me-1"></i> Tìm kiếm
            </button>
            <c:if test="${not empty keyword}">
                <a href="${pageContext.request.contextPath}/admin/product/list" class="btn btn-outline-secondary">Hủy</a>
            </c:if>
        </div>
    </form>

    <!-- Bảng Bootstrap 5 danh sách sản phẩm -->
    <div class="card shadow-sm border-0 rounded-3 overflow-hidden">
        <div class="table-responsive">
            <table class="table table-hover table-striped align-middle mb-0">
                <thead class="table-primary text-nowrap">
                    <tr>
                        <th style="width: 60px;" class="text-center">ID</th>
                        <th style="width: 80px;">Hình ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th>Danh mục</th>
                        <th>Giá bán</th>
                        <th class="text-center">Số lượng</th>
                        <th class="text-center">Đã bán</th>
                        <th style="width: 160px;" class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty products}">
                            <c:forEach var="p" items="${products}">
                                <tr>
                                    <td class="text-center fw-bold text-secondary">${p.id}</td>
                                    <td>
                                        <img src="${p.getImageUrl(pageContext.request.contextPath)}" alt="${p.name}" class="rounded border" style="width: 48px; height: 48px; object-fit: cover;" />
                                    </td>
                                    <td class="fw-semibold text-dark">${p.name}</td>
                                    <td>
                                        <span class="badge bg-light text-primary border border-primary-subtle">
                                            ${p.category != null ? p.category.name : 'Chưa chọn'}
                                        </span>
                                    </td>
                                    <td class="fw-bold text-danger">
                                        <fmt:formatNumber value="${p.price}" pattern="#,###" /> VNĐ
                                    </td>
                                    <td class="text-center fw-semibold text-dark">${p.quantity}</td>
                                    <td class="text-center">
                                        <span class="badge bg-success-subtle text-success border border-success-subtle fw-bold fs-6">
                                            ${p.sold}
                                        </span>
                                    </td>
                                    <td class="text-center text-nowrap">
                                        <a href="${pageContext.request.contextPath}/admin/product/edit?id=${p.id}" class="btn btn-warning btn-sm fw-semibold me-1">
                                            <i class="bi bi-pencil-square"></i> Sửa
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/product/delete?id=${p.id}" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');" class="btn btn-danger btn-sm fw-semibold">
                                            <i class="bi bi-trash"></i> Xóa
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="8" class="text-center py-4 text-muted">Chưa có sản phẩm nào.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>