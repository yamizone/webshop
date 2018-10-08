import Classes.Customers;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "ServletForm")
public class ServletForm extends HttpServlet {

    private static final long serialVersionUID = 1L;
String firstPartHtml = "<html>\n" +
        "<head>\n" +
        "    <title>Customers</title>\n" +
        "    <link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css\" integrity=\"sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO\" crossorigin=\"anonymous\">\n" +
        "    <script src=\"https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js\" integrity=\"sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy\" crossorigin=\"anonymous\"></script>\n" +
        "</head>\n" +
        "<body>\n" +
        "<div class=\"container align-middle\">\n" +
        "<nav class=\"navbar navbar-expand-lg navbar-light bg-light\">\n" +
        "    <a class=\"navbar-brand\" href=\"/WebShopFinished/editperson.jsp\">AB\\Design</a>\n" +
        "    <button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#navbarNavAltMarkup\" aria-controls=\"navbarNavAltMarkup\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">\n" +
        "        <span class=\"navbar-toggler-icon\"></span>\n" +
        "    </button>\n" +
        "    <div class=\"collapse navbar-collapse\" id=\"navbarNavAltMarkup\">\n" +
        "        <div class=\"navbar-nav\">\n" +
        "            <a class=\"nav-item nav-link\" href=\"/WebShopFinished/editperson.jsp\">Home <span class=\"sr-only\">(current)</span></a>\n" +
        "            <a class=\"nav-item nav-link\" href=\"/WebShopFinished/coustomers.jsp\">Customers</a>\n" +
        "            <a class=\"nav-item nav-link\" href=\"/WebShopFinished/products.jsp\">Products</a>\n" +
        "            <a class=\"nav-item nav-link\" href=\"/WebShopFinished/sales.jsp\">Sales</a>\n" +
        "        </div>\n" +
        "    </div>\n" +
        "</nav>\n" +
        "\n" +
        "    <div class=\"divider\">\n" +
        "        <hr>\n" +
        "    </div>\n" +
        "\n" +
        "\n" +
        "<div class=\"jumbotron\"><h1>Customer Updated</h1></div>";

String secondPartHtml = "</div>\n" +
        "<script src=\"https://code.jquery.com/jquery-3.3.1.slim.min.js\" integrity=\"sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo\" crossorigin=\"anonymous\"></script>\n" +
        "<script src=\"https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js\" integrity=\"sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49\" crossorigin=\"anonymous\"></script>\n" +
        "\n" +
        "\n" +
        "</body>\n" +
        "</html>\n";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            String firstName, lastName, address, country;
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

            if (request.getParameter("first_name").equals("") && request.getParameter("last_name").equals("") && request.getParameter("address").equals("") && request.getParameter("country").equals("")) {

                out.print("<h1>Please Enter Values</h1>");
            } else if (request.getParameter("first_name").equals("") || request.getParameter("last_name").equals("") || request.getParameter("address").equals("") || request.getParameter("country").equals("")) {
                out.print("<h1>Please Enter All Values</h1>");

            } else {
                SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
                Session session = sessionFactory.openSession();
                session.beginTransaction();
                firstName = request.getParameter("first_name");
                lastName = request.getParameter("last_name");
                address = request.getParameter("address");
                country = request.getParameter("country");

                org.hibernate.Query query = session.createQuery("update Customers set firstName = :name,lastName = :lastname,address = :address, country = :country where id ="+ request.getParameter("id"));
                query.setParameter("name", firstName);
                query.setParameter("lastname", lastName);
                query.setParameter("address", address);
                query.setParameter("country", country);
                query.executeUpdate();
                out.print(firstPartHtml);
                out.print("<div class=\"row \">\n " +
                        "    <div class=\"col-md-6 offset-md-3 alert alert-success\" role=\"alert\">\n" +

                        "                <h3>Customer Changed</h3>");
                query = session.createQuery("from Customers where idNumber="+request.getParameter("id"));
                List<Customers> list;
                list=query.list();
                for (int i = 0; i< list.size(); i++){

                    out.println("<p> ID-Number  -  " + list.get(i).getIdNumber()+"</p><p> First Name  -  " + list.get(i).getFirstName()+"</p><p> Last Name  -  "+ list.get(i).getLastName()+"</p><p> Address  -  "+list.get(i).getAddress()+"</p><p> Country  -  "+list.get(i).getCountry()+"</p>" );
                }

                session.close();

                sessionFactory.close();
                out.print("<h4>Successfully updated Customer!</h4>");
                out.println("<p><a href=\"/WebShopFinished/coustomers.jsp\" class=\"btn btn-dark\" role=\"button\">Go Back</a></p>\n" +
                        "            </div>\n" +
                        "</div>");

                out.print(secondPartHtml);

            }
        } catch (Exception e){
            System.out.println(e);
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
