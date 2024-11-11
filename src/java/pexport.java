/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import com.itextpdf.text.PageSize;
import com.itextpdf.text.Document;
import com.itextpdf.text.Image;
import com.itextpdf.text.PdfPTable;
import com.itextpdf.text.PdfWriter;
import com.sun.xml.registry.uddi.bindings_v2_2.DispositionReport;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/export")
public class pexport extends HttpServlet {
  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
String action=request.getParameter("action");


if("pdf".equalsIgnoreCase(action))
{
    try {
        exportToPdf(response);
    } catch (SQLException ex) {
        Logger.getLogger(export.class.getName()).log(Level.SEVERE, null, ex);
    }
}
else if("csv".equalsIgnoreCase(action))
{

    try {
        exportToCsv(response);
    } catch (SQLException ex) {
        Logger.getLogger(export.class.getName()).log(Level.SEVERE, null, ex);
    }
    }

  }

   

    
     private void exportToPdf (HttpServletResponse response)
            throws IOException, SQLException {
         response.setContentType("application/pdf");
         
        response.setHeader("content-Disposition","attachment; filename=\"buyer.pdf\"");
        
        try{
            
            
            Document document= new Document(PageSize.A4);
            pdfWriter.getInstance((javax.swing.text.Document) document,response.getOutputStream());
            document.open();
            
            
            pdfTable pdftable=new pdfTable();
            
            pdftable.addCell("id");
            pdftable.addCell("name");

            pdftable.addCell("rate");

            pdftable.addCell("image");

               Connection con=DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:1433;databasename=uvei;TrustServerCertificate=True;user=uver;password=1234");
             PreparedStatement pre=con.prepareStatement("select * from prod_table");

                 ResultSet rs =pre.executeQuery();
                       while(rs.next())
                 {
                 pdfTable.addCell(rs.getString("id"));
                 pdfTable.addCell(rs.getString("name"));

                 pdfTable.addCell(rs.getString("rate"));

                  byte[] imageBytes=rs.getBytes("image");
                  Image image=Image.getInstance(imageBytes);

                  
                  pdfTable.addCell(image);
                 }
        
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        
        
    }
    
    
    
  
    
     private void exportToCsv (HttpServletResponse response)
            throws IOException, SQLException {
         
        response.setContentType("text/csv");
         
        response.setHeader("content-Disposition","attachment; filename=\"buyer.pdf\"");
        
        OutputStream os=response.getOutputStream ();
        StringBuilder csvBuilder =new StringBuilder();
        csvBuilder.append("id,name,gender,image\n");
        
        try{
             Connection con=DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:1433;databasename=uvei;TrustServerCertificate=True;user=uver;password=1234");
             PreparedStatement pre=con.prepareStatement("select * from prod_table");

                 ResultSet rs =pre.executeQuery();
                 while(rs.next())
                 {
                 csvBuilder.append(rs.getString("id"))
                         
                .append(",").append(rs.getString("name")).append(",")

                 .append(rs.getString("rate")).append(",")

                  .append(rs.getBytes("image")).append("\n");

                  
           }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
       
          os.write(csvBuilder.toString().getBytes());
           os.flush();
            os.close();

           
           }
       
    } 

    
  
     
     
    


