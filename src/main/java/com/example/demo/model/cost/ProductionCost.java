package com.example.demo.model.cost;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
public class ProductionCost {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String batchId;
    private BigDecimal rawMaterialCost;
    private BigDecimal laborCost;
    private BigDecimal energyCost;
    private BigDecimal transportCost;
    private BigDecimal totalCost;
    private String region;
    private String zone;
    private String province;
    private String district;
    private String productionSeason;
    private String note;

    // getters & setters
}
