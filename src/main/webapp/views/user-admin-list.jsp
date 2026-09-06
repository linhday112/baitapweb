<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Tài Khoản Người Dùng - Admin Panel</title>
</head>
<body>

    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <h2 class="h4 text-dark border-start border-4 border-primary ps-2 mb-0 fw-bold">
            <i class="bi bi-people-fill text-primary me-1"></i> Quản Lý Tài Khoản Thành Viên
        </h2>
        <span class="badge bg-secondary rounded-pill fs-6 px-3 py-2">Tổng số tài khoản: <strong>${users.size()}</strong></span>
    </div>

    <!-- Thông báo kết quả -->
    <c:if test="${param.msg == 'deleted'}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm mb-3" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>Đã xóa thành công tài khoản thành viên!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${param.error == 'self_delete'}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm mb-3" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>Bạn không thể tự xóa tài khoản Admin đang đăng nhập!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${param.error == 'cannot_delete_admin'}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm mb-3" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>Không thể xóa tài khoản Quản trị viên (ADMIN)!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Bảng Bootstrap 5 danh sách tài khoản -->
    <div class="card shadow-sm border-0 rounded-3 overflow-hidden">
        <div class="table-responsive">
            <table class="table table-hover table-striped align-middle mb-0">
                <thead class="table-primary text-nowrap">
                    <tr>
                        <th style="width: 50px;" class="text-center">ID</th>
                        <th style="width: 70px;">Avatar</th>
                        <th>Username</th>
                        <th>Họ và tên</th>
                        <th>Email</th>
                        <th>SĐT</th>
                        <th>Vai trò</th>
                        <th>Trạng thái</th>
                        <th style="width: 100px;" class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${users}">
                        <tr>
                            <td class="text-center fw-bold text-secondary">${u.id}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty u.images}">
                                        <c:choose>
                                            <c:when test="${u.images.startsWith('http')}">
                                                <img src="${u.images}" alt="avatar" class="rounded-circle border" style="width: 40px; height: 40px; object-fit: cover;" />
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/image?fname=${u.images}" alt="avatar" class="rounded-circle border" style="width: 40px; height: 40px; object-fit: cover;" />
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://via.placeholder.com/40?text=U" alt="avatar" class="rounded-circle border" style="width: 40px; height: 40px; object-fit: cover;" />
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="fw-bold text-dark">${u.username}</td>
                            <td class="fw-semibold">${u.fullName}</td>
                            <td class="text-primary">${u.email != null ? u.email : '-'}</td>
                            <td class="text-secondary">${u.phone != null ? u.phone : '-'}</td>
                            <td>
                                <span class="badge ${u.role == 'ADMIN' || u.roleId == 1 ? 'bg-danger' : 'bg-success'}">
                                    ${u.role}
                                </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${u.status == 1}">
                                        <span class="badge bg-success-subtle text-success border border-success-subtle">
                                            <i class="bi bi-check-circle me-1"></i>Đã kích hoạt
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-warning-subtle text-warning border border-warning-subtle">
                                            Chờ OTP
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${u.role == 'ADMIN' || u.roleId == 1}">
                                        <span class="text-muted small fw-semibold">(Quản trị)</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/admin/user/delete?id=${u.id}" 
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa tài khoản thành viên \'${u.username}\' này không?');" 
                                           class="btn btn-danger btn-sm fw-semibold">
                                            <i class="bi bi-trash"></i> Xóa
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>