package Classes;

import javax.persistence.*;

@Entity
@Table
public class Customers {


    private String firstName,lastName,address,country;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idNumber;




    public Customers(String firstName, String lastName, String address, String country){
        this.firstName = firstName;
        this.lastName = lastName;
        this.address = address;
        this.country = country;
    }

    public Customers() {
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(Integer idNumber) {
        this.idNumber = idNumber;
    }



}
