<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quên Mật Khẩu</title>
</head>

<body style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f4f6f9; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0;">

    <div style="background: white; padding: 35px 40px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); width: 100%; max-width: 400px;">
        <h2 style="text-align: center; color: #1a73e8; margin-bottom: 15px;">Quên Mật Khẩu</h2>
        <p style="text-align: center; color: #666; font-size: 14px; margin-bottom: 20px;">Nhập Tên đăng nhập hoặc Email đăng ký của bạn để nhận mã OTP khôi phục mật khẩu qua Email.</p>

        <c:if test="${not empty alert}">
            <p style="color: #dc3545; background: #fde8e8; padding: 10px; border-radius: 5px; text-align: center; font-size: 14px;">${alert}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/forgot-password" method="post">
            <div style="margin-bottom: 22px;">
                <label style="display: block; margin-bottom: 6px; font-weight: 500;">Tên đăng nhập hoặc Email:</label>
                <input type="text" name="accountInput" value="${accountInput}" placeholder="Username hoặc Email..." style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box;" required />
            </div>

            <button type="submit" style="width: 100%; padding: 12px; background: #1a73e8; color: white; border: none; border-radius: 5px; font-size: 16px; font-weight: bold; cursor: pointer;">Gửi Mã OTP Khôi Phục</button>
        </form>

        <div style="text-align: center; margin-top: 20px; font-size: 14px;">
            Nhớ mật khẩu? <a href="${pageContext.request.contextPath}/login" style="color: #1a73e8; text-decoration: none; font-weight: bold;">Đăng nhập tại đây</a>
        </div>
    </div>

</body>
</html>