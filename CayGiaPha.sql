-- STEP 1: DROP & CREATE DATABASE
USE master;
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'CayGiaPha')
BEGIN
    ALTER DATABASE CayGiaPha SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE CayGiaPha;
END;

CREATE DATABASE CayGiaPha;
GO

USE CayGiaPha;
GO

CREATE TABLE QUEQUAN (
    MaQueQuan INT PRIMARY KEY,
    TenQueQuan NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE NGHENGHIEP (
    MaNgheNghiep INT PRIMARY KEY,
    TenNgheNghiep NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE LOAIQUANHE (
    MaLoaiQuanHe INT PRIMARY KEY,
    TenLoaiQuanHe NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE LOAITHANHTICH (
    MaLoaiThanhTich INT PRIMARY KEY,
    TenLoaiThanhTich NVARCHAR(100) NOT NULL
);
GO

-- STEP 3: TẠO BẢNG THANHVIEN (FULL CẤU TRÚC + SELF FK)
CREATE TABLE THANHVIEN (
    MaThanhVien INT PRIMARY KEY,
    MaThanhVienCu INT NULL,
    HoTen NVARCHAR(150) NOT NULL,
    NgayPhatSinh DATE NULL,
    NgaySinh DATE NULL,
    GioiTinh NVARCHAR(10) NULL,
    DiaChi NVARCHAR(255) NULL,
    QueQuan INT NOT NULL,
    NgheNghiep INT NULL,
    Doi INT NULL
);
GO

ALTER TABLE THANHVIEN ADD CONSTRAINT FK_ThanhVien_ThanhVienCu
    FOREIGN KEY (MaThanhVienCu) REFERENCES THANHVIEN(MaThanhVien);
ALTER TABLE THANHVIEN ADD CONSTRAINT FK_ThanhVien_QueQuan
    FOREIGN KEY (QueQuan) REFERENCES QUEQUAN(MaQueQuan);
ALTER TABLE THANHVIEN ADD CONSTRAINT FK_ThanhVien_NgheNghiep
    FOREIGN KEY (NgheNghiep) REFERENCES NGHENGHIEP(MaNgheNghiep);
GO

-- STEP 4: TẠO QUAN HỆ
CREATE TABLE QUANHE (
    MaThanhVien1 INT NOT NULL,
    MaThanhVien2 INT NOT NULL,
    MaLoaiQuanHe INT NOT NULL,
    CONSTRAINT PK_QUANHE PRIMARY KEY (MaThanhVien1, MaThanhVien2)
);
GO

ALTER TABLE QUANHE ADD CONSTRAINT FK_QUANHE_ThanhVien1
    FOREIGN KEY (MaThanhVien1) REFERENCES THANHVIEN(MaThanhVien);
ALTER TABLE QUANHE ADD CONSTRAINT FK_QUANHE_ThanhVien2
    FOREIGN KEY (MaThanhVien2) REFERENCES THANHVIEN(MaThanhVien);
ALTER TABLE QUANHE ADD CONSTRAINT FK_QUANHE_LoaiQuanHe
    FOREIGN KEY (MaLoaiQuanHe) REFERENCES LOAIQUANHE(MaLoaiQuanHe);
GO

-- STEP 5: TẠO THÀNH TÍCH
CREATE TABLE THANHTICH (
    MaThanhVien INT NOT NULL,
    MaLoaiThanhTich INT NOT NULL,
    NgayPhatSinhThanhTich DATE NULL,
    CONSTRAINT PK_THANHTICH PRIMARY KEY (MaThanhVien, MaLoaiThanhTich)
);
GO

ALTER TABLE THANHTICH ADD CONSTRAINT FK_THANHTICH_ThanhVien
    FOREIGN KEY (MaThanhVien) REFERENCES THANHVIEN(MaThanhVien);
ALTER TABLE THANHTICH ADD CONSTRAINT FK_THANHTICH_LoaiThanhTich
    FOREIGN KEY (MaLoaiThanhTich) REFERENCES LOAITHANHTICH(MaLoaiThanhTich);
GO


---- Thêm dữ liệu ----
INSERT INTO QUEQUAN (MaQueQuan, TenQueQuan)
VALUES
(1, N'Hà Nội'),
(2, N'TP. Hồ Chí Minh'),
(3, N'Đà Nẵng'),
(4, N'Hải Phòng'),
(5, N'Cần Thơ'),
(6, N'Bắc Giang'),
(7, N'Bắc Kạn'),
(8, N'Bạc Liêu'),
(9, N'Bắc Ninh'),
(10, N'Bến Tre'),
(11, N'Bình Định'),
(12, N'Bình Dương'),
(13, N'Bình Phước'),
(14, N'Bình Thuận'),
(15, N'Cà Mau'),
(16, N'Cao Bằng'),
(17, N'Đắk Lắk'),
(18, N'Đắk Nông'),
(19, N'Điện Biên'),
(20, N'Đồng Nai'),
(21, N'Đồng Tháp'),
(22, N'Gia Lai'),
(23, N'Hà Giang'),
(24, N'Hà Nam'),
(25, N'Hà Tĩnh'),
(26, N'Hải Dương'),
(27, N'Hậu Giang'),
(28, N'Hòa Bình'),
(29, N'Hưng Yên'),
(30, N'Khánh Hòa'),
(31, N'Kiên Giang'),
(32, N'Kon Tum'),
(33, N'Lai Châu'),
(34, N'Lâm Đồng'),
(35, N'Lạng Sơn'),
(36, N'Lào Cai'),
(37, N'Long An'),
(38, N'Nam Định'),
(39, N'Nghệ An'),
(40, N'Ninh Bình'),
(41, N'Ninh Thuận'),
(42, N'Phú Thọ'),
(43, N'Phú Yên'),
(44, N'Quảng Bình'),
(45, N'Quảng Nam'),
(46, N'Quảng Ngãi'),
(47, N'Quảng Ninh'),
(48, N'Quảng Trị'),
(49, N'Sóc Trăng'),
(50, N'Sơn La'),
(51, N'Tây Ninh'),
(52, N'Thái Bình'),
(53, N'Thái Nguyên'),
(54, N'Thanh Hóa'),
(55, N'Thừa Thiên Huế'),
(56, N'Tiền Giang'),
(57, N'Trà Vinh'),
(58, N'Tuyên Quang'),
(59, N'Vĩnh Long'),
(60, N'Vĩnh Phúc'),
(61, N'Yên Bái'),
(62, N'An Giang'),
(63, N'Hậu Giang');


INSERT INTO NGHENGHIEP (MaNgheNghiep, TenNgheNghiep)
VALUES
(1, N'Nông dân'),
(2, N'Giáo viên'),
(3, N'Kỹ sư'),
(4, N'Bác sĩ'),
(5, N'Công nhân'),
(6, N'Văn phòng'),
(7, N'Kinh doanh'),
(8, N'Nội trợ'),
(9, N'Sinh viên'),
(10, N'Luật sư'), 
(11, N'Kiến trúc sư'), 
(12, N'Lập trình viên'), 
(13, N'Nhà báo'), 
(14, N'Hướng dẫn viên du lịch'),
(15, N'Hưu trí');


INSERT INTO LOAIQUANHE (MaLoaiQuanHe, TenLoaiQuanHe)
VALUES
(1, N'Con'),
(2, N'Vợ/Chồng');


INSERT INTO LOAITHANHTICH (MaLoaiThanhTich, TenLoaiThanhTich)
VALUES
(1, N'Tốt nghiệp đại học'),
(2, N'Tốt nghiệp thạc sĩ'),
(3, N'Tốt nghiệp tiến sĩ'),
(4, N'Huân chương lao động'),
(5, N'Giải thưởng khoa học'),
(6, N'Thành tích thể thao'),
(7, N'Thành tích nghệ thuật'),
(8, N'Giáo viên ưu tú'),
(9, N'Đóng góp cộng đồng'),
(10, N'Khen thưởng doanh nghiệp');


INSERT INTO THANHVIEN
(MaThanhVien, MaThanhVienCu, HoTen, NgayPhatSinh, NgaySinh, GioiTinh, DiaChi, QueQuan, NgheNghiep, Doi)
VALUES
(1, 4, N'Đặng Minh Tú', '2025-03-10', '1968-03-28', N'Nam', N'987 Phan Đình Phùng, Hải Phòng', 1, 1, 1),
(2, 5, N'Vũ Khánh Dung', '2025-01-02', '1967-11-18', N'Nữ', N'456 Nguyễn Huệ, TP. Hồ Chí Minh', 2, 2, 2),
(3, 6, N'Lê Khánh Hà', '2025-01-09', '1962-12-14', N'Nam', N'321 Hai Bà Trưng, Cần Thơ', 3, 3, 3),
(4, 7, N'Võ Đức Dung', '2025-04-14', '1954-10-20', N'Nữ', N'789 Trần Phú, Đà Nẵng', 4, 4, 4),
(5, 8, N'Phạm Mai Tâm', '2025-03-14', '1968-01-17', N'Nam', N'123 Lý Thường Kiệt, Hà Nội', 5, 5, 5),
(6, 9, N'Hoàng Khánh Hương', '2025-03-02', '1954-05-28', N'Nữ', N'456 Nguyễn Huệ, TP. Hồ Chí Minh', 6, 6, 6),
(7, 10, N'Võ Khánh Hà', '2025-01-07', '1961-06-17', N'Nam', N'789 Trần Phú, Đà Nẵng', 7, 7, 7),
(8, 11, N'Phạm Hữu Hùng', '2025-03-11', '1974-01-09', N'Nữ', N'123 Lý Thường Kiệt, Hà Nội', 8, 8, 8),
(9, 12, N'Nguyễn Đức Nam', '2025-02-05', '1968-05-13', N'Nam', N'321 Hai Bà Trưng, Cần Thơ', 9, 9, 9),
(10, 13, N'Bùi Ngọc Long', '2025-03-03', '1961-06-08', N'Nữ', N'321 Hai Bà Trưng, Cần Thơ', 10, 10, 10),
(11, 14, N'Nguyễn Xuân Hà', '2025-04-03', '1996-04-19', N'Nam', N'789 Trần Phú, Đà Nẵng', 11, 11, 1),
(12, 15, N'Đỗ Xuân Dung', '2025-04-23', '1964-01-14', N'Nữ', N'987 Phan Đình Phùng, Hải Phòng', 12, 12, 2),
(13, 16, N'Võ Thanh Tâm', '2025-04-01', '1965-11-17', N'Nam', N'789 Trần Phú, Đà Nẵng', 13, 13, 3),
(14, 17, N'Lê Khánh Hương', '2025-03-03', '2000-09-29', N'Nữ', N'321 Hai Bà Trưng, Cần Thơ', 14, 14, 4),
(15, 18, N'Trần Ngọc Nam', '2025-04-17', '1980-03-11', N'Nam', N'123 Lý Thường Kiệt, Hà Nội', 15, 15, 5),
(16, 19, N'Võ Thanh Lan', '2025-02-11', '1966-08-10', N'Nữ', N'456 Nguyễn Huệ, TP. Hồ Chí Minh', 16, 1, 6),
(17, 20, N'Trần Mai Tâm', '2025-02-25', '1983-12-14', N'Nam', N'789 Trần Phú, Đà Nẵng', 17, 2, 7),
(18, 21, N'Vũ Hữu Trang', '2025-01-05', '1962-09-16', N'Nữ', N'789 Trần Phú, Đà Nẵng', 18, 3, 8),
(19, 22, N'Phạm Hữu Dung', '2025-02-25', '1981-06-02', N'Nam', N'987 Phan Đình Phùng, Hải Phòng', 19, 4, 9),
(20, 23, N'Trần Hữu Hương', '2025-04-25', '1980-08-05', N'Nữ', N'654 Lê Lợi, Huế', 20, 5, 10),
(21, 24, N'Đỗ Đức Dung', '2025-03-28', '1985-06-07', N'Nam', N'987 Phan Đình Phùng, Hải Phòng', 21, 6, 1),
(22, 25, N'Vũ Hữu Hương', '2025-01-16', '1992-12-26', N'Nữ', N'321 Hai Bà Trưng, Cần Thơ', 22, 7, 2),
(23, 26, N'Hoàng Thanh Dung', '2025-01-12', '1957-07-29', N'Nam', N'654 Lê Lợi, Huế', 23, 8, 3),
(24, 27, N'Trần Thanh Hương', '2025-04-02', '1993-05-13', N'Nữ', N'123 Lý Thường Kiệt, Hà Nội', 24, 9, 4),
(25, 28, N'Vũ Thanh Tâm', '2025-01-20', '1991-07-22', N'Nam', N'654 Lê Lợi, Huế', 25, 10, 5),
(26, 29, N'Bùi Xuân Hương', '2025-01-15', '2001-08-07', N'Nữ', N'654 Lê Lợi, Huế', 26, 11, 6),
(27, 30, N'Phạm Minh Dung', '2025-04-17', '1962-12-02', N'Nam', N'456 Nguyễn Huệ, TP. Hồ Chí Minh', 27, 12, 7),
(28, 31, N'Nguyễn Đức Tâm', '2025-03-23', '1954-07-22', N'Nữ', N'123 Lý Thường Kiệt, Hà Nội', 28, 13, 8),
(29, 32, N'Bùi Hữu Hà', '2025-02-23', '1981-04-21', N'Nam', N'321 Hai Bà Trưng, Cần Thơ', 29, 14, 9),
(30, 33, N'Đặng Mai Long', '2025-02-12', '1980-06-15', N'Nữ', N'789 Trần Phú, Đà Nẵng', 30, 15, 10),
(31, 34, N'Hoàng Xuân Nam', '2025-03-22', '1961-02-03', N'Nam', N'654 Lê Lợi, Huế', 31, 1, 1),
(32, 35, N'Nguyễn Minh Tâm', '2025-03-04', '1971-09-08', N'Nữ', N'654 Lê Lợi, Huế', 32, 2, 2),
(33, 36, N'Võ Thanh Hùng', '2025-02-11', '1985-03-31', N'Nam', N'123 Lý Thường Kiệt, Hà Nội', 33, 3, 3),
(34, 37, N'Đỗ Hữu Lan', '2025-03-21', '1981-02-19', N'Nữ', N'987 Phan Đình Phùng, Hải Phòng', 34, 4, 4),
(35, 38, N'Võ Hữu Dung', '2025-01-10', '1995-10-03', N'Nam', N'654 Lê Lợi, Huế', 35, 5, 5),
(36, 39, N'Võ Minh Tú', '2025-01-21', '1992-06-21', N'Nữ', N'987 Phan Đình Phùng, Hải Phòng', 36, 6, 6),
(37, 40, N'Võ Mai Lan', '2025-01-12', '1953-09-07', N'Nam', N'789 Trần Phú, Đà Nẵng', 37, 7, 7),
(38, 41, N'Lê Ngọc Lan', '2025-04-07', '1989-05-31', N'Nữ', N'456 Nguyễn Huệ, TP. Hồ Chí Minh', 38, 8, 8),
(39, 42, N'Lê Hữu Tâm', '2025-03-28', '1975-11-12', N'Nam', N'123 Lý Thường Kiệt, Hà Nội', 39, 9, 9),
(40, 43, N'Bùi Mai Long', '2025-01-22', '1978-10-06', N'Nữ', N'789 Trần Phú, Đà Nẵng', 40, 10, 10),
(41, 44, N'Đỗ Hữu Dung', '2025-04-05', '1973-12-20', N'Nam', N'456 Nguyễn Huệ, TP. Hồ Chí Minh', 41, 11, 1),
(42, 45, N'Lê Khánh Tú', '2025-04-02', '1983-11-09', N'Nữ', N'321 Hai Bà Trưng, Cần Thơ', 42, 12, 2),
(43, 46, N'Vũ Ngọc Hương', '2025-03-25', '1952-04-21', N'Nam', N'987 Phan Đình Phùng, Hải Phòng', 43, 13, 3),
(44, 47, N'Đặng Ngọc Long', '2025-02-10', '1990-02-01', N'Nữ', N'321 Hai Bà Trưng, Cần Thơ', 44, 14, 4),
(45, 48, N'Phạm Minh Dung', '2025-04-15', '1966-08-11', N'Nam', N'789 Trần Phú, Đà Nẵng', 45, 15, 5),
(46, 49, N'Võ Mai Long', '2025-04-06', '1975-03-14', N'Nữ', N'456 Nguyễn Huệ, TP. Hồ Chí Minh', 46, 1, 6),
(47, 50, N'Đỗ Hữu Hùng', '2025-01-21', '1976-03-29', N'Nam', N'321 Hai Bà Trưng, Cần Thơ', 47, 2, 7),
(48, 51, N'Vũ Mai Tâm', '2025-01-10', '1993-12-08', N'Nữ', N'123 Lý Thường Kiệt, Hà Nội', 48, 3, 8),
(49, 52, N'Lê Thanh Hương', '2025-02-27', '1966-05-02', N'Nam', N'321 Hai Bà Trưng, Cần Thơ', 49, 4, 9),
(50, 53, N'Trần Ngọc Hương', '2025-03-01', '1970-10-16', N'Nữ', N'321 Hai Bà Trưng, Cần Thơ', 50, 5, 10),
(51, 54, N'Nguyễn Xuân Long', '2025-03-08', '1978-01-05', N'Nam', N'321 Hai Bà Trưng, Cần Thơ', 51, 6, 1),
(52, 55, N'Trần Minh Trang', '2025-01-11', '2000-05-31', N'Nữ', N'123 Lý Thường Kiệt, Hà Nội', 52, 7, 2),
(53, 56, N'Vũ Hữu Tú', '2025-01-10', '1980-02-04', N'Nam', N'321 Hai Bà Trưng, Cần Thơ', 53, 8, 3),
(54, 57, N'Lê Đức Hương', '2025-01-03', '1955-03-18', N'Nữ', N'123 Lý Thường Kiệt, Hà Nội', 54, 9, 4),
(55, 58, N'Hoàng Ngọc Tú', '2025-04-04', '1989-11-29', N'Nam', N'789 Trần Phú, Đà Nẵng', 55, 10, 5),
(56, 59, N'Phạm Thanh Tâm', '2025-01-08', '1970-01-14', N'Nữ', N'321 Hai Bà Trưng, Cần Thơ', 56, 11, 6),
(57, 60, N'Đỗ Đức Tâm', '2025-01-27', '1956-02-19', N'Nam', N'321 Hai Bà Trưng, Cần Thơ', 57, 12, 7),
(58, 61, N'Đỗ Mai Hà', '2025-02-23', '1975-10-28', N'Nữ', N'456 Nguyễn Huệ, TP. Hồ Chí Minh', 58, 13, 8),
(59, 62, N'Hoàng Xuân Hà', '2025-03-08', '1990-09-07', N'Nam', N'654 Lê Lợi, Huế', 59, 14, 9),
(60, 63, N'Võ Hữu Tâm', '2025-03-03', '1967-07-26', N'Nữ', N'654 Lê Lợi, Huế', 60, 15, 10),
(61, 64, N'Bùi Mai Long', '2025-01-13', '1996-11-12', N'Nam', N'321 Hai Bà Trưng, Cần Thơ', 61, 1, 1),
(62, 65, N'Nguyễn Xuân Lan', '2025-03-24', '1996-08-19', N'Nữ', N'123 Lý Thường Kiệt, Hà Nội', 62, 2, 2),
(63, 66, N'Vũ Thị Lan', '2025-02-24', '1997-10-26', N'Nam', N'987 Phan Đình Phùng, Hải Phòng', 63, 3, 3),
(64, 67, N'Trần Khánh Lan', '2025-02-02', '1959-11-29', N'Nữ', N'789 Trần Phú, Đà Nẵng', 1, 4, 4),
(65, 68, N'Bùi Minh Tú', '2025-04-23', '1996-10-10', N'Nam', N'321 Hai Bà Trưng, Cần Thơ', 2, 5, 5),
(66, 69, N'Lê Hữu Tâm', '2025-04-02', '1972-05-16', N'Nữ', N'789 Trần Phú, Đà Nẵng', 3, 6, 6),
(67, 70, N'Phạm Văn Trang', '2025-01-11', '1983-04-20', N'Nam', N'789 Trần Phú, Đà Nẵng', 4, 7, 7),
(68, 71, N'Bùi Xuân Long', '2025-04-09', '1993-09-22', N'Nữ', N'123 Lý Thường Kiệt, Hà Nội', 5, 8, 8),
(69, 72, N'Phạm Thanh Lan', '2025-01-28', '1984-05-21', N'Nam', N'987 Phan Đình Phùng, Hải Phòng', 6, 9, 9),
(70, 73, N'Vũ Thanh Tâm', '2025-03-14', '1965-05-24', N'Nữ', N'321 Hai Bà Trưng, Cần Thơ', 7, 10, 10),
(71, 74, N'Đặng Xuân Lan', '2025-02-16', '1962-03-26', N'Nam', N'987 Phan Đình Phùng, Hải Phòng', 8, 11, 1),
(72, 75, N'Đặng Minh Long', '2025-03-26', '1960-05-22', N'Nữ', N'123 Lý Thường Kiệt, Hà Nội', 9, 12, 2),
(73, 76, N'Võ Thị Nam', '2025-02-18', '1967-01-04', N'Nam', N'789 Trần Phú, Đà Nẵng', 10, 13, 3),
(74, 77, N'Vũ Thị Tâm', '2025-03-22', '1956-02-06', N'Nữ', N'789 Trần Phú, Đà Nẵng', 11, 14, 4),
(75, 78, N'Hoàng Đức Dung', '2025-04-06', '2003-05-08', N'Nam', N'987 Phan Đình Phùng, Hải Phòng', 12, 15, 5),
(76, 79, N'Đặng Minh Hương', '2025-01-24', '1986-09-22', N'Nữ', N'789 Trần Phú, Đà Nẵng', 13, 1, 6),
(77, 80, N'Đỗ Xuân Hùng', '2025-01-03', '1992-10-16', N'Nam', N'987 Phan Đình Phùng, Hải Phòng', 14, 2, 7),
(78, 81, N'Võ Minh Long', '2025-02-01', '1980-07-04', N'Nữ', N'456 Nguyễn Huệ, TP. Hồ Chí Minh', 15, 3, 8),
(79, 82, N'Đỗ Đức Hà', '2025-02-03', '1968-08-22', N'Nam', N'456 Nguyễn Huệ, TP. Hồ Chí Minh', 16, 4, 9),
(80, 83, N'Vũ Minh Nam', '2025-01-20', '2002-09-07', N'Nữ', N'456 Nguyễn Huệ, TP. Hồ Chí Minh', 17, 5, 10),
(81, 84, N'Đặng Minh Lan', '2025-04-25', '2002-03-04', N'Nam', N'123 Lý Thường Kiệt, Hà Nội', 18, 6, 1),
(82, 85, N'Đỗ Hữu Long', '2025-03-13', '1998-04-06', N'Nữ', N'789 Trần Phú, Đà Nẵng', 19, 7, 2),
(83, 86, N'Hoàng Ngọc Tâm', '2025-01-24', '2002-06-08', N'Nam', N'456 Nguyễn Huệ, TP. Hồ Chí Minh', 20, 8, 3),
(84, 87, N'Đặng Mai Nam', '2025-01-09', '1963-07-29', N'Nữ', N'789 Trần Phú, Đà Nẵng', 21, 9, 4),
(85, 88, N'Đặng Ngọc Dung', '2025-03-23', '1991-08-29', N'Nam', N'321 Hai Bà Trưng, Cần Thơ', 22, 10, 5),
(86, 89, N'Phạm Thị Tú', '2025-01-15', '1989-02-21', N'Nữ', N'456 Nguyễn Huệ, TP. Hồ Chí Minh', 23, 11, 6),
(87, 90, N'Đặng Thị Lan', '2025-03-23', '1968-05-05', N'Nam', N'123 Lý Thường Kiệt, Hà Nội', 24, 12, 7),
(88, 91, N'Bùi Mai Hùng', '2025-03-28', '1971-04-29', N'Nữ', N'456 Nguyễn Huệ, TP. Hồ Chí Minh', 25, 13, 8),
(89, 92, N'Lê Minh Long', '2025-02-04', '1985-04-12', N'Nam', N'456 Nguyễn Huệ, TP. Hồ Chí Minh', 26, 14, 9),
(90, 93, N'Lê Ngọc Hương', '2025-01-12', '2003-10-27', N'Nữ', N'654 Lê Lợi, Huế', 27, 15, 10),
(91, 94, N'Đỗ Minh Hương', '2025-02-20', '1990-05-07', N'Nam', N'123 Lý Thường Kiệt, Hà Nội', 28, 1, 1),
(92, 95, N'Trần Thanh Nam', '2025-04-17', '1958-12-01', N'Nữ', N'321 Hai Bà Trưng, Cần Thơ', 29, 2, 2),
(93, 96, N'Võ Khánh Tâm', '2025-02-11', '1992-08-03', N'Nam', N'987 Phan Đình Phùng, Hải Phòng', 30, 3, 3),
(94, 97, N'Trần Đức Hương', '2025-03-05', '1999-10-05', N'Nữ', N'654 Lê Lợi, Huế', 31, 4, 4),
(95, 98, N'Đỗ Hữu Tú', '2025-04-17', '1967-10-27', N'Nam', N'123 Lý Thường Kiệt, Hà Nội', 32, 5, 5),
(96, 99, N'Trần Mai Tú', '2025-03-06', '1994-08-02', N'Nữ', N'456 Nguyễn Huệ, TP. Hồ Chí Minh', 33, 6, 6),
(97, 100, N'Vũ Ngọc Lan', '2025-03-28', '1979-04-19', N'Nam', N'123 Lý Thường Kiệt, Hà Nội', 34, 7, 7),
(98, 1, N'Hoàng Ngọc Long', '2025-03-05', '1965-07-25', N'Nữ', N'987 Phan Đình Phùng, Hải Phòng', 35, 8, 8),
(99, 2, N'Hoàng Khánh Long', '2025-01-17', '1973-08-09', N'Nam', N'987 Phan Đình Phùng, Hải Phòng', 36, 9, 9),
(100, 3, N'Lê Khánh Dung', '2025-02-06', '2002-06-05', N'Nữ', N'987 Phan Đình Phùng, Hải Phòng', 37, 10, 10);


INSERT INTO QUANHE (MaThanhVien1, MaThanhVien2, MaLoaiQuanHe) VALUES
(1, 4, 1),
(2, 5, 1),
(3, 6, 2),
(4, 7, 1),
(5, 8, 2),
(6, 9, 2),
(7, 10, 1),
(8, 11, 2),
(9, 12, 1),
(10, 13, 2),
(11, 14, 2),
(12, 15, 1),
(13, 16, 2),
(14, 17, 2),
(15, 18, 2),
(16, 19, 1),
(17, 20, 1),
(18, 21, 2),
(19, 22, 2),
(20, 23, 1),
(21, 24, 1),
(22, 25, 1),
(23, 26, 1),
(24, 27, 2),
(25, 28, 2),
(26, 29, 1),
(27, 30, 2),
(28, 31, 1),
(29, 32, 2),
(30, 33, 1),
(31, 34, 1),
(32, 35, 1),
(33, 36, 2),
(34, 37, 2),
(35, 38, 2),
(36, 39, 1),
(37, 40, 2),
(38, 41, 2),
(39, 42, 2),
(40, 43, 1),
(41, 44, 1),
(42, 45, 1),
(43, 46, 1),
(44, 47, 1),
(45, 48, 1),
(46, 49, 2),
(47, 50, 2),
(48, 51, 2),
(49, 52, 1),
(50, 53, 1),
(51, 54, 2),
(52, 55, 1),
(53, 56, 1),
(54, 57, 2),
(55, 58, 1),
(56, 59, 1),
(57, 60, 2),
(58, 61, 2),
(59, 62, 1),
(60, 63, 2),
(61, 64, 1),
(62, 65, 1),
(63, 66, 1),
(64, 67, 2),
(65, 68, 2),
(66, 69, 1),
(67, 70, 2),
(68, 71, 1),
(69, 72, 2),
(70, 73, 1),
(71, 74, 1),
(72, 75, 2),
(73, 76, 2),
(74, 77, 2),
(75, 78, 2),
(76, 79, 2),
(77, 80, 1),
(78, 81, 2),
(79, 82, 2),
(80, 83, 2),
(81, 84, 2),
(82, 85, 1),
(83, 86, 1),
(84, 87, 2),
(85, 88, 2),
(86, 89, 1),
(87, 90, 2),
(88, 91, 2),
(89, 92, 1),
(90, 93, 2),
(91, 94, 2),
(92, 95, 1),
(93, 96, 1),
(94, 97, 1),
(95, 98, 1),
(96, 99, 1),
(97, 100, 2),
(98, 1, 1),
(99, 2, 1),
(100, 3, 2);


INSERT INTO THANHTICH (MaThanhVien, MaLoaiThanhTich, NgayPhatSinhThanhTich)
VALUES
(1, 1, '1986-03-28'),
(2, 2, '1985-11-18'),
(3, 3, '1980-12-14'),
(4, 4, '1972-10-20'),
(5, 5, '1986-01-17'),
(6, 6, '1972-05-28'),
(7, 7, '1979-06-17'),
(8, 8, '1992-01-09'),
(9, 9, '1986-05-13'),
(10, 10, '1979-06-08'),
(11, 1, '2014-04-19'),
(12, 2, '1982-01-14'),
(13, 3, '1983-11-17'),
(14, 4, '2018-09-29'),
(15, 5, '1998-03-11'),
(16, 6, '1984-08-10'),
(17, 7, '2001-12-14'),
(18, 8, '1980-09-16'),
(19, 9, '1999-06-02'),
(20, 10, '1998-08-05'),
(21, 1, '2003-06-07'),
(22, 2, '2010-12-26'),
(23, 3, '1975-07-29'),
(24, 4, '2011-05-13'),
(25, 5, '2009-07-22'),
(26, 6, '2019-08-07'),
(27, 7, '1980-12-02'),
(28, 8, '1972-07-22'),
(29, 9, '1999-04-21'),
(30, 10, '1998-06-15'),
(31, 1, '1979-02-03'),
(32, 2, '1989-09-08'),
(33, 3, '2003-03-31'),
(34, 4, '1999-02-19'),
(35, 5, '2013-10-03'),
(36, 6, '2010-06-21'),
(37, 7, '1971-09-07'),
(38, 8, '2007-05-31'),
(39, 9, '1993-11-12'),
(40, 10, '1996-10-06'),
(41, 1, '1991-12-20'),
(42, 2, '2001-11-09'),
(43, 3, '1970-04-21'),
(44, 4, '2008-02-01'),
(45, 5, '1984-08-11'),
(46, 6, '1993-03-14'),
(47, 7, '1994-03-29'),
(48, 8, '2011-12-08'),
(49, 9, '1984-05-02'),
(50, 10, '1988-10-16'),
(51, 1, '1996-01-05'),
(52, 2, '2018-05-31'),
(53, 3, '1998-02-04'),
(54, 4, '1973-03-18'),
(55, 5, '2007-11-29'),
(56, 6, '1988-01-14'),
(57, 7, '1974-02-19'),
(58, 8, '1993-10-28'),
(59, 9, '2008-09-07'),
(60, 10, '1985-07-26'),
(61, 1, '2014-11-12'),
(62, 2, '2014-08-19'),
(63, 3, '2015-10-26'),
(64, 4, '1977-11-29'),
(65, 5, '2014-10-10'),
(66, 6, '1990-05-16'),
(67, 7, '2001-04-20'),
(68, 8, '2011-09-22'),
(69, 9, '2002-05-21'),
(70, 10, '1983-05-24'),
(71, 1, '1980-03-26'),
(72, 2, '1978-05-22'),
(73, 3, '1985-01-04'),
(74, 4, '1974-02-06'),
(75, 5, '2021-05-08'),
(76, 6, '2004-09-22'),
(77, 7, '2010-10-16'),
(78, 8, '1998-07-04'),
(79, 9, '1986-08-22'),
(80, 10, '2020-09-07'),
(81, 1, '2020-03-04'),
(82, 2, '2016-04-06'),
(83, 3, '2020-06-08'),
(84, 4, '1981-07-29'),
(85, 5, '2009-08-29'),
(86, 6, '2007-02-21'),
(87, 7, '1986-05-05'),
(88, 8, '1989-04-29'),
(89, 9, '2003-04-12'),
(90, 10, '2021-10-27'),
(91, 1, '2008-05-07'),
(92, 2, '1976-12-01'),
(93, 3, '2010-08-03'),
(94, 4, '2017-10-05'),
(95, 5, '1985-10-27'),
(96, 6, '2012-08-02'),
(97, 7, '1997-04-19'),
(98, 8, '1983-07-25'),
(99, 9, '1991-08-09'),
(100, 10, '2020-06-05');

