<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f8f9fa;
        }
        .register-container {
            width: 360px;
            margin: 0 auto;
            padding: 30px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        .alert {
            color: #b00020;
            margin-bottom: 15px;
        }
        .links {
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="register-container">
    <h2>Đăng ký tài khoản</h2>

    <c:if test="${not empty alert}">
        <p class="alert">${alert}</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post">
        <div class="form-group">
            <label>Họ và tên:</label>
            <input type="text" name="fullName" value="${fullName}" placeholder="Nhập họ và tên...">
        </div>

        <div class="form-group">
            <label>Tên đăng nhập (*):</label>
            <input type="text" name="username" value="${username}" required placeholder="Nhập username...">
        </div>

        <div class="form-group">
            <label>Mật khẩu (*):</label>
            <input type="password" name="password" required placeholder="Nhập mật khẩu...">
        </div>

        <div class="form-group">
            <label>Xác nhận mật khẩu (*):</label>
            <input type="password" name="repassword" required placeholder="Nhập lại mật khẩu...">
        </div>

        <button type="submit">Đăng ký</button>
    </form>

    <div class="links">
        <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập tại đây</a></p>
    </div>
</div>

</body>
</html>
