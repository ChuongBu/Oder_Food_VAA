-- Tạo CSDL
DROP DATABASE IF EXISTS oderfood;
CREATE DATABASE oderfood CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE oderfood;

-- Tạo bảng bàn ăn
CREATE TABLE banan (
  MaBanAn INT(5) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  TenBanAn TEXT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng loại món
CREATE TABLE loaimon (
  MaLoai INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  TenLoai TEXT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng món ăn
CREATE TABLE monan (
  MaMonAn INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  TenMon TEXT NOT NULL,
  GiaTien VARCHAR(100) NOT NULL,
  MaLoai INT(10) NOT NULL,
  ChiTietSP TEXT,
  image VARCHAR(255) NOT NULL,
  FOREIGN KEY (MaLoai) REFERENCES loaimon(MaLoai)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng loại sốt
CREATE TABLE loaisot (
  MaSoT INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  TenSoT TEXT,
  MoTa TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng trung gian món ăn - sốt
CREATE TABLE monan_sot (
  MaMonAn INT(11) NOT NULL,
  MaSoT INT(11) NOT NULL,
  PRIMARY KEY (MaMonAn, MaSoT),
  FOREIGN KEY (MaMonAn) REFERENCES monan(MaMonAn),
  FOREIGN KEY (MaSoT) REFERENCES loaisot(MaSoT)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng nhân viên
CREATE TABLE nhanvien (
  MaNV INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  TenDN TEXT NOT NULL,
  MatKhau TEXT NOT NULL,
  GioiTinh TEXT,
  NgaySinh DATE,
  CCCD TEXT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng gọi món
CREATE TABLE goimon (
  MaGoiMon INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  MaNV INT(11) NOT NULL,
  NgayOder DATE NOT NULL,
  TinhTrang TEXT NOT NULL,
  MabanOder INT(11) NOT NULL,
  FOREIGN KEY (MaNV) REFERENCES nhanvien(MaNV),
  FOREIGN KEY (MabanOder) REFERENCES banan(MaBanAn)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng giỏ hàng
CREATE TABLE giohang (
  MaGioHang INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  MaMonAn INT(11) NOT NULL,
  Soluong INT(11) NOT NULL,
  MabanOder INT(11) NOT NULL,
  FOREIGN KEY (MaMonAn) REFERENCES monan(MaMonAn),
  FOREIGN KEY (MabanOder) REFERENCES goimon(MaGoiMon)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dữ liệu mẫu cho bảng loaimon
INSERT INTO loaimon (MaLoai, TenLoai) VALUES
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

-- Dữ liệu mẫu cho bảng loaisot
INSERT INTO loaisot (MaSoT, TenSoT, MoTa) VALUES
(1, 'Sốt tiêu đen', 'Vị cay nồng từ tiêu đen và kem tươi.'),
(2, 'Sốt tiêu xanh', 'Vị cay nhẹ, thơm mùi tiêu xanh và kem.'),
(3, 'Sốt nấm', 'Kem nấm béo ngậy, đậm đà hương vị nấm.'),
(4, 'Sốt kem', 'Kem tươi nhẹ béo, dễ kết hợp nhiều món.'),
(5, 'Sốt Bearnaise', 'Sốt bơ, trứng và giấm, vị chua béo nhẹ.');

INSERT INTO monan (TenMon, GiaTien, MaLoai, ChiTietSP, image) VALUES
('Bít tết bò', '250000', 1, 'Steak từ thăn nội, thăn ngoại, thăn lưng hoặc lõi vai bò.', 'bit_tet_bo'),
('Bò Wagyu', '500000', 1, 'Steak bò Wagyu cao cấp, vân mỡ đẹp, mềm tan trong miệng.', 'Bo_Wagyu'),
('Bít tết cừu', '300000', 1, 'Bít tết cừu nướng/áp chảo với gia vị và thảo mộc.', 'Bit_tet_cuu'),
('Bít tết cá hồi', '280000', 1, 'Cá hồi áp chảo/nướng, ăn kèm rau củ và sốt đặc trưng.', 'Bit_tet_ca_hoi');

INSERT INTO monan (TenMon, GiaTien, MaLoai, ChiTietSP, image) VALUES
('Spaghetti Carbonara', '120000', 2, 'Mì Spaghetti, thịt xông khói, trứng, phô mai Pecorino Romano, tiêu đen.', 'SpaghettiCarbonara'),
('Spaghetti alla Bolognese', '130000', 2, 'Mì Spaghetti, thịt bò xay, sốt cà chua, rau củ và rượu vang đỏ.', 'Spaghetti_alla_Bolognese'),
('Spaghetti Aglio e Olio', '110000', 2, 'Mì Spaghetti xào với tỏi, ớt, dầu ô liu, rau mùi tây.', 'Spaghetti_Aglio_e_Olio'),
('Penne all\'Arrabbiata', '115000', 2, 'Mì Penne với sốt cà chua cay, tỏi, ớt, dầu ô liu.', 'Penne_all\'Arrabbiata'),
('Mì Ý sốt kem', '125000', 2, 'Kem tươi, phô mai, các loại thịt hoặc rau củ.', 'Mi_Y_sot_kem'),
('Mì Ý sốt pesto', '125000', 2, 'Sốt pesto từ húng quế, tỏi, dầu ô liu, hạt thông.', 'Mi_Y_sot_pesto'),
('Mì Ý hải sản', '140000', 2, 'Hải sản xào với sốt cà chua hoặc sốt kem.', 'Mi_Y_hai_san');

INSERT INTO monan (TenMon, GiaTien, MaLoai, ChiTietSP, image) VALUES
('Pizza Margherita', '150000', 3, 'Pizza truyền thống với sốt cà chua, phô mai mozzarella và lá húng quế.', 'Pizza_Margherita'),
('Pizza Pepperoni', '160000', 3, 'Xúc xích pepperoni cay, sốt cà chua, phô mai mozzarella.', 'Pizza_Pepperoni'),
('Pizza Hải sản', '180000', 3, 'Tôm, mực, sò, phô mai và sốt cà chua.', 'Pizza_Hai_san'),
('Pizza Thập cẩm', '170000', 3, 'Xúc xích, giăm bông, ớt chuông, nấm, phô mai.', 'Pizza_Thapcam'),
('Pizza Gà BBQ', '165000', 3, 'Gà nướng sốt BBQ, hành tây và phô mai.', 'Pizza_Ga_BBQ'),
('Pizza Rau củ chay', '145000', 3, 'Ớt chuông, nấm, hành tây, ngô, phô mai.', 'Pizza_chay');

INSERT INTO monan (TenMon, GiaTien, MaLoai, ChiTietSP, image) VALUES
('Salad Caesar', '85000', 4, 'Xà lách Romaine, phô mai Parmesan, sốt Caesar, gà nướng.', 'Salad_Caesar'),
('Salad Hy Lạp', '80000', 4, 'Dưa leo, cà chua, phô mai feta, ô liu đen.', 'Salad_HyLap'),
('Salad trộn cá ngừ', '90000', 4, 'Rau xanh, cá ngừ, trứng luộc, sốt mayonnaise.', 'Salad_CaNgu'),
('Salad trái cây', '75000', 4, 'Trái cây tươi, sốt sữa chua hoặc mật ong.', 'Salad_trai_cay'),
('Salad rau củ nướng', '85000', 4, 'Cà tím, bí đỏ, ớt chuông nướng, dầu ô liu.', 'Salad_rau_cu_nuong');

INSERT INTO monan (TenMon, GiaTien, MaLoai, ChiTietSP, image) VALUES
('Bánh Tiramisu', '60000', 5, 'Bánh Ý truyền thống với cà phê, kem mascarpone và cacao.', 'Tiramisu'),
('Bánh Red Velvet', '65000', 5, 'Bánh bông lan đỏ với kem phô mai mềm mịn.', 'Red_Velvet'),
('Bánh phô mai Nhật', '70000', 5, 'Nhẹ, mềm mịn, ít ngọt, đậm vị phô mai.', 'Banh_pho_mai_Nhat'),
('Bánh su kem', '55000', 5, 'Vỏ bánh mỏng, nhân kem vani.', 'su_kem'),
('Bánh mousse socola', '68000', 5, 'Mousse socola mịn màng, vị đậm.', 'mousse_socola');

INSERT INTO monan (TenMon, GiaTien, MaLoai, ChiTietSP, image) VALUES
('Trà đào cam sả', '40000', 6, 'Trà đen với đào, cam tươi và sả.', 'Tra_đao_cam_sa'),
('Trà sữa truyền thống', '35000', 6, 'Trà đen hoặc ô long với sữa và trân châu.', 'Tra_sua'),
('Cà phê sữa đá', '30000', 6, 'Cà phê phin với sữa đặc và đá.', 'Ca_phe_sua_da'),
('Sinh tố bơ', '45000', 6, 'Bơ xay với sữa đặc và đá.', 'Sinh_to_bo'),
('Nước cam ép', '38000', 6, 'Cam tươi vắt nguyên chất.', 'cam_ep');

INSERT INTO monan (TenMon, GiaTien, MaLoai, ChiTietSP, image) VALUES
('Sushi cá hồi', '95000', 8, 'Cơm sushi với cá hồi sống.', 'Sushi_ca_hoi'),
('Sashimi tổng hợp', '120000', 8, 'Cá hồi, cá ngừ, mực cắt lát.', 'Sashimi_tong_hop');

INSERT INTO monan (TenMon, GiaTien, MaLoai, ChiTietSP, image) VALUES
('Mì Ramen Tonkotsu', '100000', 9, 'Nước hầm xương heo, trứng lòng đào, thịt char siu.', 'Ramen_Tonkotsu'),
('Mì Udon Tempura', '95000', 9, 'Mì udon với tôm chiên giòn.', 'Udon_Tempura');

INSERT INTO monan (TenMon, GiaTien, MaLoai, ChiTietSP, image) VALUES
('Cơm rang Dương Châu', '75000', 10, 'Cơm chiên trứng, tôm, lạp xưởng.', 'Com_rang_Duong_Chau');

INSERT INTO monan (TenMon, GiaTien, MaLoai, ChiTietSP, image) VALUES
('Lẩu thái hải sản', '250000', 12, 'Nước lẩu chua cay, tôm, mực, rau.', 'Lau_thai'),
('Lẩu bò nhúng giấm', '260000', 12, 'Thịt bò, nước giấm, rau, nước mắm gừng.', 'bo_nhung_giam'),
('Lẩu nấm chay', '230000', 12, 'Nấm đùi gà, kim châm, đậu phụ.', 'Lau_nam_chay'),
('Lẩu gà lá é', '240000', 12, 'Thịt gà, lá é, nấm, mì trứng.', 'ga_la_e'),
('Lẩu kim chi Hàn Quốc', '260000', 12, 'Kim chi, đậu phụ, thịt ba chỉ.', 'Lau_kimchi');

INSERT INTO monan (TenMon, GiaTien, MaLoai, ChiTietSP, image) VALUES
('Hủ tiếu Nam Vang', '80000', 13, 'Thịt heo, tôm, trứng cút, gan, hành phi.', 'Hu_tieu_Nam_Vang'),
('Phở bò tái chín', '85000', 13, 'Thịt bò tái chín, nước dùng thơm.', 'Pho_tai_chin'),
('Bún bò Huế', '85000', 13, 'Chả, giò heo, nước dùng cay.', 'Bun_bo');


