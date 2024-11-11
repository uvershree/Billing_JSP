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

public class get_update extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        String number =request.getParameter("number");
        
        if(number!=null)
            
        {      
            try{
            
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection con=DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:1433;databasename=uvei;TrustServerCertificate=True;user=uver;password=1234");
            PreparedStatement sta=con.prepareStatement("select * from addbuyer_tbl where number = ?");
            
                sta.setString(1, number);
                
                ResultSet rs=sta.executeQuery();
                
                if(rs.next())
                {
                    request.setAttribute("number", rs.getString("number"));
                    
                    request.setAttribute("username", rs.getString("username"));

                    request.setAttribute("gender", rs.getString("gender"));

                    request.setAttribute("image", rs.getBytes("image"));
                    
                }
                else
                {
                   request.setAttribute("message", "number don't exist");

                }
                
                RequestDispatcher dispatcher= request.getRequestDispatcher("/get_buyer.jsp");
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
        
        String number =request.getParameter("number");
        String username =request.getParameter("username");
        String gender =request.getParameter("gender");
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
                PreparedStatement pre=con.prepareStatement("update addbuyer_tbl set username= ? ,gender =? ,image =? where number = ?"))
            {
                pre.setString(2, gender);
                pre.setString(1,username);
                pre.setBytes(3, imageBytes);
                pre.setString(4, number);

                int a= pre.executeUpdate();
                
                if(a>0)
                {
                    request.setAttribute("message", "updated successfully");

                }
                else
                {
                    request.setAttribute("message", "not updated");

                }

                     RequestDispatcher dispatcher= request.getRequestDispatcher("/get_buyer.jsp");
                     dispatcher.forward(request, response);

            } 
            catch (Exception ex)
            {
                
             ex.printStackTrace();
        }
            
                request.getRequestDispatcher("/get_buyer.jsp").forward(request, response);

    }
        
         doGet(request,response);   
}
    
}
