package linh_room.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import linh_room.model.User;
import linh_room.service.UserService;
import linh_room.service.UserServiceImpl;

@WebFilter({ "/home", "/admin/*", "/profile" })
public class AuthenticationFilter implements Filter {

    private final UserService userService = new UserServiceImpl();

    @Override
    public void doFilter(jakarta.servlet.ServletRequest request,
            jakarta.servlet.ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        if (session == null || session.getAttribute("account") == null) {
            User rememberedUser = findRememberedUser(httpRequest.getCookies());
            if (rememberedUser != null) {
                session = httpRequest.getSession(true);
                session.setAttribute("account", rememberedUser);
            } else {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
                return;
            }
        }

        User account = (User) session.getAttribute("account");
        String servletPath = httpRequest.getServletPath();
        if (servletPath != null && servletPath.startsWith("/admin") && !account.isAdmin()) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/home?error=access_denied");
            return;
        }

        chain.doFilter(request, response);
    }

    private User findRememberedUser(Cookie[] cookies) {
        if (cookies == null) {
            return null;
        }
        for (Cookie cookie : cookies) {
            if ("rememberedUsername".equals(cookie.getName())) {
                return userService.get(cookie.getValue());
            }
        }
        return null;
    }
}
