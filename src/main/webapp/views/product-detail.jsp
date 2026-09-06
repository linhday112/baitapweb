<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${product.name} - Chi Tiết Sản Phẩm</title>
</head>
<body>

    <div style="margin-bottom: 15px;">
        <a href="${pageContext.request.contextPath}/product" style="color: #1a73e8; text-decoration: none; font-weight: bold;">&larr; Quay lại danh sách sản phẩm</a>
    </div>

    <!-- Bài 4.4: Hiển thị chi tiết 01 sản phẩm -->
    <div style="background: white; border-radius: 10px; padding: 30px; box-shadow: 0 4px 15px rgba(0,0,0,0.06); display: flex; gap: 35px; flex-wrap: wrap;">
        <div style="flex: 1; min-width: 300px; max-width: 450px;">
            <img src="${product.getImageUrl(pageContext.request.contextPath)}" alt="${product.name}" style="width: 100%; border-radius: 8px; object-fit: cover; box-shadow: 0 2px 8px rgba(0,0,0,0.1);" />
        </div>

        <div style="flex: 1.5; min-width: 300px;">
            <span style="background: #e8f0fe; color: #1a73e8; padding: 4px 12px; border-radius: 15px; font-size: 13px; font-weight: bold; text-transform: uppercase;">
                ${product.category != null ? product.category.name : 'Chưa xếp danh mục'}
            </span>

            <h1 style="color: #2c3e50; margin: 15px 0 10px 0; font-size: 26px;">${product.name}</h1>

            <p style="color: #e74c3c; font-size: 28px; font-weight: bold; margin-bottom: 20px;">
                <fmt:formatNumber value="${product.price}" pattern="#,###" /> VNĐ
            </p>

            <div style="background: #f8fafc; padding: 15px; border-radius: 8px; margin-bottom: 20px;">
                <p style="margin-bottom: 8px;">Số lượng còn trong kho: <strong>${product.quantity}</strong> sản phẩm</p>
                <p style="margin-bottom: 8px;">Số lượng đã bán: <strong style="color: #27ae60;">${product.sold}</strong> sản phẩm</p>
                <p style="margin: 0; color: #666; font-size: 13px;">Ngày nhập hàng: <fmt:formatDate value="${product.createdAt}" pattern="dd/MM/yyyy HH:mm" /></p>
            </div>

            <h3 style="color: #2c3e50; font-size: 18px; margin-bottom: 10px;">Mô tả sản phẩm:</h3>
            <div style="line-height: 1.6; color: #444; font-size: 15px; margin-bottom: 25px;">
                <p>${product.description != null && !product.description.isBlank() ? product.description : 'Sản phẩm chính hãng với đầy đủ chế độ bảo hành.'}</p>
            </div>

            <div style="display: flex; gap: 15px;">
                <button style="padding: 12px 25px; background: #28a745; color: white; border: none; border-radius: 5px; font-size: 16px; font-weight: bold; cursor: pointer;">Thêm Vào Giỏ Hàng</button>
                <a href="${pageContext.request.contextPath}/home" style="padding: 12px 25px; background: #6c757d; color: white; text-decoration: none; border-radius: 5px; font-size: 16px; font-weight: bold;">Trở về Trang chủ</a>
            </div>
        </div>
    </div>

</body>
</html>