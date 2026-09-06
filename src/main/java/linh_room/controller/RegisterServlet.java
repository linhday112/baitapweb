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
        String username = request.getParameter("username");
        if (username != null && !username.isBlank()) {
            User user = userService.get(username.trim());
            if (user != null) {
                request.setAttribute("username", user.getUsername());
                request.setAttribute("fullName", user.getFullName());
                request.setAttribute("email", user.getEmail());
            }
        }
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
        String email = request.getParameter("email");

        if (username == null || username.isBlank()
                || password == null || password.isBlank()) {
            request.setAttribute("alert", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu.");
            request.setAttribute("username", username);
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        if (rePassword != null && !rePassword.equals(password)) {
            request.setAttribute("alert", "Mật khẩu xác nhận không khớp.");
            request.setAttribute("username", username);
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        User existingUser = userService.get(username.trim());
        if (existingUser != null) {
            if (existingUser.getStatus() != null && existingUser.getStatus() == 1) {
                request.setAttribute("alert", "Tên đăng nhập '" + username + "' đã tồn tại.");
                request.setAttribute("fullName", fullName);
                request.setAttribute("email", email);
                request.getRequestDispatcher("/views/register.jsp").forward(request, response);
                return;
            } else {
                // Cập nhật lại thông tin đăng ký cho tài khoản chưa kích hoạt
                existingUser.setPassword(password.trim());
                existingUser.setFullName((fullName != null && !fullName.isBlank()) ? fullName.trim() : username.trim());
                existingUser.setEmail((email != null && !email.isBlank()) ? email.trim() : username.trim() + "@example.com");
                userService.update(existingUser);
                boolean sent = userService.generateAndSendOTP(existingUser, "Mã OTP Kích Hoạt Tài Khoản Linh Room", "Xác Thực Kích Hoạt Tài Khoản");
                if (sent) {
                    response.sendRedirect(request.getContextPath() + "/verify-otp?username=" + existingUser.getUsername() + "&msg=otp_sent");
                } else {
                    request.setAttribute("alert", "Không thể gửi OTP. Vui lòng kiểm tra email và thử lại.");
                    request.setAttribute("username", existingUser.getUsername());
                    request.setAttribute("fullName", existingUser.getFullName());
                    request.setAttribute("email", existingUser.getEmail());
                    request.getRequestDispatcher("/views/register.jsp").forward(request, response);
                }
                return;
            }
        }

        User newUser = new User();
        newUser.setUsername(username.trim());
        newUser.setPassword(password.trim());
        newUser.setFullName((fullName != null && !fullName.isBlank()) ? fullName.trim() : username.trim());
        newUser.setEmail((email != null && !email.isBlank()) ? email.trim() : username.trim() + "@example.com");
        newUser.setRole("USER");
        newUser.setRoleId(2);
        newUser.setStatus(0); // 0: Chờ kích hoạt qua OTP

        try {
            boolean success = userService.register(newUser);
            if (success) {
                // Gửi mã OTP xác nhận
                boolean sent = userService.generateAndSendOTP(newUser, "Mã OTP Kích Hoạt Tài Khoản Linh Room", "Xác Thực Kích Hoạt Tài Khoản");
                if (sent) {
                    response.sendRedirect(request.getContextPath() + "/verify-otp?username=" + newUser.getUsername() + "&msg=otp_sent");
                } else {
                    request.setAttribute("alert", "Tài khoản đã được tạo nhưng không thể gửi OTP. Vui lòng kiểm tra email và đăng ký lại để gửi mã mới.");
                    request.setAttribute("username", newUser.getUsername());
                    request.setAttribute("fullName", newUser.getFullName());
                    request.setAttribute("email", newUser.getEmail());
                    request.getRequestDispatcher("/views/register.jsp").forward(request, response);
                }
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