<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác Thực Mã OTP</title>
</head>

<body style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f4f6f9; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0;">

    <div style="background: white; padding: 35px 40px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); width: 100%; max-width: 400px;">
        <h2 style="text-align: center; color: #1a73e8; margin-bottom: 15px;">Kích Hoạt Tài Khoản (OTP)</h2>
        <p style="text-align: center; color: #666; font-size: 14px; margin-bottom: 20px;">Mã OTP xác thực 6 chữ số đã được gửi tới Email của bạn. Mã có hiệu lực trong 10 phút.</p>

        <c:if test="${not empty alert}">
            <p style="color: #dc3545; background: #fde8e8; padding: 10px; border-radius: 5px; text-align: center; font-size: 14px;">${alert}</p>
        </c:if>
        <c:if test="${not empty msg}">
            <p style="color: #28a745; background: #e8f8f0; padding: 10px; border-radius: 5px; text-align: center; font-size: 14px;">${msg}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/verify-otp" method="post">
            <div style="margin-bottom: 16px;">
                <label style="display: block; margin-bottom: 6px; font-weight: 500;">Tên đăng nhập:</label>
                <input type="text" name="username" value="${username}" style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box;" required />
            </div>

            <div style="margin-bottom: 22px;">
                <label style="display: block; margin-bottom: 6px; font-weight: 500;">Mã OTP 6 chữ số:</label>
                <input type="text" name="otp" placeholder="VD: 123456" maxlength="6" style="width: 100%; padding: 12px; border: 2px solid #1a73e8; border-radius: 5px; font-size: 20px; text-align: center; letter-spacing: 4px; box-sizing: border-box;" required />
            </div>

            <button type="submit" style="width: 100%; padding: 12px; background: #1a73e8; color: white; border: none; border-radius: 5px; font-size: 16px; font-weight: bold; cursor: pointer;">Kích Hoạt Tài Khoản</button>
        </form>

        <form action="${pageContext.request.contextPath}/verify-otp" method="post" style="margin-top: 15px;">
            <input type="hidden" name="username" value="${username}" />
            <input type="hidden" name="action" value="resend" />
            <button type="submit" style="width: 100%; padding: 10px; background: #6c757d; color: white; border: none; border-radius: 5px; font-size: 14px; cursor: pointer;">Gửi lại mã OTP qua Email</button>
        </form>

        <div style="text-align: center; margin-top: 20px; font-size: 14px;">
            <a href="${pageContext.request.contextPath}/login" style="color: #1a73e8; text-decoration: none;">Quay lại Đăng nhập</a>
        </div>

        <div style="text-align: center; margin-top: 15px; font-size: 13px; color: #666; border-top: 1px solid #eee; padding-top: 15px;">
            Nhập sai Email hoặc muốn thay đổi thông tin?
            <br>
            <a href="${pageContext.request.contextPath}/register?username=${username}" style="color: #1a73e8; text-decoration: none; font-weight: bold; display: inline-block; margin-top: 4px;">Quay lại chỉnh sửa thông tin đăng ký</a>
        </div>
    </div>

</body>
</html>