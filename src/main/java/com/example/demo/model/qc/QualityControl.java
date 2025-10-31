package com.example.demo.model.qc;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.math.BigDecimal;

@Entity
public class QualityControl {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String batchId;
    private BigDecimal fiberStrength;
    private BigDecimal fiberMoisture;
    private BigDecimal dyeIntensity;
    private String qcPass;
    private String remark;
    private String inspector;
    private LocalDateTime inspectionDate;
    private String season;

    // getters & setters
}
