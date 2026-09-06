<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
</head>

<body style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f4f6f9; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0;">

    <div style="background: white; padding: 35px 40px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); width: 100%; max-width: 400px;">
        <h2 style="text-align: center; color: #1a73e8; margin-bottom: 25px;">Đăng Nhập Hệ Thống</h2>

        <c:if test="${param.msg == 'register_success'}">
            <p style="color: #28a745; background: #e8f8f0; padding: 10px; border-radius: 5px; text-align: center; font-size: 14px;">Đăng ký thành công! Vui lòng đăng nhập.</p>
        </c:if>
        <c:if test="${param.msg == 'activated'}">
            <p style="color: #28a745; background: #e8f8f0; padding: 10px; border-radius: 5px; text-align: center; font-size: 14px;">Kích hoạt tài khoản thành công! Bạn có thể đăng nhập ngay.</p>
        </c:if>
        <c:if test="${param.msg == 'reset_success'}">
            <p style="color: #28a745; background: #e8f8f0; padding: 10px; border-radius: 5px; text-align: center; font-size: 14px;">Đặt lại mật khẩu thành công! Vui lòng đăng nhập lại.</p>
        </c:if>

        <c:if test="${not empty alert}">
            <p style="color: #dc3545; background: #fde8e8; padding: 10px; border-radius: 5px; text-align: center; font-size: 14px;">${alert}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div style="margin-bottom: 18px;">
                <label style="display: block; margin-bottom: 6px; font-weight: 500;">Tên đăng nhập:</label>
                <input type="text" name="username" style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box;" required />
            </div>

            <div style="margin-bottom: 18px;">
                <label style="display: block; margin-bottom: 6px; font-weight: 500;">Mật khẩu:</label>
                <input type="password" name="password" style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box;" required />
            </div>

            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; font-size: 14px;">
                <label style="display: flex; align-items: center; gap: 6px; cursor: pointer;">
                    <input type="checkbox" name="remember" /> Ghi nhớ đăng nhập
                </label>
                <a href="${pageContext.request.contextPath}/forgot-password" style="color: #1a73e8; text-decoration: none;">Quên mật khẩu?</a>
            </div>

            <button type="submit" style="width: 100%; padding: 12px; background: #1a73e8; color: white; border: none; border-radius: 5px; font-size: 16px; font-weight: bold; cursor: pointer;">Đăng nhập</button>
        </form>

        <div style="text-align: center; margin-top: 20px; font-size: 14px;">
            Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" style="color: #1a73e8; text-decoration: none; font-weight: bold;">Đăng ký ngay</a>
        </div>
    </div>

</body>
</html>