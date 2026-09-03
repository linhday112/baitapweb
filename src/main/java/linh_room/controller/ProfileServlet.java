package linh_room.controller;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import linh_room.model.User;
import linh_room.service.UserService;
import linh_room.service.UserServiceImpl;
import linh_room.util.Constant;

@WebServlet("/profile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User current = (User) session.getAttribute("account");
        User freshUser = userService.get(current.getUsername());
        if (freshUser != null) {
            session.setAttribute("account", freshUser);
            request.setAttribute("user", freshUser);
        } else {
            request.setAttribute("user", current);
        }

        request.getRequestDispatcher("/views/profile.jsp").include(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User current = (User) session.getAttribute("account");
        User user = userService.get(current.getUsername());
        if (user == null) {
            user = current;
        }

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");

        // Xử lý upload file hình ảnh đại diện qua Multipart
        String imagePath = user.getImages();
        try {
            Part part = request.getPart("imageFile");
            if (part != null && part.getSize() > 0) {
                String submittedFileName = part.getSubmittedFileName();
                if (submittedFileName != null && !submittedFileName.isBlank()) {
                    String ext = "";
                    int dotIdx = submittedFileName.lastIndexOf(".");
                    if (dotIdx >= 0) {
                        ext = submittedFileName.substring(dotIdx).toLowerCase();
                    }
                    if (ext.equals(".jpg") || ext.equals(".jpeg") || ext.equals(".png") || ext.equals(".webp") || ext.equals(".gif")) {
                        String fileName = "user_" + user.getId() + "_" + System.currentTimeMillis() + ext;
                        String uploadDir = Constant.getUserUploadDir();
                        String savePath = uploadDir + File.separator + fileName;
                        part.write(savePath);
                        imagePath = "user/" + fileName;
                    } else {
                        request.setAttribute("error", "Chỉ chấp nhận file ảnh (.jpg, .jpeg, .png, .webp, .gif).");
                        request.setAttribute("user", user);
                        request.getRequestDispatcher("/views/profile.jsp").include(request, response);
                        return;
                    }
                }
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi tải ảnh: " + e.getMessage());
            request.setAttribute("user", user);
            request.getRequestDispatcher("/views/profile.jsp").include(request, response);
            return;
        }

        if (fullName != null && !fullName.isBlank()) {
            user.setFullName(fullName.trim());
        }
        user.setPhone(phone != null ? phone.trim() : null);
        user.setImages(imagePath);

        try {
            userService.update(user);
            session.setAttribute("account", user);
            response.sendRedirect(request.getContextPath() + "/profile?msg=update_success");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi cập nhật dữ liệu: " + e.getMessage());
            request.setAttribute("user", user);
            request.getRequestDispatcher("/views/profile.jsp").include(request, response);
        }
    }
}