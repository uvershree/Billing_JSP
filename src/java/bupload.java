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
public class bupload extends HttpServlet {

     @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String number=request.getParameter("number");

        String username=request.getParameter("username");

        String gender=request.getParameter("gender");

        Part filePart =request.getPart("image");
        
         InputStream io=null;
        
        try{
            
                 io=filePart.getInputStream();
                 Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection con;
                PreparedStatement pre;

                
                con=DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:1433;databasename=uvei;TrustServerCertificate=True;user=uver;password=1234");
                pre=con.prepareStatement("select number from addbuyer_tbl where number=?");
                pre.setString(1, number);
                
                 ResultSet rs =pre.executeQuery();
                
                if(rs.next())
                {
                request.setAttribute("message",  "usernumber" + number + "already exists");
                request.getRequestDispatcher("/addbuyer.jsp").forward(request, response);
                }
                else
                {  
                     PreparedStatement ins;

                    ins=con.prepareStatement("insert into addbuyer_tbl(username,number,gender,image) values (?,?,?,?)");
                    ins.setString(1, username);
                    ins.setString(2, number);
                    ins.setString(3, gender);

                
                
                if(io!=null)
                {
                    ins.setBlob(4,io);

                }
                
                int row=ins.executeUpdate();
                if(row>0)
                {
                 request.setAttribute("message",  "image has succesfully uploaded with number :" +number);

                }
                else
                    {
                 request.setAttribute("message",  "Error in uploading image");

                }
                 request.getRequestDispatcher("/addbuyer.jsp").forward(request, response);

                }
               rs.close();
               pre.close();
               con.close();

                
                
        }
        catch(Exception e)
        {
             e.printStackTrace();   // out.print(e);
               request.setAttribute("message",  "Error:" + e.getMessage() );
                request.getRequestDispatcher("/addbuyer.jsp").forward(request, response);
                
        }
    }
}

  

  
  
    