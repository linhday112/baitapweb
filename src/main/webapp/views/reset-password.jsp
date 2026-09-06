<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt Lại Mật Khẩu</title>
</head>

<body style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f4f6f9; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; padding: 20px 0;">

    <div style="background: white; padding: 35px 40px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); width: 100%; max-width: 400px;">
        <h2 style="text-align: center; color: #1a73e8; margin-bottom: 15px;">Đặt Lại Mật Khẩu</h2>
        <p style="text-align: center; color: #666; font-size: 14px; margin-bottom: 20px;">Mã OTP đã được gửi đến email của bạn. Vui lòng nhập mã OTP và mật khẩu mới.</p>

        <c:if test="${not empty alert}">
            <p style="color: #dc3545; background: #fde8e8; padding: 10px; border-radius: 5px; text-align: center; font-size: 14px;">${alert}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/reset-password" method="post">
            <div style="margin-bottom: 16px;">
                <label style="display: block; margin-bottom: 6px; font-weight: 500;">Tên đăng nhập:</label>
                <input type="text" name="username" value="${username}" style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box;" required />
            </div>

            <div style="margin-bottom: 16px;">
                <label style="display: block; margin-bottom: 6px; font-weight: 500;">Mã OTP 6 chữ số:</label>
                <input type="text" name="otp" placeholder="VD: 123456" maxlength="6" style="width: 100%; padding: 10px; border: 2px solid #1a73e8; border-radius: 5px; font-size: 18px; text-align: center; letter-spacing: 3px; box-sizing: border-box;" required />
            </div>

            <div style="margin-bottom: 16px;">
                <label style="display: block; margin-bottom: 6px; font-weight: 500;">Mật khẩu mới:</label>
                <input type="password" name="newPassword" style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box;" required />
            </div>

            <div style="margin-bottom: 22px;">
                <label style="display: block; margin-bottom: 6px; font-weight: 500;">Xác nhận mật khẩu mới:</label>
                <input type="password" name="confirmPassword" style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box;" required />
            </div>

            <button type="submit" style="width: 100%; padding: 12px; background: #28a745; color: white; border: none; border-radius: 5px; font-size: 16px; font-weight: bold; cursor: pointer;">Đổi Mật Khẩu</button>
        </form>

        <div style="text-align: center; margin-top: 20px; font-size: 14px;">
            <a href="${pageContext.request.contextPath}/login" style="color: #1a73e8; text-decoration: none;">Quay lại Đăng nhập</a>
        </div>
    </div>

</body>
</html>