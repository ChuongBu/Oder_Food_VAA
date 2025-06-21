-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th6 21, 2025 lúc 10:01 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `oderfood`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `banan`
--

CREATE TABLE `banan` (
  `MaBanAn` int(5) NOT NULL,
  `TenBanAn` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `giohang`
--

CREATE TABLE `giohang` (
  `MaGioHang` int(11) NOT NULL,
  `MaMonAn` int(11) NOT NULL,
  `Soluong` int(11) NOT NULL,
  `MabanOder` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `goimon`
--

CREATE TABLE `goimon` (
  `MaGoiMon` int(11) NOT NULL,
  `MaNV` int(11) NOT NULL,
  `NgayOder` date NOT NULL,
  `TinhTrang` text NOT NULL,
  `MabanOder` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `loaimon`
--

CREATE TABLE `loaimon` (
  `MaLoai` int(11) NOT NULL,
  `TenLoai` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `loaimon`
--

INSERT INTO `loaimon` (`MaLoai`, `TenLoai`) VALUES
(1, 'Bít tết (Steak)'),
(2, 'Mì Ý (Pasta)'),
(3, 'Pizza'),
(4, 'Salad'),
(5, 'Bánh ngọt'),
(6, 'Đồ uống'),
(7, 'Món Á'),
(8, 'Sushi và Sashimi'),
(9, 'Mì Ramen/ Udon'),
(10, 'Cơm rang/ Cơm chiên'),
(11, 'Các món xào'),
(12, 'Lẩu'),
(13, 'Các món ăn truyền thống');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `loaisot`
--

CREATE TABLE `loaisot` (
  `MaSoT` int(11) NOT NULL,
  `TenSoT` text DEFAULT NULL,
  `MoTa` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `loaisot`
--

INSERT INTO `loaisot` (`MaSoT`, `TenSoT`, `MoTa`) VALUES
(1, 'Sốt tiêu đen', 'Vị cay nồng từ tiêu đen và kem tươi.'),
(2, 'Sốt tiêu xanh', 'Vị cay nhẹ, thơm mùi tiêu xanh và kem.'),
(3, 'Sốt nấm', 'Kem nấm béo ngậy, đậm đà hương vị nấm.'),
(4, 'Sốt kem', 'Kem tươi nhẹ béo, dễ kết hợp nhiều món.'),
(5, 'Sốt Bearnaise', 'Sốt bơ, trứng và giấm, vị chua béo nhẹ.');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `monan`
--

CREATE TABLE `monan` (
  `MaMonAn` int(10) NOT NULL,
  `TenMon` text NOT NULL,
  `GiaTien` varchar(100) NOT NULL,
  `MaLoai` int(10) NOT NULL,
  `ChiTietSP` text DEFAULT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `monan`
--

INSERT INTO `monan` (`MaMonAn`, `TenMon`, `GiaTien`, `MaLoai`, `ChiTietSP`, `image`) VALUES
(1, 'Bít tết bò', '250000', 1, 'Steak từ thăn nội, thăn ngoại, thăn lưng hoặc lõi vai bò.', 'bit_tet_bo'),
(2, 'Bò Wagyu', '500000', 1, 'Steak bò Wagyu cao cấp, vân mỡ đẹp, mềm tan trong miệng.', 'Bo_Wagyu'),
(3, 'Bít tết cừu', '300000', 1, 'Bít tết cừu nướng/áp chảo với gia vị và thảo mộc.', 'Bit_tet_cuu'),
(4, 'Bít tết cá hồi', '280000', 1, 'Cá hồi áp chảo/nướng, ăn kèm rau củ và sốt đặc trưng.', 'Bit_tet_ca_hoi'),
(5, 'Spaghetti Carbonara', '120000', 2, 'Mì Spaghetti, thịt xông khói, trứng, phô mai Pecorino Romano, tiêu đen. Trộn sốt trứng khi mì còn nóng để tạo độ sánh.', 'SpaghettiCarbonara'),
(6, 'Spaghetti alla Bolognese', '130000', 2, 'Mì Spaghetti, thịt bò xay, sốt cà chua, rau củ và rượu vang đỏ. Nấu sốt liu riu để sánh đặc.', 'Spaghetti_alla_Bolognese'),
(7, 'Spaghetti Aglio e Olio', '110000', 2, 'Mì Spaghetti xào với tỏi, ớt, dầu ô liu, rau mùi tây. Món đơn giản mà đậm vị Ý.', 'Spaghetti_Aglio_e_Olio'),
(8, 'Penne all\'Arrabbiata', '115000', 2, 'Mì Penne với sốt cà chua cay, tỏi, ớt, dầu ô liu và rau mùi tây.', 'Penne_all\'Arrabbiata'),
(9, 'Mì Ý sốt kem', '125000', 2, 'Kết hợp kem tươi, phô mai, các loại thịt (gà, bò, hải sản) hoặc rau củ.', 'Mi_Y_sot_kem'),
(10, 'Mì Ý sốt pesto', '125000', 2, 'Sốt pesto từ húng quế, tỏi, dầu ô liu, hạt thông và phô mai Parmesan.', 'Mi_Y_sot_pesto'),
(11, 'Mì Ý hải sản', '140000', 2, 'Hải sản (tôm, mực, ngao) xào với sốt cà chua hoặc sốt kem.', 'Mi_Y_hai_san'),
(12, 'Pizza Margherita', '150000', 3, 'Pizza truyền thống với sốt cà chua, phô mai mozzarella và lá húng quế.', 'Pizza_Margherita'),
(13, 'Pizza Pepperoni', '160000', 3, 'Pizza với xúc xích pepperoni cay, sốt cà chua và phô mai mozzarella.', 'Pizza_Pepperoni'),
(14, 'Pizza Hải sản', '180000', 3, 'Pizza với tôm, mực, sò, phô mai và sốt cà chua.', 'Pizza_Hai_san'),
(15, 'Pizza Thập cẩm', '170000', 3, 'Pizza kết hợp nhiều nguyên liệu như xúc xích, giăm bông, ớt chuông, nấm và phô mai.', 'Pizza_Thapcam'),
(16, 'Pizza Gà BBQ', '165000', 3, 'Pizza gà nướng sốt BBQ, hành tây và phô mai.', 'Pizza_Ga_BBQ'),
(17, 'Pizza Rau củ chay', '145000', 3, 'Dành cho người ăn chay, gồm ớt chuông, nấm, hành tây, ngô và phô mai.', 'Pizza_chay'),
(18, 'Salad Caesar', '85000', 4, 'Xà lách Romaine, phô mai Parmesan, bánh mì nướng, sốt Caesar, thịt gà nướng.', 'Salad_Caesar'),
(19, 'Salad Hy Lạp', '80000', 4, 'Dưa leo, cà chua, hành tây, phô mai feta, ô liu đen, sốt dầu giấm.', 'Salad_HyLap'),
(20, 'Salad trộn cá ngừ', '90000', 4, 'Rau xanh, cá ngừ hộp, trứng luộc, bắp, cà chua, sốt mayonnaise.', 'Salad_CaNgu'),
(21, 'Salad trái cây', '75000', 4, 'Các loại trái cây tươi theo mùa, sốt sữa chua hoặc mật ong.', 'Salad_trai_cay'),
(22, 'Salad rau củ nướng', '85000', 4, 'Cà tím, bí đỏ, ớt chuông nướng trộn với dầu ô liu và giấm balsamic.', 'Salad_rau_cu_nuong'),
(23, 'Bánh Tiramisu', '60000', 5, 'Bánh Ý truyền thống với cà phê, kem mascarpone và cacao.', 'Tiramisu'),
(24, 'Bánh Red Velvet', '65000', 5, 'Bánh bông lan đỏ với lớp kem phô mai mềm mịn.', 'Red_Velvet'),
(25, 'Bánh phô mai Nhật', '70000', 5, 'Bánh nhẹ, mềm mịn, ít ngọt, đậm vị phô mai.', 'Banh_pho_mai_Nhat'),
(26, 'Bánh su kem', '55000', 5, 'Vỏ bánh mỏng, nhân kem vani ngọt mát.', 'su_kem'),
(27, 'Bánh mousse socola', '68000', 5, 'Lớp mousse socola mịn màng, vị đậm đà.', 'mousse_socola'),
(28, 'Trà đào cam sả', '40000', 6, 'Trà đen kết hợp đào ngâm, cam tươi và sả thơm mát.', 'Tra_đao_cam_sa'),
(29, 'Trà sữa truyền thống', '35000', 6, 'Trà đen hoặc trà ô long kết hợp sữa và trân châu.', 'Tra_sua'),
(30, 'Cà phê sữa đá', '30000', 6, 'Cà phê pha phin truyền thống với sữa đặc, đá mát lạnh.', 'Ca_phe_sua_da'),
(31, 'Sinh tố bơ', '45000', 6, 'Bơ xay với sữa đặc và đá, béo mịn, thơm ngon.', 'Sinh_to_bo'),
(32, 'Nước cam ép', '38000', 6, 'Cam tươi vắt nguyên chất, không đường, giàu vitamin C.', 'cam_ep'),
(33, 'Sushi cá hồi', '95000', 8, 'Cơm sushi kết hợp lát cá hồi tươi sống, wasabi và gừng.', 'Sushi_ca_hoi'),
(34, 'Sashimi tổng hợp', '120000', 8, 'Nhiều loại cá sống: cá hồi, cá ngừ, mực cắt lát nghệ thuật.', 'Sashimi_tong_hop'),
(35, 'Mì Ramen Tonkotsu', '100000', 9, 'Mì ramen nước hầm xương heo đậm vị, trứng lòng đào, thịt char siu.', 'Ramen_Tonkotsu'),
(36, 'Mì Udon Tempura', '95000', 9, 'Mì udon sợi to, nước dùng thanh nhẹ, ăn kèm tôm chiên giòn.', 'Udon_Tempura'),
(37, 'Cơm cá hồi nướng Teriyaki', '105000', 7, 'Cá hồi áp chảo sốt Teriyaki ăn kèm cơm Nhật và salad.', 'Com_ca_hoi_nuong_Teriyaki'),
(38, 'Cơm rang Dương Châu', '75000', 10, 'Cơm chiên với trứng, tôm, lạp xưởng, đậu Hà Lan, cà rốt.', 'Com_rang_Duong_Chau'),
(39, 'Mì xào bò', '78000', 11, 'Mì trứng xào bò, rau cải, giá đỗ, sốt đậm đà.', 'Mi_xao_bo'),
(40, 'Hủ tiếu Nam Vang', '80000', 13, 'Nước lèo thanh, topping thịt heo, tôm, trứng cút, gan, hành phi.', 'Hu_tieu_Nam_Vang'),
(41, 'Phở bò tái chín', '85000', 13, 'Bánh phở tươi, nước dùng bò, thịt tái chín, hành, rau thơm.', 'Pho_tai_chin'),
(42, 'Bún bò Huế', '85000', 13, 'Nước dùng cay nồng, chả, giò heo, thịt bò, rau sống.', 'Bun_bo'),
(43, 'Lẩu thái hải sản', '250000', 12, 'Nước lẩu chua cay, tôm, mực, cá viên, rau và bún tươi.', 'Lau_thai'),
(44, 'Lẩu bò nhúng giấm', '260000', 12, 'Thịt bò, nước lẩu giấm thơm, bún, rau sống, nước mắm gừng.', 'bo_nhung_giam'),
(45, 'Lẩu nấm chay', '230000', 12, 'Nấm đùi gà, kim châm, rau củ, đậu phụ, nước lẩu thanh đạm.', 'Lau_nam_chay'),
(46, 'Lẩu gà lá é', '240000', 12, 'Thịt gà ta, lá é đặc trưng miền Trung, nấm và mì trứng.', 'ga_la_e'),
(47, 'Lẩu kim chi Hàn Quốc', '260000', 12, 'Nước lẩu cay, kim chi, đậu phụ, thịt ba chỉ, nấm, mì Hàn.', 'Lau_kimchi');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `monan_sot`
--

CREATE TABLE `monan_sot` (
  `MaMonAn` int(11) NOT NULL,
  `MaSoT` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nhanvien`
--

CREATE TABLE `nhanvien` (
  `MaNV` int(10) NOT NULL,
  `TenDN` text NOT NULL,
  `MatKhau` text NOT NULL,
  `GioiTinh` text DEFAULT NULL,
  `NgaySinh` date DEFAULT NULL,
  `CCCD` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `banan`
--
ALTER TABLE `banan`
  ADD PRIMARY KEY (`MaBanAn`);

--
-- Chỉ mục cho bảng `giohang`
--
ALTER TABLE `giohang`
  ADD PRIMARY KEY (`MaGioHang`),
  ADD KEY `fk_cart_monan` (`MaMonAn`);

--
-- Chỉ mục cho bảng `goimon`
--
ALTER TABLE `goimon`
  ADD PRIMARY KEY (`MaGoiMon`),
  ADD KEY `fk_goimon_nhanvien` (`MaNV`),
  ADD KEY `fk_goimon_banan` (`MabanOder`);

--
-- Chỉ mục cho bảng `loaimon`
--
ALTER TABLE `loaimon`
  ADD PRIMARY KEY (`MaLoai`);

--
-- Chỉ mục cho bảng `loaisot`
--
ALTER TABLE `loaisot`
  ADD PRIMARY KEY (`MaSoT`);

--
-- Chỉ mục cho bảng `monan`
--
ALTER TABLE `monan`
  ADD PRIMARY KEY (`MaMonAn`),
  ADD KEY `fk_monan_loai` (`MaLoai`);

--
-- Chỉ mục cho bảng `monan_sot`
--
ALTER TABLE `monan_sot`
  ADD PRIMARY KEY (`MaMonAn`,`MaSoT`),
  ADD KEY `MaSoT` (`MaSoT`);

--
-- Chỉ mục cho bảng `nhanvien`
--
ALTER TABLE `nhanvien`
  ADD PRIMARY KEY (`MaNV`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `banan`
--
ALTER TABLE `banan`
  MODIFY `MaBanAn` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `giohang`
--
ALTER TABLE `giohang`
  MODIFY `MaGioHang` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `goimon`
--
ALTER TABLE `goimon`
  MODIFY `MaGoiMon` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `loaimon`
--
ALTER TABLE `loaimon`
  MODIFY `MaLoai` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT cho bảng `loaisot`
--
ALTER TABLE `loaisot`
  MODIFY `MaSoT` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `monan`
--
ALTER TABLE `monan`
  MODIFY `MaMonAn` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT cho bảng `nhanvien`
--
ALTER TABLE `nhanvien`
  MODIFY `MaNV` int(10) NOT NULL AUTO_INCREMENT;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `giohang`
--
ALTER TABLE `giohang`
  ADD CONSTRAINT `fk_cart_monan` FOREIGN KEY (`MaMonAn`) REFERENCES `monan` (`MaMonAn`),
  ADD CONSTRAINT `fk_giohang_goimon` FOREIGN KEY (`MaGioHang`) REFERENCES `goimon` (`MaGoiMon`);

--
-- Các ràng buộc cho bảng `goimon`
--
ALTER TABLE `goimon`
  ADD CONSTRAINT `fk_goimon_banan` FOREIGN KEY (`MabanOder`) REFERENCES `banan` (`MaBanAn`),
  ADD CONSTRAINT `fk_goimon_nhanvien` FOREIGN KEY (`MaNV`) REFERENCES `nhanvien` (`MaNV`);

--
-- Các ràng buộc cho bảng `monan`
--
ALTER TABLE `monan`
  ADD CONSTRAINT `fk_monan_loai` FOREIGN KEY (`MaLoai`) REFERENCES `loaimon` (`MaLoai`);

--
-- Các ràng buộc cho bảng `monan_sot`
--
ALTER TABLE `monan_sot`
  ADD CONSTRAINT `monan_sot_ibfk_1` FOREIGN KEY (`MaMonAn`) REFERENCES `monan` (`MaMonAn`),
  ADD CONSTRAINT `monan_sot_ibfk_2` FOREIGN KEY (`MaSoT`) REFERENCES `loaisot` (`MaSoT`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
