/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.entities;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.mycompany.spring_mvc_project_final.entities.OrderDetailEntity;
import com.mycompany.spring_mvc_project_final.entities.OrderEntity;
import java.awt.Color;
import java.io.IOException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author NhatHuu
 */
public class OrderPDFExporter1 {

    private List<OrderEntity> orders;

    public OrderPDFExporter1(List<OrderEntity> orders) {
        this.orders = orders;
    }

    private void writeTableHeader(PdfPTable table) {
        PdfPCell cell = new PdfPCell();
        cell.setBackgroundColor(Color.LIGHT_GRAY);
        cell.setPadding(5);

        Font font = FontFactory.getFont(FontFactory.HELVETICA);
        font.setColor(Color.BLACK);

        cell.setPhrase(new Phrase("Or-UID", font));
        table.addCell(cell);

        cell.setPhrase(new Phrase("E-mail", font));
        table.addCell(cell);

        cell.setPhrase(new Phrase("Phone", font));
        table.addCell(cell);

        cell.setPhrase(new Phrase("OrderDate", font));
        table.addCell(cell);

        cell.setPhrase(new Phrase("TotalPrice", font));
        table.addCell(cell);

        cell.setPhrase(new Phrase("Status", font));
        table.addCell(cell);
    }
    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");

    private void writeTableData(PdfPTable table) {
        Locale localeVN = new Locale("vi", "VN");
        NumberFormat vn = NumberFormat.getInstance(localeVN);
        for (OrderEntity order : orders) {
            table.addCell(order.getOrderUId().substring(0, 8));
            table.addCell(order.getEmail());
            table.addCell(order.getPhone().toString());
            table.addCell(formatter.format(order.getDateOrder()).toString());
            table.addCell(vn.format(order.getTotalOrder()) + " VND");
            table.addCell(order.getStatus().toString());
        }
    }

    private void writeTableHeader2(PdfPTable table) {
        PdfPCell cell = new PdfPCell();
        cell.setBackgroundColor(Color.LIGHT_GRAY);
        cell.setPadding(5);

        Font font = FontFactory.getFont(FontFactory.HELVETICA);
        font.setColor(Color.BLACK);

        cell.setPhrase(new Phrase("Product Name", font));
        table.addCell(cell);

        cell.setPhrase(new Phrase("Discount", font));
        table.addCell(cell);

        cell.setPhrase(new Phrase("Quantity", font));
        table.addCell(cell);

        

    }

    private void writeTableData2(PdfPTable table, OrderEntity order) {
        for (OrderDetailEntity orderDtail : order.getOrderDetail()) {
            table.addCell(orderDtail.getProduct().getName());
            table.addCell(String.valueOf(orderDtail.getDiscount() * 100) + "%");
            table.addCell(String.valueOf(orderDtail.getQuantity()));
        }
    }

    public void export(HttpServletResponse response) throws DocumentException, IOException {
        Document document = new Document(PageSize.A4);
        PdfWriter.getInstance(document, response.getOutputStream());

        document.open();
        Font font = FontFactory.getFont(FontFactory.HELVETICA_BOLD);
        font.setSize(18);
        font.setColor(Color.BLACK);

        Paragraph p = new Paragraph("List of Orders", font);
        p.setAlignment(Paragraph.ALIGN_CENTER);
        document.add(p);
        PdfPTable table = new PdfPTable(6);
        table.setWidthPercentage(100f);
        table.setWidths(new float[]{2.0f, 4.0f, 2.3f, 2.0f, 1.8f, 2.2f});
        table.setSpacingBefore(10);
        writeTableHeader(table);
        writeTableData(table);
        document.add(table);

//      table OrderDetail
        Font font2 = FontFactory.getFont(FontFactory.HELVETICA_BOLD);
        font2.setSize(14);
        font2.setColor(Color.BLACK);
        for (OrderEntity order : orders) {
            Paragraph p2 = new Paragraph("Order: " + order.getOrderUId().substring(0, 8) + " (" + order.getEmail() + ")", font2);
            p2.setAlignment(Paragraph.ALIGN_LEFT);
            p2.setSpacingBefore(10);
            document.add(p2);

            PdfPTable table2 = new PdfPTable(3);
            table2.setWidthPercentage(100f);
            table2.setWidths(new float[]{4.5f, 3.0f, 3.0f});
            table2.setSpacingBefore(10);
            writeTableHeader2(table2);
            writeTableData2(table2, order);
            document.add(table2);

            Locale localeVN = new Locale("vi", "VN");
            NumberFormat vn = NumberFormat.getInstance(localeVN);
            Font font3 = FontFactory.getFont(FontFactory.HELVETICA_BOLD);
            font3.setSize(12);
            font3.setColor(Color.BLACK);
            Paragraph p3 = new Paragraph("Total Price: " + vn.format(order.getTotalOrder())+ " VND", font3);
            p3.setAlignment(Paragraph.ALIGN_RIGHT);
            document.add(p3);
        }

        document.close();

    }
}

