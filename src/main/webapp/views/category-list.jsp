<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Danh Mục - Admin Panel</title>
</head>
<body>

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
        <h2 style="color: #2c3e50; margin: 0; border-left: 4px solid #1a73e8; padding-left: 10px;">Quản Lý Danh Mục (Category)</h2>
        <a href="${pageContext.request.contextPath}/admin/category/add" style="padding: 10px 20px; background: #27ae60; color: white; text-decoration: none; border-radius: 5px; font-weight: bold;">+ Thêm Danh Mục Mới</a>
    </div>

    <!-- Thông báo kết quả -->
    <c:if test="${param.msg == 'added'}">
        <p style="background: #d4edda; color: #155724; padding: 12px; border-radius: 5px; font-weight: 500;">Thêm danh mục mới thành công!</p>
    </c:if>
    <c:if test="${param.msg == 'updated'}">
        <p style="background: #cce5ff; color: #004085; padding: 12px; border-radius: 5px; font-weight: 500;">Cập nhật danh mục thành công!</p>
    </c:if>
    <c:if test="${param.msg == 'deleted'}">
        <p style="background: #e2e3e5; color: #383d41; padding: 12px; border-radius: 5px; font-weight: 500;">Đã xóa danh mục thành công!</p>
    </c:if>
    <c:if test="${param.error != null}">
        <p style="background: #f8d7da; color: #721c24; padding: 12px; border-radius: 5px; font-weight: 500;">Thao tác không thành công hoặc xảy ra lỗi!</p>
    </c:if>

    <!-- Ô tìm kiếm -->
    <form action="${pageContext.request.contextPath}/admin/category/list" method="get" style="margin-bottom: 20px; display: flex; gap: 10px;">
        <input type="text" name="keyword" value="<c:out value='${keyword}'/>" placeholder="Tìm kiếm tên danh mục..." style="padding: 10px; border: 1px solid #ccc; border-radius: 5px; width: 300px;" />
        <button type="submit" style="padding: 10px 20px; background: #2980b9; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: bold;">Tìm kiếm</button>
        <c:if test="${not empty keyword}">
            <a href="${pageContext.request.contextPath}/admin/category/list" style="padding: 10px 15px; background: #95a5a6; color: white; text-decoration: none; border-radius: 5px;">Hủy tìm kiếm</a>
        </c:if>
    </form>

    <!-- Bảng danh sách danh mục -->
    <table style="width: 100%; border-collapse: collapse; background: white; box-shadow: 0 2px 10px rgba(0,0,0,0.05); border-radius: 8px; overflow: hidden;">
        <thead>
            <tr style="background-color: #1a73e8; color: white; text-align: left;">
                <th style="padding: 12px 15px; width: 60px;">STT</th>
                <th style="padding: 12px 15px; width: 80px;">Hình ảnh</th>
                <th style="padding: 12px 15px;">Tên Danh Mục</th>
                <th style="padding: 12px 15px; width: 160px; text-align: center;">Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty categories}">
                    <tr>
                        <td colspan="4" style="padding: 25px; text-align: center; color: #888;">Không có danh mục nào.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${categories}" var="cat" varStatus="loop">
                        <tr style="border-bottom: 1px solid #eee;">
                            <td style="padding: 12px 15px; font-weight: bold;">${loop.count}</td>
                            <td style="padding: 12px 15px;">
                                <c:choose>
                                    <c:when test="${empty cat.icon}">
                                        <img src="https://via.placeholder.com/45?text=No+Img" alt="no icon" style="width: 45px; height: 45px; object-fit: cover; border-radius: 4px; border: 1px solid #ddd;" />
                                    </c:when>
                                    <c:when test="${cat.icon.startsWith('http://') or cat.icon.startsWith('https://')}">
                                        <img src="<c:out value='${cat.icon}'/>" alt="icon" style="width: 45px; height: 45px; object-fit: cover; border-radius: 4px; border: 1px solid #ddd;" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:url value="/image?fname=${cat.icon}" var="imgUrl" />
                                        <img src="${imgUrl}" alt="icon" style="width: 45px; height: 45px; object-fit: cover; border-radius: 4px; border: 1px solid #ddd;" />
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td style="padding: 12px 15px; font-weight: 500; color: #2c3e50;"><c:out value="${cat.name}" /></td>
                            <td style="padding: 12px 15px; text-align: center;">
                                <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cat.id}" style="padding: 6px 12px; background: #f39c12; color: white; text-decoration: none; border-radius: 4px; font-size: 13px; font-weight: bold; margin-right: 5px;">Sửa</a>
                                <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cat.id}" 
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục \'${cat.name}\' không?');"
                                   style="padding: 6px 12px; background: #e74c3c; color: white; text-decoration: none; border-radius: 4px; font-size: 13px; font-weight: bold;">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

</body>
</html>