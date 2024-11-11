<%-- 
    Document   : get_buyer
    Created on : 29-Oct-2024, 1:09:58 pm
    Author     : HOME
--%>

<%@page import="java.util.Base64"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
//if(session.getAttribute("username")==null)
//{
 //      response.sendRedirect("login.jsp");
 // }
   
//if(request.getParameter("logout")!=null)
//{
//session.removeAttribute("username");
//response.sendRedirect("login.jsp");
//} %>
   <%
            String message = (String) request.getAttribute("message");
            String number = (String) request.getAttribute("number");
            String username = (String) request.getAttribute("username");
            String gender = (String) request.getAttribute("gender");
            byte[] image = (byte[]) request.getAttribute("image");
            String base64Image = image != null ? Base64.getEncoder().encodeToString(image) : "";


        %> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<style>
            body  {
                background-color:rgb(237,240,233);
                background: linear-gradient(90deg, rgba(237,240,233,1) 4%, rgba(224,228,217,0.8939950980392157) 43%, rgba(23,206,217,1) 74%, rgba(35,203,198,1) 100%);
            }
 </style>
        <title>Buyer Details</title>

    </head>
    <body class="container">
    
         <nav class="navbar navbar-expand-lg navbar-dark  bg-dark">
            <div class="container-fluid">
                <div class="collapse navbar-collapse"  id="navbarnav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="admin_page.jsp">back</a>

                        </li>
                         <li class="nav-item">
                            <form>
                                <input type="submit" value="logout" name="logout" class="btn btn-primary">
                            </form>
                        </li>
                    </ul>
                </div>   
            </div>   
        </nav>
        
        <h1 style="text-align: center ;font:bold">BUYER DETAILS UPDATE</h1>
         <% 
            String uname=(String) session.getAttribute("username");
            %>
            <h2 style="text-align: center; font-style: italic;">Hi Welcome <%=uname%> !</h2>


        <%                   if (message != null) {
        %>

        <p style="color:red;"><%=message%></p>

        <%
            }
        %>

        <form action="get_update"  method="post" enctype="multipart/form-data" class="container-fluid"  style="margin: 50px">
                    

                        <label>Number:</label>
                        <input type="text" name="number" value="<%=number%>" class="form-control">
                    <br>

                        <label>Name:</label>
                        <input type="text" name="username"  value="<%=username%>" class="form-control" required="">

                    
                    <br>

                    
                        <label>Gender:</label>
                        <input type="text" name="gender" value="<%=gender%>" class="form-control">
                   
                    <br>

                    
                        <label>Image:</label>
                        <br>
                        <%if (image != null) {%>

                        <img src="data:image/jpeg;base64,<%=base64Image%>"   width="100" height="100" />   

                        <% } else {%>

                        no image

                        <% }%>

                        <input type="file" name="image">
                                            <br>
                    <br>

                    <button class="btn btn-primary" name="update" value="update"> update </button> 

                </form>
            
            <br>
            <br>



            <h2 style="text-align: center;font:bold">DELETE RECORD</h2>   
            <br>

            <br>


            <form action="delete" method ="post" class="container-fluid"> 
                     <div style=" margin: 50px">

                <label> Enter the number to delete:</label>
                <br>

                <input type="text"  onkeypress="return /[0-9]/i.test(event.key)" name="number"  class="form-control" required>
                <br>
                <br>

                <input type="submit"  class="btn btn-danger" value="Delete">




            </form>
            <%
                if (message != null) {
            %>

            <p style="color:red;"><%=message%></p>

            <%
                }
            %>
            <br>
            <br>
        </div>


</body>

<jsp:include page="footer.jsp"></jsp:include>
</div>

</html>