<%-- 
    Document   : reset
    Created on : 24-Oct-2024, 6:29:30 pm
    Author     : HOME
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.crypto.spec.SecretKeySpec"%>
<%@page import="java.util.Base64"%>
<%@page import="javax.crypto.Cipher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    public static String encrypt(String data, String secretKey) throws Exception {
        Cipher cipher = Cipher.getInstance("AES");
        SecretKeySpec secretKeySpec = new SecretKeySpec(secretKey.getBytes(), "AES");
        cipher.init(cipher.ENCRYPT_MODE, secretKeySpec);

        byte[] encryptedBytes = cipher.doFinal(data.getBytes());
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }
    private final String SECRET_KEY = "1234567890123456";
%>

<%

if(session.getAttribute("username")==null)
{
       response.sendRedirect("login.jsp");
    }
if(request.getParameter("logout")!=null)
{
session.removeAttribute("username");
response.sendRedirect("login.jsp");
}
    if (request.getParameter("reset") != null) {
        String username = request.getParameter("username");
        String Password = request.getParameter("Password");
        String repass = request.getParameter("repassword");
        String copass = request.getParameter("copassword");

        try
        
        {
        if(copass.equals(repass)&& repass.equals(copass))
        {
        
              Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                
                PreparedStatement pre;
                Connection con;
                
                con=DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:1433;databasename=uvei;TrustServerCertificate=True;user=uver;password=1234");
                pre=con.prepareStatement("sp_chpwd ? , ? ");
                pre.setString(1, username);
                pre.setString(2, encrypt(repass,SECRET_KEY));

                int a = pre.executeUpdate();
                
                if(a!=0)
                {
              

        %>
    <script>
        
   alert("password changed");
   
   location.assign("http://localhost:8080/appvalue/login.jsp");

     </script> 
     <%
         
    }
else
{
%>
    <script>
    alert("not password changed");

     </script> 
     <%
         
}
}
else{
%>
    <script>
    alert("password not matched");
    
  // location.assign("http://localhost:8080/appvalue/reset.jsp");

     </script> 
     <%
         
}
}
    catch(Exception ex)
    {
    %>
    <script>
    alert("<%=ex%>");
     </script> 
     <%
    }
    }


%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

        <title>Reset Page</title>
    </head>
    <body class="container">
        <h1 style="text-align: center"> RESET PASSWORD</h1>
        <br>        <br>

        <%            String uname = (String) session.getAttribute("username");

        %>
        <div style="margin-bottom: 100px;">
            <h2 style="text-align: center; font-style: italic;">welcome <%=uname%> !</h2>
            <br>
            <br>
            <form>
                <div align="right" style="margin-top:-150px">
                    <input type="submit" name="logout" class="btn btn-danger" value="logout">

                </div>
            </form> 
        </div>

        <div style="margin-top: 50px;">
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
                    <label>Reset password</label>
                    <input type="text" name="repassword" class="form-control" required="">

                </div>
                <div class="form-group">
                    <label>confirm password</label>
                    <input type="text" name="copassword" class="form-control" required="">
                </div>

                <div class="container mt-3">


                    <div class="row">
                        <div class="col">
                            <button class="btn btn-primary" name="reset">RESET</button>
                        </div>

                        </form>


                        <div class="col">

                            <a href="login.jsp" class="btn btn-primary">go to login page</a>

                        </div> 
                    </div>
                </div>


        </div>   

    </body>
</html>
