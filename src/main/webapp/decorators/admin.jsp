<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="reqUri" value="${pageContext.request.servletPath}" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - Admin Dashboard</title>
    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f6f9;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .admin-brand {
            font-weight: 700;
            letter-spacing: -0.5px;
        }
        .user-avatar {
            width: 32px;
            height: 32px;
            object-fit: cover;
            border-radius: 50%;
            border: 2px solid #fff;
        }
        .footer-admin {
            background-color: #ffffff;
            border-top: 1px solid #dee2e6;
            margin-top: auto;
        }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>

    <!-- Bootstrap 5 Dark Header Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm sticky-top">
        <div class="container">
            <a class="navbar-brand admin-brand d-flex align-items-center gap-2 text-warning fw-bold" href="${pageContext.request.contextPath}/admin/category/list">
                <i class="bi bi-speedometer2 fs-4"></i> Trang Quản Trị (Admin Panel)
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbarContent" aria-controls="adminNavbarContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="adminNavbarContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 fw-medium">
                    <li class="nav-item">
                        <a class="nav-link ${reqUri == '/home' || reqUri == '/' ? 'text-white fw-bold active' : 'text-white-50'}" href="${pageContext.request.contextPath}/home">
                            <i class="bi bi-house-door me-1 ${reqUri == '/home' || reqUri == '/' ? 'text-warning' : ''}"></i> Trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${reqUri.startsWith('/product') ? 'text-white fw-bold active' : 'text-white-50'}" href="${pageContext.request.contextPath}/product">
                            <i class="bi bi-grid me-1 ${reqUri.startsWith('/product') ? 'text-warning' : ''}"></i> Sản phẩm
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${reqUri.startsWith('/profile') ? 'text-white fw-bold active' : 'text-white-50'}" href="${pageContext.request.contextPath}/profile">
                            <i class="bi bi-person me-1 ${reqUri.startsWith('/profile') ? 'text-warning' : ''}"></i> Hồ sơ cá nhân
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${reqUri.startsWith('/admin/category') ? 'text-white fw-bold active' : 'text-white-50'}" href="${pageContext.request.contextPath}/admin/category/list">
                            <i class="bi bi-folder-check me-1 ${reqUri.startsWith('/admin/category') ? 'text-warning' : ''}"></i> Quản lý Category
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${reqUri.startsWith('/admin/product') ? 'text-white fw-bold active' : 'text-white-50'}" href="${pageContext.request.contextPath}/admin/product/list">
                            <i class="bi bi-box-seam me-1 ${reqUri.startsWith('/admin/product') ? 'text-warning' : ''}"></i> Quản lý Sản phẩm
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${reqUri.startsWith('/admin/user') ? 'text-white fw-bold active' : 'text-white-50'}" href="${pageContext.request.contextPath}/admin/user/list">
                            <i class="bi bi-people me-1 ${reqUri.startsWith('/admin/user') ? 'text-warning' : ''}"></i> Quản lý Tài khoản
                        </a>
                    </li>
                </ul>

                <!-- Admin Info & Logout -->
                <div class="d-flex align-items-center gap-3">
                    <div class="d-flex align-items-center gap-2 bg-secondary bg-opacity-25 px-3 py-1 rounded-pill text-white border border-secondary">
                        <c:choose>
                            <c:when test="${not empty sessionScope.account.images}">
                                <c:choose>
                                    <c:when test="${sessionScope.account.images.startsWith('http')}">
                                        <img src="${sessionScope.account.images}" alt="avatar" class="user-avatar" />
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/image?fname=${sessionScope.account.images}" alt="avatar" class="user-avatar" />
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <img src="https://via.placeholder.com/32?text=A" alt="avatar" class="user-avatar" />
                            </c:otherwise>
                        </c:choose>
                        <span class="small fw-semibold text-light">${sessionScope.account.fullName}</span>
                        <span class="badge bg-danger rounded-pill">${sessionScope.account.role}</span>
                    </div>

                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm rounded-pill px-3 shadow-sm">
                        <i class="bi bi-box-arrow-right me-1"></i> Đăng xuất
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <main class="container my-4">
        <sitemesh:write property='body'/>
    </main>



    <!-- Bootstrap 5.3.3 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>