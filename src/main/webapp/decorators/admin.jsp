<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - Linh Room Admin</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            color: #333;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .navbar {
            background-color: #1a73e8;
            color: white;
            padding: 12px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        }
        .navbar-brand {
            font-size: 20px;
            font-weight: bold;
            color: #fff;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .navbar-menu {
            display: flex;
            align-items: center;
            gap: 18px;
            list-style: none;
        }
        .navbar-menu a {
            color: #e8f0fe;
            text-decoration: none;
            font-size: 15px;
            font-weight: 500;
            padding: 6px 12px;
            border-radius: 4px;
            transition: background 0.2s;
        }
        .navbar-menu a:hover {
            background-color: rgba(255,255,255,0.2);
            color: #fff;
        }
        .user-nav-box {
            display: flex;
            align-items: center;
            gap: 10px;
            background: rgba(255,255,255,0.12);
            padding: 4px 12px 4px 6px;
            border-radius: 20px;
        }
        .nav-avatar {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid white;
            background: #fff;
        }
        .role-badge {
            font-size: 11px;
            padding: 2px 7px;
            border-radius: 10px;
            background: #fbbc04;
            color: #202124;
            font-weight: bold;
        }
        .main-container {
            flex: 1;
            max-width: 1000px;
            width: 100%;
            margin: 30px auto;
            padding: 0 20px;
        }
        .footer {
            background-color: #ffffff;
            border-top: 1px solid #e0e0e0;
            text-align: center;
            padding: 18px 20px;
            font-size: 14px;
            color: #666;
            margin-top: auto;
        }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>

    <header class="navbar">
        <a href="${pageContext.request.contextPath}/home" class="navbar-brand">
            <span>Linh Room Web</span>
        </a>

        <ul class="navbar-menu">
            <li><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
            <li><a href="${pageContext.request.contextPath}/product">Sản phẩm</a></li>
            <li><a href="${pageContext.request.contextPath}/profile">Hồ sơ cá nhân</a></li>

            <c:if test="${sessionScope.account.role == 'ADMIN' || sessionScope.account.roleId == 1}">
                <li><a href="${pageContext.request.contextPath}/admin/category/list">Quản lý Category</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/product/list">Quản lý Sản phẩm</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/user/list">Quản lý Tài khoản</a></li>
            </c:if>

            <li class="user-nav-box">
                <c:choose>
                    <c:when test="${not empty sessionScope.account.images}">
                        <c:choose>
                            <c:when test="${sessionScope.account.images.startsWith('http')}">
                                <img src="${sessionScope.account.images}" alt="avatar" class="nav-avatar" />
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/image?fname=${sessionScope.account.images}" alt="avatar" class="nav-avatar" />
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <img src="https://via.placeholder.com/34?text=U" alt="avatar" class="nav-avatar" />
                    </c:otherwise>
                </c:choose>

                <span>${sessionScope.account.fullName}</span>
                <span class="role-badge">${sessionScope.account.role}</span>
            </li>

            <li><a href="${pageContext.request.contextPath}/logout" style="background: #dc3545; color: white;">Đăng xuất</a></li>
        </ul>
    </header>

    <main class="main-container">
        <sitemesh:write property='body'/>
    </main>

    <footer class="footer">
        <p>&copy; 2026 <strong>Linh Room Project</strong>. Quản lý giao diện bằng <strong>SiteMesh 3</strong> &amp; CSDL MySQL bằng <strong>JPA / Hibernate</strong>.</p>
    </footer>

</body>
</html>