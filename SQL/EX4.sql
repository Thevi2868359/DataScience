USE QLBH
--1. Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
SELECT COUNT(*)
FROM HOADON
    INNER JOIN KHACHHANG
    ON KHACHHANG.makh = HOADON.makh
WHERE HOADON.nghd < KHACHHANG.ngdk
--2. Tính doanh thu bán hàng trong năm 2006.
SELECT SUM(HD.trigia) DOANHTHU
FROM HOADON HD
WHERE YEAR(HD.nghd) = '2006'
--3. Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
SELECT HD.sohd
FROM HOADON HD
WHERE YEAR(HD.nghd) = '2006'
    AND HD.trigia = (
SELECT MAX(trigia)
    FROM HOADON)
--4. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
SELECT KH.hoten
FROM KHACHHANG KH
    JOIN
    (
	SELECT makh
    FROM HOADON
    WHERE trigia = (
	SELECT MAX(trigia)
    FROM HOADON)
) HOADON
    ON HOADON.makh = KH.makh
--5. In ra danh sách 3 khách hàng đầu tiên (MAKH, HOTEN) sắp xếp theo doanh số giảm dần.
SELECT TOP 3
    KH.makh
       , KH.hoten
FROM KHACHHANG KH
ORDER BY KH.doanhso DESC
--6. Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.
SELECT COUNT(HD.sohd)
FROM HOADON HD
    INNER JOIN CTHD
    ON CTHD.sohd = HD.sohd
    JOIN
    (
	SELECT masp
    FROM SANPHAM
    WHERE SANPHAM.nuocsx = 'Singapore'
) SANPHAM
    ON SANPHAM.masp = CTHD.masp
--7. Tìm số hóa đơn trong năm 2006 đã mua ít nhất một trong tất cả các sản phẩm do Singapore sản xuất.
SELECT DISTINCT HD.sohd
FROM HOADON HD
    JOIN CTHD
    ON CTHD.sohd = HD.sohd
WHERE CTHD.masp IN ( SELECT SP.masp
    FROM SANPHAM SP
    WHERE SP.nuocsx = 'Singapore')
    AND YEAR(HD.nghd) = '2006'
--8. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
SELECT SP.masp
       , SP.tensp
FROM SANPHAM SP
WHERE SP.gia IN ( SELECT DISTINCT TOP 3
    gia
FROM SANPHAM
ORDER BY gia DESC)
--9. In ra danh sách các sản phẩm (MASP, TENSP) do “Thái Lan” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm).
SELECT SP.masp
       , SP.tensp
FROM SANPHAM SP
WHERE SP.gia IN ( SELECT DISTINCT TOP 3
        gia
    FROM SANPHAM
    ORDER BY gia DESC)
    AND SP.nuocsx = N'Thái Lan'
--10. In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quốc” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của sản phẩm do “Trung Quốc” sản xuất).
SELECT SP.masp
       , SP.tensp
FROM SANPHAM SP
WHERE SP.gia IN ( SELECT DISTINCT TOP 3
        gia
    FROM SANPHAM
    WHERE nuocsx = N'Trung Quốc'
    ORDER BY gia DESC)
    AND SP.nuocsx = N'Trung Quốc'
--11. In ra danh sách khách hàng nằm trong 3 hạng cao nhất (xếp hạng theo doanh số).
SELECT TOP 3
    *
FROM KHACHHANG KH
ORDER BY KH.doanhso DESC
--12. Tính tổng số sản phẩm do “Trung Quốc” sản xuất.
SELECT COUNT(*) QUANTITY
FROM SANPHAM SP
WHERE SP.nuocsx = N'Trung Quốc'
--13. Tính tổng số sản phẩm của từng nước sản xuất.
SELECT SP.nuocsx, COUNT(*)
FROM SANPHAM SP
GROUP BY  SP.nuocsx
--14. Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
SELECT SP.nuocsx
       , MAX(SP.masp) MAX
       , MIN(SP.gia) MIN
       , AVG(SP.gia) AVG
FROM SANPHAM SP
GROUP BY  SP.nuocsx
--15. Tính doanh thu bán hàng mỗi ngày.
SELECT HD.nghd
       , SUM(HD.trigia)
FROM HOADON HD
GROUP BY  HD.nghd
--16. Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
SELECT COUNT(*) SL
FROM SANPHAM SP
    JOIN CTHD
    ON SP.masp = CTHD.masp
    JOIN HOADON HD
    ON HD.sohd = CTHD.sohd
WHERE MONTH(HD.nghd) = '10'AND YEAR(HD.nghd) = '2006'
--17. Tính doanh thu bán hàng của từng tháng trong năm 2006.
SELECT MONTH(HD.nghd)
       , SUM(HD.trigia)
FROM HOADON HD
WHERE YEAR(HD.nghd) = '2006'
GROUP BY  MONTH(HD.nghd)
--18. Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau.
SELECT HD.sohd
FROM CTHD HD
GROUP BY HD.sohd
HAVING 4 <= COUNT(HD.masp)
--19. Tìm hóa đơn có mua 3 sản phẩm do “Việt Nam” sản xuất (3 sản phẩm khác nhau).
SELECT HD.sohd
FROM CTHD HD JOIN (SELECT DISTINCT masp
    FROM SANPHAM
    WHERE nuocsx = N'Việt Nam') SANPHAM ON SANPHAM.masp = HD.masp
GROUP BY HD.sohd
HAVING COUNT(HD.masp) = 3
--20. Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất.
SELECT TOP 1
    KH.makh
       , KH.hoten
FROM KHACHHANG KH
    JOIN HOADON
    ON KH.makh = HOADON.makh
GROUP BY  KH.makh
         ,KH.hoten
ORDER BY  COUNT(HOADON.makh) DESC
--21. Tháng mấy trong năm 2006, doanh số bán hàng cao nhất?
SELECT TOP 1
    MONTH(HD.nghd) AS THANG
       , SUM(trigia)
FROM HOADON HD
WHERE YEAR(HD.nghd) = '2006'
GROUP BY  MONTH(HD.nghd)
ORDER BY  SUM(HD.trigia) DESC
--22. Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
SELECT TOP 1
    SP.masp
       , SP.tensp
FROM SANPHAM SP
    JOIN CTHD
    ON CTHD.masp = SP.masp
    JOIN HOADON HD
    ON HD.sohd = CTHD.sohd
WHERE YEAR(HD.nghd) = '2006'
GROUP BY  SP.masp
         ,SP.tensp
ORDER BY  SUM(CTHD.sl)
--23. Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất.

SELECT SP1.masp
       , SP1.tensp
FROM SanPham SP1
    JOIN
    (
	SELECT SP.nuocsx
	       , MAX(SP.gia) AS GIA
    FROM SANPHAM SP
    GROUP BY  SP.nuocsx
) SANPHAM
    ON SANPHAM.nuocsx = SP1.nuocsx AND SANPHAM.GIA = SP1.gia

--24. Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau.
SELECT SP.nuocsx
FROM SanPham SP
GROUP BY SP.nuocsx
HAVING COUNT(DISTINCT SP.gia) >= 3
--25. Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất .
SELECT TOP 1 KHACHHANG.hoten FROM HOADON 
JOIN (SELECT TOP 10 * FROM KHACHHANG ORDER BY KHACHHANG.doanhso DESC) KHACHHANG ON KHACHHANG.makh = HOADON.makh
JOIN (SELECT TOP 1 sohd, COUNT(masp) SL FROM CTHD GROUP BY sohd ORDER BY SL DESC)  CTHD ON CTHD.sohd = HOADON.sohd AND KHACHHANG.makh = HOADON.makh
--26. Thay đổi tên CSDL QLBH thành QLKD
USE MASTER;
GO
ALTER DATABASE QLBH SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
ALTER DATABASE QLBH MODIFY NAME = QLKD;
GO
ALTER DATABASE QLKD SET MULTI_USER;
GO
--27. Thay đổi tên bảng CTHD thành ChiTietHD
EXEC sp_rename 'CTHD','ChiTietHD' 
--28. Thêm vào bảng khách hàng trường dữ liệu LoaiKH (Loại khách hàng: dùng để lưu trữ một trong 3 giá trị “TV”, “TT”, “VIP”)
ALTER TABLE KHACHHANG
ADD LoaiKH CHAR(3) CHECK(LoaiKH IN ('TV','TT','VIP'));
--29. Cập nhật giá trị loại khách hàng cho tất cả các khách hàng hiện tại thành giá trị “TV”
UPDATE KHACHHANG
SET LoaiKH = 'TV'; 
--30. Cập nhật giá trị loại khách hàng là “TT” cho các khách hàng đã mua nhiều hơn 1 hóa đơn.
UPDATE KHACHHANG 
SET LoaiKH = 'TT'
WHERE makh IN ( SELECT KhachHang.makh
				FROM KhachHang
				JOIN HoaDon ON HoaDon.makh = KhachHang.makh
				GROUP BY KhachHang.makh
				HAVING COUNT(*) > 1);

--31. Cập nhật giá trị loại khách hàng là “VIP” cho các khách hàng có doanh số hơn 1.000.000.
UPDATE KHACHHANG 
SET LoaiKH = 'VIP'
WHERE doanhso > 1000000
--32. Xóa cột doanh số khỏi bảng khách hàng. Hiển thị và lưu lại ảnh lược đồ toàn bộ CSDL sau khi thực hiện.
ALTER TABLE KHACHHANG 
DROP COLUMN doanhso

