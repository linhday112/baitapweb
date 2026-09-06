package linh_room.controller;

import linh_room.model.User;
import linh_room.service.UserService;
import linh_room.service.UserServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Cookie;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getSession(false) != null
                && request.getSession(false).getAttribute("account") != null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username =
                request.getParameter("username");

        String password =
                request.getParameter("password");

        if (username == null || username.isBlank()
                || password == null || password.isBlank()) {
            request.setAttribute("alert", "Tài khoản và mật khẩu không được để trống.");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }

        try {
            User user = userService.login(username, password);

            if (user != null) {
                if (user.getStatus() != null && user.getStatus() == 0) {
                    request.setAttribute("alert", "Tài khoản của bạn chưa được kích hoạt. Vui lòng nhập mã OTP đã gửi qua email để kích hoạt!");
                    request.setAttribute("username", user.getUsername());
                    request.getRequestDispatcher("/views/verify-otp.jsp").include(request, response);
                    return;
                }

                request.getSession(true).setAttribute("account", user);
                request.getSession().setMaxInactiveInterval(30 * 60);

                if ("on".equals(request.getParameter("remember"))) {
                    Cookie cookie = new Cookie("rememberedUsername", user.getUsername());
                    cookie.setMaxAge(7 * 24 * 60 * 60);
                    cookie.setHttpOnly(true);
                    cookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
                    response.addCookie(cookie);
                }

                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                request.setAttribute("alert", "Tài khoản hoặc mật khẩu không chính xác.");
                request.getRequestDispatcher("/views/login.jsp").include(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("alert", "Lỗi kết nối CSDL MySQL! Vui lòng đảm bảo MySQL Server (Dịch vụ MySQL80) đang chạy.");
            request.getRequestDispatcher("/views/login.jsp").include(request, response);
        }
    }
}
