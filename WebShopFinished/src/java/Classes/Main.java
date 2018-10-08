package Classes;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import java.sql.SQLException;
import java.util.List;

public class Main {
    public static void main(String[] args) throws SQLException {

    }

    public static void createSampleCustomers() {

        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        try (Session session = sessionFactory.openSession()) {
            session.beginTransaction();
            Customers person = new Customers("Almin", "Piljevic", "Dobrinjske Bolnice", "BiH");
            Customers person1 = new Customers("Predrag", "Lucic", "Banovo Brdo", "Srbija");
            Customers person2 = new Customers("Zeljko", "Misic", "Jeliceva", "Hrvatska");
            
            session.save(person);
            session.save(person1);
            session.save(person2);
            session.getTransaction().commit();
        }
    }

    public static void createSampleProducts(){
        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        try (Session session = sessionFactory.openSession()) {
            session.beginTransaction();
            Products product1 = new Products("Prirodni Sok",10.50,20);
            Products product2 = new Products("Torta",20.50,95);
            Products product3 = new Products("Fanta",15.30,95);
            session.save(product1);
            session.save(product2);
            session.save(product3);
            session.getTransaction().commit();
        }
    }

    public static void createSampleSales(){
        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        try (Session session = sessionFactory.openSession()) {
            session.beginTransaction();
            Sales sale1 = new Sales(1,1);
            Sales sale2 = new Sales(2,2);
            Sales sale3 = new Sales(3,3);
            session.save(sale1);
            session.save(sale2);
            session.save(sale3);
            session.getTransaction().commit();
        }
    }

    public static List getCustomers() {
        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        org.hibernate.Query query = session.createQuery("from Customers");
        List<Customers> list;
        list = query.list();

        return list;

    }

}