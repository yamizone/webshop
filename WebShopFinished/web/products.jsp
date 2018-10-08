<%@ page import="Classes.Customers" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.cfg.Configuration" %>
<%@ page import="org.hibernate.query.Query" %>
<%@ page import="Classes.Products" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Products</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</head>
<body>
<div class="container">
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

    <div class="jumbotron"><h1>Products</h1></div>
    <div class="alert alert-success" role="alert">
        <h3 >Add New Product</h3>
        <div class="divider">
            <hr>
        </div>
    <form method="post">
        <div class="form-group">
            <label for="ProductName">Product Name</label>
            <input name = "product_name" type="text" class="form-control" id="ProductName">

        </div>
        <div class="form-group">
            <label   for="ProductPrice">Product Price</label>
            <input name = "product_price" type="text" class="form-control" id="ProductPrice">

        </div>
        <div class="form-group">
            <label   for="ProductInventory">Product Inventory</label>
            <input name = "product_inventory" type="text" class="form-control" id="ProductInventory">

        </div>

        <%
            try {
                if (request.getParameter("delete").equals("")) {
                    response.sendRedirect("products.jsp");
                } else {
                    System.out.println(request.getParameter("delete"));
                    SessionFactory sessisonFactory = new Configuration().configure().buildSessionFactory();
                    Session sesssion = sessisonFactory.openSession();
                    sesssion.beginTransaction();
                    Query queery = sesssion.createQuery("delete Products where idNumber =" + request.getParameter("delete"));
                    queery.executeUpdate();
                    sesssion.getTransaction().commit();
                    sesssion.close();



                }
            }catch (Exception ex){
                System.out.println(ex);
            }


        %>

        <%
            try {
                    String productName;
                    Integer inventory;
                    Double price;


                if (request.getParameter("product_name").equals("") && request.getParameter("product_price").equals("") && request.getParameter("product_inventory").equals("")) {
                    out.print("<h1>Please Enter Values</h1>");
                } else if (request.getParameter("product_name").equals("") || request.getParameter("product_price").equals("") || request.getParameter("product_inventory").equals("")) {
                    out.print("<h1>Please Enter All Values</h1>");
                } else {
                    productName = request.getParameter("product_name");
                    inventory = Integer.parseInt(request.getParameter("product_inventory"));
                    price = Double.valueOf(request.getParameter("product_price"));
                    Products products = new Products(productName, price, inventory);
                    SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
                    Session session1 = sessionFactory.openSession();
                    session1.beginTransaction();
                    session1.save(products);
                    session1.getTransaction().commit();
                    session1.close();
                }
            } catch (Exception e){
                System.out.println(e);
            }



        %>

        <input type = "submit" value = "Add" />
    </form>
    </div>
    <div class="divider">
        <hr>
    </div>

    <div class="alert alert-success" role="alert">
        <h3 >List of Products</h3>
        <div class="divider">
            <hr>
        </div>

        <%



            SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
            Session sessiion = sessionFactory.openSession();
            sessiion.beginTransaction();
            Query query = sessiion.createQuery("from Products");
            List<Products> list;
            list = query.list();
            out.print("<table class=\"table table-bordered\">");
            out.print("<tr><th>ID Number</th><th>Product Name</th><th>Product Price</th><th>Product inventory</th><th>Country</th></tr>");
            for (int i = 0; i< list.size(); i++){
                String edit = "<td><a class='btn btn-dark' href='editProduct.jsp?edit="+list.get(i).getIdNumber()+"'>Edit</a></td>";
                String delete ="<td><a class='btn btn-dark' href='products.jsp?delete="+list.get(i).getIdNumber()+"'>Delete</a></td>" ;
                if(list.get(i).getInventory() > 1) {
                    out.println("<tr><td>" + list.get(i).getIdNumber() + "</td><td>" + list.get(i).getProductName() + "</td><td>" + list.get(i).getPrice() + "$</td><td>" + list.get(i).getInventory() + "  - Items</td>" + edit + "</td>" + delete + "</tr>");
                } else {
                    out.println("<tr><td>" + list.get(i).getIdNumber() + "</td><td>" + list.get(i).getProductName() + "</td><td>" + list.get(i).getPrice() + "$</td><td>" + list.get(i).getInventory() + " - Item</td>" + edit + "</td>" + delete + "</tr>");
                }

                }
            out.print("</table>");


        %></div> </div>

</div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>

</body>
</html>