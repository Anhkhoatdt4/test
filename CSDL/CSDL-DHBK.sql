CREATE DATABASE DHBK
USE DHBK

CREATE TABLE GIANGVIEN(
	MaGV varchar(20) primary key,
	HoTen varchar(50),
	MaKhoa varchar(20)
);

CREATE TABLE KHOA(
	MaKhoa varchar(20) primary key,
	TenKhoa varchar(40),
	DienThoai varchar(15)
);

CREATE TABLE MONHOC(
	MaMonHoc varchar(20) primary key,
	TenMonHoc varchar(50),
	SoTinChi int
);

CREATE TABLE TKB(
	SoThuTu int primary key,
	HocKy varchar(10),
	MaGiangVien varchar(20),
	MaMonHoc varchar(20),
	PhongHoc varchar(20),
	Thu varchar(10),
	TietBatDau varchar (20),
	TietKetThuc varchar(20)
);

/* 1 */
SELECT GV.HoTen, TKB1.Thu, TKB1.TietBatDau, TKB1.TietKetThuc, TKB1.PhongHoc
FROM TKB TKB1 JOIN GIANGVIEN GV ON TKB1.MaGiangVien = GV.MaGV
WHERE TKB1.HocKy = N'học kỳ 1'

/* 2 */
SELECT GV.MaGV
FROM (GIANGVIEN GV JOIN KHOA K ON GV.MaKhoa = K.MaKhoa)
	JOIN TKB TKB1 ON GV.MaGV = TKB1.MaGiangVien
WHERE K.TenKhoa = N'Công nghệ Thông tin' AND TKB1.HocKy = N'học kỳ 2' AND TKB1.MaMonHoc = 'CSDL'

INTERSECT

SELECT GV.MaGV
FROM (GIANGVIEN GV JOIN KHOA K ON GV.MaKhoa = K.MaKhoa)
	JOIN TKB TKB1 ON GV.MaGV = TKB1.MaGiangVien
WHERE K.TenKhoa = N'Công nghệ Thông tin' AND TKB1.HocKy = N'học kỳ 2' AND TKB1.MaMonHoc = 'CTDL'

/* 3 */
SELECT MH.TenMonHoc
FROM MONHOC MH 
WHERE MH.MaMonHoc IN (
						SELECT TKB1.MaMonHoc
						FROM GIANGVIEN GV JOIN KHOA K ON GV.MaKhoa = K.MaKhoa
							JOIN TKB TKB1 ON TKB1.MaGiangVien = GV.MaGV
						WHERE K.TenKhoa = N'Điện')

/* 4 */
SELECT GV.HoTen
FROM TKB TKB1 JOIN GIANGVIEN GV ON TKB1.MaGiangVien = GV.MaGV 
WHERE TKB1.Thu = N'thứ 5'

/* 5 */
SELECT GV.HoTen
FROM KHOA K JOIN GIANGVIEN GV ON K.MaKhoa = GV.MaKhoa
WHERE K.TenKhoa = N'Xây dựng' AND GV.MaGV IN(
												SELECT TKB1.MaGiangVien
												FROM TKB TKB1 JOIN MONHOC MH ON TKB1.MaMonHoc = MH.MaMonHoc 
												WHERE MH.TenMonHoc = N'Cơ kết cấu' AND TKB1.Thu = N'thứ 3' AND TKB1.TietBatDau = '1'
												)
/* 6 */
SELECT K1.MaKhoa
FROM KHOA K1 JOIN GIANGVIEN GV1 ON K1.MaKhoa = GV1.MaKhoa
GROUP BY K1.MaKhoa
HAVING COUNT(*) = (
					SELECT TOP 1 COUNT(*)
					FROM KHOA K JOIN GIANGVIEN GV ON K.MaKhoa = GV.MaKhoa
					GROUP BY K.MaKhoa 
					ORDER BY COUNT(*) DESC
					)

/* 7 */
SELECT TKB1.MaGiangVien, SUM(MH.SoTinChi)  AS TONGTC
FROM MONHOC MH JOIN TKB TKB1 ON MH.MaMonHoc = TKB1.MaMonHoc
WHERE TKB1.HocKy = N'học kỳ 1'
GROUP BY TKB1.MaGiangVien

/* 8 */
SELECT DISTINCT TenMonHoc
FROM MONHOC 

SELECT TenMonHoc
FROM MONHOC
GROUP BY TenMonHoc



