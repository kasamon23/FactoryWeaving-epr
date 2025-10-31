package com.example.demo.dto.inventory;

import java.math.BigDecimal;

public class StockLedgerReq {

    private Long productId;       // materialId
    private Long locationId;      // ถ้าใช้หลายคลัง
    private BigDecimal qty;       // จำนวนเพิ่ม/ลด
    private String txnType;       // OUT, IN, ADJUST
    private BigDecimal unitCost;  // ราคาต่อหน่วย (ถ้ามี)

    // getters & setters
}
