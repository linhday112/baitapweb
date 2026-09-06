package linh_room.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import linh_room.model.Product;
import linh_room.service.ProductService;
import linh_room.service.ProductServiceImpl;

@WebServlet({"/product", "/product/detail"})
public class ProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/product/detail".equals(path)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Product product = productService.get(id);
                if (product != null) {
                    request.setAttribute("product", product);
                    request.getRequestDispatcher("/views/product-detail.jsp").include(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/product?error=notfound");
                }
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/product?error=invalid_id");
            }
        } else {
            // Yêu cầu 4.3: Hiển thị tất cả sản phẩm được phân trang 6sp/trang hiển thị trên trang có URL là /product
            int page = 1;
            int pageSize = 6;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isBlank()) {
                try {
                    page = Integer.parseInt(pageStr);
                    if (page < 1) page = 1;
                } catch (Exception ignored) {
                }
            }

            String sort = request.getParameter("sort");
            if (sort == null || sort.isBlank()) {
                sort = "sold";
            }

            int totalCount = productService.countAll();
            int totalPages = (int) Math.ceil((double) totalCount / pageSize);
            if (totalPages < 1) totalPages = 1;
            if (page > totalPages) page = totalPages;

            List<Product> products = productService.findPaginatedSorted(page, pageSize, sort);

            request.setAttribute("products", products);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalCount", totalCount);
            request.setAttribute("sort", sort);
            request.getRequestDispatcher("/views/product-public-list.jsp").include(request, response);
        }
    }
}