/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;


@MultipartConfig

public class get_pupdate extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String id =request.getParameter("id");
        
        if(id!=null)
            
        {      
            try{
            
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection con=DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:1433;databasename=uvei;TrustServerCertificate=True;user=uver;password=1234");
            PreparedStatement sta=con.prepareStatement("select * from prod_table where id = ?");
            
                sta.setString(1, id);
                
                ResultSet rs=sta.executeQuery();
                
                if(rs.next())
                {
                    request.setAttribute("id", rs.getString("id"));
                    
                    request.setAttribute("name", rs.getString("name"));

                    request.setAttribute("rate", rs.getString("rate"));

                    request.setAttribute("image", rs.getBytes("image"));
                    
                }
                
                RequestDispatcher dispatcher= request.getRequestDispatcher("/update_product.jsp");
                dispatcher.forward(request, response);
                
            }
            catch(Exception ex)
            {
                ex.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,"Database error");
            }
            
        }
           
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String id =request.getParameter("id");
        String name =request.getParameter("name");
        String rate =request.getParameter("rate");
        Part filePart =request.getPart("image");
        
        
        byte[] imageBytes=null;
        
       if(filePart !=null && filePart.getSize()>0)
          {
       try(InputStream io=filePart.getInputStream())
           {
              imageBytes= new byte[(int)filePart.getSize()];
              io.read(imageBytes);
           }
       catch(Exception e)
             {
                 e.printStackTrace();
              }
        
        
            try(Connection con=DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:1433;databasename=uvei;TrustServerCertificate=True;user=uver;password=1234");
                PreparedStatement pre=con.prepareStatement("update prod_table set name= ? ,rate =? ,image =? where id = ?"))
            {
                pre.setString(2, rate);
                pre.setString(1,name);
                pre.setBytes(3, imageBytes);
                pre.setString(4, id);

                int a= pre.executeUpdate();
                
                if(a>0)
                {
                    request.setAttribute("message", "updated successfully");

                }
                else
                {
                    request.setAttribute("message", "not updated");

                }

                     RequestDispatcher dispatcher= request.getRequestDispatcher("/update_product.jsp");
                     dispatcher.forward(request, response);

            } 
            catch (Exception ex)
            {
                
             ex.printStackTrace();
        }
            
                request.getRequestDispatcher("/update_product.jsp").forward(request, response);

    }
        
         doGet(request,response);   
}
    
}
