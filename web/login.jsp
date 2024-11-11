<%-- 
    Document   : login
    Created on : 19-Oct-2024, 8:47:52 pm
    Author     : HOME
--%>

<%@page import="javax.crypto.SecretKey"%>
<%@page import="java.util.Base64"%>
<%@page import="java.sql.*"%>
<%@page import="javax.crypto.Cipher"%>
<%@page import="javax.crypto.spec.SecretKeySpec"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    

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
    %>

<%   
     //scriptlet
if(request.getParameter("login")!=null)
{
String username=request.getParameter("username");
String password=request.getParameter("password");

try
{
     
            
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection con;
                PreparedStatement pre;
                
                con=DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:1433;databasename=uvei;TrustServerCertificate=True;user=uver;password=1234");
                pre=con.prepareStatement("select * from admin_tbl  where username=? and password=?");
                pre.setString(1, username);
                pre.setString(2,encrypt(password,SECRET_KEY));
            
                ResultSet rs =pre.executeQuery();
                
                if(rs.next())
                {
                    session.setAttribute("username",rs.getString("username"));
                     %>
<script>
    alert("Login successful");
    location.replace("welcome.jsp");
    </script>
<%
       
                }
                else
                {
                    %>
<script>
    alert("login failed");
    </script>
<%
                }
        }

catch(Exception e)

{
%>
<script>
    alert("<%= e%>");
    </script>
<%
}
}
%>

   








<!DOCTYPE html>
<html>
   <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>
    <body class="container">
        <h1>Admin Login Page</h1>
        <div>
            <form method="post">
                <label>username</label>
                <input type="text" name="username" class="form-control" required="">
                <br>
                <label>Password</label>
                <input type="password" name="password" class="form-control" required="">
                 <br>
                 
                <div class="container mt-2">

                 <div class="row">
                     <div class="col">
                <button class="btn btn-primary" name="login">Login</button>
                </div>
                 </form>
            
                 <div class="col">
                <a href="signup.jsp" class="btn btn-primary">signup</a>
                </div>
                
                <div class="col">
                <a href="forget_password.jsp" class="btn btn-primary">forgot password</a>
 
                    </div>

                 </div>
            
              
        </div>
            <jsp:include page="footer.jsp"></jsp:include>

    </body>
    </html>