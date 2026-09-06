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
import linh_room.model.Product;
import linh_room.service.CategoryService;
import linh_room.service.CategoryServiceImpl;
import linh_room.service.ProductService;
import linh_room.service.ProductServiceImpl;
import linh_room.util.Constant;

@WebServlet({
    "/admin/product/list",
    "/admin/product/add",
    "/admin/product/edit",
    "/admin/product/delete"
})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ProductAdminServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ProductService productService = new ProductServiceImpl();
    private final CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        if (path.endsWith("/add")) {
            List<Category> categories = categoryService.getAll();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/views/product-admin-form.jsp").include(request, response);
        } else if (path.endsWith("/edit")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Product product = productService.get(id);
                if (product == null) {
                    response.sendRedirect(request.getContextPath() + "/admin/product/list?error=notfound");
                    return;
                }
                List<Category> categories = categoryService.getAll();
                request.setAttribute("product", product);
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("/views/product-admin-form.jsp").include(request, response);
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/admin/product/list?error=invalid_id");
            }
        } else if (path.endsWith("/delete")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                productService.delete(id);
                response.sendRedirect(request.getContextPath() + "/admin/product/list?msg=deleted");
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/admin/product/list?error=delete_failed");
            }
        } else {
            // Danh sách tất cả sản phẩm dành cho Admin
            String keyword = request.getParameter("keyword");
            List<Product> products;
            if (keyword != null && !keyword.trim().isEmpty()) {
                products = productService.search(keyword.trim());
                request.setAttribute("keyword", keyword.trim());
            } else {
                products = productService.getAll();
            }
            request.setAttribute("products", products);
            request.getRequestDispatcher("/views/product-admin-list.jsp").include(request, response);
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
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String quantityStr = request.getParameter("quantity");
        String soldStr = request.getParameter("sold");
        String categoryIdStr = request.getParameter("categoryId");
        String imageUrlInput = request.getParameter("imageUrl");

        double price = 0;
        int quantity = 0;
        int sold = 0;
        try {
            if (priceStr != null) price = Double.parseDouble(priceStr.trim());
            if (quantityStr != null) quantity = Integer.parseInt(quantityStr.trim());
            if (soldStr != null) sold = Integer.parseInt(soldStr.trim());
        } catch (Exception ignored) {
        }

        String imagePath = (imageUrlInput != null && !imageUrlInput.isBlank()) ? imageUrlInput.trim() : null;
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
                    String fileName = "product_" + System.currentTimeMillis() + ext;
                    String uploadDir = Constant.getProductUploadDir();
                    String savePath = uploadDir + File.separator + fileName;
                    part.write(savePath);
                    imagePath = "product/" + fileName;
                }
            }
        } catch (Exception ignored) {
        }

        Category category = null;
        if (categoryIdStr != null && !categoryIdStr.isBlank()) {
            try {
                int catId = Integer.parseInt(categoryIdStr.trim());
                category = categoryService.get(catId);
            } catch (Exception ignored) {
            }
        }

        Product product = new Product();
        product.setName(name != null ? name.trim() : "");
        product.setDescription(description != null ? description.trim() : "");
        product.setPrice(price);
        product.setQuantity(quantity);
        product.setSold(sold);
        product.setImages(imagePath);
        product.setCategory(category);
        if (idStr != null && !idStr.isBlank()) {
            try { product.setId(Integer.parseInt(idStr.trim())); } catch (Exception ignored) {}
        }

        // Server-side Validation
        if (product.getName().isBlank()) {
            request.setAttribute("error", "Tên sản phẩm không được để trống.");
            request.setAttribute("product", product);
            request.setAttribute("categories", categoryService.getAll());
            request.getRequestDispatcher("/views/product-admin-form.jsp").include(request, response);
            return;
        }

        if (category == null) {
            request.setAttribute("error", "Vui lòng chọn 1 danh mục cho sản phẩm.");
            request.setAttribute("product", product);
            request.setAttribute("categories", categoryService.getAll());
            request.getRequestDispatcher("/views/product-admin-form.jsp").include(request, response);
            return;
        }

        if (price < 1000) {
            request.setAttribute("error", "Giá bán của sản phẩm phải từ 1,000 VNĐ trở lên.");
            request.setAttribute("product", product);
            request.setAttribute("categories", categoryService.getAll());
            request.getRequestDispatcher("/views/product-admin-form.jsp").include(request, response);
            return;
        }

        if (quantity < 0 || sold < 0) {
            request.setAttribute("error", "Số lượng tồn kho và số lượng đã bán không được âm.");
            request.setAttribute("product", product);
            request.setAttribute("categories", categoryService.getAll());
            request.getRequestDispatcher("/views/product-admin-form.jsp").include(request, response);
            return;
        }

        try {
            if (path.endsWith("/edit") || (idStr != null && !idStr.trim().isEmpty() && !idStr.equals("0"))) {
                int id = Integer.parseInt(idStr);
                product.setId(id);
                if (imagePath == null) {
                    Product existing = productService.get(id);
                    if (existing != null) {
                        product.setImages(existing.getImages());
                    }
                }
                productService.update(product);
                response.sendRedirect(request.getContextPath() + "/admin/product/list?msg=updated");
            } else {
                productService.insert(product);
                response.sendRedirect(request.getContextPath() + "/admin/product/list?msg=added");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi lưu dữ liệu: " + e.getMessage());
            request.setAttribute("product", product);
            request.setAttribute("categories", categoryService.getAll());
            request.getRequestDispatcher("/views/product-admin-form.jsp").include(request, response);
        }
    }
}