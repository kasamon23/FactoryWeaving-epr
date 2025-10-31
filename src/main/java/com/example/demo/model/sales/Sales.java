package com.example.demo.model.sales;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
public class Sales {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String batchId;
    private String productName;
    private String patternName;
    private String material;
    private BigDecimal weightKg;
    private BigDecimal unitSellingPrice;
    private BigDecimal totalSales;
    private String region;
    private String zone;
    private String province;
    private String district;
    private String salesSeason;
    private String customerType;
    private String note;

    // getters & setters
}
