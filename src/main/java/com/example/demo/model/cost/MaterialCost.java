package com.example.demo.model.cost;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
public class MaterialCost {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String batchId;
    private String materialType;
    private String materialName;
    private Long supplierId;
    private BigDecimal quantity;
    private BigDecimal unitPrice;
    private BigDecimal cost;
    private String deliveryRegion;
    private LocalDate deliveryDate;
    private String note;

    // getters & setters
}
