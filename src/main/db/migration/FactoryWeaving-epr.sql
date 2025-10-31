-- phpMyAdmin SQL Dump
-- version 5.x
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 31, 2025 at 10:15 PM
-- Server version: 10.4.32-MariaDB
-- Database: `factory_weaving_erp`

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+07:00"; -- Thailand Time Zone

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `factory_weaving_erp`
--

-- --------------------------------------------------------

--
-- Table structure for table `suppliers` (ตารางผู้จัดหา)
--
CREATE TABLE `suppliers` (
  `id` bigint(20) NOT NULL,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `type` enum('farmer','community','company') NOT NULL, -- ประเภทผู้จัดหา (จาก วัตถุดิบ.csv)
  `region` varchar(100) DEFAULT NULL,
  `province` varchar(100) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--
INSERT INTO `suppliers` (`id`, `name`, `type`, `region`, `province`, `district`, `contact_person`, `phone`, `email`) VALUES
(1, 'กลุ่มเกษตรกรน่าน', 'farmer', 'เหนือ', 'น่าน', 'เมืองน่าน', 'คุณสมชาย', '08x-xxx-xxxx', NULL),
(2, 'ศูนย์ส่งเสริมศิลปาชีพสุรินทร์', 'community', 'ตะวันออกเฉียงเหนือ', 'สุรินทร์', 'เมืองสุรินทร์', 'คุณสุรีย์', '09x-xxx-xxxx', NULL),
(3, 'กลุ่มชุมชนสกลนคร', 'community', 'ตะวันออกเฉียงเหนือ', 'สกลนคร', 'เมืองสกลนคร', 'คุณสันติ', '08x-xxx-xxxx', NULL),
(4, 'บริษัทนำเข้าเคมียุโรป', 'company', 'ยุโรป', 'Germany', 'Berlin', 'Mr. Muller', '+49-xxx-xxx', 'muller@chem-eu.com');

-- --------------------------------------------------------

--
-- Table structure for table `raw_materials` (Material Master - วัตถุดิบหลัก)
--
CREATE TABLE `raw_materials` (
  `id` bigint(20) NOT NULL,
  `material_name` varchar(255) NOT NULL,
  `material_type` enum('fiber','dye','chemical') NOT NULL, -- เช่น เส้นใย, สีย้อม (จาก วัตถุดิบ.csv)
  `category_lvl1` varchar(100) DEFAULT NULL,
  `category_lvl2` varchar(100) DEFAULT NULL,
  `category_lvl3` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `raw_materials`
--
INSERT INTO `raw_materials` (`id`, `material_name`, `material_type`, `category_lvl1`, `category_lvl2`, `category_lvl3`) VALUES
(1, 'ฝ้ายออร์แกนิก', 'fiber', 'ผ้า', 'เส้นใย', 'ฝ้าย'),
(2, 'ไหมพันธุ์ดีสุรินทร์', 'fiber', 'ผ้า', 'เส้นใย', 'ไหม'),
(3, 'ครามธรรมชาติ', 'dye', 'สี', 'ธรรมชาติ', 'คราม'),
(4, 'เคมี', 'dye', 'สี', 'เคมี', 'สังเคราะห์');

-- --------------------------------------------------------

--
-- Table structure for table `production_batches` (ตาราง Batch การผลิตหลัก)
--
CREATE TABLE `production_batches` (
  `batch_id` varchar(50) NOT NULL, -- รหัส Batch (จากไฟล์ทั้งหมด)
  `material_id` bigint(20) DEFAULT NULL, -- วัตถุดิบหลักที่ใช้ (FK to raw_materials)
  `product_name` varchar(255) NOT NULL, -- ชื่อผลิตภัณฑ์สำเร็จรูป (จาก ผลิตภัณฑ์.csv)
  `pattern_name` varchar(100) DEFAULT NULL, -- ลวดลายผ้า (จาก ผลิตภัณฑ์.csv)
  `production_start` datetime DEFAULT NULL, -- วันที่เริ่มผลิต (จาก กรอบเวลา.csv)
  `production_end` datetime DEFAULT NULL, -- วันที่สิ้นสุดผลิต (จาก กรอบเวลา.csv)
  `season` varchar(50) DEFAULT NULL,
  `qc_status` enum('passed','failed','pending') NOT NULL -- สถานะ QC ล่าสุด (จาก QC.csv/กรอบเวลา.csv)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `production_batches`
--
INSERT INTO `production_batches` (`batch_id`, `material_id`, `product_name`, `pattern_name`, `production_start`, `production_end`, `season`, `qc_status`) VALUES
('B001', 2, 'ผ้าไหม-ฝ้าย', 'มัดหมี่', '2025-08-10 08:00:00', '2025-08-12 17:00:00', 'ร้อน', 'passed'),
('B002', 2, 'ผ้าไหม-ฝ้าย', 'ขิด', '2025-08-11 09:00:00', '2025-08-13 18:00:00', 'ร้อน', 'passed'),
('B003', 3, 'ผ้าไหม-ฝ้าย', 'กง', '2025-08-09 07:00:00', '2025-08-11 16:00:00', 'ร้อน', 'passed'),
('B004', 4, 'ผ้าไหม-ฝ้าย', 'หมากจับ', '2025-08-11 09:30:00', '2025-08-13 18:30:00', 'ร้อน', 'failed'), -- QC fail ตาม QC.csv
('B005', 2, 'ผ้าไหม-ฝ้าย', 'นาค', '2025-08-10 09:30:00', '2025-08-12 17:30:00', 'ร้อน', 'passed');

-- --------------------------------------------------------

--
-- Table structure for table `batch_sales_and_cost` (ตารางต้นทุน, ขาย, กำไร/ขาดทุน)
--
CREATE TABLE `batch_sales_and_cost` (
  `id` bigint(20) NOT NULL,
  `batch_id` varchar(50) NOT NULL,
  `raw_material_cost` decimal(12,2) DEFAULT NULL, -- raw_material_cost (จาก ต้นทุนผลิต.csv)
  `labor_cost` decimal(10,2) DEFAULT NULL,
  `energy_cost` decimal(10,2) DEFAULT NULL,
  `transport_cost` decimal(10,2) DEFAULT NULL,
  `total_cost` decimal(12,2) DEFAULT NULL,
  `unit_selling_price` decimal(10,2) DEFAULT NULL, -- unit_selling_price (จาก ผลิตภัณฑ์.csv)
  `total_sales` decimal(12,2) DEFAULT NULL,
  `profit` decimal(12,2) DEFAULT NULL,
  `profit_percent` decimal(10,4) DEFAULT NULL,
  `customer_type` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `batch_sales_and_cost`
--
INSERT INTO `batch_sales_and_cost` (`id`, `batch_id`, `raw_material_cost`, `labor_cost`, `energy_cost`, `transport_cost`, `total_cost`, `unit_selling_price`, `total_sales`, `profit`, `profit_percent`, `customer_type`) VALUES
(1, 'B001', 5000.00, 1200.00, 500.00, 800.00, 7500.00, 850.00, 8500.00, 1000.00, 13.3333, 'ร้านค้าปลีก'),
(2, 'B002', 6000.00, 1100.00, 600.00, 900.00, 8600.00, 830.00, 6640.00, -1960.00, -22.7907, 'ร้านค้าส่ง'),
(3, 'B003', 3000.00, 1400.00, 550.00, 750.00, 5700.00, 820.00, 9840.00, 4140.00, 72.6316, 'ออนไลน์'),
(4, 'B004', 3000.00, 1300.00, 500.00, 800.00, 5600.00, 810.00, 7290.00, 1690.00, 30.1786, 'ร้านค้าปลีก'),
(5, 'B005', 6000.00, 1250.00, 450.00, 700.00, 8400.00, 850.00, 5950.00, -2450.00, -29.1667, 'ร้านค้าส่ง');

-- --------------------------------------------------------

--
-- Table structure for table `quality_checks` (ตารางการควบคุมคุณภาพ)
--
CREATE TABLE `quality_checks` (
  `id` bigint(20) NOT NULL,
  `batch_id` varchar(50) NOT NULL,
  `inspection_date` datetime DEFAULT NULL,
  `inspector` varchar(100) DEFAULT NULL,
  `qc_pass` enum('Y','N') NOT NULL,
  `fiber_strength` decimal(5,3) DEFAULT NULL, -- fiber_strength (จาก QC.csv)
  `dye_intensity` decimal(5,3) DEFAULT NULL, -- dye_intensity (จาก QC.csv)
  `remark` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quality_checks`
--
INSERT INTO `quality_checks` (`id`, `batch_id`, `inspection_date`, `inspector`, `qc_pass`, `fiber_strength`, `dye_intensity`, `remark`) VALUES
(1, 'B001', '2025-08-12 14:00:00', 'คุณสมชาย', 'Y', 0.850, NULL, 'ผ่านเกณฑ์'),
(2, 'B002', '2025-08-13 15:00:00', 'คุณศิริพร', 'Y', 0.900, NULL, 'ผ่านเกณฑ์'),
(3, 'B003', '2025-08-11 13:00:00', 'Mr. Muller', 'Y', NULL, 0.950, 'สีเข้มพอดี'),
(4, 'B004', '2025-08-12 14:30:00', 'คุณสมชาย', 'N', 0.800, NULL, 'เส้นใยอ่อน'),
(5, 'B005', '2025-08-12 14:45:00', 'คุณศิริพร', 'Y', 0.870, NULL, 'ผ่านเกณฑ์');

-- --------------------------------------------------------

--
-- Table structure for table `shipping_tracking` (ตารางจัดส่งและติดตามสินค้า)
--
CREATE TABLE `shipping_tracking` (
  `id` bigint(20) NOT NULL,
  `batch_id` varchar(50) NOT NULL,
  `delivery_method` varchar(100) DEFAULT NULL,
  `tracking_number` varchar(100) DEFAULT NULL,
  `delivery_status` varchar(50) NOT NULL,
  `expected_delivery` date DEFAULT NULL,
  `actual_delivery` date DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shipping_tracking`
--
INSERT INTO `shipping_tracking` (`id`, `batch_id`, `delivery_method`, `tracking_number`, `delivery_status`, `expected_delivery`, `actual_delivery`, `region`) VALUES
(1, 'B001', 'ขนส่งทางบก', 'TRK20250817001', 'จัดส่งเรียบร้อย', '2025-08-15', '2025-08-15', 'ภาคเหนือ'),
(2, 'B002', 'ขนส่งทางบก', 'TRK20250817002', 'รอจัดส่ง', '2025-08-17', NULL, 'ภาคอีสาน'),
(3, 'B003', 'ขนส่งทางเรือ', 'TRK20250817003', 'กำลังขนส่ง', '2025-08-18', NULL, 'ภาคเหนือ'),
(4, 'B004', 'ขนส่งทางบก', 'TRK20250817004', 'จัดส่งเรียบร้อย', '2025-08-15', '2025-08-15', 'ภาคกลาง'),
(5, 'B005', 'ขนส่งทางอากาศ', 'TRK20250817005', 'จัดส่งเรียบร้อย', '2025-08-14', '2025-08-14', 'ภาคใต้');


--
-- Indexes for dumped tables
--

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_idx` (`name`);

--
-- Indexes for table `raw_materials`
--
ALTER TABLE `raw_materials`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `material_name_idx` (`material_name`);

--
-- Indexes for table `production_batches`
--
ALTER TABLE `production_batches`
  ADD PRIMARY KEY (`batch_id`),
  ADD KEY `material_id` (`material_id`);

--
-- Indexes for table `batch_sales_and_cost`
--
ALTER TABLE `batch_sales_and_cost`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `batch_id_idx` (`batch_id`);

--
-- Indexes for table `quality_checks`
--
ALTER TABLE `quality_checks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `batch_id_idx` (`batch_id`);

--
-- Indexes for table `shipping_tracking`
--
ALTER TABLE `shipping_tracking`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `batch_id_idx` (`batch_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `raw_materials`
--
ALTER TABLE `raw_materials`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `batch_sales_and_cost`
--
ALTER TABLE `batch_sales_and_cost`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `quality_checks`
--
ALTER TABLE `quality_checks`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `shipping_tracking`
--
ALTER TABLE `shipping_tracking`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `production_batches`
--
ALTER TABLE `production_batches`
  ADD CONSTRAINT `production_batches_ibfk_1` FOREIGN KEY (`material_id`) REFERENCES `raw_materials` (`id`);

--
-- Constraints for table `batch_sales_and_cost`
--
ALTER TABLE `batch_sales_and_cost`
  ADD CONSTRAINT `batch_sales_and_cost_ibfk_1` FOREIGN KEY (`batch_id`) REFERENCES `production_batches` (`batch_id`);

--
-- Constraints for table `quality_checks`
--
ALTER TABLE `quality_checks`
  ADD CONSTRAINT `quality_checks_ibfk_1` FOREIGN KEY (`batch_id`) REFERENCES `production_batches` (`batch_id`);

--
-- Constraints for table `shipping_tracking`
--
ALTER TABLE `shipping_tracking`
  ADD CONSTRAINT `shipping_tracking_ibfk_1` FOREIGN KEY (`batch_id`) REFERENCES `production_batches` (`batch_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;