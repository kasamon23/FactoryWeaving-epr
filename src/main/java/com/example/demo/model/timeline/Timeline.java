package com.example.demo.model.timeline;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
public class Timeline {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String batchId;
    private LocalDateTime productionStart;
    private LocalDateTime productionEnd;
    private LocalDateTime qcDate;
    private LocalDateTime shippingDate;
    private LocalDateTime deliveryDate;
    private String season;
    private String timeSlot;
    private String note;

    // getters & setters
}
