package linh_room.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import linh_room.service.UserService;
import linh_room.service.UserServiceImpl;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        request.setAttribute("username", username);
        request.getRequestDispatcher("/views/reset-password.jsp").include(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String otp = request.getParameter("otp");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (username == null || username.isBlank() || otp == null || otp.isBlank()
                || newPassword == null || newPassword.isBlank()) {
            request.setAttribute("alert", "Vui lòng nhập đầy đủ các thông tin.");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/views/reset-password.jsp").include(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("alert", "Mật khẩu xác nhận không khớp.");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/views/reset-password.jsp").include(request, response);
            return;
        }

        boolean success = userService.resetPasswordWithOTP(username.trim(), otp.trim(), newPassword.trim());
        if (success) {
            response.sendRedirect(request.getContextPath() + "/login?msg=reset_success");
        } else {
            request.setAttribute("alert", "Mã OTP không chính xác hoặc đã hết hạn (10 phút). Vui lòng thử lại!");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/views/reset-password.jsp").include(request, response);
        }
    }
}