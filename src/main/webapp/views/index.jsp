<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
</head>

<body>

    <h1>Chào mừng đến với Login Web</h1>

    <p>Xin chào ${sessionScope.account.fullName}.</p>

    <p>Đây là trang chủ của project.</p>

    <a href="${pageContext.request.contextPath}/login">
        login
    </a>

    <p>
        <a href="${pageContext.request.contextPath}/admin/category/list">Quản lý Category (JPA CRUD)</a>
        | <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
    </p>

</body>
</html>
