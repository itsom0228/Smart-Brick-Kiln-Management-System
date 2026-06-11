package com.dipaksarpane.kiln.service;

import com.dipaksarpane.kiln.entity.InventoryTransaction;
import com.dipaksarpane.kiln.entity.Order;
import com.dipaksarpane.kiln.entity.Product;
import com.dipaksarpane.kiln.entity.Quotation;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
public class ReportService {

    public ByteArrayInputStream exportOrdersToExcel(List<Order> orders) {
        String[] columns = {"ID", "Order Number", "Order Date", "Customer Name", "Mobile", "Product", "Qty", "Prod Cost", "GST", "Transport", "Total Cost", "Status"};

        try (Workbook workbook = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            Sheet sheet = workbook.createSheet("Orders Report");

            // Header Font & Style
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerFont.setColor(IndexedColors.WHITE.getIndex());

            CellStyle headerCellStyle = workbook.createCellStyle();
            headerCellStyle.setFont(headerFont);
            headerCellStyle.setFillForegroundColor(IndexedColors.DARK_TEAL.getIndex());
            headerCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerCellStyle.setAlignment(HorizontalAlignment.CENTER);

            // Create Header Row
            Row headerRow = sheet.createRow(0);
            for (int i = 0; i < columns.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(columns[i]);
                cell.setCellStyle(headerCellStyle);
            }

            // Date & Currency Format
            CellStyle dateStyle = workbook.createCellStyle();
            dateStyle.setDataFormat(workbook.getCreationHelper().createDataFormat().getFormat("yyyy-mm-dd hh:mm"));

            int rowIdx = 1;
            for (Order order : orders) {
                Row row = sheet.createRow(rowIdx++);

                row.createCell(0).setCellValue(order.getId());
                row.createCell(1).setCellValue(order.getOrderNumber());
                
                Cell dateCell = row.createCell(2);
                dateCell.setCellValue(order.getOrderDate().toString());
                
                row.createCell(3).setCellValue(order.getFullName());
                row.createCell(4).setCellValue(order.getMobileNumber());
                row.createCell(5).setCellValue(order.getProductTypeName());
                row.createCell(6).setCellValue(order.getQuantity());
                
                row.createCell(7).setCellValue(order.getProductCost().doubleValue());
                row.createCell(8).setCellValue(order.getGstAmount().doubleValue());
                row.createCell(9).setCellValue(order.getTransportCost().doubleValue());
                row.createCell(10).setCellValue(order.getTotalCost().doubleValue());
                row.createCell(11).setCellValue(order.getCurrentStatus());
            }

            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }

            workbook.write(out);
            return new ByteArrayInputStream(out.toByteArray());
        } catch (IOException e) {
            throw new RuntimeException("Fail to import data to Excel: " + e.getMessage());
        }
    }

    public ByteArrayInputStream exportInventoryToExcel(List<InventoryTransaction> transactions) {
        String[] columns = {"ID", "Date", "Product", "Type", "Qty Change", "Remarks"};

        try (Workbook workbook = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            Sheet sheet = workbook.createSheet("Inventory Logs");

            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerFont.setColor(IndexedColors.WHITE.getIndex());

            CellStyle headerCellStyle = workbook.createCellStyle();
            headerCellStyle.setFont(headerFont);
            headerCellStyle.setFillForegroundColor(IndexedColors.DARK_BLUE.getIndex());
            headerCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerCellStyle.setAlignment(HorizontalAlignment.CENTER);

            Row headerRow = sheet.createRow(0);
            for (int i = 0; i < columns.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(columns[i]);
                cell.setCellStyle(headerCellStyle);
            }

            int rowIdx = 1;
            for (InventoryTransaction tx : transactions) {
                Row row = sheet.createRow(rowIdx++);

                row.createCell(0).setCellValue(tx.getId());
                row.createCell(1).setCellValue(tx.getTransactionDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
                row.createCell(2).setCellValue(tx.getProduct().getName());
                row.createCell(3).setCellValue(tx.getTransactionType());
                row.createCell(4).setCellValue(tx.getQuantity());
                row.createCell(5).setCellValue(tx.getRemarks());
            }

            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }

            workbook.write(out);
            return new ByteArrayInputStream(out.toByteArray());
        } catch (IOException e) {
            throw new RuntimeException("Fail to export inventory to Excel: " + e.getMessage());
        }
    }

    public ByteArrayInputStream exportQuotationsToExcel(List<Quotation> quotations) {
        String[] columns = {"ID", "Quote Number", "Request Date", "Customer Name", "Mobile", "Product", "Qty", "Est Cost", "GST", "Transport", "Total Est", "Status"};

        try (Workbook workbook = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            Sheet sheet = workbook.createSheet("Quotations Report");

            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerFont.setColor(IndexedColors.WHITE.getIndex());

            CellStyle headerCellStyle = workbook.createCellStyle();
            headerCellStyle.setFont(headerFont);
            headerCellStyle.setFillForegroundColor(IndexedColors.GREY_80_PERCENT.getIndex());
            headerCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerCellStyle.setAlignment(HorizontalAlignment.CENTER);

            Row headerRow = sheet.createRow(0);
            for (int i = 0; i < columns.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(columns[i]);
                cell.setCellStyle(headerCellStyle);
            }

            int rowIdx = 1;
            for (Quotation quote : quotations) {
                Row row = sheet.createRow(rowIdx++);

                row.createCell(0).setCellValue(quote.getId());
                row.createCell(1).setCellValue(quote.getQuotationNumber());
                row.createCell(2).setCellValue(quote.getRequestDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
                row.createCell(3).setCellValue(quote.getFullName());
                row.createCell(4).setCellValue(quote.getMobileNumber());
                row.createCell(5).setCellValue(quote.getProductTypeName());
                row.createCell(6).setCellValue(quote.getQuantity());
                row.createCell(7).setCellValue(quote.getEstimatedProductCost().doubleValue());
                row.createCell(8).setCellValue(quote.getEstimatedGstAmount().doubleValue());
                row.createCell(9).setCellValue(quote.getEstimatedTransportCost().doubleValue());
                row.createCell(10).setCellValue(quote.getTotalEstimatedCost().doubleValue());
                row.createCell(11).setCellValue(quote.getStatus());
            }

            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }

            workbook.write(out);
            return new ByteArrayInputStream(out.toByteArray());
        } catch (IOException e) {
            throw new RuntimeException("Fail to export quotations to Excel: " + e.getMessage());
        }
    }
}
