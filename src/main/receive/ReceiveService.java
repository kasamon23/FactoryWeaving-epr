package com.example.demo.model.receive;

import com.example.demo.model.inventory.Stock;
import com.example.demo.model.inventory.StocksRepository;
import com.example.demo.dto.inventory.PostStockDto;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Optional;

@Service
public class ReceiveService {

    private final StocksRepository stockRepo;

    public ReceiveService(StocksRepository stockRepo) {
        this.stockRepo = stockRepo;
    }

    @Transactional
    public Stock receiveMaterial(PostStockDto dto) {
        // หา Stock เดิมตาม materialId
        Optional<Stock> opt = stockRepo.findById(dto.getSupplierId());
        Stock stock = opt.orElseGet(Stock::new);

        // อัปเดตข้อมูลจาก DTO
        stock.setLotNo(dto.getLotNo());
        stock.setMaterialName(dto.getMaterialName());
        stock.setType(dto.getType());
        stock.setCategory1(dto.getCategory1());
        stock.setCategory2(dto.getCategory2());
        stock.setCategory3(dto.getCategory3());
        stock.setSupplierId(dto.getSupplierId());
        stock.setInitialQty(dto.getInitialQty());
        stock.setCurrentQty(dto.getCurrentQty());
        stock.setExpireDate(dto.getExpireDate());
        stock.setQcStatus(dto.getQcStatus());
        stock.setGrade(dto.getGrade());
        stock.setQcDate(dto.getQcDate());
        stock.setRejectReason(dto.getRejectReason());
        stock.setRegion(dto.getRegion());
        stock.setZone(dto.getZone());
        stock.setProvince(dto.getProvince());
        stock.setDistrict(dto.getDistrict());
        stock.setNote(dto.getNote());

        return stockRepo.save(stock);
    }
}
