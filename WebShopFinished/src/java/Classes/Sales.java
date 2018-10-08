package Classes;

import java.io.Serializable;
import javax.persistence.*;

@Entity
@Table
public class Sales implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idNumber;
    private Integer productIDNumber;
    private Integer customerID;

    public Sales (Integer productIDNumber,Integer customerID){
        this.productIDNumber = productIDNumber;
        this.customerID = customerID;
    }

    public Integer getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(Integer idNumber) {
        this.idNumber = idNumber;
    }

    public Sales() {
    }

    public Integer getProductIDNumber() {
        return productIDNumber;
    }

    public void setProductIDNumber(Integer productIDNumber) {
        this.productIDNumber = productIDNumber;
    }

    public Integer getCustomerID() {
        return customerID;
    }

    public void setCustomerID(Integer customerID) {
        this.customerID = customerID;
    }
}
