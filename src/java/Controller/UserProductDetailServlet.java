package Controller;

import DAO.*;
import Model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "UserProductDetailServlet", urlPatterns = {"/UserProductDetailServlet", "/product-detail"})
public class UserProductDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/UserProductServlet");
            return;
        }
        
        try {
            int maDen = Integer.parseInt(idParam);
            
            DenDAO denDAO = new DenDAO();
            LoaiDenDAO loaiDenDAO = new LoaiDenDAO();
            BienTheDenDAO bienTheDenDAO = new BienTheDenDAO();
            MauSacDAO mauSacDAO = new MauSacDAO();
            KichThuocDAO kichThuocDAO = new KichThuocDAO();
            KhoDenDAO khoDenDAO = new KhoDenDAO();
            
            // Lấy thông tin sản phẩm
            Den product = denDAO.getById(maDen);
            
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/UserProductServlet");
                return;
            }
            
            // Lấy danh sách biến thể của sản phẩm
            List<BienTheDen> variants = bienTheDenDAO.getByMaDen(maDen);
            
            // Lấy danh sách màu sắc và kích thước có sẵn
            Set<Integer> availableColors = new HashSet<>();
            Set<Integer> availableSizes = new HashSet<>();
            Map<Integer, Integer> variantStock = new HashMap<>(); // maBienThe -> soLuongTon
            
            for (BienTheDen variant : variants) {
                KhoDen kho = khoDenDAO.getByMaBienThe(variant.getMaBienThe());
                if (kho != null) {
                    int soLuongTon = kho.getSoLuongNhap() - kho.getSoLuongBan();
                    variantStock.put(variant.getMaBienThe(), soLuongTon);
                    
                    if (soLuongTon > 0) {
                        if (variant.getMaMau() != null) {
                            availableColors.add(variant.getMaMau());
                        }
                        if (variant.getMaKichThuoc() != null) {
                            availableSizes.add(variant.getMaKichThuoc());
                        }
                    }
                }
            }
            
            // Lấy thông tin màu sắc và kích thước
            List<MauSac> allColors = mauSacDAO.getAll();
            List<KichThuoc> allSizes = kichThuocDAO.getAll();
            List<MauSac> colors = new ArrayList<>();
            List<KichThuoc> sizes = new ArrayList<>();
            
            for (MauSac color : allColors) {
                if (availableColors.contains(color.getMaMau())) {
                    colors.add(color);
                }
            }
            
            for (KichThuoc size : allSizes) {
                if (availableSizes.contains(size.getMaKichThuoc())) {
                    sizes.add(size);
                }
            }
            
            // Lấy loại đèn
            LoaiDen category = null;
            try {
                List<LoaiDen> allCategories = loaiDenDAO.getAll();
                for (LoaiDen cat : allCategories) {
                    if (cat.getMaLoai() == product.getMaLoai()) {
                        category = cat;
                        break;
                    }
                }
                // Nếu không tìm thấy, tạo đối tượng tạm
                if (category == null) {
                    String categoryName = loaiDenDAO.getTenLoaiById(product.getMaLoai());
                    category = new LoaiDen(product.getMaLoai(), categoryName != null ? categoryName : "Sản phẩm", "");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            // Lấy sản phẩm liên quan (cùng loại)
            List<Den> relatedProducts = denDAO.searchAndFilter(null, product.getMaLoai(), null, null, "", 0, 4);
            relatedProducts.removeIf(p -> p.getMaDen() == maDen); // Loại bỏ sản phẩm hiện tại
            
            // Set attributes
            request.setAttribute("product", product);
            request.setAttribute("category", category);
            request.setAttribute("variants", variants);
            request.setAttribute("colors", colors);
            request.setAttribute("sizes", sizes);
            request.setAttribute("variantStock", variantStock);
            request.setAttribute("relatedProducts", relatedProducts);
            
            // Forward to JSP
            request.getRequestDispatcher("/elements/UserProductDetail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/UserProductServlet");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/UserProductServlet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

