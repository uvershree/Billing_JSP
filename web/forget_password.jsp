<%-- 
    Document   : forget_password
    Created on : 19-Oct-2024, 10:00:37 pm
    Author     : HOME
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forget password</title>
    </head>
    <body class="container">
        <h2 style="text-align: center"> Get your password</h2>

        <form action="password"  method="post">


            <label>Username</label>
            <input type="text" name="username" class="form-control" required="">
            <br>
            <label>Security Question</label>
            <input type="text" name="question" class="form-control" required="">
            <br>

            <label>Security Answer</label>
            <input type="text" name="answer" class="form-control" required="">
            <br>

            <div class="container mt-2">

                <div class="row">
                    <div class="col">
                        <button class="btn btn-primary" name="Get" value="getpassword">Get password</button>
                    </div>
                    </form>

                    <div class="col">
                        <a href="login.jsp" class="btn btn-outline-primary">login</a>
                    </div>
                </div>


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
</html>
