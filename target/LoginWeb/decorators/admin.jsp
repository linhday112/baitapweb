<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - Quản Trị Hệ Thống</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f9;
            color: #333;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .admin-navbar {
            background-color: #2c3e50;
            color: white;
            padding: 12px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        }
        .admin-navbar-brand {
            font-size: 20px;
            font-weight: bold;
            color: #ecf0f1;
            text-decoration: none;
        }
        .admin-menu {
            display: flex;
            align-items: center;
            gap: 16px;
            list-style: none;
        }
        .admin-menu a {
            color: #bdc3c7;
            text-decoration: none;
            font-size: 15px;
            padding: 6px 12px;
            border-radius: 4px;
        }
        .admin-menu a:hover {
            color: #fff;
            background-color: #34495e;
        }
        .admin-container {
            flex: 1;
            max-width: 1100px;
            width: 100%;
            margin: 25px auto;
            padding: 0 20px;
        }
        .admin-footer {
            background-color: #ffffff;
            border-top: 1px solid #e0e0e0;
            text-align: center;
            padding: 15px 20px;
            font-size: 13px;
            color: #777;
            margin-top: auto;
        }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>

    <header class="admin-navbar">
        <a href="${pageContext.request.contextPath}/admin/category/list" class="admin-navbar-brand">
            🛡️ Trang Quản Trị (Admin Panel)
        </a>

        <ul class="admin-menu">
            <li><a href="${pageContext.request.contextPath}/home">🏠 Trang chủ</a></li>
            <li><a href="${pageContext.request.contextPath}/profile">👤 Profile</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/category/list">📦 Quản lý Category</a></li>
            <li><a href="${pageContext.request.contextPath}/logout" style="background: #e74c3c; color: white;">Đăng xuất</a></li>
        </ul>
    </header>

    <main class="admin-container">
        <sitemesh:write property='body'/>
    </main>

    <footer class="admin-footer">
        <p>&copy; 2026 Admin Dashboard - SiteMesh Layout Management.</p>
    </footer>

</body>
</html>