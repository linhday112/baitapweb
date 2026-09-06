package linh_room.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import linh_room.model.User;
import linh_room.service.UserService;
import linh_room.service.UserServiceImpl;

@WebServlet({"/admin/user/list", "/admin/user/delete"})
public class UserAdminServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        User currentAcc = (User) request.getSession().getAttribute("account");
        if (currentAcc == null || (!"ADMIN".equalsIgnoreCase(currentAcc.getRole()) && currentAcc.getRoleId() != 1)) {
            response.sendRedirect(request.getContextPath() + "/login?error=access_denied");
            return;
        }

        if (path.endsWith("/delete")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                if (id == currentAcc.getId()) {
                    response.sendRedirect(request.getContextPath() + "/admin/user/list?error=self_delete");
                    return;
                }
                boolean deleted = userService.deleteUser(id);
                if (deleted) {
                    response.sendRedirect(request.getContextPath() + "/admin/user/list?msg=deleted");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/user/list?error=cannot_delete_admin");
                }
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/admin/user/list?error=invalid_id");
            }
        } else {
            List<User> users = userService.getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("/views/user-admin-list.jsp").include(request, response);
        }
    }
}