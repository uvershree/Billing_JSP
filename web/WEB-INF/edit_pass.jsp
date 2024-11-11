

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Base64"%>
<%@page import="javax.crypto.spec.SecretKeySpec"%>
<%@page import="javax.crypto.Cipher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%!
   public static String decrypt(String encryptedData,String secretKey) throws Exception            
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
 if(request.getParameter("save")!=null)
   {
    
String id=request.getParameter("id");
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
                pre=con.prepareStatement("update amin_tbl set username=?,password=?,question=?,answer=? where id=?");
                pre.setString(5, id);

                pre.setString(1, username);
                pre.setString(2,encrypt(password,SECRET_KEY));
                pre.setString(3, question);
                pre.setString(4, answer);
                
                int i =pre.executeUpdate();
                
                if(i!=0)
                {
                %>
             <script>
                    alert(" updated");
                    location.assign("http://localhost:8080/appvalue/admin_page.jsp");

                </script>
                
                <%
}
else
{
%>
                <script>
                    alert(" not updated");

                </script>
                
                <%
}
}
     
catch (Exception ex)
{

}
}
   %>
    
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>welcome to Edit Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    </head>
    <body>
        <h1>EDIT PASSWORD</h1>
   <form>
<%            

String id=request.getParameter("id");
try{
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection con;
                PreparedStatement pre;
                
                con=DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:1433;databasename=uvei;TrustServerCertificate=True;user=uver;password=1234");
                pre=con.prepareStatement("select * from where id=?");
                pre.setString(1, id);
                
                ResultSet rs =pre.executeQuery();
                
                if(rs.next())
                {
                %>

                <div class="form-group">
                <label>ID</label>
                <input type="text" name="username"  value="<%= rs.getString("id")%>" class="form-control">
        </div>
                <div class="form-group">
                <label>username</label>
                <input type="text" name="username"  value="<%= rs.getString("username")%>" class="form-control" required="">
        </div>
                 <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" value="<%= rs.getString("Password")%>" class="form-control" required="">
                
        </div>
                 <div class="form-group">
                 <label>question</label>
                <input type="text" name="question" value="<%= rs.getString("question")%>" class="form-control" required="">
                
        </div>
                 <div class="form-group">
                <label>answer</label>
                <input type="text" name="answer" value="<%= rs.getString("answer")%>" class="form-control" required="">
                        </div>
                        
   <% 
   %>
                <script>
                    alert(" inserted=<%=rs.getString("id")%>");
                </script>
                
                <%
     }
else
{
%>
                <script>
                    alert(" ID not inserted");
                    location.assign("http://localhost:8080/appvalue/edit_pass.jsp");

                </script>
                
                <%
}
}
catch(Exception ex)
{
out.print(ex);
}


 %>
                     <div class="row">
                            <div class="col">

                                <input type="submit" value="delete" name="delete" class="btn btn-primary">   

                            </div>
                       </div>

   </form>

   <div class="col">

       <input type="submit" value="delete" name="delete" class="btn btn-primary">
   
   </div></div>


   <div class="col">

       <input type="submit" value="delete" name="delete" class="btn btn-primary">

   </div>

   </body>
   <jsp:include page="footer.jsp"></jsp:include>

</html>                            