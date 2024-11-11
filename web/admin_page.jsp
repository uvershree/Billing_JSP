

<%@page import="java.util.Base64"%>
<%@page import="javax.crypto.spec.SecretKeySpec"%>
<%@page import="javax.crypto.Cipher"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
   
if(request.getParameter("delete")!=null)
{
String id=request.getParameter("id");
try
{
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection con;
                PreparedStatement pre;
                
                con=DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:1433;databasename=uvei;TrustServerCertificate=True;user=uver;password=1234");
                pre=con.prepareStatement("delete admin_tbl where id=?");
                pre.setString(1,id);
                
                int i=pre.executeUpdate();
                
                if(i!=0)
                {
                %>
                
                <script>
                    alert("DELETED");
                    location.assign("http://localhost:8080/appvalue/admin_page.jsp");

                </script>
                <%
                                 
}
else
{
%>
                <script>
                    alert("NOT DELETED");
                </script>
                
                <%
}
}
catch(Exception ex)
{
out.print(ex);
}
}

%>

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
     private final String SECRET_KEY="1234567890123456";
%> 

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign Page</title>
                        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>
    <body class="container">
        <nav class="navbar navbar-expand-lg navbar-dark  bg-dark">
            <div class="container-fluid">
                <div class="collapse navbar-collapse"  id="navbarnav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="welcome.jsp">back</a>

                        </li>
                        </ul>
                </div>   
            </div>   
        </nav>
        
        <h1 style="text-align: center"> admin Page</h1>
        <div>
        <div class="row">
        <div class="col">

        <% 
            String uname=(String) session.getAttribute("username");
            %>
            <h2 style="text-align: center; font-style: italic;">Hi Welcome <%=uname%> !</h2>
            <form class="">
                
            <input type="submit" value="logout" name="logout" class="btn btn-primary">

            </form>
             </div>
        </div>
            <br><br>
            <table class="table table-scripted">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">NAME</th>
                        <th scope="col">PASSWORD</th>
                        <th scope="col">QUESTION</th>
                        <th scope="col">ANSWER</th>
                        <th scope="col">EDIT</th>
                        <th scope="col">DELETE</th>
                    </tr>
                    
                </thead>
          <tbody>  
        
 <%
try{   
Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection con;
                PreparedStatement pre;
                
                con=DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:1433;databasename=uvei;TrustServerCertificate=True;user=uver;password=1234");
                pre=con.prepareStatement("select * from admin_tbl");
                
                ResultSet rs =pre.executeQuery();
                
                while(rs.next())
                {
%>
<tr>
                   <td><%= rs.getString("id")%></td>

                    <td><%= rs.getString("username")%></td>

                    <td><%=decrypt(rs.getString("password"),SECRET_KEY)%></td>
                    <td><%= rs.getString("question")%></td>
                    <td><%= rs.getString("answer")%></td>
                    
                    <td><a href="edit_pass.jsp?id=<%=rs.getString("id")%>" class="btn btn-primary"></a></td>
                    <td>
                        <form>
                            <input hidden="" type ="text" name="id" value="<%=rs.getString("id")%>">
                            <input type="submit" value="delete" name="delete" class="btn btn-primary">
                        </form>
                    </td>
                    </tr>
            
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
    

%>
       </tbody>

   </table>
                    
</body>
<jsp:include page="footer.jsp"></jsp:include>
</html>