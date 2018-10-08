<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.Hibernate" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="org.hibernate.cfg.Configuration" %>
<%@ page import="org.hibernate.query.Query" %>
<%@ page import="java.util.List" %>
<%@ page import="Classes.Customers" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Customers</title>
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


<div class="jumbotron "><h1>Customers</h1></div>
    <h2>Edit Selected Customer</h2><br>
<hr>
<div class="row">
<div class="col-md-6">
    <%
        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        Session session1 = sessionFactory.openSession();
        session1.beginTransaction();

        Query query = session1.createQuery("from Customers where idNumber='"+request.getParameter("id")+"'");
        List<Customers> list;
        list=query.list();
        for (int i = 0; i< list.size(); i++){

            out.println("<p>" + list.get(i).getIdNumber()+"</p><p>" + list.get(i).getFirstName()+"</p><p>"+ list.get(i).getLastName()+"</p><p>"+list.get(i).getAddress()+"</p><p>"+list.get(i).getCountry()+"</p>" );
        }
        session1.close();
        sessionFactory.close();








    %>
</div>

<div class="col-md-6">



    <form action="servlet?id=<%=request.getParameter("id")%>" method="post">
        <div class="form-group">
            <label for="FirstName">First Name</label>
            <input name = "first_name" type="text" class="form-control" id="FirstName">

        </div>
        <div class="form-group">
            <label   for="LastName">Last Name</label>
            <input name = "last_name" type="text" class="form-control" id="LastName">

        </div>
        <div class="form-group">
            <label   for="Address">Address</label>
            <input name = "address" type="text" class="form-control" id="Address">

        </div>
        <div class="form-group">
            <label   for="Country">Country</label>
            <input name = "country" type="text" class="form-control" id="Country">

        </div>


        <input type = "submit" value = "Submit" />

    </form>





</div>
</div>


</body>

</html>

