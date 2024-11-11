

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



<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Buyer Page</title>
         <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
       <style>
            body  {
                background-color:rgb(237,240,233);
                background: linear-gradient(90deg, rgba(237,240,233,1) 4%, rgba(224,228,217,0.8939950980392157) 43%, rgba(23,206,217,1) 74%, rgba(35,203,198,1) 100%);
            }



        </style>
    </head>
    
            <body class="container">
        
        <nav class="navbar navbar-expand-lg navbar-dark  bg-dark">
            <div class="container-fluid">
                <div class="collapse navbar-collapse"  id="navbarnav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="add_product.jsp">add product</a>

                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="update_product.jsp">update product</a>

                        </li>
                        
                        <li class="nav-item">
                            <a class="nav-link" href="details_product.jsp">product details </a>

                        </li>
                       
                        <li class="nav-item">
                            <a class="nav-link" href="welcome.jsp">back</a>

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
 
        <h1 style="text-align: center;font-size: bold;">Welcome to Product page!</h1>
        <br>
       <% 
            String uname=(String) session.getAttribute("username");
            %>
            <h2 style="text-align: center; font-style: italic;">Hi Welcome <%=uname%> !</h2>

    
    </body>

    <jsp:include page="footer.jsp"></jsp:include>
</html>

        
   