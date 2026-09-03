<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>

<body>

    <h1>Đăng nhập</h1>

    <% if ("register_success".equals(request.getParameter("msg"))) { %>
        <p style="color: #28a745; font-weight: bold;">Đăng ký thành công! Vui lòng đăng nhập.</p>
    <% } %>

    <p style="color: #b00020;">${alert}</p>

    <form action="${pageContext.request.contextPath}/login"
          method="post">

        <div>
            <label>Username:</label>
            <input type="text" name="username" required>
        </div>

        <br>

        <label>
            <input type="checkbox" name="remember">
            Ghi nhớ đăng nhập bằng Cookie trong 7 ngày
        </label>

        <br><br>

        <div>
            <label>Password:</label>
            <input type="password" name="password" required>
        </div>

        <br>

        <button type="submit">
            Login
        </button>

    </form>

    <br>
    <div>
        Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký tại đây</a>
    </div>

</body>
</html>
