CREATE DATABASE QLDKTX
--
USE QLDKTX
--
CREATE TABLE NHACUNGCAP
(
    MaNhaCC VARCHAR(6) UNIQUE NOT NULL,
    TenNhaCC NVARCHAR(60),
    DiaChi NVARCHAR(40),
    SoDT VARCHAR(12),
    MaSoThue VARCHAR(12),
    PRIMARY KEY (MaNhaCC)
);
--
CREATE TABLE MUCPHI
(
    MaMP VARCHAR(4),
    DonGia INT,
    MoTa NVARCHAR(40),
    PRIMARY KEY (MaMP)
);
--
CREATE TABLE LOAIDICHVU
(
    MaLoaiDV VARCHAR(4),
    TenLoaiDV NVARCHAR(60),
    PRIMARY KEY (MaLoaiDV)

);
--
CREATE TABLE DONGXE
(
    DongXe VARCHAR(10),
    HangXe VARCHAR(10),
    SoChoNgoi TINYINT,
    PRIMARY KEY (DongXe)
);
--

CREATE TABLE DANGKYCUNGCAP
(
    MaDKCC VARCHAR(5),
    MaNhaCC VARCHAR(6),
    MaLoaiDV VARCHAR(4),
    DongXe VARCHAR(10),
    MaMP VARCHAR(4),
    NgayBatDauCungCap DATE,
    NgayKetThucCungCap DATE,
    SoLuongXeDangKy INT,
    PRIMARY KEY (MaDKCC),
    FOREIGN KEY (MaNhaCC) REFERENCES NHACUNGCAP(MaNhaCC),
    FOREIGN KEY (MaLoaiDV) REFERENCES LOAIDICHVU(MaLoaiDV),
    FOREIGN KEY (DongXe) REFERENCES DONGXE(DongXe),
    FOREIGN KEY (MaMP) REFERENCES MUCPHI(MaMP)
);

INSERT INTO NHACUNGCAP
    (MaNhaCC, TenNhaCC, DiaChi, SoDT, MaSoThue)
VALUES
    ('NCC002', N'Cty Cổ Phần Đông Du', N'Liên Chiểu', '051133999889', '456789'),
    ('NCC003', N'Ông Nguyễn Văn A', N'Hòa Thuận', '051133999890', '321456'),
    ('NCC001', N'Cty TNHH Toàn Phát', N'Hải Châu', '051133999888', '568941'),
    ('NCC004', N'Cty Cổ Phần Toàn Cầu Xanh', N'Hải Châu', '09135874575', '513364'),
    ('NCC005', N'Cty TNHH AMA', N'Thanh Khê', '051103875466', '546546'),
    ('NCC006', N'Bà Trần Thị Bích Vân', N'Liên Chiểu', '0918745874', '524545'),
    ('NCC007', N'Cty TNHH Phan Thành', N'Thanh Khê', '0906212323', '113021'),
    ('NCC008', N'Ông Phan Đình Nam', N'Hòa Thuận', '05113532456', '121230'),
    ('NCC009', N'Tập đoàn Đông Nam Á', N'Liên Chiểu', '0755987654', '187385'),
    ('NCC010', N'Cty Cổ Phần Rạng đông', N'Liên Chiểu', '05113569654', '187864');

INSERT INTO MUCPHI
    (MaMP, DonGia, MoTa)
VALUES
    ('MP01', 10000, N'Áp dụng từ ngày 1/2015'),
    ('MP02', 15000, N'Áp dụng từ ngày 2/2015'),
    ('MP03', 20000, N'Áp dụng từ ngày 1/2010'),
    ('MP04', 25000, N'Áp dụng từ ngày 2/2011');

INSERT INTO LOAIDICHVU
    (MaLoaiDV, TenLoaiDV)
VALUES
    ('DV01', N'Dịch vụ xe taxi'),
    ('DV02', N'Dịch vụ xe buýt công cộng theo tuyến cố định'),
    ('DV03', N'Dịch vụ cho thuê xe theo hợp đồng');

INSERT INTO DONGXE
    (DongXe, HangXe, SoChoNgoi)
VALUES
    ('Cerato', 'KIA', 7),
    ('Escape', 'Ford', 5),
    ('Forte', 'KIA', 5),
    ('Grand-i10', 'Huyndai', 7),
    ('Hiace', 'Toyota', 16),
    ('Starex', 'Huyndai', 7),
    ('Vios', 'Toyota', 5);

INSERT INTO DANGKYCUNGCAP
    (MaDKCC, MaNhaCC, MaLoaiDV, DongXe, MaMP, NgayBatDauCungCap, NgayKetThucCungCap, SoLuongXeDangKy)
VALUES
    ('DK001', 'NCC001', 'DV01', 'Hiace', 'MP01', '2015-11-20', '2016-11-20', 4),
    ('DK002', 'NCC002', 'DV02', 'Vios', 'MP02', '2015-11-20', '2017-11-20', 3),
    ('DK003', 'NCC003', 'DV03', 'Escape', 'MP03', '2017-11-20', '2018-11-20', 5),
    ('DK004', 'NCC005', 'DV01', 'Cerato', 'MP04', '2015-11-20', '2019-11-20', 7),
    ('DK005', 'NCC002', 'DV02', 'Forte', 'MP03', '2019-11-20', '2020-11-20', 1),
    ('DK006', 'NCC004', 'DV03', 'Starex', 'MP04', '2016-11-10', '2021-11-20', 2),
    ('DK007', 'NCC005', 'DV01', 'Cerato', 'MP03', '2015-11-30', '2016-01-25', 8),
    ('DK008', 'NCC006', 'DV01', 'Vios', 'MP02', '2016-02-28', '2016-08-15', 9),
    ('DK009', 'NCC005', 'DV03', 'Grand-i10', 'MP02', '2016-04-27', '2017-04-30', 10),
    ('DK010', 'NCC006', 'DV01', 'Forte', 'MP02', '2016-11-21', '2016-02-22', 4),
    ('DK011', 'NCC007', 'DV01', 'Forte', 'MP01', '2016-12-25', '2017-02-20', 5),
    ('DK012', 'NCC007', 'DV03', 'Cerato', 'MP01', '2016-04-14', '2017-12-20', 6),
    ('DK013', 'NCC003', 'DV02', 'Cerato', 'MP01', '2015-12-21', '2016-12-21', 8),
    ('DK014', 'NCC006', 'DV02', 'Cerato', 'MP01', '2015-12-24', '2016-12-21', 9),
    ('DK015', 'NCC003', 'DV02', 'Cerato', 'MP01', '2015-12-25', '2016-12-21', 20);

--3. Thực hiện các thay đổi về cấu trúc và dữ liệu:
--a) Đổi tên các cột: NgayBatDauCungCap, NgayKetThucCungCap tương ứng thành NgayBDCC, NgayKTCC. Lưu lại ảnh chụp ảnh kết quả thực hiện. (0.5đ)
EXEC sp_rename 'DANGKYCUNGCAP.NgayBatDauCungCap', 'NgayBDCC', 'COLUMN'
EXEC sp_rename 'DANGKYCUNGCAP.NgayKetThucCungCap', 'NgayKTCC', 'COLUMN'
--b) Thay đổi kiểu dữ liệu của TenNhaCC và DiaChi của bảng NHACUNGCAP thành cùng kiểu nvarchar(50). Lưu lại ảnh chụp ảnh kết quả thực hiện. (0.5đ)
ALTER TABLE NHACUNGCAP 
ALTER COLUMN  TenNhaCC NVARCHAR(50)
ALTER TABLE NHACUNGCAP 
ALTER COLUMN  DiaChi NVARCHAR(50)
--c) Cập nhật SoLuongXeDangKy là 10 của DANGKYCUNGCAP có MaDKCC ‘DK014’ hoặc thực hiện xóa DANGKYCUNGCAP có MaDKCC ‘DK015’. Hiển thị và lưu lại ảnh chụp dữ liệu của bảng để kiểm tra. (0.5đ)
UPDATE DANGKYCUNGCAP 
SET SoLuongXeDangKy = '10'
WHERE MaDKCC = 'DK014'
--HOẶC
DELETE DANGKYCUNGCAP
WHERE MaDKCC = 'DK015'

--4. Thực hiện các truy vấn dữ liệu và lưu lại ảnh chụp kết quả:
--a) Cho biết thông tin nhà cung cấp đã cung cấp dòng xe "Forte" cho loại "Dịch vụ xe taxi"? (1đ).
SELECT * FROM NHACUNGCAP NCC INNER JOIN (SELECT MaNhaCC, DongXe, MaLoaiDV FROM DANGKYCUNGCAP) DANGKYCUNGCAP ON DANGKYCUNGCAP.MaNhaCC = NCC.MaNhaCC
INNER JOIN (SELECT DongXe FROM DONGXE WHERE DongXE = 'Forte') DONGXE ON DONGXE.DongXe = DANGKYCUNGCAP.DongXe
INNER JOIN (SELECT MaLoaiDV FROM LOAIDICHVU WHERE TenLoaiDV = N'Dịch vụ xe taxi' ) LOAIDICHVU ON LOAIDICHVU.MaLoaiDV = DANGKYCUNGCAP.MaLoaiDV
--b) Hiển thị các dòng xe của mỗi hãng xe? (1đ).
SELECT DX.DongXe FROM DONGXE DX 
--c) Cho biết thông tin chi tiết của các nhà cung cấp không phải là công ty một thành viên (Tên nhà cung cấp là Ông/Bà) và có cung cấp xe trong năm 2016 (1đ).
SELECT * FROM NHACUNGCAP NCC INNER JOIN DANGKYCUNGCAP DKCC ON DKCC.MaNhaCC = NCC.MaNhaCC
WHERE NCC.TenNhaCC NOT IN (SELECT TenNhaCC FROM NHACUNGCAP WHERE LEFT(TenNhaCC,3) IN ('Ông','Bà'))
AND YEAR(DKCC.NgayBDCC) BETWEEN CASE WHEN YEAR(DKCC.NgayBDCC) <= 2016 THEN YEAR(DKCC.NgayBDCC) END AND YEAR(DKCC.NgayKTCC)
--d) Theo từng dòng xe, cho biết số lượng nhà cung cấp cung cấp dòng xe đó và số lượng xe được cung cấp theo từng dòng xe (1đ)
SELECT DX.DongXe,COUNT(DX.MaNhaCC) FROM DANGKYCUNGCAP DX
GROUP BY DX.DongXe
--e) Cho biết tổng số tiền thu được (tổng tiền = đơn giá * số lượng xe đăng ký) của từng nhà cung cấp, sắp xếp tổng tiền tăng dần? (1đ).
SELECT NCC.TenNhaCC,SUM(MP.DonGia*DKCC.SoLuongXeDangKy) AS TONGTIEN FROM MUCPHI MP INNER JOIN DANGKYCUNGCAP DKCC ON DKCC.MaMP = MP.MaMP
INNER JOIN NHACUNGCAP NCC ON NCC.MaNhaCC = DKCC.MaNhaCC
GROUP BY NCC.TenNhaCC
ORDER BY TONGTIEN