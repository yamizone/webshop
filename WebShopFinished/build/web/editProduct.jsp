<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.Hibernate" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="org.hibernate.cfg.Configuration" %>
<%@ page import="org.hibernate.query.Query" %>
<%@ page import="java.util.List" %>
<%@ page import="Classes.Customers" %>
<%@ page import="Classes.Products" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Product</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</head>

<body class="container">
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="/WebShopFinished/index.jsp">AB\Design</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
        <div class="navbar-nav">
            <a class="nav-item nav-link" href="/WebShopFinished/index.jsp">Home <span class="sr-only">(current)</span></a>
            <a class="nav-item nav-link" href="/WebShopFinished/coustomers.jsp">Customers</a>
            <a class="nav-item nav-link" href="/WebShopFinished/products.jsp">Products</a>
            <a class="nav-item nav-link" href="/WebShopFinished/sales.jsp">Sales</a>
        </div>
    </div>
</nav>

<div class="divider">
    <hr>
</div>


<div class="jumbotron "><h1>Edit Product</h1></div>
<h2>Edit Selected Product</h2><br>
<hr>
<div class="row">
    <%--<div class="col-md-6">--%>
        <%--<%--%>
            <%--SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();--%>
            <%--Session session1 = sessionFactory.openSession();--%>
            <%--session1.beginTransaction();--%>

            <%--Query query = session1.createQuery("from Products where idNumber='"+request.getParameter("edit")+"'");--%>
            <%--List<Products> list;--%>
            <%--list=query.list();--%>
            <%--for (int i = 0; i< list.size(); i++){--%>
                <%--out.println("<p>" + list.get(i).getIdNumber()+"</p><p>" + list.get(i).getProductName()+"</p><p>"+ list.get(i).getPrice()+"</p><p>"+list.get(i).getInventory()+"</p>" );--%>
            <%--}--%>
            <%--session1.close();--%>
            <%--sessionFactory.close();--%>








        <%--%>--%>
    <%--</div>--%>

    <div class="col-md-6">



        <form action="editProduct.jsp?edit=<%=request.getParameter("edit")%>" method="post">
            <div class="form-group">
                <label for="Product Name">Product Name</label>
                <input name = "product_name" type="text" class="form-control" id="Product Name">

            </div>
            <div class="form-group">
                <label   for="Price">Price</label>
                <input name = "price" type="text" class="form-control" id="Price">

            </div>
            <div class="form-group">
                <label   for="Inventory">Inventory</label>
                <input name = "inventory" type="text" class="form-control" id="Inventory">

            </div>



            <input type = "submit" value = "Submit" />

        </form>

    </div>
        <%

                try {
                    String productName,price,inventory;
                    response.setContentType("text/html");


                    if (request.getParameter("product_name").equals("") && request.getParameter("price").equals("") && request.getParameter("inventory").equals("") ) {


                        out.print("<h1>Please Enter Values</h1>");
                    } else if (request.getParameter("product_name").equals("") || request.getParameter("price").equals("") || request.getParameter("inventory").equals("")) {
                        out.print("<h1>Please Enter All Values</h1>");

                    } else {
                        SessionFactory sesssionFactory = new Configuration().configure().buildSessionFactory();
                        Session sesssion = sesssionFactory.openSession();
                        sesssion.beginTransaction();
                        productName = request.getParameter("product_name");
                        price = request.getParameter("price");
                        inventory = request.getParameter("inventory");




                        Query queryy = sesssion.createQuery("update Products set productName = '"+productName+"', price = '"+price+"', inventory = '"+inventory+"' where idNumber ="+ request.getParameter("edit"));
//                        Query queryy = sesssion.createQuery("update Products set productName = :name, price = :prajs, inventory = :inv where idNumber ="+ request.getParameter("edit"));
//                        queryy.setParameter("name", productName);
//                        queryy.setParameter("price", price);
//                        queryy.setParameter("inventory", inventory);
                        queryy.executeUpdate();


                        out.print("<div class=\"row \">\n " +
                                "    <div class=\"col-md-12 .offset-md-3 alert alert-success\" role=\"alert\">\n" +

                                "                <h3>Product Changed</h3>");
                        queryy = sesssion.createQuery("from Products where idNumber="+request.getParameter("edit"));
                        List<Products> listt;
                        listt=queryy.list();
                        for (int i = 0; i< listt.size(); i++){

                            out.println("<p> ID-Number  -  " + listt.get(i).getIdNumber()+"</p><p> Product Name  -  " + listt.get(i).getProductName()+"</p><p> Price  -  "+ listt.get(i).getPrice()+"</p><p> Inventory  -  "+listt.get(i).getInventory()+"</p>" );
                        }



                        sesssion.close();

                        sesssionFactory.close();
                        out.print("<h4>Successfully updated Product!</h4>");
                        out.println("<p><a href=\"/WebShopFinished/products.jsp\" class=\"btn btn-dark\" role=\"button\">Go Back</a></p>\n" +
                                "            </div>\n" +
                                "</div>");



                    }
                } catch (Exception e){
                    System.out.println(e);
                }




        %>







</div>


</body>

</html>

