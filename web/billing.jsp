
<%@page import="com.itextpdf.text.pdf.PdfWriter"%>
<%@page import="com.itextpdf.text.Document"%>
<%@page import="com.itextpdf.text.Paragraph"%>
<%@page import="com.itextpdf.text.pdf.PdfPTable"%>
<%@page import="com.itextpdf.text.Image"%>
<%@page import="com.itextpdf.text.PageSize"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="javax.jms.Session"%>
<%@page import="javax.jms.Session"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

LocalDateTime currentDateTime=LocalDateTime.now();

DateTimeFormatter formatter=DateTimeFormatter.ofPattern("dd-MM-YY  HH:mm:ss");

String formattedDateTime=currentDateTime.format(formatter);

    HttpSession session1=request.getSession();


Connection con=null;

PreparedStatement psproduct=null;

ResultSet rsproduct =null;

PreparedStatement psbuy=null;

ResultSet rsbuy=null;


List<Map<String,Object>> cart=(List<Map<String,Object>>) session1.getAttribute("cart");
if(cart==null)
{
cart=new ArrayList<>();
}

List<Map<String,Object>> cartb=(List<Map<String,Object>>) session1.getAttribute("cartb");
if(cartb==null)
{
cartb=new ArrayList<>();
}



if(request.getParameter("search")!=null)
{

String number=request.getParameter("number");

try
{


                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                con=DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:1433;databasename=uvei;TrustServerCertificate=True;user=uver;password=1234");
                psbuy=con.prepareStatement("select * from addbuyer_tbl where number=?");
                psbuy.setString(1, number);
                
                 rsbuy=psbuy.executeQuery();
                
                if(rsbuy.next())
                {
                
                String name=rsbuy.getString("username");
                String num=rsbuy.getString("number");

                Map<String,Object> buyer= new HashMap<>();
                
                buyer.put("name", name);
                
                 buyer.put("num", number);

                cartb.add(buyer);
                
                
                }
                
}
catch(Exception e)
{
e.printStackTrace();

}


session1.setAttribute("cartb", cartb);
}

if(request.getParameter("removebuyer")!=null)
{

String numb=request.getParameter("removebuyer");


for(Iterator<Map<String,Object>> iteratorb=cartb.iterator();iteratorb.hasNext();)
{

Map<String,Object> buyer=iteratorb.next();
if(buyer.get("number").equals(numb))
{
iteratorb.remove();
}
}
session1.setAttribute("cartb", cartb);

}



// add product


if(request.getParameter("addproduct")!=null)
{

String id=request.getParameter("productid");

int quantity=Integer.parseInt(request.getParameter("quantity"));

try
{


                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                con=DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:1433;databasename=uvei;TrustServerCertificate=True;user=uver;password=1234");
                psproduct=con.prepareStatement("select id from prod_table where id=?");
                psproduct.setString(1, id);
                
                 rsproduct=psproduct.executeQuery();
                
                if(rsproduct.next())
                {
                
                String name=rsproduct.getString("name");
                double rate=Integer.parseInt(rsproduct.getString("rate"));

                Map<String,Object> product= new HashMap<>();
                
                product.put("id", id);

                product.put(" productname",name);
                
                product.put("productprice",rate);
                product.put("quantity", quantity);

                product.put("total", rate * quantity);


                cart.add(product);
                
                
                }
                
}
catch(Exception e)
{
e.printStackTrace();

}


session1.setAttribute("cart", cart);
}


if(request.getParameter("removeProduct")!=null)
{

String pdtoremove=request.getParameter("removeProduct");


for(Iterator<Map<String,Object>> iterator=cart.iterator();iterator.hasNext();)
{

Map<String,Object> buyer=iterator.next();
if(buyer.get("id").equals(pdtoremove))
{
iterator.remove();
}
}
session1.setAttribute("cart", cart);

}





//pdf
if(request.getParameter("generatePDF")!=null)
{

response.setContentType("application/pdf");
         
        response.setHeader("content-Disposition","attachment; filename=buyer.pdf");
        
        try{
            


            Document document= new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();
            
            
            document.add(new Paragraph("                   "));
            document.add(new Paragraph(""));
            document.add(new Paragraph(" Date AND TIME :" +  formattedDateTime  ));
            document.add(new Paragraph(""));
            document.add(new Paragraph("                             buyer details                       "));
            document.add(new Paragraph(""));



            
            
            PdfPTable table1=new PdfPTable(2);
            
            table1.addCell("name");

            table1.addCell("number");
            
          for(Map<String,Object> buyer:cartb)
          {
                      table1.addCell((String) buyer.get("name"));
                     table1.addCell((String) buyer.get("number"));


}

            document.add(table1);
            
            document.add(new Paragraph(" "));
            document.add(new Paragraph("                             product details                       "));
            document.add(new Paragraph(" "));

            PdfPTable table2=new PdfPTable(4);
            table2.addCell(" product name");
            table2.addCell("quantity");
            table2.addCell("rate");
            table2.addCell("total");
            
              
            
            double totalAmount=0;
            int totalQuantity=0;
            
          for(Map<String,Object> product:cart)
          {
                      table2.addCell((String) product.get(" product name"));
                                          table2.addCell(String.valueOf(product.get("quantity")));
                                          table2.addCell("rs-" + String.valueOf(product.get("rate")));

                                          table2.addCell("rs-" + String.valueOf(product.get("total")));



}
            
            document.add(table2);
            
            
            
                      document.add(new Paragraph(" "));
                      document.add(new Paragraph("total Quantity:" + totalQuantity ));
                      document.add(new Paragraph("total Amount: rs-" + totalAmount ));
                      
                      document.close();
}
                      
          catch(Exception e)
                 {
                 e.printStackTrace();
             }
        
     
    }
    

 double totalAmount=0;
  int totalQuantity=0;



  for(Map<String,Object> product:cart)
{

totalAmount+=(Double) product.get("total");

totalQuantity+=(Integer) product.get("quantity");
}
%>





<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome Page</title>

        <style>
            body  {
                background-color:rgb(237,240,233);
                background: linear-gradient(90deg, rgba(237,240,233,1) 4%, rgba(224,228,217,0.8939950980392157) 43%, rgba(23,206,217,1) 74%, rgba(35,203,198,1) 100%);
            }



        </style>
        
            <body>
                <P> The Current data and time is:<strong><%= formattedDateTime%> </strong></p>
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



        <h1 style="text-align: center;font-size: bold;">Welcome to Appvalue Solutions</h1>
        <br>
 
       <% 
            String uname=(String) session.getAttribute("username");
            %>
            <h2 style="text-align: center; font-style: italic;">Hi Welcome <%=uname%> !</h2>

        <div align="center">

            <image style="margin-top: 70px;height: 500px ; width: 500px" src="data:image/png;base64,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" alt=""/>
        </div>
            
            <div class="container-fluid"><!-- comment -->
                <h1 class="text-center"> Buyer details</h1>
                
                <form action="billing.jsp" method ="post">
                    
                    <label> select buyer :</label>
                    <select class="form-control" name="number" id="number">
                        
                <%       
                    
                  try{ 
                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                con=DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:1433;databasename=uvei;TrustServerCertificate=True;user=uver;password=1234");
                psbuy=con.prepareStatement("select * from addbuyer_tbl");
                
                 rsbuy=psbuy.executeQuery();
                
                if(rsbuy.next())
                {
                
                String name=rsbuy.getString("username");
                String number=rsbuy.getString("number");
                
                %>
                <option value="<=num%>"><%=name%> </option>
                <%
                    
                 }
}
                 catch(Exception e)
                 {
                 e.printStackTrace();
             }
        
     
    
                
                %>
                    </select>
                    
                    <br>
                    <br><!-- comment -->
                    
                    
                    <button type="submit" name="search">Search Buyer</button>
                    
                </form>
                
                    
                    
                    
                    <table class=" table table-scripted" style="text-align: center;">
                        
                        <tr>
                            <th>Name</th>
                              <th>Number</th>
                               <th>remove</th>

            
                                    </tr>
                                    
        <%
            
        for(Map<String,Object> buyer:cartb)
{

%>                            

<tr>
    <td><%= buyer.get("name")%></td>
        <td><%= buyer.get("number")%></td>

        
        <td>
            
            <form action="billing.jsp"  method="post" style="display: inline;">
                
                <input type="hidden" name="removebuyer" value="<%= buyer.get("number")%>"><!-- comment -->
                <button type="submit" class="form-control" > remove</button>
                        
                        </form>
                       
        </td>

</tr>
            
                    </table>   
                <br>
                <br><!-- comment -->
                <%
                    }
                    
                    %>
            </div>
            
            <!<!-- add buyer -->
                  <div class="container-fluid"><!-- comment -->
                      <h1 class="text-center"> Add product</h1>
                
                <form action="billing.jsp" method ="post">
                    
                    <label> select product :</label>
                    <select class="form-control" name="id" id="id">
                        
                <%       
                    
                  try{ 
                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                con=DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:1433;databasename=uvei;TrustServerCertificate=True;user=uver;password=1234");
                psbuy=con.prepareStatement("select * from prod_tbl");
                
                 rsproduct=psproduct.executeQuery();
                
                if(rsproduct.next())
                {
                
                String id=rsproduct.getString("id");
                String productname=rsproduct.getString("name");
                double productprice=rsproduct.getDouble("rate");
                
                %>
                <option value="<=id%>"><%=productname%>(rs-<%=productprice%>)</option>
                <%
                    
                 }
}
                 catch(Exception e)
                 {
                 e.printStackTrace();
             }
finally{

if(rsproduct!=null)
rsproduct.close();
if(psproduct!=null)
psproduct.close();

if(con!=null)
con.close();
}
        
       
                %>
                  
                
                    </select>
                 
                    <label> quantity  :</label>
                    <select class="form-control" name="quantity" id="quantity" value="1" min="1">
                    
                    <br>
                    <br><!-- comment -->
                    
                    
                    <button type="submit" name="addproduct">add product </button>
                    
                </form>
                
                    
                    
                    
                    <table class=" table table-scripted" style="text-align: center;">
                        
                        <tr>
                            <th> product Name</th>
                                 <th>quantity</th>
                                    <th>rate</th>
                                    <th>total</th>
                                     <th>remove</th>

                                                                                    

            
                   </tr>
                                    
        <%
            
        for(Map<String,Object> product:cart)
{

%>                            

<tr>
    <td><%= product.get("name")%></td>
        <td><%= product.get("quantity")%></td
                <td><%= product.get("price")%></td>

                        <td><%= product.get("total")%></td>


        
        <td>
             
            <form action="billing.jsp"  method="post" style="display: inline;">
                
                <input type="hidden" name="removeProduct" value="<%= product.get("id")%>"><!-- comment -->
                <button type="submit" class="form-control"> remove</button>
                        
                        </form>
                       
        </td>

</tr>
            
                    </table>   
                <br>
                <br><!-- comment -->
                <%
                    }
                    
                    %>
                    
                    <tr>
                    
                    <td colspan="2"></td>
                    <td><strong>Total Quantity</strong></td>
                    <td><%= totalQuantity%></td>
                    
                    </tr>
                    
                     <tr>
                    
                    <td colspan="2"></td>
                    <td><strong>Total Amount</strong></td>
                    <td><%= totalAmount%></td>
                    
                    </tr>
                    
                    </table>
                    
                    <br><!-- comment -->
                    
                    <form action="billing.jsp" method="post">
                        
                        <button type="submit" name="generatePDF">Generate pdf</button>
                        
                        
                    </form>
                    
                    <div class="row">
                        
                        <div class=""offset-md-4">
                            
                            <img src="#"/>
                        </div>
                        <br>
                        <br> 
                            
                            
                            
                      <div class=""offset-md-12">
                          <p>shri jaya rama</p>
                            <p>shri jaya rama</p>

                          </div>

                        
                    </div>
                    
            </div>
            
            
    </body>

    <jsp:include page="footer.jsp"></jsp:include>
</html>

