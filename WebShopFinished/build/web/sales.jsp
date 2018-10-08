<%@ page import="Classes.Products" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="org.hibernate.cfg.Configuration" %>
<%@ page import="org.hibernate.query.Query" %>
<%@ page import="java.util.List" %>
<%@ page import="Classes.Sales" %>
<%@ page import="Classes.Customers" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sales</title>
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

    <div class="jumbotron"><h1>Sales</h1></div>
    <div class="alert alert-success" role="alert">
        <h3 >Add New Sale</h3>
        <div class="divider">
            <hr>
        </div>
        <form method="post">
            <div class="form-group">
                <label for="CustomerID">Customer ID</label>
                <input name = "customer_id" type="text" class="form-control" id="CustomerID">

            </div>
            <div class="form-group">
                <label   for="ProductID">Product ID</label>
                <input name = "product_id" type="text" class="form-control" id="ProductID">

            </div>

            <%
                try {
                    if (request.getParameter("delete").equals("")) {
                        response.sendRedirect("sales.jsp");
                    } else {
                        System.out.println(request.getParameter("delete"));
                        SessionFactory sessisonFactory = new Configuration().configure().buildSessionFactory();
                        Session sesssion = sessisonFactory.openSession();
                        sesssion.beginTransaction();
                        Query queery = sesssion.createQuery("delete Sales where idNumber =" + request.getParameter("delete"));
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
                    Integer customerID,productID;


                    if (request.getParameter("customer_id").equals("") && request.getParameter("product_id").equals("")) {
                        out.print("<h1>Please Enter Values</h1>");
                    } else if (request.getParameter("customer_id").equals("") || request.getParameter("product_id").equals("")) {
                        out.print("<h1>Please Enter All Values</h1>");
                    } else {
                        customerID = Integer.valueOf(request.getParameter("customer_id"));
                        productID = Integer.valueOf(request.getParameter("product_id"));
                        Sales sales = new Sales(productID, customerID);
                        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
                        Session session1 = sessionFactory.openSession();
                        session1.beginTransaction();
                        session1.save(sales);
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
        <h3 >List of Sales</h3>
        <div class="divider">
            <hr>
        </div>

        <%



            SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
            Session sessiion = sessionFactory.openSession();
            sessiion.beginTransaction();
            Query query = sessiion.createQuery("from Sales");
            List<Sales> list;

            list = query.list();
            out.print("<table class=\"table table-bordered\">");
            out.print("<tr><th>Sales ID Number</th><th>Customer ID Number</th><th>Product ID Number</th></tr>");
            for (int i = 0; i< list.size(); i++){
                String edit = "<td><a class='btn btn-dark' href='editsales.jsp?edit="+list.get(i).getCustomerID()+"'>Edit</a></td>";
                String delete ="<td><a class='btn btn-dark' href='sales.jsp?delete="+list.get(i).getCustomerID()+"'>Delete</a></td>" ;
                String view ="<td><a class='btn btn-dark' href='sales.jsp?view="+list.get(i).getCustomerID()+"'>View</a></td>" ;

                    out.println("<tr><td>"+list.get(i).getIdNumber()+ "</td><td>"+ list.get(i).getCustomerID() + "</td><td>" + list.get(i).getProductIDNumber()+"</td>" + edit +  delete + view +"</tr>");


            }
            out.print("</table>");


        %></div>

<div class="row alert alert-success" role="alert">

    <%

        try {



        SessionFactory sesssionFactory = new Configuration().configure().buildSessionFactory();
        Session sesssiion = sesssionFactory.openSession();
            sesssiion.beginTransaction();
        Query queeery = sesssiion.createQuery("from Sales where idNumber="+request.getParameter("view"));
        List<Sales> lisst;

            lisst = queeery.list();


        for (int i = 0; i< lisst.size(); i++){
            queeery = sessiion.createQuery("from Customers where idNumber ="+lisst.get(i).getCustomerID());

            List<Customers> customer= queeery.list();

            out.print("<h3 class=\"col-md-6\">" +customer.get(i).getIdNumber()+"<br>"+customer.get(i).getFirstName()+"<br>"+customer.get(i).getLastName()+"<br>"+customer.get(i).getAddress()+"<br>"+customer.get(i).getCountry()+"<br>" + "</h3>");
            queeery = sessiion.createQuery("from Products where idNumber ="+lisst.get(i).getProductIDNumber());
            List<Products> product = queeery.list();
            out.print("<h3 class=\"col-md-6\">" +product.get(i).getIdNumber()+"<br>"+product.get(i).getProductName()+"<br>"+product.get(i).getPrice()+"<br>"+product.get(i).getInventory()+"</h3>");

        }
        out.print("</table>");

        }catch (Exception e){
            System.out.println(e);
        }
    %>

</div>
</div>

</div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>

</body>
</html>