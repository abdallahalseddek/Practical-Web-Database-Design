package store.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;

@Entity
@Table(name="orders")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Integer orderId;
    private Timestamp orderDate;
    private Double orderTotalAmount;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(referencedColumnName = "customerId")
    private Customer customer;
}
