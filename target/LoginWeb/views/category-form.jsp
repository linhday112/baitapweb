<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${category == null or category.id == 0 ? 'Thêm mới' : 'Chỉnh sửa'} Danh mục</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            margin: 30px;
            background-color: #f4f6f9;
            color: #333;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: #fff;
            padding: 25px 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }
        h1 {
            color: #2c3e50;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 18px;
        }
        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #495057;
        }
        input[type="text"], input[type="file"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        input[type="text"]:focus {
            border-color: #3498db;
            outline: none;
        }
        .alert-danger {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
            padding: 12px;
            border-radius: 4px;
            margin-bottom: 18px;
        }
        .btn-group {
            margin-top: 25px;
            display: flex;
            gap: 10px;
        }
        .btn {
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
            cursor: pointer;
            border: none;
        }
        .btn-primary { background: #3498db; color: #fff; }
        .btn-primary:hover { background: #2980b9; }
        .btn-secondary { background: #95a5a6; color: #fff; }
        .btn-secondary:hover { background: #7f8c8d; }
        .current-img {
            margin-top: 8px;
            width: 80px;
            height: 80px;
            object-fit: cover;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>${category == null or category.id == 0 ? 'Thêm mới' : 'Chỉnh sửa'} Danh mục</h1>

    <c:if test="${not empty error}">
        <div class="alert-danger"><c:out value="${error}" /></div>
    </c:if>

    <form method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${category != null ? category.id : 0}" />

        <div class="form-group">
            <label for="name">Tên danh mục <span style="color:red;">*</span>:</label>
            <input type="text" id="name" name="name" value="<c:out value='${category != null ? category.name : ""}'/>" required placeholder="Nhập tên danh mục..." />
        </div>

        <div class="form-group">
            <label for="iconFile">Chọn tệp hình ảnh (Upload File):</label>
            <input type="file" id="iconFile" name="iconFile" accept="image/*" />
        </div>

        <div class="form-group">
            <label for="icon">Hoặc nhập URL hình ảnh:</label>
            <input type="text" id="icon" name="icon" value="<c:out value='${category != null ? category.icon : ""}'/>" placeholder="https://example.com/image.png" />
            <c:if test="${not empty category.icon}">
                <div style="margin-top: 6px;">
                    <small style="color: #666;">Hình ảnh hiện tại:</small><br/>
                    <c:choose>
                        <c:when test="${category.icon.startsWith('http://') or category.icon.startsWith('https://')}">
                            <img src="<c:out value='${category.icon}'/>" alt="Current image" class="current-img" />
                        </c:when>
                        <c:otherwise>
                            <c:url value="/image?fname=${category.icon}" var="imgUrl" />
                            <img src="${imgUrl}" alt="Current image" class="current-img" />
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
        </div>

        <div class="btn-group">
            <button type="submit" class="btn btn-primary">Lưu Danh mục</button>
            <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-secondary">Hủy bỏ</a>
        </div>
    </form>
</div>
</body>
</html>