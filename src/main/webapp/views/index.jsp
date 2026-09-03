<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
</head>

<body>

    <div style="background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
        <h1 style="color: #1a73e8; margin-bottom: 15px;">Chào mừng đến với Login Web</h1>

        <div style="display: flex; align-items: center; gap: 20px; margin: 20px 0; padding: 15px; background: #f8fafc; border-radius: 8px;">
            <c:choose>
                <c:when test="${not empty sessionScope.account.images}">
                    <c:choose>
                        <c:when test="${sessionScope.account.images.startsWith('http')}">
                            <img src="${sessionScope.account.images}" alt="avatar" style="width: 80px; height: 80px; border-radius: 50%; object-fit: cover; border: 3px solid #1a73e8;" />
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/image?fname=${sessionScope.account.images}" alt="avatar" style="width: 80px; height: 80px; border-radius: 50%; object-fit: cover; border: 3px solid #1a73e8;" />
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="avatar" style="width: 80px; height: 80px; border-radius: 50%; object-fit: cover; border: 3px solid #1a73e8;" />
                </c:otherwise>
            </c:choose>

            <div>
                <p style="font-size: 18px; margin-bottom: 6px;">Xin chào <strong>${sessionScope.account.fullName}</strong> (<code>${sessionScope.account.username}</code>)!</p>
                <p style="color: #555; margin-bottom: 6px;">Số điện thoại: <strong>${not empty sessionScope.account.phone ? sessionScope.account.phone : 'Chưa cập nhật'}</strong></p>
                <p>Vai trò tài khoản (Role): <strong style="background: #e2e8f0; padding: 3px 10px; border-radius: 12px;">${sessionScope.account.role}</strong></p>
            </div>
        </div>

        <p style="margin-bottom: 25px; color: #555;">Đây là trang chủ của project sau khi đăng nhập thành công. Giao diện được quản lý đồng bộ bởi <strong>SiteMesh 3</strong>.</p>

        <div style="display: flex; gap: 12px; flex-wrap: wrap;">
            <a href="${pageContext.request.contextPath}/profile" style="display: inline-block; padding: 11px 22px; background: #1a73e8; color: white; text-decoration: none; border-radius: 6px; font-weight: bold;">
                👤 Chỉnh sửa hồ sơ cá nhân (Profile)
            </a>

            <c:if test="${sessionScope.account.role == 'ADMIN' || sessionScope.account.roleId == 1}">
                <a href="${pageContext.request.contextPath}/admin/category/list" style="display: inline-block; padding: 11px 22px; background: #28a745; color: white; text-decoration: none; border-radius: 6px; font-weight: bold;">
                    📦 Quản lý Category (JPA CRUD)
                </a>
            </c:if>

            <a href="${pageContext.request.contextPath}/logout" style="display: inline-block; padding: 11px 22px; background: #dc3545; color: white; text-decoration: none; border-radius: 6px; font-weight: bold;">
                🚪 Đăng xuất
            </a>
        </div>
    </div>

</body>
</html>