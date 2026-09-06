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

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Product> top10Products = productService.findTop10Newest();
        List<Product> top10SoldProducts = productService.findTop10Sold();
        request.setAttribute("top10Products", top10Products);
        request.setAttribute("top10SoldProducts", top10SoldProducts);

        request.getRequestDispatcher("/views/index.jsp")
               .include(request, response);
    }
}