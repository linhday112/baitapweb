<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Sản Phẩm - Admin Panel</title>
</head>
<body>

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
        <h2 style="color: #2c3e50; margin: 0;">Quản Lý Sản Phẩm</h2>
        <a href="${pageContext.request.contextPath}/admin/product/add" style="padding: 10px 20px; background: #27ae60; color: white; text-decoration: none; border-radius: 5px; font-weight: bold;">+ Thêm Sản Phẩm Mới</a>
    </div>

    <!-- Thông báo kết quả -->
    <c:if test="${param.msg == 'added'}">
        <p style="background: #d4edda; color: #155724; padding: 12px; border-radius: 5px; font-weight: 500;">Thêm sản phẩm thành công!</p>
    </c:if>
    <c:if test="${param.msg == 'updated'}">
        <p style="background: #cce5ff; color: #004085; padding: 12px; border-radius: 5px; font-weight: 500;">Cập nhật sản phẩm thành công!</p>
    </c:if>
    <c:if test="${param.msg == 'deleted'}">
        <p style="background: #e2e3e5; color: #383d41; padding: 12px; border-radius: 5px; font-weight: 500;">Đã xóa sản phẩm thành công!</p>
    </c:if>

    <!-- Ô tìm kiếm -->
    <form action="${pageContext.request.contextPath}/admin/product/list" method="get" style="margin-bottom: 20px; display: flex; gap: 10px;">
        <input type="text" name="keyword" value="${keyword}" placeholder="Tìm kiếm sản phẩm theo tên..." style="padding: 10px; border: 1px solid #ccc; border-radius: 5px; width: 300px;" />
        <button type="submit" style="padding: 10px 20px; background: #2980b9; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: bold;">Tìm kiếm</button>
        <c:if test="${not empty keyword}">
            <a href="${pageContext.request.contextPath}/admin/product/list" style="padding: 10px 15px; background: #95a5a6; color: white; text-decoration: none; border-radius: 5px;">Hủy tìm kiếm</a>
        </c:if>
    </form>

    <!-- Bảng danh sách sản phẩm (Bài 4.1) -->
    <table style="width: 100%; border-collapse: collapse; background: white; box-shadow: 0 2px 10px rgba(0,0,0,0.05); border-radius: 8px; overflow: hidden;">
        <thead>
            <tr style="background-color: #1a73e8; color: white; text-align: left;">
                <th style="padding: 12px 15px; width: 60px;">ID</th>
                <th style="padding: 12px 15px; width: 90px;">Hình ảnh</th>
                <th style="padding: 12px 15px;">Tên sản phẩm</th>
                <th style="padding: 12px 15px;">Danh mục</th>
                <th style="padding: 12px 15px;">Giá bán</th>
                <th style="padding: 12px 15px; width: 90px;">Số lượng</th>
                <th style="padding: 12px 15px; width: 90px;">Đã bán</th>
                <th style="padding: 12px 15px; width: 160px; text-align: center;">Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty products}">
                    <c:forEach var="p" items="${products}">
                        <tr style="border-bottom: 1px solid #eee;">
                            <td style="padding: 12px 15px; font-weight: bold;">${p.id}</td>
                            <td style="padding: 12px 15px;">
                                <img src="${p.getImageUrl(pageContext.request.contextPath)}" alt="${p.name}" style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;" />
                            </td>
                            <td style="padding: 12px 15px; font-weight: 500; color: #2c3e50;">${p.name}</td>
                            <td style="padding: 12px 15px; color: #16a085;">${p.category != null ? p.category.name : 'Chưa chọn'}</td>
                            <td style="padding: 12px 15px; font-weight: bold; color: #e74c3c;">
                                <fmt:formatNumber value="${p.price}" pattern="#,###" /> VNĐ
                            </td>
                            <td style="padding: 12px 15px; text-align: center;">${p.quantity}</td>
                            <td style="padding: 12px 15px; text-align: center; color: #27ae60; font-weight: bold;">${p.sold}</td>
                            <td style="padding: 12px 15px; text-align: center;">
                                <a href="${pageContext.request.contextPath}/admin/product/edit?id=${p.id}" style="padding: 6px 12px; background: #f39c12; color: white; text-decoration: none; border-radius: 4px; font-size: 13px; font-weight: bold; margin-right: 5px;">Sửa</a>
                                <a href="${pageContext.request.contextPath}/admin/product/delete?id=${p.id}" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');" style="padding: 6px 12px; background: #e74c3c; color: white; text-decoration: none; border-radius: 4px; font-size: 13px; font-weight: bold;">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="8" style="padding: 25px; text-align: center; color: #888;">Chưa có sản phẩm nào.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

</body>
</html>