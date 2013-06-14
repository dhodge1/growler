/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.scripps.growler;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author 162107
 */
public class PDFServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PDFServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PDFServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {            
            out.close();
        }
    }
    
    protected void service(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            // step 1
            Document document = new Document();
            // step 2
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            PdfWriter.getInstance(document, baos);
            // step 3
            document.open();
            // step 4
            addContent(document);
            // step 5
            document.close();
 
            // setting some response headers
            response.setHeader("Expires", "0");
            response.setHeader("Cache-Control",
                "must-revalidate, post-check=0, pre-check=0");
            response.setHeader("Pragma", "public");
            // setting the content type
            response.setContentType("application/pdf");
            // the contentlength
            response.setContentLength(baos.size());
            // write ByteArrayOutputStream to the ServletOutputStream
            OutputStream os = response.getOutputStream();
            baos.writeTo(os);
            os.flush();
            os.close();
        }
        catch(DocumentException e) {
            throw new IOException(e.getMessage());
        }
    }
    
    public void addContent(Document document) throws DocumentException {
        ReportGenerator rg = new ReportGenerator();
        ArrayList<SurveyReport> report = rg.generateSurveyReport();
        PdfPTable table = new PdfPTable(3);
//        float[] columnWidth = {10, 45, 45};
//        Rectangle pageSize = new Rectangle((float) 8.5, 11);
//        table.setWidthPercentage(columnWidth, pageSize);
        float cellHeight = 5;
        PdfPCell c1 = new PdfPCell(new Phrase("Entry Number"));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        c1.setFixedHeight(cellHeight);


        table.addCell(c1);

        PdfPCell c2 = new PdfPCell(new Phrase("User Name"));
        c2.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(c2);

        PdfPCell c3 = new PdfPCell(new Phrase("Session Name"));
        c3.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(c3);

        table.setHeaderRows(1);

        for (int i = 0; i < report.size(); i++) {
            PdfPCell c4 = new PdfPCell();
            c4.setHorizontalAlignment(Element.ALIGN_LEFT);
            c4.setFixedHeight(cellHeight);
            c4.setPhrase(new Phrase(String.valueOf(i + 1)));
            c4.setBorderWidthBottom((float)1.5);
            table.addCell(c4);
            table.addCell(report.get(i).getUser().getUserName());
            table.addCell(report.get(i).getSession().getName());
        }
        try {
            document.add(table);
        } catch (DocumentException ex) {
            Logger.getLogger(ReportGenerator.class.getName()).log(Level.SEVERE, null, ex);
        }

    }


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
