package com.example.demo.model.inventory;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
public class Stock {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long materialId;

    private String lotNo;
    private String materialName;
    private String type;
    private String category1;
    private String category2;
    private String category3;

    private Long supplierId;
    private BigDecimal initialQty;
    private BigDecimal currentQty;

    private LocalDate expireDate;
    private String qcStatus;
    private String grade;
    private LocalDate qcDate;
    private String rejectReason;

    private String region;
    private String zone;
    private String province;
    private String district;
    private String note;

    // getters & setters
}
