package linh_room.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import linh_room.model.Category;
import linh_room.service.CategoryService;
import linh_room.service.CategoryServiceImpl;
import linh_room.util.Constant;

@WebServlet({
    "/admin/category/list",
    "/admin/category/add",
    "/admin/category/edit",
    "/admin/category/delete",
    "/admin/category/search"
})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class CategoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        if (path.endsWith("/add")) {
            request.getRequestDispatcher("/views/category-form.jsp").forward(request, response);
        } else if (path.endsWith("/edit")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Category category = categoryService.get(id);
                if (category == null) {
                    response.sendRedirect(request.getContextPath() + "/admin/category/list?error=notfound");
                    return;
                }
                request.setAttribute("category", category);
                request.getRequestDispatcher("/views/category-form.jsp").forward(request, response);
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/admin/category/list?error=invalid_id");
            }
        } else if (path.endsWith("/delete")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                categoryService.delete(id);
                response.sendRedirect(request.getContextPath() + "/admin/category/list?msg=deleted");
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/admin/category/list?error=delete_failed");
            }
        } else {
            // Danh sách & Tìm kiếm
            String keyword = request.getParameter("keyword");
            List<Category> categories;
            if (keyword != null && !keyword.trim().isEmpty()) {
                categories = categoryService.search(keyword.trim());
                request.setAttribute("keyword", keyword.trim());
            } else {
                categories = categoryService.getAll();
            }
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/views/category-list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String path = request.getServletPath();
        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String iconUrl = request.getParameter("icon");

        // Xử lý upload file hình ảnh đại diện (nếu có)
        String icon = (iconUrl != null && !iconUrl.trim().isEmpty()) ? iconUrl.trim() : null;
        try {
            Part part = request.getPart("iconFile");
            if (part != null && part.getSize() > 0) {
                String submittedFileName = part.getSubmittedFileName();
                if (submittedFileName != null && !submittedFileName.isBlank()) {
                    String ext = "";
                    int dotIdx = submittedFileName.lastIndexOf(".");
                    if (dotIdx >= 0) {
                        ext = submittedFileName.substring(dotIdx);
                    }
                    String fileName = System.currentTimeMillis() + ext;
                    String savePath = Constant.getCategoryUploadDir() + File.separator + fileName;
                    part.write(savePath);
                    icon = "category/" + fileName;
                }
            }
        } catch (Exception ignored) {
            // Trường hợp không gửi multipart
        }

        Category category = new Category();
        category.setName(name);
        category.setIcon(icon);

        try {
            if (path.endsWith("/edit") || (idStr != null && !idStr.trim().isEmpty() && !idStr.equals("0"))) {
                int id = Integer.parseInt(idStr);
                category.setId(id);
                // Nếu không upload ảnh mới và không đổi URL ảnh thì giữ ảnh cũ
                if (icon == null) {
                    Category existing = categoryService.get(id);
                    if (existing != null) {
                        category.setIcon(existing.getIcon());
                    }
                }
                categoryService.update(category);
                response.sendRedirect(request.getContextPath() + "/admin/category/list?msg=updated");
            } else {
                categoryService.insert(category);
                response.sendRedirect(request.getContextPath() + "/admin/category/list?msg=added");
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("category", category);
            request.getRequestDispatcher("/views/category-form.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi xử lý cơ sở dữ liệu: " + e.getMessage());
            request.setAttribute("category", category);
            request.getRequestDispatcher("/views/category-form.jsp").forward(request, response);
        }
    }
}