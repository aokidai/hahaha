create database QLSinhVien on primary
(
	name = 'QLSinhVien',
	filename = N'D:\baitap\QLSinhVien.mdf',
	size =30MB, filegrowth =10%, maxsize=200mb
)
log on
(
	name = 'QLSinhVien_Log',
	filename = N'D:\baitap\QLSinhVien_log.ldf',
	size =10mb, filegrowth = 2mb, maxsize=unlimited
)
go
use QLSinhVien
go
create table Khoa
(
	MaKhoa char(4) primary key,
	TenKhoa Nvarchar(30),
	Solop int,
)

create table Lop
(
	MaLop varchar(10) primary key,
	TenLop nvarchar(30),
	MAGV varchar(10),
	MAKHOA CHAR(4) references Khoa(MaKhoa),
	SiSo int
)
create table SinhVien
(
	MaSV varchar(10) primary key,
	HoDem nvarchar(30),
	Ten nvarchar(20),
	Phai BIT,
	NGAYSINH DATE,
	DIACHI NVARCHAR(50),
	DIENTHOAI NVARCHAR(14),
	MALOP VARCHAR(10) REFERENCES LOP(MALOP),
	EMAIL VARCHAR(30),
)
CREATE TABLE GIAOVIEN
(
MAGV varchar(10) PRIMARY KEY,
MaKhoa char(4) references Khoa(MaKhoa),
TenGV nvarchar(30),
DienThoai nvarchar(14),
Email nvarchar(20),
)

CREATE TABLE HOCPHAN
(
	MAHP VARCHAR(10) PRIMARY KEY,
	TENHP NVARCHAR(30),
	SOTC INT,
	MAGV varchar(10) references giaovien(MAGV),
)



CREATE TABLE KETQUA
(
	MASV VARCHAR(10) REFERENCES SINHVIEN(MASV),
	MAHP VARCHAR(10) REFERENCES HOCPHAN(MAHP),
	DiemGiuaHP FLOAT,
	DiemThi FLOAT, 
	PRIMARY KEY (MASV,MAHP)
)
ALTER TABLE KETQUA ADD CONSTRAINT DF_KQ1 DEFAULT 0 FOR DIEMGIUAHP
ALTER TABLE KETQUA ADD CONSTRAINT DF_KQ2 DEFAULT 0 FOR DIEMTHI
ALTER TABLE SINHVIEN ADD CONSTRAINT DF_DC DEFAULT N'BÌNH DƯƠNG' FOR DIACHI

ALTER TABLE KETQUA ADD CONSTRAINT RB CHECK(DiemGiuaHP>=0 AND DiemGiuaHP<=10) --giới hạn điểm 0-10
ALTER TABLE KETQUA ADD CONSTRAINT RB2 CHECK(DiemThi>=0 AND DiemThi<=10)

ALTER TABLE SINHVIEN ADD CONSTRAINT CHECK_SDT CHECK(LEN(DIENTHOAI)=10 OR LEN(DIENTHOAI)=11) -- ràng buộc sdt chỉ có 10 hoặc 11 số

ALTER TABLE SINHVIEN ADD SOCMND VARCHAR(10)
ALTER TABLE SINHVIEN ADD CONSTRAINT PRI_SCM UNIQUE(SOCMND)

ALTER TABLE SINHVIEN ADD CONSTRAINT DATETI CHECK(DATEDIFF(year, NGAYSINH ,GETDATE())>=18) -- ràng buộc sinh viên phải trên 18 tuổi


INSERT INTO KHOA VALUES('CNTT',N'CÔNG NGHỆ THÔNG TIN',70)
INSERT INTO KHOA VALUES('CTXH',N'CÔNG TÁC XÃ HỘI',50)
INSERT INTO KHOA VALUES('DDT',N'ĐIỆN - ĐIỆN TỬ', 65)
INSERT INTO KHOA VALUES('KHTN',N'KHOA HỌC TỰ NHIÊN',81)
INSERT INTO KHOA VALUES('KT',N'KINH TẾ',51)
INSERT INTO KHOA VALUES('LLCT', N'LÝ LUẬN CHÍNH TRỊ',65)
INSERT INTO KHOA VALUES('LS',N'LỊCH SỬ',65)
INSERT INTO KHOA VALUES('LU',N'LUẬT',65)
INSERT INTO KHOA VALUES('NV', N'NGỮ VĂN',65)
INSERT INTO KHOA VALUES('SP', N'SƯ PHẠM',65)

INSERT INTO LOP VALUES('CKT2A', N'Kinh tế 2A','01','KT',45)
INSERT INTO LOP VALUES('CTH1A', N'Tin học 1A','02','CNTT',56)
INSERT INTO LOP VALUES('CTH1B', N'Tin học 1B','03','CNTT',43)
INSERT INTO LOP VALUES('CTH2B', N'Tin học 2B','03','CNTT',43)
INSERT INTO LOP VALUES('DLS36A', N'Lịch sử 36A','04','LS',46)
INSERT INTO LOP VALUES('DSP35B', N'Sư phạm 35B','05','SP',50)
INSERT INTO LOP VALUES('DTH2B', N'Tin học 2B','06','CNTT',40)
INSERT INTO LOP VALUES('DTH35A', N'Tin học 35A','06','CNTT',45)
INSERT INTO LOP VALUES('DTH35B', N'Tin học 35B','06','CNTT',45)

INSERT INTO GIAOVIEN VALUES('01','CNTT',N'Lê Thanh Hùng','0123456789','LTH.CNTT@GMAIL.COM')
INSERT INTO GIAOVIEN VALUES('02','LU',N'Nguyễn Văn Minh','0123456788','NVM.JAVA@GMAIL.COM')
INSERT INTO GIAOVIEN VALUES('03','NV',N'Nguyễn Văn Thắng','0123456787','NVT.NMTH@GMAIL.COM')
INSERT INTO GIAOVIEN VALUES('04','SP',N'Trần Văn Hải','0123456786','TVH.PTWB@GMAIL.COM')
INSERT INTO GIAOVIEN VALUES('05','LLCT',N'Nguyễn Hoàng Huế','0123456785','NHH.PPLT@GMAIL.COM')
INSERT INTO GIAOVIEN VALUES('06','KT',N'Lê Thanh Hùng','0123456784','LTH.TRR@GMAIL.COM')

insert into HocPhan values ('CTR', N'Chính trị', 3,'01')
insert into HocPhan values ('JAVA', N'Lập trình JAVA', 5,'01')
insert into HocPhan values ('NMTH', N'Nhập môn tin học', 4,'02')
insert into HocPhan values ('PPLT', N'Phương pháp lập trình', 5,'03')
insert into HocPhan values ('PTWB', N'Phát triển web', 3,'02')
insert into HocPhan values ('TRR', N'Toán rời rạc', 3,'03')



insert into sinhvien values('A202',N'Tạ Thành',N'Lâm','false','1996-11-01',N'172 Nguyễn Du',Null,'CKT2A','TTL.CKT2A@GMAIL.COM','1')
insert into sinhvien values('A203',N'Hoàng Minh',N'Minh','true','1994-11-22',N'132/12 Lê Lợi',Null,'CKT2A','HMM.CKT2A@GMIL.COM','2')
insert into sinhvien values('A204',N'Lê Thị',N'Hoa','false','1996-03-12',N'98 Võ Văn Kiệt','0990789213','CKT2A','LTH.CKT2A@GMAIL.COM','3')
insert into sinhvien values('B101',N'Lê Bá',N'Hải','true','1993-12-12',N'12 Trương Định','0909081312','CTH1B','LBH.CTH1B@GMAIL.COM','4')
insert into sinhvien values('B102',N'Phạm Thị',N'Hoa','false','1993-01-09',N'5 Lê Lai Q1',Null,'CTH1B','PTH.CTH1B@GMAIL.COM','5')
insert into sinhvien values('B103',N'Lê Vĩnh Phúc',N'Phúc','true','1995-01-04',N'12 Phan Văn Trị',Null,'CTH1B','LVP.CTH1B@GMAIL.COM','6')
insert into sinhvien values('B104',N'Phạm Văn',N'Hùng','true','1994-9-04',N'50 Nguyễn Kiệt','0919095413','DLS36A','PVH.DLS36A@GMAIL.COM','7')
insert into sinhvien values('B105',N'Nguyễn Thanh',N'Tâm','true','1991-05-07',N'45 Lê Quang Đị','01689908231','CTH1B','NTT.CTH1B@GMAIL.COM','8')
insert into sinhvien values('B201',N'Đỗ',N'Hoàng','true','1996-09-11',N'12 Nguyễn Kiệ','01687990912','CTH2B','DH.CTH2B@GMAIL.COM','9')
insert into sinhvien values('B202',N'Trần Thị',N'Dung','false','1994-10-01',N'39/12a Nguyễn',Null,'CTH2B','NTD.CTH2B@GMAIL.COM','10')
insert into sinhvien values('B203',N'Lê Văn',N'lợi','true','1993-01-12',N'145/1A Nguyễn',Null,'DSP35B','LVL.DSP35B@GMAIL.COM','11')
insert into sinhvien values('B204',N'Đặng Trung',N'Tiến','true','1995-12-22',N'11/1E Lê Lợi GV',Null,'DTH2B','DTT.DTH@GMAIL.COM','12')
insert into sinhvien values('C3501',N'Nguyễn Văn',N'Hùng','true','1995-12-12',N'45 Bạch Đằng BT',Null,'DTH35A','NVH.DTH35A@GMAIL.COM','13')
insert into sinhvien values('C3504',N'Trần Hùng',N'Hùng','true','1990-12-12',N'45 Nguyễn Trãi','09907213131','DTH35B','THH.DTH35B@GMAIL.COM','16')
insert into sinhvien values('C3601',N'Nguyễn Hoàng',N'Nam','true','1996-07-12',N'12/A Võ Thị Sáu',Null,'DLS36A','NHN.DLS36A@GMAIL.COM','19')



go

insert into KetQua values ('A202', 'JAVA', 4,NULL)
insert into KetQua values ('A204', 'JAVA', 7,NULL)
insert into KetQua values ('A204', 'TRR', 6.5,NULL)
insert into KetQua values ('B101', 'CTR', 3, 1)
insert into KetQua values ('B101', 'TRR', 8,NULL)
insert into KetQua values ('B102', 'CTR', 9, 7)
insert into KetQua values ('B104', 'NMTH', 8,NULL)
insert into KetQua values ('B102', 'PPLT', 7,NULL)
insert into KetQua values ('B102', 'PTWB', 2, 3)
insert into KetQua values ('B102', 'TRR', 9,NULL)
insert into KetQua values ('B103', 'PPLT', 7,NULL)
insert into KetQua values ('B103', 'PTWB', 6,NULL)
insert into KetQua values ('B103', 'TRR', 9,NULL)
go

BACKUP DATABASE QLSinhVien to disk='D:\baitap\backup_bt1.bak'
restore database QLSinhVien from disk='D:\baitap\backup_bt1.bak'

