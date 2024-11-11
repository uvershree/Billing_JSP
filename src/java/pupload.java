/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.InputStream;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author HOME
 */
@MultipartConfig
public class pupload extends HttpServlet {

     @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id=request.getParameter("id");

        String name=request.getParameter("name");

        String rate=request.getParameter("rate");

        Part filePart =request.getPart("image");
        
         InputStream io=null;
        
        try{
            
                 io=filePart.getInputStream();
                 Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection con;
                PreparedStatement pre;

                
                con=DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:1433;databasename=uvei;TrustServerCertificate=True;user=uver;password=1234");
                pre=con.prepareStatement("select id from prod_table where id=?");
                pre.setString(1, id);
                
                 ResultSet rs =pre.executeQuery();
                
                if(rs.next())
                {
                request.setAttribute("message",  "id" + id + "already exists");
                request.getRequestDispatcher("/add_product.jsp").forward(request, response);
                }
                else
                {  
                     PreparedStatement ins;

                    ins=con.prepareStatement("insert into prod_table(id,name,rate,image) values (?,?,?,?)");
                    ins.setString(1, id);
                    ins.setString(2, name);
                    ins.setString(3, rate);

                
                
                if(io!=null)
                {
                    ins.setBlob(4,io);

                }
                
                int row=ins.executeUpdate();
                if(row>0)
                {
                 request.setAttribute("message",  "image has succesfully uploaded with number :" +id);

                }
                else
                    {
                 request.setAttribute("message",  "Error in uploading image");

                }
                 request.getRequestDispatcher("/add_product.jsp").forward(request, response);

                }
               rs.close();
               pre.close();
               con.close();

                
                
        }
        catch(Exception e)
        {
             e.printStackTrace();   // out.print(e);
               request.setAttribute("message",  "Error:" + e.getMessage() );
                request.getRequestDispatcher("/add_product.jsp").forward(request, response);
                
        }
    }
}

  

  
  
    