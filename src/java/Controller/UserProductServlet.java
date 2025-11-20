package Controller;

import DAO.DenDAO;
import DAO.LoaiDenDAO;
import Model.Den;
import Model.LoaiDen;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserProductServlet", urlPatterns = {"/UserProductServlet", "/products"})
public class UserProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        DenDAO denDAO = new DenDAO();
        LoaiDenDAO loaiDenDAO = new LoaiDenDAO();
        
        // Lấy tham số từ request
        String keyword = request.getParameter("keyword");
        String categoryParam = request.getParameter("category");
        String minPriceParam = request.getParameter("minPrice");
        String maxPriceParam = request.getParameter("maxPrice");
        String sortBy = request.getParameter("sort");
        String pageParam = request.getParameter("page");
        
        // Parse các tham số
        Integer maLoai = null;
        if (categoryParam != null && !categoryParam.isEmpty() && !categoryParam.equals("0")) {
            try {
                maLoai = Integer.parseInt(categoryParam);
            } catch (NumberFormatException e) {
                maLoai = null;
            }
        }
        
        Double minPrice = null;
        if (minPriceParam != null && !minPriceParam.isEmpty()) {
            try {
                minPrice = Double.parseDouble(minPriceParam);
            } catch (NumberFormatException e) {
                minPrice = null;
            }
        }
        
        Double maxPrice = null;
        if (maxPriceParam != null && !maxPriceParam.isEmpty()) {
            try {
                maxPrice = Double.parseDouble(maxPriceParam);
            } catch (NumberFormatException e) {
                maxPrice = null;
            }
        }
        
        int page = 1;
        int itemsPerPage = 12;
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        int offset = (page - 1) * itemsPerPage;
        
        // Lấy danh sách sản phẩm
        List<Den> products = denDAO.searchAndFilter(keyword, maLoai, minPrice, maxPrice, sortBy, offset, itemsPerPage);
        
        // Đếm tổng số sản phẩm
        int totalProducts = denDAO.countSearchAndFilter(keyword, maLoai, minPrice, maxPrice);
        int totalPages = (int) Math.ceil((double) totalProducts / itemsPerPage);
        
        // Lấy danh sách loại đèn
        List<LoaiDen> categories = loaiDenDAO.getAll();
        
        // Set attributes
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("keyword", keyword != null ? keyword : "");
        request.setAttribute("selectedCategory", maLoai != null ? maLoai : 0);
        request.setAttribute("minPrice", minPrice != null ? minPrice : 0.0);
        request.setAttribute("maxPrice", maxPrice != null ? maxPrice : 0.0);
        request.setAttribute("sortBy", sortBy != null ? sortBy : "");
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("itemsPerPage", itemsPerPage);
        
        // Forward to JSP
        request.getRequestDispatcher("/elements/UserProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
