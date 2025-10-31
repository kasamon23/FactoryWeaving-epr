package com.example.demo.model.shipment;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
public class ShipmentTracking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String batchId;
    private String productName;
    private String deliveryMethod;
    private String trackingNumber;
    private String deliveryStatus;
    private String region;
    private String zone;
    private String province;
    private String district;
    private LocalDate expectedDelivery;
    private LocalDate actualDelivery;
    private String note;

    // getters & setters
}
