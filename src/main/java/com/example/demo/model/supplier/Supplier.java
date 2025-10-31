package com.example.demo.model.supplier;

import jakarta.persistence.*;

@Entity
public class Supplier {

    @Id
    private Long supplierId;

    private String supplierName;
    private String supplierType;
    private String materialType;
    private String materialName;
    private String categoryLvl1;
    private String categoryLvl2;
    private String categoryLvl3;
    private String region;
    private String province;
    private String district;
    private String contactPerson;
    private String phone;
    private String email;
    private String note;
    private String batchId;

    // getters & setters
}
