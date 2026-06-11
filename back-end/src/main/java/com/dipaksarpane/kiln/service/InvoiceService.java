package com.dipaksarpane.kiln.service;

import com.dipaksarpane.kiln.entity.Invoice;
import com.dipaksarpane.kiln.entity.Order;
import com.dipaksarpane.kiln.entity.Quotation;
import com.dipaksarpane.kiln.repository.InvoiceRepository;
import com.dipaksarpane.kiln.repository.OrderRepository;
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.awt.Color;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Optional;
import java.util.Random;

@Service
@Transactional
public class InvoiceService {

    private final InvoiceRepository invoiceRepository;
    private final OrderRepository orderRepository;
    private final SystemSettingService systemSettingService;

    public InvoiceService(InvoiceRepository invoiceRepository, 
                          OrderRepository orderRepository,
                          SystemSettingService systemSettingService) {
        this.invoiceRepository = invoiceRepository;
        this.orderRepository = orderRepository;
        this.systemSettingService = systemSettingService;
    }

    public Optional<Invoice> getInvoiceByOrderId(Long orderId) {
        return invoiceRepository.findByOrderId(orderId);
    }

    public Invoice generateOrGetInvoice(Long orderId, String gstNumber) {
        Optional<Invoice> existing = invoiceRepository.findByOrderId(orderId);
        if (existing.isPresent()) {
            if (gstNumber != null && !gstNumber.trim().isEmpty()) {
                Invoice inv = existing.get();
                inv.setGstNumber(gstNumber.trim().toUpperCase());
                return invoiceRepository.save(inv);
            }
            return existing.get();
        }

        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new IllegalArgumentException("Order not found ID: " + orderId));

        Invoice inv = new Invoice();
        inv.setOrder(order);
        inv.setInvoiceNumber("DSBI-INV-" + (10000 + new Random().nextInt(90000)));
        inv.setGstNumber(gstNumber != null ? gstNumber.trim().toUpperCase() : "27AAACD1234F1Z0"); // Mock default GSTIN
        inv.setBillingAddress(order.getFullAddress() + ", Village: " + order.getVillage() + ", Taluka: " + order.getTaluka() + ", " + order.getDistrict() + ", " + order.getState() + " - " + order.getPincode());
        inv.setInvoiceDate(LocalDateTime.now());

        return invoiceRepository.save(inv);
    }

    public ByteArrayInputStream generateInvoicePdf(Invoice invoice) {
        Document document = new Document(PageSize.A4);
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        try {
            PdfWriter.getInstance(document, out);
            document.open();

            // Font Settings
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 22, new Color(178, 34, 34)); // Brick Red
            Font subTitleFont = FontFactory.getFont(FontFactory.HELVETICA, 10, new Color(44, 44, 44));
            Font sectionHeaderFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, Color.WHITE);
            Font regularFont = FontFactory.getFont(FontFactory.HELVETICA, 10, Color.BLACK);
            Font boldFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, Color.BLACK);

            // Header Section
            Paragraph title = new Paragraph("DIPAK SARPANE BRICK INDUSTRIES", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);

            Paragraph tagline = new Paragraph("Strong Foundations Begin With Quality Bricks", subTitleFont);
            tagline.setAlignment(Element.ALIGN_CENTER);
            tagline.setSpacingAfter(10);
            document.add(tagline);

            Paragraph contactInfo = new Paragraph("Owner: Dipak Sarpane | Phone: +91 95884 30156 | Email: dipaksarpane@gmail.com\nFactory Addr: Hingangaon Bk, Paranda, Osmanabad (Dharashiv), Maharashtra - 413502", subTitleFont);
            contactInfo.setAlignment(Element.ALIGN_CENTER);
            contactInfo.setSpacingAfter(20);
            document.add(contactInfo);

            // Invoice / Order Metadata Table
            PdfPTable metaTable = new PdfPTable(2);
            metaTable.setWidthPercentage(100);
            metaTable.setSpacingAfter(20);

            // Left Cell: Invoice details
            PdfPCell leftCell = new PdfPCell();
            leftCell.setBorder(Rectangle.NO_BORDER);
            leftCell.addElement(new Paragraph("INVOICE DETAILS", boldFont));
            leftCell.addElement(new Paragraph("Invoice Number: " + invoice.getInvoiceNumber(), regularFont));
            leftCell.addElement(new Paragraph("Invoice Date: " + invoice.getInvoiceDate().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm")), regularFont));
            leftCell.addElement(new Paragraph("GSTIN: " + invoice.getGstNumber(), regularFont));
            metaTable.addCell(leftCell);

            // Right Cell: Customer details
            PdfPCell rightCell = new PdfPCell();
            rightCell.setBorder(Rectangle.NO_BORDER);
            rightCell.addElement(new Paragraph("BILL TO", boldFont));
            rightCell.addElement(new Paragraph("Customer: " + invoice.getOrder().getFullName(), regularFont));
            rightCell.addElement(new Paragraph("Mobile: " + invoice.getOrder().getMobileNumber(), regularFont));
            rightCell.addElement(new Paragraph("Address: " + invoice.getBillingAddress(), regularFont));
            metaTable.addCell(rightCell);

            document.add(metaTable);

            // Line Item Table
            PdfPTable itemTable = new PdfPTable(5);
            itemTable.setWidthPercentage(100);
            itemTable.setWidths(new float[]{1, 4, 2, 2, 2});
            itemTable.setSpacingAfter(20);

            // Headers
            String[] headers = {"S.No", "Product Name", "Quantity", "Unit Price", "Total (INR)"};
            for (String header : headers) {
                PdfPCell cell = new PdfPCell(new Phrase(header, sectionHeaderFont));
                cell.setBackgroundColor(new Color(44, 44, 44)); // Charcoal
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setPadding(8);
                itemTable.addCell(cell);
            }

            // Row 1
            itemTable.addCell(createCenterCell("1", regularFont));
            itemTable.addCell(createLeftCell(invoice.getOrder().getProductTypeName(), regularFont));
            itemTable.addCell(createCenterCell(String.valueOf(invoice.getOrder().getQuantity()), regularFont));
            itemTable.addCell(createRightCell(String.format("%.2f", invoice.getOrder().getProductUnitPrice()), regularFont));
            itemTable.addCell(createRightCell(String.format("%.2f", invoice.getOrder().getProductCost()), regularFont));

            document.add(itemTable);

            // Financial Summary Block
            PdfPTable summaryTable = new PdfPTable(2);
            summaryTable.setWidthPercentage(40);
            summaryTable.setHorizontalAlignment(Element.ALIGN_RIGHT);
            summaryTable.setSpacingAfter(30);

            summaryTable.addCell(createLeftCell("Product Cost:", boldFont));
            summaryTable.addCell(createRightCell(String.format("%.2f", invoice.getOrder().getProductCost()), regularFont));

            BigDecimal gstRatePercent = systemSettingService.getGstRatePercent();
            summaryTable.addCell(createLeftCell("GST (" + gstRatePercent + "%):", boldFont));
            summaryTable.addCell(createRightCell(String.format("%.2f", invoice.getOrder().getGstAmount()), regularFont));

            summaryTable.addCell(createLeftCell("Transport Cost:", boldFont));
            summaryTable.addCell(createRightCell(String.format("%.2f", invoice.getOrder().getTransportCost()), regularFont));

            PdfPCell totalLabel = new PdfPCell(new Phrase("Grand Total:", titleFont));
            totalLabel.setBorder(Rectangle.NO_BORDER);
            summaryTable.addCell(totalLabel);

            PdfPCell totalVal = new PdfPCell(new Phrase("INR " + String.format("%.2f", invoice.getOrder().getTotalCost()), titleFont));
            totalVal.setBorder(Rectangle.NO_BORDER);
            totalVal.setHorizontalAlignment(Element.ALIGN_RIGHT);
            summaryTable.addCell(totalVal);

            document.add(summaryTable);

            // Terms and Signature
            Paragraph footer = new Paragraph("Thank you for your business!\n\nThis is a computer-generated invoice and does not require a signature.", subTitleFont);
            footer.setAlignment(Element.ALIGN_CENTER);
            document.add(footer);

            document.close();
        } catch (DocumentException e) {
            e.printStackTrace();
        }

        return new ByteArrayInputStream(out.toByteArray());
    }

    public ByteArrayInputStream generateQuotationPdf(Quotation quotation) {
        Document document = new Document(PageSize.A4);
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        try {
            PdfWriter.getInstance(document, out);
            document.open();

            // Font Settings
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 22, new Color(178, 34, 34)); // Brick Red
            Font subTitleFont = FontFactory.getFont(FontFactory.HELVETICA, 10, new Color(44, 44, 44));
            Font sectionHeaderFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, Color.WHITE);
            Font regularFont = FontFactory.getFont(FontFactory.HELVETICA, 10, Color.BLACK);
            Font boldFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, Color.BLACK);

            // Header Section
            Paragraph title = new Paragraph("DIPAK SARPANE BRICK INDUSTRIES", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);

            Paragraph tagline = new Paragraph("Strong Foundations Begin With Quality Bricks", subTitleFont);
            tagline.setAlignment(Element.ALIGN_CENTER);
            tagline.setSpacingAfter(10);
            document.add(tagline);

            Paragraph contactInfo = new Paragraph("Owner: Dipak Sarpane | Phone: +91 95884 30156 | Email: dipaksarpane@gmail.com\nFactory Addr: Hingangaon Bk, Paranda, Osmanabad (Dharashiv), Maharashtra - 413502", subTitleFont);
            contactInfo.setAlignment(Element.ALIGN_CENTER);
            contactInfo.setSpacingAfter(20);
            document.add(contactInfo);

            // Quote Details
            PdfPTable metaTable = new PdfPTable(2);
            metaTable.setWidthPercentage(100);
            metaTable.setSpacingAfter(20);

            PdfPCell leftCell = new PdfPCell();
            leftCell.setBorder(Rectangle.NO_BORDER);
            leftCell.addElement(new Paragraph("QUOTATION ESTIMATE", boldFont));
            leftCell.addElement(new Paragraph("Quote Number: " + quotation.getQuotationNumber(), regularFont));
            leftCell.addElement(new Paragraph("Date: " + quotation.getRequestDate().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm")), regularFont));
            leftCell.addElement(new Paragraph("Validity: 15 Days from Date", regularFont));
            metaTable.addCell(leftCell);

            PdfPCell rightCell = new PdfPCell();
            rightCell.setBorder(Rectangle.NO_BORDER);
            rightCell.addElement(new Paragraph("PREPARED FOR", boldFont));
            rightCell.addElement(new Paragraph("Client: " + quotation.getFullName(), regularFont));
            rightCell.addElement(new Paragraph("Mobile: " + quotation.getMobileNumber(), regularFont));
            rightCell.addElement(new Paragraph("Site Address: " + quotation.getFullAddress(), regularFont));
            metaTable.addCell(rightCell);

            document.add(metaTable);

            // Table
            PdfPTable itemTable = new PdfPTable(5);
            itemTable.setWidthPercentage(100);
            itemTable.setWidths(new float[]{1, 4, 2, 2, 2});
            itemTable.setSpacingAfter(20);

            String[] headers = {"S.No", "Product Name", "Quantity", "Base Unit Price", "Est. Total (INR)"};
            for (String header : headers) {
                PdfPCell cell = new PdfPCell(new Phrase(header, sectionHeaderFont));
                cell.setBackgroundColor(new Color(44, 44, 44));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setPadding(8);
                itemTable.addCell(cell);
            }

            itemTable.addCell(createCenterCell("1", regularFont));
            itemTable.addCell(createLeftCell(quotation.getProductTypeName(), regularFont));
            itemTable.addCell(createCenterCell(String.valueOf(quotation.getQuantity()), regularFont));
            itemTable.addCell(createRightCell(String.format("%.2f", quotation.getProduct().getPrice()), regularFont));
            itemTable.addCell(createRightCell(String.format("%.2f", quotation.getEstimatedProductCost()), regularFont));

            document.add(itemTable);

            // Financial Summary Block
            PdfPTable summaryTable = new PdfPTable(2);
            summaryTable.setWidthPercentage(40);
            summaryTable.setHorizontalAlignment(Element.ALIGN_RIGHT);
            summaryTable.setSpacingAfter(30);

            summaryTable.addCell(createLeftCell("Base Cost:", boldFont));
            summaryTable.addCell(createRightCell(String.format("%.2f", quotation.getEstimatedProductCost()), regularFont));

            BigDecimal gstRatePercent = systemSettingService.getGstRatePercent();
            summaryTable.addCell(createLeftCell("GST (" + gstRatePercent + "%):", boldFont));
            summaryTable.addCell(createRightCell(String.format("%.2f", quotation.getEstimatedGstAmount()), regularFont));

            summaryTable.addCell(createLeftCell("Transport Cost:", boldFont));
            summaryTable.addCell(createRightCell(String.format("%.2f", quotation.getEstimatedTransportCost()), regularFont));

            PdfPCell totalLabel = new PdfPCell(new Phrase("Est. Total:", titleFont));
            totalLabel.setBorder(Rectangle.NO_BORDER);
            summaryTable.addCell(totalLabel);

            PdfPCell totalVal = new PdfPCell(new Phrase("INR " + String.format("%.2f", quotation.getTotalEstimatedCost()), titleFont));
            totalVal.setBorder(Rectangle.NO_BORDER);
            totalVal.setHorizontalAlignment(Element.ALIGN_RIGHT);
            summaryTable.addCell(totalVal);

            document.add(summaryTable);

            Paragraph footer = new Paragraph("Disclaimer: This quotation is an estimate only and subject to variation based on transportation fuel costs, site conditions, and order sizes. Please contact us to lock-in prices.", subTitleFont);
            footer.setAlignment(Element.ALIGN_CENTER);
            document.add(footer);

            document.close();
        } catch (DocumentException e) {
            e.printStackTrace();
        }

        return new ByteArrayInputStream(out.toByteArray());
    }

    private PdfPCell createLeftCell(String text, Font font) {
        PdfPCell cell = new PdfPCell(new Paragraph(text, font));
        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
        cell.setPadding(6);
        return cell;
    }

    private PdfPCell createCenterCell(String text, Font font) {
        PdfPCell cell = new PdfPCell(new Paragraph(text, font));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setPadding(6);
        return cell;
    }

    private PdfPCell createRightCell(String text, Font font) {
        PdfPCell cell = new PdfPCell(new Paragraph(text, font));
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        cell.setPadding(6);
        return cell;
    }
}
