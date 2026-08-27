<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Danh mục (JPA)</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            margin: 30px;
            background-color: #f4f6f9;
            color: #333;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }
        h1 {
            color: #2c3e50;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
        }
        .actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .btn {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
            cursor: pointer;
            border: none;
        }
        .btn-primary { background: #3498db; color: #fff; }
        .btn-primary:hover { background: #2980b9; }
        .btn-danger { background: #e74c3c; color: #fff; }
        .btn-danger:hover { background: #c0392b; }
        .btn-secondary { background: #95a5a6; color: #fff; }
        .btn-secondary:hover { background: #7f8c8d; }
        .search-box {
            display: flex;
            gap: 8px;
        }
        .search-box input {
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 250px;
        }
        .alert {
            padding: 12px;
            border-radius: 4px;
            margin-bottom: 15px;
        }
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-danger { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f8f9fa;
            color: #495057;
        }
        tr:hover { background-color: #f1f7fe; }
        .img-thumb {
            width: 55px;
            height: 55px;
            object-fit: cover;
            border-radius: 4px;
            border: 1px solid #ddd;
            display: block;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Quản lý Danh mục (Category - JPA)</h1>

    <c:if test="${param.msg == 'added'}">
        <div class="alert alert-success">Thêm danh mục mới thành công!</div>
    </c:if>
    <c:if test="${param.msg == 'updated'}">
        <div class="alert alert-success">Cập nhật danh mục thành công!</div>
    </c:if>
    <c:if test="${param.msg == 'deleted'}">
        <div class="alert alert-success">Đã xóa danh mục thành công!</div>
    </c:if>
    <c:if test="${param.error != null}">
        <div class="alert alert-danger">Thao tác không thành công hoặc xảy ra lỗi!</div>
    </c:if>

    <div class="actions">
        <div>
            <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-primary">+ Thêm Danh mục</a>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary">Về Trang chủ</a>
        </div>
        <form action="${pageContext.request.contextPath}/admin/category/list" method="get" class="search-box">
            <input type="text" name="keyword" value="<c:out value='${keyword}'/>" placeholder="Tìm kiếm tên danh mục..." />
            <button type="submit" class="btn btn-primary">Tìm</button>
            <c:if test="${not empty keyword}">
                <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-secondary">Tất cả</a>
            </c:if>
        </form>
    </div>

    <table>
        <thead>
            <tr>
                <th style="width: 50px;">STT</th>
                <th style="width: 70px;">Hình ảnh</th>
                <th>Tên Danh mục</th>
                <th style="width: 150px; text-align: center;">Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty categories}">
                    <tr>
                        <td colspan="4" style="text-align: center; color: #888; padding: 25px;">
                            Không có danh mục nào.
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${categories}" var="cat" varStatus="loop">
                        <tr>
                            <td>${loop.count}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${empty cat.icon}">
                                        <img src="https://via.placeholder.com/55?text=No+Img" alt="no icon" class="img-thumb" />
                                    </c:when>
                                    <c:when test="${cat.icon.startsWith('http://') or cat.icon.startsWith('https://')}">
                                        <img src="<c:out value='${cat.icon}'/>" alt="icon" class="img-thumb" onerror="this.src='https://via.placeholder.com/55?text=No+Img';" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:url value="/image?fname=${cat.icon}" var="imgUrl" />
                                        <img src="${imgUrl}" alt="icon" class="img-thumb" onerror="this.src='https://via.placeholder.com/55?text=No+Img';" />
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><strong><c:out value="${cat.name}" /></strong></td>
                            <td style="text-align: center;">
                                <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cat.id}" class="btn btn-primary" style="padding: 4px 10px; font-size: 12px;">Sửa</a>
                                <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cat.id}" 
                                   class="btn btn-danger" 
                                   style="padding: 4px 10px; font-size: 12px;"
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục \'${cat.name}\' không?');">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</div>
</body>
</html>