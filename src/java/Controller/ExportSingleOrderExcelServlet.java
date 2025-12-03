package Controller;

import DAO.*;
import Model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.IOException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;

@WebServlet(name = "ExportSingleOrderExcelServlet", urlPatterns = {"/ExportSingleOrderExcelServlet", "/admin/export-order-excel"})
public class ExportSingleOrderExcelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/View/adminLogin.jsp");
            return;
        }

        // Lấy mã hóa đơn từ parameter
        String maHdStr = request.getParameter("maHd");
        if (maHdStr == null || maHdStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu mã hóa đơn");
            return;
        }

        try {
            int maHd = Integer.parseInt(maHdStr);

            HoaDonDAO hoaDonDAO = new HoaDonDAO();
            NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
            ChiTietHoaDonDAO chiTietDAO = new ChiTietHoaDonDAO();
            BienTheDenDAO bienTheDAO = new BienTheDenDAO();
            DenDAO denDAO = new DenDAO();
            MauSacDAO mauSacDAO = new MauSacDAO();
            KichThuocDAO kichThuocDAO = new KichThuocDAO();

            // Lấy thông tin hóa đơn
            HoaDon order = hoaDonDAO.getById(maHd);
            if (order == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy hóa đơn");
                return;
            }

            // Lấy thông tin khách hàng
            NguoiDung customer = nguoiDungDAO.getById(order.getMaNd());
            String customerName = customer != null && customer.getTenDangNhap() != null ? customer.getTenDangNhap() : "N/A";
            String customerEmail = customer != null && customer.getEmail() != null ? customer.getEmail() : "N/A";

            // Lấy chi tiết hóa đơn
            List<ChiTietHoaDon> chiTietList = chiTietDAO.getByHoaDon(maHd);

            // Tạo workbook Excel
            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("Hóa đơn #" + maHd);

            // Tạo style cho header
            CellStyle headerStyle = workbook.createCellStyle();
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerFont.setFontHeightInPoints((short) 14);
            headerFont.setColor(IndexedColors.WHITE.getIndex());
            headerStyle.setFont(headerFont);
            headerStyle.setFillForegroundColor(IndexedColors.DARK_BLUE.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerStyle.setAlignment(HorizontalAlignment.CENTER);
            headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
            headerStyle.setBorderBottom(BorderStyle.THIN);
            headerStyle.setBorderTop(BorderStyle.THIN);
            headerStyle.setBorderLeft(BorderStyle.THIN);
            headerStyle.setBorderRight(BorderStyle.THIN);

            // Tạo style cho title
            CellStyle titleStyle = workbook.createCellStyle();
            Font titleFont = workbook.createFont();
            titleFont.setBold(true);
            titleFont.setFontHeightInPoints((short) 16);
            titleStyle.setFont(titleFont);
            titleStyle.setAlignment(HorizontalAlignment.CENTER);
            titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);

            // Tạo style cho dữ liệu
            CellStyle dataStyle = workbook.createCellStyle();
            dataStyle.setBorderBottom(BorderStyle.THIN);
            dataStyle.setBorderTop(BorderStyle.THIN);
            dataStyle.setBorderLeft(BorderStyle.THIN);
            dataStyle.setBorderRight(BorderStyle.THIN);
            dataStyle.setVerticalAlignment(VerticalAlignment.CENTER);

            CellStyle labelStyle = workbook.createCellStyle();
            labelStyle.cloneStyleFrom(dataStyle);
            Font labelFont = workbook.createFont();
            labelFont.setBold(true);
            labelStyle.setFont(labelFont);

            CellStyle currencyStyle = workbook.createCellStyle();
            currencyStyle.cloneStyleFrom(dataStyle);
            DataFormat format = workbook.createDataFormat();
            currencyStyle.setDataFormat(format.getFormat("#,##0"));

            CellStyle dateStyle = workbook.createCellStyle();
            dateStyle.cloneStyleFrom(dataStyle);
            CreationHelper createHelper = workbook.getCreationHelper();
            dateStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd/MM/yyyy HH:mm"));

            NumberFormat nf = NumberFormat.getNumberInstance(new Locale("vi", "VN"));
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");

            int rowNum = 0;

            // Tiêu đề
            Row titleRow = sheet.createRow(rowNum++);
            Cell titleCell = titleRow.createCell(0);
            titleCell.setCellValue("HÓA ĐƠN BÁN HÀNG");
            titleCell.setCellStyle(titleStyle);
            sheet.addMergedRegion(new org.apache.poi.ss.util.CellRangeAddress(0, 0, 0, 6));

            rowNum++; // Dòng trống

            // Thông tin hóa đơn
            Row infoRow1 = sheet.createRow(rowNum++);
            infoRow1.createCell(0).setCellValue("Mã hóa đơn:");
            infoRow1.getCell(0).setCellStyle(labelStyle);
            infoRow1.createCell(1).setCellValue("#" + maHd);
            infoRow1.getCell(1).setCellStyle(dataStyle);

            infoRow1.createCell(3).setCellValue("Ngày lập:");
            infoRow1.getCell(3).setCellStyle(labelStyle);
            Cell dateCell = infoRow1.createCell(4);
            if (order.getNgayLap() != null) {
                dateCell.setCellValue(order.getNgayLap());
                dateCell.setCellStyle(dateStyle);
            } else {
                dateCell.setCellValue("N/A");
                dateCell.setCellStyle(dataStyle);
            }

            Row infoRow2 = sheet.createRow(rowNum++);
            infoRow2.createCell(0).setCellValue("Khách hàng:");
            infoRow2.getCell(0).setCellStyle(labelStyle);
            infoRow2.createCell(1).setCellValue(customerName);
            infoRow2.getCell(1).setCellStyle(dataStyle);

            infoRow2.createCell(3).setCellValue("Email:");
            infoRow2.getCell(3).setCellStyle(labelStyle);
            infoRow2.createCell(4).setCellValue(customerEmail);
            infoRow2.getCell(4).setCellStyle(dataStyle);

            Row infoRow3 = sheet.createRow(rowNum++);
            infoRow3.createCell(0).setCellValue("Trạng thái:");
            infoRow3.getCell(0).setCellStyle(labelStyle);
            String status = order.getTrangThaiGiaoHang() != null ? order.getTrangThaiGiaoHang() : "chờ xử lý";
            infoRow3.createCell(1).setCellValue(status);
            infoRow3.getCell(1).setCellStyle(dataStyle);

            if (order.getGhiChu() != null && !order.getGhiChu().trim().isEmpty()) {
                Row infoRow4 = sheet.createRow(rowNum++);
                infoRow4.createCell(0).setCellValue("Ghi chú:");
                infoRow4.getCell(0).setCellStyle(labelStyle);
                infoRow4.createCell(1).setCellValue(order.getGhiChu());
                infoRow4.getCell(1).setCellStyle(dataStyle);
                sheet.addMergedRegion(new org.apache.poi.ss.util.CellRangeAddress(rowNum - 1, rowNum - 1, 1, 6));
            }

            rowNum++; // Dòng trống

            // Header cho bảng chi tiết
            Row headerRow = sheet.createRow(rowNum++);
            String[] headers = {"STT", "Tên sản phẩm", "Màu sắc", "Kích thước", "Số lượng", "Đơn giá (VNĐ)", "Thành tiền (VNĐ)"};
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
            }

            // Chi tiết sản phẩm
            int stt = 1;
            for (ChiTietHoaDon chiTiet : chiTietList) {
                Row row = sheet.createRow(rowNum++);

                // STT
                Cell cell0 = row.createCell(0);
                cell0.setCellValue(stt++);
                cell0.setCellStyle(dataStyle);

                // Tên sản phẩm
                String productName = "N/A";
                String colorName = "N/A";
                String sizeName = "N/A";
                BienTheDen bienThe = bienTheDAO.getById(chiTiet.getMaBienThe());
                if (bienThe != null) {
                    Den den = denDAO.getById(bienThe.getMaDen());
                    if (den != null) {
                        productName = den.getTenDen();
                    }
                    if (bienThe.getMaMau() != null) {
                        MauSac mauSac = mauSacDAO.getById(bienThe.getMaMau());
                        if (mauSac != null) {
                            colorName = mauSac.getTenMau();
                        }
                    }
                    if (bienThe.getMaKichThuoc() != null) {
                        KichThuoc kichThuoc = kichThuocDAO.getById(bienThe.getMaKichThuoc());
                        if (kichThuoc != null) {
                            sizeName = kichThuoc.getTenKichThuoc();
                        }
                    }
                }

                Cell cell1 = row.createCell(1);
                cell1.setCellValue(productName);
                cell1.setCellStyle(dataStyle);

                // Màu sắc
                Cell cell2 = row.createCell(2);
                cell2.setCellValue(colorName);
                cell2.setCellStyle(dataStyle);

                // Kích thước
                Cell cell3 = row.createCell(3);
                cell3.setCellValue(sizeName);
                cell3.setCellStyle(dataStyle);

                // Số lượng
                Cell cell4 = row.createCell(4);
                cell4.setCellValue(chiTiet.getSoLuong());
                cell4.setCellStyle(dataStyle);

                // Đơn giá
                Cell cell5 = row.createCell(5);
                cell5.setCellValue(chiTiet.getDonGia());
                cell5.setCellStyle(currencyStyle);

                // Thành tiền
                Cell cell6 = row.createCell(6);
                cell6.setCellValue(chiTiet.getThanhTien());
                cell6.setCellStyle(currencyStyle);
            }

            rowNum++; // Dòng trống

            // Tổng tiền
            Row totalRow = sheet.createRow(rowNum++);
            Cell totalLabelCell = totalRow.createCell(5);
            totalLabelCell.setCellValue("TỔNG TIỀN:");
            totalLabelCell.setCellStyle(labelStyle);

            Cell totalValueCell = totalRow.createCell(6);
            totalValueCell.setCellValue(order.getTongTien());
            totalValueCell.setCellStyle(currencyStyle);

            // Tự động điều chỉnh độ rộng cột
            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
                sheet.setColumnWidth(i, sheet.getColumnWidth(i) + 1000);
            }

            // Thiết lập response để download file
            String fileName = "Hoa_don_" + maHd + "_" + new SimpleDateFormat("yyyyMMdd_HHmmss").format(new java.util.Date()) + ".xlsx";
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
            response.setCharacterEncoding("UTF-8");

            // Ghi workbook vào response
            workbook.write(response.getOutputStream());
            workbook.close();

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Mã hóa đơn không hợp lệ");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xuất Excel: " + e.getMessage());
        }
    }
}

