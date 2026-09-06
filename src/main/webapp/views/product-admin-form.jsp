<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${product != null && product.id > 0 ? 'Chỉnh Sửa Sản Phẩm' : 'Thêm Sản Phẩm Mới'}</title>
</head>
<body>

    <div style="max-width: 650px; margin: 0 auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.08);">
        <h2 style="color: #2c3e50; margin-bottom: 20px; border-bottom: 2px solid #eee; padding-bottom: 10px;">
            ${product != null && product.id > 0 ? 'Chỉnh Sửa Sản Phẩm' : 'Thêm Sản Phẩm Mới'}
        </h2>

        <c:if test="${not empty error}">
            <p style="color: #721c24; background: #f8d7da; padding: 10px; border-radius: 4px; font-size: 14px;">${error}</p>
        </c:if>

        <form action="${product != null && product.id > 0 ? pageContext.request.contextPath.concat('/admin/product/edit') : pageContext.request.contextPath.concat('/admin/product/add')}"
              method="post" enctype="multipart/form-data">

            <input type="hidden" name="id" value="${product.id}" />

            <div style="margin-bottom: 18px;">
                <label style="display: block; font-weight: bold; margin-bottom: 6px;">Tên sản phẩm (*):</label>
                <input type="text" name="name" value="${product.name}" style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;" required />
            </div>

            <div style="margin-bottom: 18px;">
                <label style="display: block; font-weight: bold; margin-bottom: 6px;">Danh mục sản phẩm:</label>
                <select name="categoryId" style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;">
                    <option value="">-- Chọn danh mục --</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.id}" ${product != null && product.category != null && product.category.id == cat.id ? 'selected' : ''}>
                            ${cat.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div style="display: flex; gap: 15px; margin-bottom: 18px;">
                <div style="flex: 1;">
                    <label style="display: block; font-weight: bold; margin-bottom: 6px;">Giá bán (VNĐ):</label>
                    <input type="number" name="price" value="${product.price}" step="1000" style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;" required />
                </div>
                <div style="flex: 1;">
                    <label style="display: block; font-weight: bold; margin-bottom: 6px;">Số lượng tồn kho:</label>
                    <input type="number" name="quantity" value="${product.quantity}" style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;" required />
                </div>
                <div style="flex: 1;">
                    <label style="display: block; font-weight: bold; margin-bottom: 6px;">Số lượng đã bán:</label>
                    <input type="number" name="sold" value="${product != null ? product.sold : 0}" min="0" style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;" required />
                </div>
            </div>

            <div style="margin-bottom: 18px;">
                <label style="display: block; font-weight: bold; margin-bottom: 6px;">Mô tả sản phẩm:</label>
                <textarea name="description" rows="4" style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;">${product.description}</textarea>
            </div>

            <div style="margin-bottom: 22px;">
                <label style="display: block; font-weight: bold; margin-bottom: 6px;">Chọn file ảnh sản phẩm (Upload Multipart):</label>
                <input type="file" name="imageFile" accept="image/*" style="display: block; margin-bottom: 8px;" />

                <label style="display: block; font-size: 13px; color: #666; margin-top: 6px;">Hoặc nhập URL hình ảnh:</label>
                <input type="text" name="imageUrl" value="${product.images}" placeholder="https://..." style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;" />

                <c:if test="${not empty product.images}">
                    <div style="margin-top: 10px;">
                        <p style="font-size: 13px; color: #666;">Ảnh hiện tại:</p>
                        <img src="${product.getImageUrl(pageContext.request.contextPath)}" alt="Current Image" style="width: 100px; height: 100px; object-fit: cover; border-radius: 4px; border: 1px solid #ddd;" />
                    </div>
                </c:if>
            </div>

            <div style="display: flex; gap: 10px;">
                <button type="submit" style="padding: 12px 25px; background: #27ae60; color: white; border: none; border-radius: 4px; font-weight: bold; cursor: pointer;">Lưu Sản Phẩm</button>
                <a href="${pageContext.request.contextPath}/admin/product/list" style="padding: 12px 20px; background: #7f8c8d; color: white; text-decoration: none; border-radius: 4px;">Hủy bỏ</a>
            </div>
        </form>
    </div>

</body>
</html>