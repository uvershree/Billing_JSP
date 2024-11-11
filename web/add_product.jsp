

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
         <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Add Product</title>
        <style>
            body  {
                background-color:rgb(237,240,233);
                background: linear-gradient(90deg, rgba(237,240,233,1) 4%, rgba(224,228,217,0.8939950980392157) 43%, rgba(23,206,217,1) 74%, rgba(35,203,198,1) 100%);
            }
 </style>

    </head>
    <body>
          <body>
        
        <nav class="navbar navbar-expand-lg navbar-dark  bg-dark">
            <div class="container-fluid">
                <div class="collapse navbar-collapse"  id="navbarnav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="product.jsp">back</a>

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
        
        <h1 style="text-align: center;font-size: bold;">Welcome to Add Product Page!</h1>
        <br>
       <% 
            String uname=(String) session.getAttribute("username");
            %>
            <h2 style="text-align: center; font-style: italic;">Hi Welcome <%=uname%> !</h2>

            <div class="container">
                  <div class="row justify-content-center">
                     <div class="col-md-6">

                
                <form action="pupload" method="post" enctype="multipart/form-data" >
                    
                       <div class="form-group">
                <label>Id</label>
                <input type="text" name="id"  class="form-control" required="">
        </div>
                <div class="form-group">
                <label>Name</label>
                <input type="text" name="name" class="form-control" required="">
        </div>
                 <div class="form-group">
                <label>rate</label>
                <input type="text" name="rate" onkeypress="return /[0-9]/i.test(event.key)"  class="form-control" required="">

                </div>               
                <div class="form-group">
                <label>Product image</label>
                <br>
                <input type="file" name="image" value="image" class="form-control-file" required="" accept="image/*">
        </div>
                
        </div>
                    
                    <br>   
            <div class="row">
                            <div class="col">

                                <input type="submit" value="Add" name="ADD" class="btn btn-primary">   

                            </div> 
                </form>
                        </div>
                    <br>   
                    <br>   

                  <%
                    String message =(String) request.getAttribute("message");
                    if(message!=null)
                    {
                    %>
                    
                    <p style="color:red;"><%=message%></p>
                    
                    <%
                        }
%>
    </body>

    <jsp:include page="footer.jsp"></jsp:include>
    
    </div>

            </div>
                    
</html>
   