

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


        %> 

<!DOCTYPE html>
<html>
    <head>
                 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Page</title>
        <style>
            body  {
                background-color:rgb(237,240,233);
                background: linear-gradient(90deg, rgba(237,240,233,1) 4%, rgba(224,228,217,0.8939950980392157) 43%, rgba(23,206,217,1) 74%, rgba(35,203,198,1) 100%);
            }
 </style>

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
                            <form>
                                <input type="submit" value="logout" name="logout" class="btn btn-primary">
                            </form>
                        </li>
                    </ul>
                </div>   
            </div>   
        </nav>
        <h1 style="text-align: center;font-size: bold;">Welcome to buyer page!</h1>
        <br>
       <% 
            String uname=(String) session.getAttribute("username");
            %>
            <h2 style="text-align: center; font-style: italic;">Hi Welcome <%=uname%> !</h2>

        
        
        <h1>Welcome to update page!</h1>
           <%
                if (message != null) {
            %>

            <p style="color:red;"><%=message%></p>

            <%
                }
            %>
            
            <form action="get_update" method="post" enctype="multipart/form-data" >

                    <div class="form-group" >
                        <label>Number:</label>
                        <input type="text" name="number" value="<%=number%>" class="form-control" required="">
                    </div>
                    <br>

                    <div class="form-group">
                        <label>Name:</label>
                        <input type="text" name="username"  value="<%=username%>" class="form-control" required="">

                    </div>
                    <br>

                    <div class="form-group">
                        <label>Gender:</label>
                        <input type="text" name="gender" value="<%=gender%>" class="form-control" required="">
                    </div> 
        
    </body>
    
    <jsp:include page="footer.jsp"></jsp:include>

</html>
