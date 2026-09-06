<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Tài Khoản Người Dùng - Admin Panel</title>
</head>
<body>

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
        <h2 style="color: #2c3e50; margin: 0; border-left: 4px solid #1a73e8; padding-left: 10px;">Quản Lý Tài Khoản Thành Viên</h2>
        <span style="color: #666; font-size: 14px;">Tổng số tài khoản: <strong>${users.size()}</strong></span>
    </div>

    <!-- Thông báo kết quả -->
    <c:if test="${param.msg == 'deleted'}">
        <p style="background: #d4edda; color: #155724; padding: 12px; border-radius: 5px; font-weight: 500;">Đã xóa thành công tài khoản thành viên!</p>
    </c:if>
    <c:if test="${param.error == 'self_delete'}">
        <p style="background: #f8d7da; color: #721c24; padding: 12px; border-radius: 5px; font-weight: 500;">Bạn không thể tự xóa tài khoản Admin đang đăng nhập!</p>
    </c:if>
    <c:if test="${param.error == 'cannot_delete_admin'}">
        <p style="background: #f8d7da; color: #721c24; padding: 12px; border-radius: 5px; font-weight: 500;">Không thể xóa tài khoản Quản trị viên (ADMIN)!</p>
    </c:if>

    <!-- Bảng danh sách tài khoản -->
    <table style="width: 100%; border-collapse: collapse; background: white; box-shadow: 0 2px 10px rgba(0,0,0,0.05); border-radius: 8px; overflow: hidden; margin-top: 15px;">
        <thead>
            <tr style="background-color: #1a73e8; color: white; text-align: left;">
                <th style="padding: 12px 15px; width: 50px;">ID</th>
                <th style="padding: 12px 15px; width: 70px;">Avatar</th>
                <th style="padding: 12px 15px;">Username</th>
                <th style="padding: 12px 15px;">Họ và tên</th>
                <th style="padding: 12px 15px;">Email</th>
                <th style="padding: 12px 15px;">SĐT</th>
                <th style="padding: 12px 15px;">Vai trò</th>
                <th style="padding: 12px 15px;">Trạng thái</th>
                <th style="padding: 12px 15px; width: 100px; text-align: center;">Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="u" items="${users}">
                <tr style="border-bottom: 1px solid #eee;">
                    <td style="padding: 12px 15px; font-weight: bold;">${u.id}</td>
                    <td style="padding: 12px 15px;">
                        <c:choose>
                            <c:when test="${not empty u.images}">
                                <c:choose>
                                    <c:when test="${u.images.startsWith('http')}">
                                        <img src="${u.images}" alt="avatar" style="width: 40px; height: 40px; border-radius: 50%; object-fit: cover;" />
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/image?fname=${u.images}" alt="avatar" style="width: 40px; height: 40px; border-radius: 50%; object-fit: cover;" />
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <img src="https://via.placeholder.com/40?text=U" alt="avatar" style="width: 40px; height: 40px; border-radius: 50%; object-fit: cover;" />
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td style="padding: 12px 15px; font-weight: bold; color: #2c3e50;">${u.username}</td>
                    <td style="padding: 12px 15px;">${u.fullName}</td>
                    <td style="padding: 12px 15px; color: #16a085;">${u.email != null ? u.email : '-'}</td>
                    <td style="padding: 12px 15px;">${u.phone != null ? u.phone : '-'}</td>
                    <td style="padding: 12px 15px;">
                        <span style="padding: 3px 10px; border-radius: 12px; font-size: 12px; font-weight: bold; background: ${u.role == 'ADMIN' || u.roleId == 1 ? '#e74c3c' : '#27ae60'}; color: white;">
                            ${u.role}
                        </span>
                    </td>
                    <td style="padding: 12px 15px;">
                        <c:choose>
                            <c:when test="${u.status == 1}">
                                <span style="color: #27ae60; font-weight: bold;">Đã kích hoạt</span>
                            </c:when>
                            <c:otherwise>
                                <span style="color: #e67e22; font-weight: bold;">Chờ OTP</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td style="padding: 12px 15px; text-align: center;">
                        <c:choose>
                            <c:when test="${u.role == 'ADMIN' || u.roleId == 1}">
                                <span style="color: #aaa; font-size: 13px;">(Quản trị)</span>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/admin/user/delete?id=${u.id}" 
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa tài khoản thành viên \'${u.username}\' này không?');" 
                                   style="padding: 6px 12px; background: #e74c3c; color: white; text-decoration: none; border-radius: 4px; font-size: 13px; font-weight: bold;">
                                    Xóa
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</body>
</html>