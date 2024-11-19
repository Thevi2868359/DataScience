CREATE DATABASE QLTS

USE QLTS

CREATE TABLE THISINH
(
    SOBD INT UNIQUE NOT NULL,
    HOTEN NVARCHAR(40),
    GIOITINH BIT,
    NGAYSINH DATE,
    NOISINH NVARCHAR(90),
    MACN CHAR(4),
    KHOATS FLOAT(4),
    PRIMARY KEY (SOBD),
    FOREIGN KEY (MACN) REFERENCES CHUYENNGANH(MACN)
);

CREATE TABLE CHUYENNGANH
(
    MACN CHAR(4) NOT NULL UNIQUE,
    TENCN NVARCHAR(90),
    PRIMARY KEY (MACN)
);

CREATE TABLE MONTHI
(
    MAMT CHAR(4) NOT NULL UNIQUE,
    TENMT NVARCHAR(40),
    TINHCHAT TINYINT,
    PRIMARY KEY (MAMT)
);

CREATE TABLE KETQUA
(
    SOBD INT,
    MAMT CHAR(4),
    DIEM FLOAT CHECK (DIEM BETWEEN 0 AND 10),
    PRIMARY KEY (SOBD, MAMT),
    FOREIGN KEY (SOBD) REFERENCES THISINH(SOBD),
    FOREIGN KEY (MAMT) REFERENCES MONTHI(MAMT)
);

INSERT INTO CHUYENNGANH
    (MACN,TENCN)
VALUES
    ('CNTT', N'Công nghệ thông tin'),
    ('KHMT', N'Khoa học máy tính'),
    ('KTPM', N'Kỹ thuật phần mềm'),
    ('HTTT', N'Hệ thống thông tin')

INSERT INTO MONTHI
    (MAMT, TENMT, TINHCHAT)
VALUES
    ('MT01', N'Ngoại ngữ', 1),
    ('MT12', N'CNTT CB', 2),
    ('MT13', N'Hướng đối tượng', 3),
    ('MT23', N'Toán rời rạc', 3)

INSERT INTO THISINH
    (SOBD, HOTEN, GIOITINH, NGAYSINH, NOISINH, MACN, KHOATS)
VALUES
    ('221001', N'Nguyễn Văn Bình', 0, '1992-07-03', N'Thành phố Hồ Chí Minh', 'KTPM', '22.1'),
    ('221002', N'Phạm Thị Duyên', 1, '1998-03-28', N'Thành phố Hồ Chí Minh', 'KTPM', '22.1'),
    ('221003', N'Lê Ngọc Hải', 0, '1994-09-21', N'Vĩnh Long', 'CNTT', '22.1'),
    ('221004', N'Trần Thị Hương', 1, '1996-12-12', N'Hậu Giang', 'CNTT', '22.1'),
    ('221005', N'Hồ Xuân Hiếu', 0, '1998-03-26', N'Cần Thơ', 'KTPM', '22.1'),
    ('221006', N'Nguyễn Thị Hoa', 1, '2000-08-05', N'Bến Tre', 'KHMT', '22.1'),
    ('222001', N'Phạm Đức Lâm', 0, '1999-12-08', N'Sóc Trăng', 'HTTT', '22.2'),
    ('222002', N'Lê Thanh Mai', 1, '2001-04-20', N'Sóc Trăng', 'KHMT', '22.2'),
    ('222003', N'Trần Thị Nga', 1, '1997-06-13', N'Hậu Giang', 'HTTT', '22.2'),
    ('222004', N'Hồ Xuân Ngọc', 1, '1995-10-24', N'Kiên Giang', 'HTTT', '22.2'),
    ('231001', N'Nguyễn Thị Quỳnh', 1, '1993-01-25', N'An Giang', 'CNTT', '23.1'),
    ('231002', N'Phạm Đức Sơn', 0, '2002-09-14', N'Bạc Liêu', 'KTPM', '23.1'),
    ('231003', N'Lê Thanh Tâm', 0, '1991-05-02', N'An Giang', 'KTPM', '23.1'),
    ('231004', N'Trần Thị Trang', 1, '1990-07-15', N'Đồng Tháp', 'CNTT', '23.1'),
    ('231005', N'Hồ Xuân Tùng', 0, '1998-05-27', N'Vĩnh Long', 'KHMT', '23.1'),
    ('231006', N'Nguyễn Thị Uyên', 1, '2000-03-29', N'Cần Thơ', 'KHMT', '23.1'),
    ('231007', N'Trần Văn Sĩ', 0, '1999-01-24', N'Kiên Giang', 'KHMT', '23.1'),
    ('231008', N'Nguyễn Thị Thu Hoa', 1, '1997-05-16', N'An Giang', 'HTTT', '23.1'),
    ('232001', N'Ngô Hữu Hậu', 0, '1999-02-12', N'Bạc Liêu', 'CNTT', '23.2'),
    ('232002', N'Trần Hoàng Anh', 0, '1996-04-01', N'Vĩnh Long', 'HTTT', '23.2'),
    ('232003', N'Diệu Hoa', 1, '1998-01-30', N'Cần Thơ', 'HTTT', '23.2'),
    ('311036', N'Nguyễn Thế Vĩ', 0, '2005-9-5', N'Kiêng Giang', 'KHMT', '23.2')


INSERT INTO KETQUA
    (SOBD,MAMT, DIEM)
VALUES
    ('221001', 'MT01', 5),
    ('221001', 'MT12', 6),
    ('221001', 'MT13', 6),
    ('221002', 'MT01', 6),
    ('221002', 'MT12', 7),
    ('221002', 'MT13', 6),
    ('221003', 'MT01', 8),
    ('221003', 'MT12', 7.5),
    ('221003', 'MT23', 7),
    ('221004', 'MT01', 6),
    ('221004', 'MT12', 8),
    ('221004', 'MT23', 8),
    ('221005', 'MT01', 7.5),
    ('221005', 'MT12', 8),
    ('221005', 'MT13', 8.5),
    ('221006', 'MT01', 0),
    ('221006', 'MT12', 0),
    ('221006', 'MT23', 0),
    ('222001', 'MT01', 4),
    ('222001', 'MT12', 6),
    ('222001', 'MT13', 6),
    ('222002', 'MT01', 7.5),
    ('222002', 'MT12', 7),
    ('222002', 'MT23', 7.5),
    ('222003', 'MT01', 8),
    ('222003', 'MT12', 7.5),
    ('222003', 'MT13', 8.5),
    ('222004', 'MT01', 5.5),
    ('222004', 'MT12', 5.5),
    ('222004', 'MT13', 6),
    ('311036', 'MT13', 10)



--3.Thực hiện các thay đổi về cấu trúc và dữ liệu:
--a)Đổi tên cột GIOITINH trong bảng THISINH thành tên là GIOI. Lưu lại ảnh chụp ảnh kết quả thực hiện. (0.5đ)
EXEC sp_rename 'THISINH.GIOITINH', 'GIOI', 'COLUMN';
--b)Điều chỉnh kiểu dữ liệu cột TINHCHAT với kiểu tinyint trong bảng MONTHI. Lưu lại ảnh chụp ảnh kết quả thực hiện. (0.5đ)
ALTER TABLE MONTHI 
ALTER COLUMN TINHCHAT TINYINT
--c)Trong bảng KETQUA, cập nhật SOBD thành ‘232010’ cho thí sinh có SOBD là 6 số cuối MSSV của cá nhân SV. Chụp lại ảnh kết quả thực hiện; giải thích lỗi và đề xuất cách xử lý nếu có. (0.5đ)
UPDATE KETQUA 
SET SOBD = '232010'
WHERE SOBD = '311036'
--The UPDATE statement conflicted with the FOREIGN KEY constraint "FK__KETQUA__SOBD__4222D4EF". The conflict occurred in database "QLTS", table "dbo.THISINH", column 'SOBD'.
-- LỖI TOÀN VẸN DỮ LIỆU VÌ SOBD UPDATE BẢNG KQ KHÔNG CÓ TRONG SOBD TRONG BẢNG CỦA KHÓA CHÍNH

--4.Thực hiện các truy vấn dữ liệu và lưu lại ảnh chụp kết quả:
--a)Cho biết thông tin các thí sinh của khóa tuyển sinh ‘23.1’ có năm sinh nhỏ hơn 2000. (1đ)
SELECT *
FROM THISINH TS
WHERE TS.KHOATS = '23.1' AND YEAR(TS.NGAYSINH) < 2000
--b)Cho biết thông tin TENCN, SOBD, HOTEN, KHOATS của các thí sinh thi trượt (có điểm thi môn bất kỳ nhỏ hơn 5.5). Sắp xếp theo chuyên ngành. (1đ)
SELECT CHUYENNGANH.MACN, TS.SOBD, TS.HOTEN, TS.KHOATS
FROM THISINH TS INNER JOIN CHUYENNGANH ON CHUYENNGANH.MACN = TS.MACN
    INNER JOIN (SELECT DISTINCT SOBD
    FROM KETQUA
    WHERE KETQUA.DIEM < 5.5) KETQUA ON KETQUA.SOBD = TS.SOBD
ORDER BY CHUYENNGANH.TENCN
--c)Cho biết MACN, TENCN và số lượng thí sinh theo từng chuyên ngành của khóa thi 23. (1đ)
SELECT CNG.MACN, CNG.TENCN, COUNT(*) AS QUANTITY
FROM CHUYENNGANH CNG
    INNER JOIN THISINH TS ON TS.MACN = CNG.MACN
GROUP BY CNG.MACN, CNG.TENCN
--d)Cho biết thông tin các thí sinh có điểm thi ít nhất 2 môn từ 7.5 trở lên. Hiển thị kèm tuổi của thí sinh và sắp xếp theo tuổi giảm dần (1đ)
--Cho biết: tuổi tính dựa trên ngày sinh; và hàm TODAY() trả về ngày tháng năm hiện tại.
SELECT *, (YEAR(GETDATE()-YEAR(TS.NGAYSINH))) AS TUOI
FROM THISINH TS INNER JOIN (SELECT SOBD
    FROM KETQUA
    WHERE KETQUA.DIEM > 7.5
    GROUP BY SOBD
    HAVING COUNT(*) >= 2) KETQUA ON KETQUA.SOBD = TS.SOBD
ORDER BY TUOI DESC
--e)Cho biết SOBD, HOTEN, MACN, KHOATS và điểm thi trung bình 02 môn Cơ bản và môn Cơ sở của những thí sinh có điểm môn Ngoại ngữ cao nhất. (1đ)
SELECT TS.SOBD, TS.HOTEN, TS.KHOATS, AVG(CASE WHEN MT.TINHCHAT IN ('2','3') THEN KQ.DIEM END) AS AVG
FROM THISINH TS INNER JOIN CHUYENNGANH CNG ON CNG.MACN = TS.MACN
    INNER JOIN KETQUA KQ ON KQ.SOBD = TS.SOBD INNER JOIN MONTHI MT ON MT.MAMT = KQ.MAMT
WHERE TS.SOBD IN (SELECT TOP 2
    SOBD
FROM KETQUA
WHERE KETQUA.MAMT = 'MT01'
ORDER BY KETQUA.DIEM DESC)
GROUP BY TS.SOBD,TS.HOTEN,TS.KHOATS

