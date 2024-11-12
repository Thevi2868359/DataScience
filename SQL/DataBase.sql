
create database QLSV


use QLSV

create table DMKHOA
(
    MaKhoa varchar(4) not null,
    TenKhoa nvarchar(40),
    primary key (MaKhoa)
);

create table DMNGANH
(
    MaNganh varchar(6),
    TenNganh nvarchar(40),
    MaKhoa varchar(4),
    primary key (MaNganh),
    foreign key (MaKhoa) references DMKHOA(MaKhoa)
);

create table DMLOP
(
    MaLop varchar(4),
    TenLop nvarchar(40),
    MaNganh VARCHAR(6),
    KhoaHoc INT,
    HeDT CHAR(2),
    NamNhapHoc INT,
    primary key (MaLop),
    foreign key (MaNganh) references DMNGANH(MaNganh)
);

CREATE table SINHVIEN
(
    MaSV VARCHAR(4) PRIMARY KEY,
    HoTen NVARCHAR(50),
    MaLop VARCHAR(4),
    GioiTinh BIT,
    NgaySinh DATE,
    DiaChi NVARCHAR(100),
    foreign key (MaLop) references DMLOP(MaLop)
);

CREATE TABLE DMHOCPHAN
(
    MaHP VARCHAR(4) PRIMARY KEY,
    TenHP NVARCHAR(50),
    SoDVHT INT,
    MaNganh VARCHAR(6),
    HocKy INT,
);
DROP TABLE DIEMHP


CREATE TABLE DIEMHP
(
    MaSV VARCHAR(4),
    MaHP VARCHAR(4),
    DiemHP FLOAT,
    PRIMARY KEY (MaSV, MaHP),
    foreign key (MaSV) references SINHVIEN(MaSV)
);

INSERT INTO DMKHOA
    (MaKhoa, TenKhoa)
VALUES
    ('CNTT', N'Công nghệ thông tin'),
    ('KT', N'Kế Toán'),
    ('SP', N'Sư phạm');

INSERT INTO DMNGANH
    (MaNganh, TenNganh, MaKhoa)
VALUES
    ('140902', N'Sư phạm toán tin', 'SP'),
    ('480202', N'Tin học ứng dụng', 'CNTT');

INSERT INTO DMLOP
    (MaLop, TenLop, MaNganh, KhoaHoc, HeDT, NamNhapHoc)
VALUES
    ('CT11', N'Cao đẳng tin học', '480202', 11, 'TC', 2013),
    ('CT12', N'Cao đẳng tin học', '480202', 12, 'CĐ', 2013),
    ('CT13', N'Cao đẳng tin học', '480202', 13, 'CĐ', 2014);

INSERT INTO SINHVIEN
    (MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi)
VALUES
    ('001', N'Phan Thanh', 'CT12', 0, '1990-12-09', N'Tuy Phước'),
    ('002', N'Nguyễn Thị Cẩm Tú', 'CT12', 1, '1994-12-01', N'Quy Nhơn'),
    ('003', N'Võ Thị Hà', 'CT12', 1, '1995-02-07', N'An Nhơn'),
    ('004', N'Trần Hoài Nam', 'CT12', 0, '1994-05-04', N'Tây Sơn'),
    ('005', N'Trần Văn Hoàng', 'CT13', 0, '1995-04-08', N'Vĩnh Thạnh'),
    ('006', N'Đặng Thị Thảo', 'CT13', 1, '1995-12-06', N'Quy Nhơn'),
    ('007', N'Lê Thị Sen', 'CT13', 1, '1994-12-08', N'Phù Cát'),
    ('008', N'Nguyễn Văn Huy', 'CT11', 0, '1995-04-06', N'Phù Mỹ'),
    ('009', N'Trần Thị Hoa', 'CT11', 1, '1994-09-08', N'Hoài Nhơn');

INSERT INTO DMHOCPHAN
    (MaHP, TenHP, SoDVHT, MaNganh, HocKy)
VALUES
    ('001', N'Toán cao cấp A1', 4, '480202', 1),
    ('002', N'Tiếng Anh 1', 3, '480202', 1),
    ('003', N'Vật lý đại cương', 4, '480202', 1),
    ('004', N'Tiến anh 2', 7, '480202', 1),
    ('005', N'Tiếng anh 1', 3, '140909', 2),
    ('006', N'Xác suất thống kê', 3, '140902', 2);

INSERT INTO DIEMHP
    (MaSV, MaHP, DiemHP)
VALUES
    ('002', '002', 5.9),
    ('002', '003', 4.5),
    ('003', '001', 4.3),
    ('003', '002', 6.7),
    ('003', '003', 7.3),
    ('004', '001', 4.0),
    ('004', '002', 5.2),
    ('004', '003', 3.5),
    ('005', '001', 9.8),
    ('005', '002', 7.9),
    ('005', '003', 7.5),
    ('006', '001', 6.1),
    ('006', '002', 5.6),
    ('006', '003', 4.0),
    ('007', '001', 6.2);

