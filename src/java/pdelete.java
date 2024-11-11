/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class pdelete extends HttpServlet {

 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String id=request.getParameter("id");
        
         try(Connection con=DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:1433;databasename=uvei;TrustServerCertificate=True;user=uver;password=1234");
                PreparedStatement pre=con.prepareStatement("delete from prod_table where id = ?"))
            {
                pre.setString(1, id);

                int a= pre.executeUpdate();
                
               if(a>0)
               {
                   request.setAttribute("message", "Record deleted successfully!");

               }
               else
               {
                   request.setAttribute("message", "Record deletion was unsuccessful!");

               }
                    
        
        
        
}       catch (Exception ex) {
            request.setAttribute("message", "Database error");

        }
         
            request.getRequestDispatcher("/update_product.jsp").forward(request, response);


    }
}