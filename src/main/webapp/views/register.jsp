<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản</title>
</head>

<body style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f4f6f9; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; padding: 20px 0;">

    <div style="background: white; padding: 35px 40px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); width: 100%; max-width: 420px;">
        <h2 style="text-align: center; color: #1a73e8; margin-bottom: 25px;">Đăng Ký Tài Khoản</h2>

        <c:if test="${not empty alert}">
            <p style="color: #dc3545; background: #fde8e8; padding: 10px; border-radius: 5px; text-align: center; font-size: 14px;">${alert}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div style="margin-bottom: 16px;">
                <label style="display: block; margin-bottom: 6px; font-weight: 500;">Tên đăng nhập (*):</label>
                <input type="text" name="username" value="${username}" style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box;" required />
            </div>

            <div style="margin-bottom: 16px;">
                <label style="display: block; margin-bottom: 6px; font-weight: 500;">Họ và tên:</label>
                <input type="text" name="fullName" value="${fullName}" style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box;" />
            </div>

            <div style="margin-bottom: 16px;">
                <label style="display: block; margin-bottom: 6px; font-weight: 500;">Email (để nhận mã OTP kích hoạt):</label>
                <input type="email" name="email" value="${email}" placeholder="user@gmail.com" style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box;" required />
            </div>

            <div style="margin-bottom: 16px;">
                <label style="display: block; margin-bottom: 6px; font-weight: 500;">Mật khẩu (*):</label>
                <input type="password" name="password" style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box;" required />
            </div>

            <div style="margin-bottom: 22px;">
                <label style="display: block; margin-bottom: 6px; font-weight: 500;">Xác nhận mật khẩu (*):</label>
                <input type="password" name="repassword" style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box;" required />
            </div>

            <button type="submit" style="width: 100%; padding: 12px; background: #28a745; color: white; border: none; border-radius: 5px; font-size: 16px; font-weight: bold; cursor: pointer;">Đăng Ký &amp; Nhận Mã OTP</button>
        </form>

        <div style="text-align: center; margin-top: 20px; font-size: 14px;">
            Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" style="color: #1a73e8; text-decoration: none; font-weight: bold;">Đăng nhập ngay</a>
        </div>
    </div>

</body>
</html>