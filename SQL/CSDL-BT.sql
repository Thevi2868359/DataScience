USE QLSV
--DẠNG 1: CÂU LỆNH TRUY VẤN CÓ ĐIỀU KIỆN
--Bài số 1: Câu lệnh SQL không kết nối
--1.Hiển thị danh sách gồm: MaSV, HoTen, MaLop, NgaySinh (dd/mm/yyyy),GioiTinh(Nam, Nữ) , Namsinh của những sinh viên có họ không bắt đầu bằng chữ N,L,T.
SELECT SV.MaSV, SV.HoTen, SV.MaLop, CONVERT(VARCHAR(10), SV.NgaySinh, 103) AS NgaySinh,
    CASE 
    WHEN SV.GIOITINH = 0 THEN 'NAM'
    WHEN SV.GIOITINH = 1 THEN N'NỮ'
END AS GioiTinh
FROM SINHVIEN SV
WHERE LEFT(SV.HoTen, 1) NOT IN ('N', 'L', 'T');

--2.Hiển thị danh sách gồm: MaSV, HoTen, MaLop, NgaySinh (dd/mm/yyyy), GioiTinh (Nam, Nữ) , Namsinh của những sinh viên nam  học lớp CT11.
SELECT SV.MaSV, SV.HoTen, SV.MaLop, CONVERT(VARCHAR(10), SV.NgaySinh, 103) AS NgaySinh,
    CASE 
    WHEN SV.GIOITINH = 0 THEN 'NAM'
    WHEN SV.GIOITINH = 1 THEN N'NỮ'
END AS GioiTinh
FROM SINHVIEN SV
WHERE SV.GioiTinh = 'FALSE' AND SV.MaLop = 'CT11';
--3.Hiển thị danh sách gồm: MaSV, HoTen, MaLop, NgaySinh (dd/mm/yyyy), GioiTinh (Nam, Nữ) của những sinh viên học lớp CT11,CT12,CT13.
SELECT SV.MaSV, SV.HoTen, SV.MaLop, CONVERT(VARCHAR(10), SV.NgaySinh, 103) as NgaySinh,
    CASE 
    WHEN SV.GioiTinh = 'False' THEN 'Nam'
    WHEN SV.GioiTinh = 'True' THEN N'Nữ'
END AS GioiTinh
FROM SINHVIEN  SV
WHERE SV.MaLop IN ('CT11','CT12','CT13')
--4.Hiển thị danh sách gồm: MaSV, HoTen, MaLop, NgaySinh (dd/mm/yyyy), GioiTinh (Nam, Nữ), Tuổi của những sinh viên có tuổi từ 19-21.
SELECT SV.MaSV, SV.HoTen, SV.MaLop, CONVERT(VARCHAR(10), SV.NgaySinh, 103) as NgaySinh,
    CASE 
    WHEN SV.GioiTinh = 0 THEN 'Nam'
    WHEN SV.GioiTinh = 1 THEN N'Nữ'  
END AS GioiTinh, DATEDIFF(YEAR, SV.NgaySinh, GETDATE()) AS Tuoi
FROM SINHVIEN  SV
WHERE DATEDIFF(YEAR, SV.NgaySinh, GETDATE()) BETWEEN 19 AND 21

--Bài số 2: Câu lệnh SQL có kết nối
--1.Hiển thị danh sách gồm MaSV, HoTên, MaLop, DiemHP, MaHP của những sinh viên có điểm HP >= 5.
SELECT SV.MaSV, SV.HoTen, SV.MaLop, DHP.DiemHP, DHP.MaHP
FROM SINHVIEN SV INNER JOIN DIEMHP DHP ON  SV.MaSV = DHP.MaSV
WHERE DHP.DiemHP >= 5.0
--2.Hiển thị danh sách MaSV, HoTen , MaLop, MaHP, DiemHP được sắp xếp theo ưu tiên Mã lớp, Họ tên tăng dần.
SELECT SV.MaSV, SV.HoTen, SV.MaLop, DHP.MaHP, DHP.DiemHP
FROM SINHVIEN SV INNER JOIN DIEMHP DHP ON DHP.MaSV = SV.MaSV
ORDER BY SV.MaLop, SV.HoTen
--3.Hiển thị danh sách gồm MaSV, HoTen, MaLop, DiemHP, MaHP của những sinh viên có điểm HP từ 5 đến 7 ở học kỳ I.
SELECT SV.MaSV, SV.HoTen, SV.MaLop, DHP.DiemHP, DHP.MaHP
FROM SINHVIEN SV
    INNER JOIN DIEMHP DHP ON DHP.MaSV = SV.MaSV
    INNER JOIN DMHOCPHAN DMHP ON DMHP.MAHP = DHP.MaHP
WHERE (DHP.DiemHP BETWEEN 5 AND 7) AND DMHP.HocKy = 1
--4.Hiển thị danh sách sinh viên gồm MaSV, HoTen, MaLop, TenLop, MaKhoa của Khoa có mã CNTT.
SELECT SV.MaSV, SV.HoTen, SV.MaLop, DML.MaLop, DML.TenLop, DMK.MaKhoa
FROM SINHVIEN SV
    INNER JOIN DMLOP DML ON DML.MaLop = SV.MaLop
    INNER JOIN DMNGANH DMN ON DMN.MaNganh = DML.MaNganh
    INNER JOIN DMKHOA DMK ON DMK.MaKhoa = DMN.MaKhoa
WHERE DMK.MaKhoa = 'CNTT'

--DẠNG 2: CÂU LỆNH TRUY VẤN CÓ PHÂN NHÓM
--Bài số 1: Câu lệnh SQL có từ khoá GROUP BY không điều kiện.
--1.Cho biết MaLop, TenLop, tổng số sinh viên của mỗi lớp.
SELECT SV.MaLop, DML.TenLop, COUNT(*) AS SOSV
FROM SINHVIEN SV
    INNER JOIN DMLOP DML ON DML.MaLop = SV.MaLop
GROUP BY SV.MaLop, DML.TenLop
--2.Cho biết điểm trung bình chung của mỗi sinh viên, xuất ra bảng mới có tên DIEMTBC, biết rằng công thức tính DiemTBC như sau:DiemTBC =  (DiemHP * SoDvht) /  (SoDvht)
SELECT SV.MaSV, SV.HoTen, SUM(DHP.DiemHP * DMHP.SoDVHT) / SUM(DMHP.SoDVHT) AS DiemTBC
FROM SINHVIEN SV
    INNER JOIN DIEMHP DHP ON SV.MaSV = DHP.MaSV
    INNER JOIN DMHOCPHAN DMHP ON DHP.MaHP = DMHP.MaHP
--3.Cho biết điểm trung bình chung của mỗi sinh viên ở mỗi học kỳ
SELECT SV.MaSV, DMHP.HocKy, SUM(DHP.DiemHP*DMHP.SoDVHT)/SUM(DMHP.SoDVHT) AS DIEMTBC
FROM dbo.DIEMHP DHP
    INNER JOIN DMHOCPHAN DMHP ON DHP.MaHP = DMHP.MaHP
    INNER JOIN SINHVIEN SV ON SV.MaSV = DHP.MaSV
GROUP BY SV.MaSV, DMHP.HocKy

--4.Cho biết MaLop, TenLop, số lượng nam nữ theo từng lớp
SELECT DML.MaLop, DML.MaLop, COUNT(SV.MaSV) AS SoLuong
FROM DMLOP DML
    INNER JOIN SINHVIEN SV ON SV.MaLop = DML.MaLop
GROUP BY DML.MaLop, DML.MaLop
--Bài số 2: Câu lệnh SQL có từ khoá GROUP BY với điều kiện lọc.
--1.Cho biết điểm trung bình chung của mỗi sinh viên ở học kỳ 1. DiemTBC =  (DiemHP * SoDvht) /  (SoDvht)
SELECT SV.MaSV, SUM(DHP.DiemHP * DMHP.SoDVHT)/SUM(DMHP.SoDVHT) AS DiemTBC
FROM SINHVIEN SV, DIEMHP DHP, DMHOCPHAN DMHP
WHERE SV.MaSV = DHP.MaSV AND DHP.MaHP = DMHP.MaHP AND DMHP.HocKy = 1
GROUP BY SV.MaSV
--2.Cho biết MaSV, HoTen, Số các học phần thiếu điểm (DiemHP<5) của mỗi sinh viên.
SELECT SV.MaSV, SV.HoTen, COUNT(CASE WHEN DHP.DiemHP < 5 THEN 1 ELSE 0 END) AS HPTD
FROM SINHVIEN SV, DIEMHP DHP
WHERE SV.MaSV = DHP.MaSV
GROUP BY SV.MaSV, SV.HoTen
--3.Đếm số sinh viên có điểm HP <5 của mỗi học phần. Tính tổng số đơn vị học trình có điểm HP <5 của mỗi sinh viên
SELECT DHP.MaHP, COUNT(CASE WHEN DHP.DiemHP < 5 THEN 1 ELSE 0 END) AS QUANLITY, SUM(CASE WHEN DHP.DiemHP < 5 THEN DMHP.SoDVHT ELSE 0 END) AS TDVHT
FROM SINHVIEN SV
    INNER JOIN DIEMHP DHP ON SV.MaSV = DHP.MaSV
    INNER JOIN DMHOCPHAN DMHP ON DHP.MaHP = DMHP.MaHP
GROUP BY DHP.MaHP
--Bài số 3: Câu lệnh SQL có từ khoá GROUP BY với điều kiện nhóm.
--1.Cho biết MaLop,TenLop có tổng số sinh viên >10.
SELECT DML.MaLop, DML.TenLop
FROM DMLOP DML
    INNER JOIN SINHVIEN SV ON SV.MaLop = DML.MaLop
GROUP BY DML.MaLop, DML.TenLop
HAVING COUNT(*) > 10
--2.Cho biết HoTen sinh viên có điểm Trung bình chung các học phần <3.
SELECT SV.HoTen
FROM SINHVIEN SV
    INNER JOIN DIEMHP DHP ON SV.MaSV = DHP.MaSV
    INNER JOIN DMHOCPHAN DMHP ON DMHP.MaHP = DHP.DiemHP
GROUP BY SV.HoTen
HAVING SUM(DHP.DiemHP*DMHP.SoDVHT)/SUM(DMHP.SoDVHT) < 3
--3.Cho biết HoTen sinh viên có ít nhất 2 học phần có điểm <5.
SELECT SV.HoTen
FROM SINHVIEN SV
    INNER JOIN DIEMHP DHP ON DHP.MaSV = SV.MaSV
GROUP BY SV.HoTen
HAVING 2 >= COUNT(CASE WHEN DHP.DiemHP < 5 THEN 1 ELSE 0 END)
--4.Cho biết HoTen sinh viên học TẤT CẢ các học phần ở ngành 140902.
SELECT SV.HoTen
FROM SINHVIEN SV
    INNER JOIN DIEMHP DHP ON SV.MaSV = DHP.MaSV
    INNER JOIN DMHOCPHAN DMHP ON DMHP.MaHP = DHP.DiemHP
WHERE DMHP.MaNganh = '140902'
GROUP BY SV.HoTen
HAVING COUNT(DISTINCT DHP.MaHP) = (SELECT COUNT(DISTINCT MaHP)
FROM DMHOCPHAN
WHERE MaNganh = '140902')
--5.Cho biết HoTen sinh viên học ít nhất 3 học phần mã ‘001’, ‘002’, ‘003’.
SELECT SV.HoTen
FROM SINHVIEN SV
    INNER JOIN DIEMHP DHP ON DHP.MaSV = SV.MaSV
GROUP BY SV.HoTen
HAVING  COUNT(DISTINCT CASE WHEN DHP.MaHP IN ('001','002','003') THEN 1 ELSE 0 END) >= 3
--Bài số 4: Câu lệnh SQL có từ khoá TOP.
--1.Cho biết MaSV, HoTen sinh viên có điểm TBC cao nhất ở học kỳ 1.
SELECT TOP 1
    SV.MaSV, SV.HoTen, SUM(DHP.DiemHP*DMHP.SoDVHT)/SUM(DMHP.SoDVHT) AS DTBC
FROM SINHVIEN SV
    INNER JOIN DIEMHP DHP ON DHP.MaSV = SV.MaSV
    INNER JOIN DMHOCPHAN DMHP ON DMHP.MaHP = DHP.MaHP
WHERE DMHP.HocKy = 1
GROUP BY SV.MaSV, SV.HoTen
ORDER BY DTBC DESC
--2.Cho biết MaSV, HoTen sinh viên có số học phần điểm HP <5 nhiều nhất.
SELECT TOP 1
    SV.MaSV, SV.HoTen, COUNT(CASE WHEN DHP.DiemHP < 5 THEN 1 ELSE 0 END) AS QUANLITY
FROM SINHVIEN SV
    INNER JOIN DIEMHP DHP ON DHP.MaSV = SV.MaSV
    INNER JOIN DMHOCPHAN DMHP ON DMHP.MaHP = DHP.MaHP
GROUP BY SV.MaSV, SV.HoTen
ORDER BY QUANLITY DESC
--3.Cho biết MaHP, TenHP có số sinh viên điểm HP <5 nhiều nhất.
SELECT DMHP.MaHP, DMHP.TenHP
FROM DMHOCPHAN DMHP
    INNER JOIN DIEMHP DHP ON DMHP.MaHP = DHP.MaHP
GROUP BY DMHP.MaHP, DMHP.TenHP
ORDER BY COUNT(CASE WHEN DHP.DiemHP < 5 THEN 1 ELSE 0 END) DESC

--DẠNG 3: CÂU LỆNH TRUY VẤN VỚI CẤU TRÚC LỒNG NHAU
--Bài số 1: Cấu trúc lồng nhau phủ định (KHÔNG, CHƯA).
--1.Cho biết Họ tên sinh viên KHÔNG học học phần nào.
SELECT SV.HoTen
FROM SINHVIEN SV
WHERE SV.MaSV NOT IN (SELECT DHP.MaSV
FROM DIEMHP DHP)
--2.Cho biết Họ tên sinh viên CHƯA học học phần có mã ‘001’.
SELECT SV.HoTen
FROM SINHVIEN SV
WHERE SV.MaSV NOT IN (SELECT DHP.MaSV
FROM DIEMHP DHP
WHERE DHP.MaHP = '001')
--3.Cho biết Tên học phần KHÔNG có sinh viên điểm HP <5.
SELECT DMHP.TenHP
FROM DMHOCPHAN DMHP
WHERE NOT EXISTS (SELECT *
FROM DIEMHP DHP
WHERE DMHP.MaHP = DHP.MaHP AND DHP.DiemHP < 5);
--4.Cho biết Họ tên sinh viên KHÔNG có học phần điểm HP<5
SELECT SV.HoTen
FROM SINHVIEN SV
WHERE NOT EXISTS (SELECT *
FROM DIEMHP DHP
WHERE DHP.MaSV = SV.MaSV AND DHP.DiemHP < 5)

--Bài số 2: Cấu trúc lồng nhau không kết nối.
--1.Cho biết Tên lớp có sinh viên tên Hoa.
SELECT DML.TenLop
FROM DMLOP DML, SINHVIEN SV
WHERE SV.HoTen LIKE '%Hoa%'
--2.Cho biết HoTen sinh viên có điểm học phần ‘001’là <5.
SELECT SV.HoTen
FROM SINHVIEN SV INNER JOIN DIEMHP DHP ON SV.MaSV = DHP.MaSV
WHERE DHP.MaHP = '001' AND DHP.DiemHP < 5
--3.Cho biết danh sách các học phần có số đơn vị học trình lớn hơn hoặc bằng số đơn vị học trình của học phần mã 001.
SELECT *
FROM DMHOCPHAN DMHP
WHERE DMHP.SoDVHT >= (CASE WHEN DMHP.MaHP = '001' THEN DMHP.SoDVHT END)
--DẠNG 4: CÂU LỆNH TRUY VẤN VỚI LƯỢNG TỪ ALL, ANY, EXISTS
--Bài số 1: Lượng từ ALL
--1.Cho biết HoTen sinh viên có DiemHP cao nhất.
SELECT SV.HoTen
FROM SINHVIEN SV
WHERE SV.MaSV = ALL (SELECT TOP 1
    DHP.MaSV
FROM DIEMHP DHP
ORDER BY DHP.DiemHP DESC)
--2.	Cho biết HoTen sinh viên có tuổi cao nhất.
SELECT SV.HoTen
FROM SINHVIEN SV
WHERE (YEAR(GETDATE())-YEAR(SV.NgaySinh)) = ALL (SELECT TOP 1
    (YEAR(GETDATE())-YEAR(SV.NgaySinh))
FROM SINHVIEN SV
ORDER BY (YEAR(GETDATE())-YEAR(SV.NgaySinh)) DESC )
--3.	Cho biết MaSV, HoTen sinh viên có điểm học phần mã ‘001’ cao nhất.
SELECT SV.MaSV, SV.HoTen
FROM SINHVIEN SV
WHERE SV.MaSV = ALL (SELECT TOP 1
    DHP.MaSV
FROM DIEMHP DHP
WHERE DHP.MaHP = '001'
ORDER BY DHP.DiemHP DESC)
--Bài số 2: Lượng từ ANY
--1.Cho biết MaSV, MaHP có điểm HP lớn hơn bất kỳ các điểm HP của sinh viên mã ‘001’.
SELECT SV.MaSV, DHP.MaHP
FROM SINHVIEN SV INNER JOIN DIEMHP DHP ON DHP.MaSV = SV.MaSV
WHERE DHP.DiemHP > ANY (SELECT DHP.DiemHP
FROM DIEMHP DHP
WHERE DHP.MaSV = '001')
--2.Cho biết sinh viên có điểm học phần nào đó lớn hơn gấp rưỡi điểm trung bình chung của sinh viên đó.
SELECT SV.HoTen
FROM SINHVIEN SV
    INNER JOIN DIEMHP DHP ON DHP.MaSV = SV.MaSV
WHERE DHP.DiemHP > ANY (SELECT SUM(DHP.DiemHP*DMHP.SoDVHT)/SUM(DMHP.SoDVHT) AS DTBC
FROM DMHOCPHAN DMHP)
--Bài số 3: Lượng từ EXISTS
--1.Cho biết MaSV, HoTen sinh viên đã ít nhất một lần học học phần nào đó.
SELECT SV.MaSV, SV.HoTen
FROM SINHVIEN SV
WHERE EXISTS (SELECT *
FROM DIEMHP DHP
WHERE SV.MaLop = DHP.MaSV)
--2.Cho biết MaSV, HoTen sinh viên đã không học học phần nào. 
SELECT SV.MaSV, SV.HoTen
FROM SINHVIEN SV
WHERE NOT EXISTS (SELECT *
FROM DIEMHP DHP
WHERE SV.MaLop = DHP.MaSV)
--3.Cho biết MaLop,TenLop đã không có sinh viên nào học.
SELECT DML.MaLop, DML.TenLop
FROM DMLOP DML
WHERE NOT EXISTS (SELECT *
FROM SINHVIEN SV
WHERE SV.MaLop = DML.MaLop)





