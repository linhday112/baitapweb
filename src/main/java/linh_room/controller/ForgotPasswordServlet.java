package linh_room.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import linh_room.model.User;
import linh_room.service.UserService;
import linh_room.service.UserServiceImpl;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/forgot-password.jsp").include(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String accountInput = request.getParameter("accountInput");
        if (accountInput == null || accountInput.isBlank()) {
            request.setAttribute("alert", "Vui lòng nhập Tên đăng nhập hoặc Email.");
            request.getRequestDispatcher("/views/forgot-password.jsp").include(request, response);
            return;
        }

        User user = userService.get(accountInput.trim());
        if (user == null) {
            user = userService.findByEmail(accountInput.trim());
        }

        if (user == null) {
            request.setAttribute("alert", "Không tìm thấy tài khoản tương ứng với '" + accountInput + "'.");
            request.setAttribute("accountInput", accountInput);
            request.getRequestDispatcher("/views/forgot-password.jsp").include(request, response);
            return;
        }

        boolean sent = userService.generateAndSendOTP(user, "Mã OTP Quên Mật Khẩu - Linh Room", "Yêu Cầu Đặt Lại Mật Khẩu");
        if (sent) {
            response.sendRedirect(request.getContextPath() + "/reset-password?username=" + user.getUsername() + "&msg=otp_sent");
        } else {
            request.setAttribute("alert", "Không thể gửi OTP. Vui lòng thử lại sau.");
            request.getRequestDispatcher("/views/forgot-password.jsp").include(request, response);
        }
    }
}