package com.example.factoryweaving.service;

import com.example.factoryweaving.model.Stock;
import com.example.factoryweaving.model.StockLedger;
import com.example.factoryweaving.model.StockTxnType;
import com.example.factoryweaving.repository.StockLedgerRepo;
import com.example.factoryweaving.repository.StockRepo;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.Instant;

@Service
public class InventoryService {

    private final StockRepo stockRepo;
    private final StockLedgerRepo ledgerRepo;

    public InventoryService(StockRepo stockRepo, StockLedgerRepo ledgerRepo) {
        this.stockRepo = stockRepo;
        this.ledgerRepo = ledgerRepo;
    }

    /**
     * บันทึกการเคลื่อนไหววัตถุดิบ/ผ้า/สีของโรงงานทอผ้า
     */
    public StockLedger post(Long materialId, Long locationId, int qty, StockTxnType txnType, Double unitCost) {
        if (materialId == null || locationId == null || qty == 0 || txnType == null) {
            throw new IllegalArgumentException("materialId, locationId, qty, txnType are required");
        }

        // 1) บันทึก Ledger
        StockLedger lg = StockLedger.builder()
                .materialId(materialId)
                .locationId(locationId)
                .qty(qty)
                .txnType(txnType)
                .build();
        ledgerRepo.save(lg);

        // 2) คำนวณผลกระทบคงคลัง
        int delta = qty;
        if (txnType == StockTxnType.OUT) { // เบิกวัตถุดิบ
            delta = -delta;
        } else if (txnType == StockTxnType.ADJUST) { // ปรับ stock ให้ตรงกับ qty ใหม่
            int current = stockRepo.findByMaterialIdAndLocationId(materialId, locationId)
                    .map(Stock::getOnHand).orElse(0);
            delta = qty - current;
        }

        // 3) upsert ตาราง stocks
        Stock stock = stockRepo.findByMaterialIdAndLocationId(materialId, locationId)
                .orElse(Stock.builder()
                        .materialId(materialId)
                        .locationId(locationId)
                        .onHand(0)
                        .build());

        int onHand = (stock.getOnHand() == null ? 0 : stock.getOnHand()) + delta;
        stock.setOnHand(onHand);

        if (unitCost != null) {
            stock.setLastCost(BigDecimal.valueOf(unitCost));
        }
        stock.setUpdatedAt(Instant.now());
        stockRepo.save(stock);

        return lg;
    }
}
