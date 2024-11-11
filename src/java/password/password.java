/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package password;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;
import java.sql.*;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author HOME
 */
public class password extends HttpServlet {
public static String decrypt(String encryptedData,String secretKey) throws Exception              //declaration tag
{
    Cipher cipher=Cipher.getInstance("AES");
    SecretKeySpec secretKeySpec = new SecretKeySpec(secretKey.getBytes(),"AES");
    cipher.init(cipher.DECRYPT_MODE,secretKeySpec);
    byte[] decodedBytes =Base64.getDecoder().decode(encryptedData);
    byte[] decryptedBytes =cipher.doFinal(decodedBytes);
    return new String(decryptedBytes);
}

    public static String encrypt(String data,String secretKey) throws Exception
   {
    Cipher cipher=Cipher.getInstance("AES");
    SecretKeySpec secretKeySpec = new SecretKeySpec(secretKey.getBytes(),"AES");
    cipher.init(cipher.ENCRYPT_MODE,secretKeySpec);
    
    byte[] encryptedBytes =cipher.doFinal(data.getBytes());
    return Base64.getEncoder().encodeToString(encryptedBytes);
}
     private final String SECRET_KEY="1234567890123456";
   
     
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


  
String username=request.getParameter("username");
String question=request.getParameter("question");
String answer=request.getParameter("answer");


                Connection con=null;
                String message=null;

  try
     {

                 Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                
                PreparedStatement pre;
                
                con=DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:1433;databasename=uvei;TrustServerCertificate=True;user=uver;password=1234");
                pre=con.prepareStatement("select password from admin_tbl where username=? and question=? and answer=?");
                pre.setString(1, username);
                pre.setString(2, question);
                pre.setString(3, answer);
                
               ResultSet rs=pre.executeQuery();
               
               if(rs.next())
               {
                   String password=rs.getString("password");
                   String depass=decrypt(password,SECRET_KEY);
                   message="your password is" +depass;
                   
               }
               else
                   
                   message="Invalid information provided!";
     }
  
  
  catch(Exception ex)
  {
      
      ex.printStackTrace();
      
      message ="an error occured:" +ex.getMessage();
      
  }
  finally
  {
      if(con!=null)
      {
          try
          {
              con.close();
          }
          catch(Exception ex)
          {
              ex.printStackTrace();
          }
      }
  }
  
     request.setAttribute("message", message);
     getServletContext().getRequestDispatcher("/forget_password.jsp").forward(request, response);
  
    }
    
}


        
     
