<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ cá nhân</title>
    <style>
        .profile-card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.06);
            padding: 35px 40px;
            margin: 10px auto;
            max-width: 650px;
        }
        .profile-header {
            display: flex;
            align-items: center;
            gap: 25px;
            padding-bottom: 25px;
            border-bottom: 1px solid #edf2f7;
            margin-bottom: 25px;
        }
        .avatar-wrapper {
            position: relative;
            width: 110px;
            height: 110px;
            flex-shrink: 0;
        }
        .avatar-img {
            width: 110px;
            height: 110px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #1a73e8;
            box-shadow: 0 3px 8px rgba(0,0,0,0.12);
        }
        .profile-title h2 {
            font-size: 22px;
            color: #2d3748;
            margin-bottom: 5px;
        }
        .profile-title p {
            color: #718096;
            font-size: 14px;
        }
        .form-row {
            margin-bottom: 20px;
        }
        .form-row label {
            display: block;
            margin-bottom: 7px;
            font-weight: 600;
            color: #4a5568;
            font-size: 14px;
        }
        .form-control {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #cbd5e0;
            border-radius: 6px;
            font-size: 15px;
            transition: border-color 0.2s;
        }
        .form-control:focus {
            border-color: #1a73e8;
            outline: none;
            box-shadow: 0 0 0 3px rgba(26,115,232,0.15);
        }
        .form-control[readonly] {
            background-color: #f7fafc;
            color: #718096;
            cursor: not-allowed;
        }
        .alert {
            padding: 12px 16px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        .alert-success {
            background-color: #def7ec;
            color: #03543f;
            border: 1px solid #bcf0da;
        }
        .alert-danger {
            background-color: #fde8e8;
            color: #9b1c1c;
            border: 1px solid #fbd5d5;
        }
        .btn-group {
            display: flex;
            gap: 12px;
            margin-top: 25px;
        }
        .btn-primary {
            background-color: #1a73e8;
            color: white;
            padding: 11px 22px;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }
        .btn-primary:hover {
            background-color: #1557b0;
        }
        .btn-secondary {
            background-color: #edf2f7;
            color: #4a5568;
            padding: 11px 20px;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            font-weight: 500;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        .btn-secondary:hover {
            background-color: #e2e8f0;
        }
        .file-hint {
            font-size: 12px;
            color: #718096;
            margin-top: 4px;
        }
    </style>
</head>
<body>

<div class="profile-card">

    <c:if test="${param.msg == 'update_success'}">
        <div class="alert alert-success">
            ✅ <strong>Thành công!</strong> Thông tin cá nhân và ảnh đại diện đã được cập nhật.
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            ⚠️ ${error}
        </div>
    </c:if>

    <div class="profile-header">
        <div class="avatar-wrapper">
            <c:choose>
                <c:when test="${not empty user.images}">
                    <c:choose>
                        <c:when test="${user.images.startsWith('http')}">
                            <img src="${user.images}" alt="avatar" class="avatar-img" />
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/image?fname=${user.images}" alt="avatar" class="avatar-img" />
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="avatar" class="avatar-img" />
                </c:otherwise>
            </c:choose>
        </div>
        <div class="profile-title">
            <h2>${user.fullName}</h2>
            <p>Tên đăng nhập: <strong>${user.username}</strong> | Vai trò: <span style="background: #e2e8f0; padding: 2px 8px; border-radius: 10px; font-weight: bold;">${user.role}</span></p>
        </div>
    </div>

    <!-- Form cập nhật thông tin User với Multipart/form-data -->
    <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data">
        
        <div class="form-row">
            <label>Tên đăng nhập (Username):</label>
            <input type="text" class="form-control" value="${user.username}" readonly />
        </div>

        <div class="form-row">
            <label for="fullName">Họ và tên (Fullname):</label>
            <input type="text" id="fullName" name="fullName" class="form-control" value="${user.fullName}" required placeholder="Nhập họ và tên..." />
        </div>

        <div class="form-row">
            <label for="phone">Số điện thoại (Phone):</label>
            <input type="tel" id="phone" name="phone" class="form-control" value="${user.phone}" placeholder="Ví dụ: 0912345678" />
        </div>

        <div class="form-row">
            <label for="imageFile">Ảnh đại diện mới (Images):</label>
            <input type="file" id="imageFile" name="imageFile" class="form-control" accept="image/*" />
            <p class="file-hint">Định dạng hỗ trợ: JPG, PNG, WEBP, GIF. Kích thước tối đa 10MB.</p>
        </div>

        <div class="btn-group">
            <button type="submit" class="btn-primary">💾 Lưu thay đổi</button>
            <a href="${pageContext.request.contextPath}/home" class="btn-secondary">Quay lại Trang chủ</a>
        </div>

    </form>

</div>

</body>
</html>