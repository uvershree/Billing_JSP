<%-- 
    Document   : signup
    Created on : 19-Oct-2024, 9:40:51 pm
    Author     : HOME
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.crypto.SecretKey"%>
<%@page import="java.util.Base64"%>
<%@page import="java.sql.*"%>
<%@page import="javax.crypto.Cipher"%>
<%@page import="javax.crypto.spec.SecretKeySpec"%>

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
if(request.getParameter("signup")!=null)
{
String username=request.getParameter("username");
String password=request.getParameter("password");
String question=request.getParameter("question");
String answer=request.getParameter("answer");



try
{

Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection con;
                PreparedStatement pre;
                
                con=DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:1433;databasename=uvei;TrustServerCertificate=True;user=uver;password=1234");
                pre=con.prepareStatement("sp_insert ? ,? ,? ,? ");
                pre.setString(1, username);
                pre.setString(2,encrypt(password,SECRET_KEY));
                pre.setString(3, question);
                pre.setString(4, answer);
                
                int exec =pre.executeUpdate();
                
                if(exec!=0)
                {
                %>
                <script>
                    alert("Signup Successful");
                    location.assign("http://localhost:8080/appvalue/login.jsp");
                </script>
                
                <%
}
else{
%>
                <script>
                    alert("Signup Successful");
                </script>
                
                <%
                
    }
}
    catch(Exception e)
    {
    
%>
                <script>
                    alert("<%=e%>");
                </script>
                
                <%
}









    }




%>











<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign Page</title>
                        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    </head>
    <body class="container">
        <h1 style="text-align: center"> admin signup Page</h1>

        <div>
            <form method="post">
                
                <div class="form-group">
                <label>username</label>
                <input type="text" name="username" class="form-control" required="">
        </div>
                 <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" class="form-control" required="">
                
        </div>
                 <div class="form-group">
                 <label>question</label>
                <input type="text" name="question" class="form-control" required="">
                
        </div>
                 <div class="form-group">
                <label>answer</label>
                <input type="text" name="answer" class="form-control" required="">
                        </div>

                               <div class="container mt-3">

            
                    <div class="row">
                    <div class="col">
                <button class="btn btn-primary" name="signup">signup</button>
        </div>

            </form>
            
            <div class="col">
              <a href="login.jsp"  class="btn btn-primary" > go to Login</a>
        </div>
         </div>
        </div>

    </body>
</html>
