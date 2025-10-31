package com.example.demo.model.sales;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
public class ProfitLoss {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String batchId;
    private BigDecimal totalCost;
    private BigDecimal totalSales;
    private BigDecimal profit;
    private BigDecimal profitPercent;
    private String region;
    private String zone;
    private String province;
    private String district;
    private String season;
    private String note;

    // getters & setters
}
