package Classes;

import java.io.Serializable;
import javax.persistence.*;

@Entity
@Table
public class Products implements Serializable {

    private String productName;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idNumber;
    private Double price;
    private Integer inventory;

    public Products (String productName,Double price,Integer inventory){
        this.productName = productName;
        this.price = price;
        this.inventory = inventory;
    }

    public Products() {
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Integer getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(Integer idNumber) {
        this.idNumber = idNumber;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getInventory() {
        return inventory;
    }

    public void setInventory(Integer inventory) {
        this.inventory = inventory;
    }
}
