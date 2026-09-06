<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Danh Mục - Admin Panel</title>
</head>
<body>

    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <h2 class="h4 text-dark border-start border-4 border-primary ps-2 mb-0 fw-bold">
            <i class="bi bi-folder-check text-primary me-1"></i> Quản Lý Danh Mục (Category)
        </h2>
        <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-success fw-bold shadow-sm">
            <i class="bi bi-plus-lg me-1"></i> Thêm Danh Mục Mới
        </a>
    </div>

    <!-- Thông báo kết quả -->
    <c:if test="${param.msg == 'added'}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm mb-3" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>Thêm danh mục mới thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${param.msg == 'updated'}">
        <div class="alert alert-info alert-dismissible fade show shadow-sm mb-3" role="alert">
            <i class="bi bi-info-circle-fill me-2"></i>Cập nhật danh mục thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${param.msg == 'deleted'}">
        <div class="alert alert-secondary alert-dismissible fade show shadow-sm mb-3" role="alert">
            <i class="bi bi-trash-fill me-2"></i>Đã xóa danh mục thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${param.error != null}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm mb-3" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>Thao tác không thành công hoặc xảy ra lỗi!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Ô tìm kiếm Bootstrap Input Group -->
    <form action="${pageContext.request.contextPath}/admin/category/list" method="get" class="mb-4">
        <div class="input-group" style="max-width: 450px;">
            <input type="text" name="keyword" value="<c:out value='${keyword}'/>" class="form-control" placeholder="Tìm kiếm tên danh mục..." />
            <button type="submit" class="btn btn-primary fw-semibold">
                <i class="bi bi-search me-1"></i> Tìm kiếm
            </button>
            <c:if test="${not empty keyword}">
                <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-outline-secondary">Hủy</a>
            </c:if>
        </div>
    </form>

    <!-- Bảng Bootstrap 5 danh sách danh mục -->
    <div class="card shadow-sm border-0 rounded-3 overflow-hidden">
        <div class="table-responsive">
            <table class="table table-hover table-striped align-middle mb-0">
                <thead class="table-primary text-nowrap">
                    <tr>
                        <th style="width: 70px;" class="text-center">STT</th>
                        <th style="width: 100px;">Hình ảnh</th>
                        <th>Tên Danh Mục</th>
                        <th style="width: 180px;" class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty categories}">
                            <tr>
                                <td colspan="4" class="text-center py-4 text-muted">Không có danh mục nào.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${categories}" var="cat" varStatus="loop">
                                <tr>
                                    <td class="text-center fw-bold text-secondary">${loop.count}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${empty cat.icon}">
                                                <img src="https://via.placeholder.com/45?text=No+Img" alt="no icon" class="rounded border" style="width: 45px; height: 45px; object-fit: cover;" />
                                            </c:when>
                                            <c:when test="${cat.icon.startsWith('http://') or cat.icon.startsWith('https://')}">
                                                <img src="<c:out value='${cat.icon}'/>" alt="icon" class="rounded border" style="width: 45px; height: 45px; object-fit: cover;" />
                                            </c:when>
                                            <c:otherwise>
                                                <c:url value="/image?fname=${cat.icon}" var="imgUrl" />
                                                <img src="${imgUrl}" alt="icon" class="rounded border" style="width: 45px; height: 45px; object-fit: cover;" />
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="fw-semibold text-dark"><c:out value="${cat.name}" /></td>
                                    <td class="text-center text-nowrap">
                                        <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cat.id}" class="btn btn-warning btn-sm fw-semibold me-1">
                                            <i class="bi bi-pencil-square"></i> Sửa
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cat.id}" 
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục \'${cat.name}\' không?');"
                                           class="btn btn-danger btn-sm fw-semibold">
                                            <i class="bi bi-trash"></i> Xóa
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>