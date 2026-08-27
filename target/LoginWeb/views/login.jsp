<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>

<body>

    <h1>Đăng nhập</h1>

    <p style="color: #b00020;">${alert}</p>

    <form action="${pageContext.request.contextPath}/login"
          method="post">

        <div>
            <label>Username:</label>
            <input type="text" name="username">
        </div>

        <br>

        <label>
            <input type="checkbox" name="remember">
            Ghi nhớ đăng nhập bằng Cookie trong 7 ngày
        </label>

        <br><br>

        <div>
            <label>Password:</label>
            <input type="password" name="password">
        </div>

        <br>

        <button type="submit">
            Login
        </button>

    </form>

</body>
</html>
