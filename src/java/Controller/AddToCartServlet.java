package Controller;

import DAO.*;
import Model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AddToCartServlet", urlPatterns = {"/AddToCartServlet", "/add-to-cart"})
@jakarta.servlet.annotation.MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Đảm bảo encoding đúng - PHẢI SET TRƯỚC KHI ĐỌC PARAMETERS
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Debug: Kiểm tra request info
        System.out.println("🔍 AddToCartServlet - Request Info:");
        System.out.println("   - Method: " + request.getMethod());
        System.out.println("   - Content-Type: " + request.getContentType());
        System.out.println("   - Content-Length: " + request.getContentLength());
        System.out.println("   - Request URI: " + request.getRequestURI());
        System.out.println("   - Query String: " + request.getQueryString());
        
        // Lấy thông tin sản phẩm từ request
        // Thử đọc từ parameter trước
        String productId = request.getParameter("productId");
        String quantity = request.getParameter("quantity");
        String variantId = request.getParameter("variantId"); // Mã biến thể từ client
        String colorId = request.getParameter("colorId");
        String sizeId = request.getParameter("sizeId");
        
        // Debug log - chi tiết hơn
        System.out.println("🔍 AddToCartServlet - Request parameters (first try):");
        System.out.println("   - productId: '" + productId + "' (null: " + (productId == null) + ")");
        System.out.println("   - quantity: '" + quantity + "'");
        System.out.println("   - variantId: '" + variantId + "'");
        System.out.println("   - colorId: '" + colorId + "'");
        System.out.println("   - sizeId: '" + sizeId + "'");
        
        // Debug: In tất cả parameter names và values
        System.out.println("   - All parameters:");
        java.util.Enumeration<String> paramNames = request.getParameterNames();
        boolean hasParams = false;
        while (paramNames.hasMoreElements()) {
            hasParams = true;
            String paramName = paramNames.nextElement();
            String paramValue = request.getParameter(paramName);
            System.out.println("     * " + paramName + " = '" + paramValue + "'");
        }
        if (!hasParams) {
            System.out.println("     (No parameters found!)");
            
            // Thử đọc từ input stream nếu không có parameters
            String contentType = request.getContentType();
            System.out.println("   - Content-Type: " + contentType);
            
            if (contentType != null && contentType.contains("multipart/form-data")) {
                System.out.println("   ⚠️ Detected multipart/form-data - trying to read parts");
                try {
                    java.util.Collection<jakarta.servlet.http.Part> parts = request.getParts();
                    for (jakarta.servlet.http.Part part : parts) {
                        String name = part.getName();
                        if (part.getSize() > 0) {
                            java.io.InputStream is = part.getInputStream();
                            java.io.BufferedReader reader = new java.io.BufferedReader(new java.io.InputStreamReader(is));
                            StringBuilder value = new StringBuilder();
                            String line;
                            while ((line = reader.readLine()) != null) {
                                value.append(line);
                            }
                            System.out.println("     Part: " + name + " = '" + value.toString() + "'");
                            
                            // Set values
                            if ("productId".equals(name)) productId = value.toString();
                            else if ("quantity".equals(name)) quantity = value.toString();
                            else if ("variantId".equals(name)) variantId = value.toString();
                            else if ("colorId".equals(name)) colorId = value.toString();
                            else if ("sizeId".equals(name)) sizeId = value.toString();
                        }
                    }
                } catch (Exception e) {
                    System.err.println("❌ Error reading multipart: " + e.getMessage());
                    e.printStackTrace();
                }
            } else {
                // Thử đọc từ request body trực tiếp
                System.out.println("   ⚠️ Trying to read from request body");
                try {
                    java.io.BufferedReader reader = request.getReader();
                    StringBuilder body = new StringBuilder();
                    String line;
                    while ((line = reader.readLine()) != null) {
                        body.append(line);
                    }
                    System.out.println("   - Request body: " + body.toString());
                } catch (Exception e) {
                    System.err.println("❌ Error reading body: " + e.getMessage());
                }
            }
        }
        
        // Kiểm tra session user
        HttpSession session = request.getSession(false);
        NguoiDung user = null;
        
        if (session != null) {
            user = (NguoiDung) session.getAttribute("user");
            
            // Kiểm tra nếu là admin thì không cho thêm vào giỏ
            if (user != null && user.getVaiTro() != null && user.getVaiTro().equalsIgnoreCase("admin")) {
                user = null;
            }
        }
        
        // Nếu chưa đăng nhập, lưu thông tin sản phẩm vào session và redirect đến trang đăng nhập
        if (user == null) {
            // Lưu thông tin sản phẩm vào session để sau khi đăng nhập xong sẽ tự động thêm vào giỏ
            if (session == null) {
                session = request.getSession(true);
            }
            session.setAttribute("pendingAddToCart", "true");
            session.setAttribute("pendingProductId", productId);
            session.setAttribute("pendingQuantity", quantity);
            session.setAttribute("pendingColorId", colorId);
            session.setAttribute("pendingSizeId", sizeId);
            
            // Lưu URL hiện tại để sau khi đăng nhập xong sẽ quay lại
            String referer = request.getHeader("Referer");
            if (referer != null && !referer.isEmpty()) {
                // Chỉ lưu URL nếu là URL trong cùng domain
                String contextPath = request.getContextPath();
                if (referer.contains(contextPath)) {
                    session.setAttribute("returnUrl", referer);
                }
            }
            
            // Trả về JSON response để JavaScript xử lý
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": false, \"requireLogin\": true, \"message\": \"Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng!\"}");
            return;
        }
        
        // Đã đăng nhập - Thêm vào giỏ hàng
        try {
            // Validate productId - kiểm tra kỹ hơn
            if (productId == null || productId.trim().isEmpty() || productId.trim().equals("null") || productId.trim().equals("undefined")) {
                System.err.println("❌ productId không hợp lệ: " + productId);
                System.err.println("   - productId == null: " + (productId == null));
                if (productId != null) {
                    System.err.println("   - productId.trim().isEmpty(): " + productId.trim().isEmpty());
                    System.err.println("   - productId.trim(): '" + productId.trim() + "'");
                }
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"Mã sản phẩm không hợp lệ! Vui lòng thử lại.\"}");
                return;
            }
            
            // Parse parameters
            int maDen;
            try {
                String productIdTrimmed = productId.trim();
                System.out.println("🔍 Parsing productId: '" + productIdTrimmed + "'");
                maDen = Integer.parseInt(productIdTrimmed);
                System.out.println("✅ Parsed maDen: " + maDen);
            } catch (NumberFormatException e) {
                System.err.println("❌ Lỗi parse productId: '" + productId + "'");
                System.err.println("   - Exception: " + e.getMessage());
                e.printStackTrace();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"Mã sản phẩm không hợp lệ!\"}");
                return;
            }
            
            int soLuong = 1;
            if (quantity != null && !quantity.trim().isEmpty()) {
                try {
                    soLuong = Integer.parseInt(quantity.trim());
                    if (soLuong < 1) soLuong = 1;
                } catch (NumberFormatException e) {
                    soLuong = 1;
                }
            }
            
            Integer maMau = null;
            if (colorId != null && !colorId.trim().isEmpty() && !colorId.trim().equals("null") && !colorId.trim().equals("undefined")) {
                try {
                    maMau = Integer.parseInt(colorId.trim());
                } catch (NumberFormatException e) {
                    maMau = null;
                }
            }
            
            Integer maKichThuoc = null;
            if (sizeId != null && !sizeId.trim().isEmpty() && !sizeId.trim().equals("null") && !sizeId.trim().equals("undefined")) {
                try {
                    maKichThuoc = Integer.parseInt(sizeId.trim());
                } catch (NumberFormatException e) {
                    maKichThuoc = null;
                }
            }
            
            // Lấy thông tin sản phẩm
            DenDAO denDAO = new DenDAO();
            Den product = null;
            try {
                product = denDAO.getById(maDen);
            } catch (Exception e) {
                System.err.println("❌ Lỗi khi lấy sản phẩm với mã: " + maDen);
                e.printStackTrace();
            }
            
            if (product == null) {
                System.err.println("❌ Không tìm thấy sản phẩm với mã: " + maDen);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"Sản phẩm không tồn tại!\"}");
                return;
            }
            
            // Ưu tiên sử dụng variantId từ client nếu có, nếu không thì tìm dựa trên maDen, maMau, maKichThuoc
            Integer maBienThe = null;
            BienTheDen variant = null;
            BienTheDenDAO bienTheDenDAO = new BienTheDenDAO();
            
            if (variantId != null && !variantId.trim().isEmpty() && !variantId.trim().equals("null") && !variantId.trim().equals("undefined")) {
                // Nếu có variantId từ client, lấy trực tiếp
                try {
                    int variantIdInt = Integer.parseInt(variantId.trim());
                    variant = bienTheDenDAO.getById(variantIdInt);
                    if (variant != null && variant.getMaDen() == maDen) {
                        maBienThe = variant.getMaBienThe();
                        // Cập nhật maMau và maKichThuoc từ variant để đảm bảo đồng bộ
                        if (variant.getMaMau() != null) maMau = variant.getMaMau();
                        if (variant.getMaKichThuoc() != null) maKichThuoc = variant.getMaKichThuoc();
                        System.out.println("✅ Sử dụng variantId từ client: maBienThe=" + maBienThe);
                    } else {
                        System.out.println("⚠️ variantId không khớp với maDen, tìm lại variant");
                        variant = null;
                    }
                } catch (NumberFormatException e) {
                    System.err.println("❌ Lỗi parse variantId: " + variantId);
                }
            }
            
            // Nếu chưa có variant, tìm dựa trên maDen, maMau, maKichThuoc
            if (variant == null) {
                variant = bienTheDenDAO.findByMaDenAndVariant(maDen, maMau, maKichThuoc);
                if (variant != null) {
                    maBienThe = variant.getMaBienThe();
                    System.out.println("✅ Tìm thấy biến thể: maBienThe=" + maBienThe + ", maDen=" + maDen + ", maMau=" + maMau + ", maKichThuoc=" + maKichThuoc);
                }
            }
            
            // BẮT BUỘC PHẢI CÓ BIẾN THỂ MỚI ĐƯỢC THÊM VÀO GIỎ HÀNG
            if (variant == null || maBienThe == null) {
                System.err.println("❌ KHÔNG TÌM THẤY BIẾN THỂ cho maDen=" + maDen + ", maMau=" + maMau + ", maKichThuoc=" + maKichThuoc);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"Không tìm thấy biến thể sản phẩm! Vui lòng chọn màu sắc và kích thước.\"}");
                return;
            }
            
            // Kiểm tra tồn kho của biến thể
            KhoDenDAO khoDenDAO = new KhoDenDAO();
            KhoDen kho = khoDenDAO.getByMaBienThe(maBienThe);
            int soLuongTon = 0;
            if (kho != null) {
                soLuongTon = kho.getSoLuongNhap() - kho.getSoLuongBan();
            }
            
            // Kiểm tra số lượng yêu cầu có vượt quá tồn kho không
            if (soLuong > soLuongTon) {
                System.err.println("❌ Số lượng yêu cầu (" + soLuong + ") vượt quá tồn kho (" + soLuongTon + ")");
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"Số lượng yêu cầu vượt quá tồn kho! Hiện chỉ còn " + soLuongTon + " sản phẩm.\"}");
                return;
            }
            
            // Lấy thông tin màu sắc và kích thước từ biến thể
            String tenMau = null;
            String tenKichThuoc = null;
            if (variant.getMaMau() != null) {
                MauSacDAO mauSacDAO = new MauSacDAO();
                MauSac mau = mauSacDAO.getById(variant.getMaMau());
                if (mau != null) {
                    tenMau = mau.getTenMau();
                }
            }
            if (variant.getMaKichThuoc() != null) {
                KichThuocDAO kichThuocDAO = new KichThuocDAO();
                KichThuoc kichThuoc = kichThuocDAO.getById(variant.getMaKichThuoc());
                if (kichThuoc != null) {
                    tenKichThuoc = kichThuoc.getTenKichThuoc();
                }
            }
            
            // Tạo cart item với thông tin TỪ BIẾN THỂ (không phải từ sản phẩm chính)
            GioHangItem item = new GioHangItem();
            item.setMaDen(product.getMaDen());
            item.setMaBienThe(maBienThe); // BẮT BUỘC phải có mã biến thể
            item.setTenDen(product.getTenDen());
            item.setHinhAnh(product.getHinhAnh());
            item.setGia(product.getGia()); // Giá từ sản phẩm (nếu variant có giá riêng thì lấy từ variant)
            item.setSoLuong(soLuong);
            // Lấy maMau và maKichThuoc từ variant (đảm bảo đúng)
            item.setMaMau(variant.getMaMau());
            item.setMaKichThuoc(variant.getMaKichThuoc());
            item.setTenMau(tenMau);
            item.setTenKichThuoc(tenKichThuoc);
            
            System.out.println("✅ Thêm vào giỏ hàng: maBienThe=" + maBienThe + ", maDen=" + maDen + ", maMau=" + variant.getMaMau() + ", maKichThuoc=" + variant.getMaKichThuoc() + ", soLuong=" + soLuong);
            
            // Lấy giỏ hàng từ session hoặc tạo mới
            GioHang cart = (GioHang) session.getAttribute("cart");
            if (cart == null) {
                cart = new GioHang();
                session.setAttribute("cart", cart);
            }
            
            // Thêm vào giỏ hàng
            cart.addItem(item);
            
            System.out.println("✅ Đã thêm vào giỏ hàng thành công:");
            System.out.println("   - maDen: " + maDen);
            System.out.println("   - maBienThe: " + maBienThe);
            System.out.println("   - tenDen: " + product.getTenDen());
            System.out.println("   - soLuong: " + soLuong);
            System.out.println("   - gia: " + product.getGia());
            System.out.println("   - Tổng items trong giỏ: " + cart.getTotalItems());
            
            // Trả về JSON response thành công với số lượng giỏ hàng
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": true, \"message\": \"Đã thêm sản phẩm vào giỏ hàng!\", \"cartCount\": " + cart.getTotalItems() + "}");
            
        } catch (Exception e) {
            System.err.println("❌ Lỗi thêm vào giỏ hàng: " + e.getMessage());
            System.err.println("   - productId: " + productId);
            System.err.println("   - quantity: " + quantity);
            System.err.println("   - colorId: " + colorId);
            System.err.println("   - sizeId: " + sizeId);
            e.printStackTrace();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": false, \"message\": \"Có lỗi xảy ra khi thêm vào giỏ hàng: " + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển POST request
        doPost(request, response);
    }
}

