package linh_room.controller;

import linh_room.model.User;
import linh_room.service.UserService;
import linh_room.service.UserServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rePassword = request.getParameter("repassword");
        String fullName = request.getParameter("fullName");

        if (username == null || username.isBlank()
                || password == null || password.isBlank()) {
            request.setAttribute("alert", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu.");
            request.setAttribute("username", username);
            request.setAttribute("fullName", fullName);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        if (rePassword != null && !rePassword.equals(password)) {
            request.setAttribute("alert", "Mật khẩu xác nhận không khớp.");
            request.setAttribute("username", username);
            request.setAttribute("fullName", fullName);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        if (userService.checkExistUsername(username.trim())) {
            request.setAttribute("alert", "Tên đăng nhập '" + username + "' đã tồn tại.");
            request.setAttribute("fullName", fullName);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        User newUser = new User();
        newUser.setUsername(username.trim());
        newUser.setPassword(password.trim());
        newUser.setFullName((fullName != null && !fullName.isBlank()) ? fullName.trim() : username.trim());
        newUser.setRole("USER");
        newUser.setRoleId(2);

        try {
            boolean success = userService.register(newUser);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/login?msg=register_success");
            } else {
                request.setAttribute("alert", "Đăng ký không thành công. Vui lòng thử lại.");
                request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("alert", "Lỗi lưu dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
        }
    }
}
