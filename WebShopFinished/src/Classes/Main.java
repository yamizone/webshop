package Classes;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;

import javax.xml.transform.Result;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static com.sun.org.apache.xml.internal.security.keys.keyresolver.KeyResolver.length;
import static java.lang.System.out;

public class Main {
    public static void main(String[] args) throws SQLException {
//        createSampleCustomers();
//        createSampleProducts();
//        createSampleSales();


    }





    public static void createSampleCustomers() {

        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        Customers person = new Customers("Alen", "Beslija", "Bosanski put 196", "BIH");
        Customers person1 = new Customers("John", "Doe", "Low Road", "England");
        Customers person2 = new Customers("Elizabeth", "Swan", "High Road", "Scotland");

        session.save(person);
        session.save(person1);
        session.save(person2);
        session.getTransaction().commit();
        session.close();
    }

    public static void createSampleProducts(){
        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        Products product1 = new Products("Chocolate",9.99,12);
        Products product2 = new Products("Whisky",39.99,100);
        Products product3 = new Products("Marlboro Red",5.99,1500);
        session.save(product1);
        session.save(product2);
        session.save(product3);
        session.getTransaction().commit();
        session.close();
    }

    public static void createSampleSales(){
        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        Sales sale1 = new Sales(1,1);
        Sales sale2 = new Sales(2,2);
        Sales sale3 = new Sales(3,3);
        session.save(sale1);
        session.save(sale2);
        session.save(sale3);
        session.getTransaction().commit();
        session.close();
    }

    public static List getCustomers() {
        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        Query query = session.createQuery("from Customers");
        List<Customers> list;
        list = query.list();

        return list;


    }





}