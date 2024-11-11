

<%@page import="java.util.Base64"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BUYER DETAILS</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<style>
            body  {
                background-color:rgb(237,240,233);
                background: linear-gradient(90deg, rgba(237,240,233,1) 4%, rgba(224,228,217,0.8939950980392157) 43%, rgba(23,206,217,1) 74%, rgba(35,203,198,1) 100%);
            }



        </style>
                <script>
                    function print()
                    {   
                        alert("print is in");

                        var divToPrint= document.getElementById("print");
                        var newWin=window.Open("");
                        newWin.document.write('<html><head><title> BUYER DETAIL </title></head></html><body>');
                        newWin.document.write(divToPrint.outerHTML);
                        newWin.document.write('</body></html>');
                        newWin.print();
                        newWin.close();
                       
                    }
                    function showExportAlert(type)
                    {
                        alert(type + "export is successful");
                    }
                    
                    </script>
                  
    </head>
    <body>
       
        
        <nav class="navbar navbar-expand-lg navbar-dark  bg-dark">
            <div class="container-fluid">
                <div class="collapse navbar-collapse"  id="navbarnav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="buyer.jsp">back</a>

                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="login.jsp">logout</a>

                        </li>
                     </ul>
                </div>   
            </div>   
        </nav>
                        
     <div class="container">          
     <h1 style="text-align: center;font-size: bold;">Display Buyer details from Database</h1>
        <br>
       <% 
            String uname=(String) session.getAttribute("username");
            %>
            <h2 style="text-align: center; font-style: italic;">Hi Welcome <%=uname%> !</h2>

            <table border="1" class="table table-striped" id="print">
                <thead>
                    
                    
                    <tr style="text-align: center">
                        <th>ID</th>
                        <th>NAME</th>
                        <th>RATE</th>
                        <th>IMAGE</th>

                    </tr>  
                </thead> 
                
                <tbody>
                <% Connection con=null;    
                    
try{
            con=DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:1433;databasename=uvei;TrustServerCertificate=True;user=uver;password=1234");
             PreparedStatement pre=con.prepareStatement("select * from prod_table");

                 ResultSet rs =pre.executeQuery();
                  
                 
                 
                 while(rs.next())
                 {
                 String id=rs.getString("id");
                  String name=rs.getString("name");

                  String rate=rs.getString("rate");

                  byte[] imageBytes=rs.getBytes("image");
                                                                    
                   String base64Image =Base64.getEncoder().encodeToString(imageBytes);
                       
                       
                       %>
                       
                       <tr>
                           <td><%= id%></td>
                           <td><%= name%></td>
                           <td><%= rate%></td>
                           <td>
                               
                               <img src="data:image/jpeg;base64,<%= base64Image%> width="100" height="100">
                           </td>

                           
                       </tr>
                       <%
                    }
                    }
                    catch(Exception ex)
                    {
                    ex.printStackTrace();
                    }finally
{
if(con!=null)
{
try{
con.close();
}   catch(Exception ex){

                    ex.printStackTrace();

}
}
}                
                    %>
                </tbody>
                
                
                
                
            </table>
            
                <button class="btn btn-primary" onlick="print()"> print</button>
                
                <form action="pexport" method="post" onsubmit="showExportAlert(this.action.value)">
                    <br>
                    <br>
                    
                    <button type="submit" name="action" value="pdf" class="btn btn-primary"> pdf</button>
                    
                <button type="submit" name="action" value="csv" class="btn btn-primary" > csv</button>

                    
                </form>
        
        </div>  
    </body>
    
        <jsp:include page="footer.jsp"></jsp:include>

</html>
