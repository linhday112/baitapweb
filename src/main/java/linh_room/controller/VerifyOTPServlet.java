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

@WebServlet("/verify-otp")
public class VerifyOTPServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        if (username != null && !username.isBlank()) {
            User user = userService.get(username.trim());
            if (user != null) {
                request.setAttribute("otpCode", user.getOtp());
            }
        }
        request.setAttribute("username", username);
        request.getRequestDispatcher("/views/verify-otp.jsp").include(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String otp = request.getParameter("otp");
        String action = request.getParameter("action");

        if ("resend".equals(action)) {
            User user = userService.get(username);
            if (user != null) {
                boolean sent = userService.generateAndSendOTP(user, "Mã OTP Kích Hoạt Tài Khoản Linh Web", "Mã OTP Mới Kích Hoạt Tài Khoản");
                request.setAttribute("msg", sent ? "Đã gửi lại mã OTP mới qua email!" : "Không thể gửi lại OTP. Vui lòng thử lại sau.");
                if (sent) {
                    request.setAttribute("otpCode", user.getOtp());
                }
            } else {
                request.setAttribute("alert", "Không tìm thấy tài khoản.");
            }
            request.setAttribute("username", username);
            request.getRequestDispatcher("/views/verify-otp.jsp").include(request, response);
            return;
        }

        if (username == null || username.isBlank() || otp == null || otp.isBlank()) {
            request.setAttribute("alert", "Vui lòng nhập tên đăng nhập và mã OTP.");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/views/verify-otp.jsp").include(request, response);
            return;
        }

        boolean success = userService.verifyOTP(username.trim(), otp.trim());
        if (success) {
            response.sendRedirect(request.getContextPath() + "/login?msg=activated");
        } else {
            request.setAttribute("alert", "Mã OTP không chính xác hoặc đã hết hạn (10 phút). Vui lòng thử lại!");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/views/verify-otp.jsp").include(request, response);
        }
    }
}