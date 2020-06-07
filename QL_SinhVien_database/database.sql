create database QLSinhVien on primary
(
	name = 'QLSinhVien',
	filename = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\QLSinhVien.mdf',
	size =30MB, filegrowth =10%, maxsize=200mb
)
log on
(
	name = 'QLSinhVien_Log',
	filename = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\QLSinhVien_log.ldf',
	size =10mb, filegrowth = 2mb, maxsize=unlimited
)
go
use QLSinhVien
go
create table Khoa
(
	MaKhoa char(4) primary key,
	TenKhoa Nvarchar(30),
	SiSo int,
)
create table Lop
(
	MaLop varchar(10) primary key,
	TenLop nvarchar(30),
	GVCN nvarchar(30),
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
)
CREATE TABLE HOCPHAN
(
	MAHP VARCHAR(10) PRIMARY KEY,
	TENHP NVARCHAR(30),
	SOTC INT,
)
CREATE TABLE KETQUA
(
	MASV VARCHAR(10) REFERENCES SINHVIEN(MASV),
	MAHP VARCHAR(10) REFERENCES HOCPHAN(MAHP),
	DIEMLAN1 FLOAT,
	DIEMLAN2 FLOAT, 
	PRIMARY KEY (MASV,MAHP)
)
ALTER TABLE KETQUA ADD CONSTRAINT DF_KQ1 DEFAULT 0 FOR DIEMLAN1
ALTER TABLE KETQUA ADD CONSTRAINT DF_KQ2 DEFAULT 0 FOR DIEMLAN2
ALTER TABLE SINHVIEN ADD CONSTRAINT DF_DC DEFAULT N'BÌNH DƯƠNG' FOR DIACHI

ALTER TABLE KETQUA ADD CONSTRAINT RB CHECK(DIEMLAN1>=0 AND DIEMLAN1<=10)
ALTER TABLE KETQUA ADD CONSTRAINT RB2 CHECK(DIEMLAN2>=0 AND DIEMLAN2<=10)

ALTER TABLE SINHVIEN ADD CONSTRAINT CHECK_SDT CHECK(LEN(DIENTHOAI)=10 OR LEN(DIENTHOAI)=11)

ALTER TABLE SINHVIEN ADD SOCMND VARCHAR(10)
ALTER TABLE SINHVIEN ADD CONSTRAINT PRI_SCM UNIQUE(SOCMND)

ALTER TABLE SINHVIEN ADD CONSTRAINT DATETI CHECK(DATEDIFF(year, NGAYSINH ,GETDATE())>=18)
ALTER TABLE SINHVIEN drop CONSTRAINT DATETI

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

INSERT INTO LOP VALUES('CKT2A', N'Kinh tế 2A',N'Lê Thanh Hùng','KT',45)
INSERT INTO LOP VALUES('CTH1A', N'Tin học 1A',N'Nguyễn Văn Minh','CNTT',56)
INSERT INTO LOP VALUES('CTH1B', N'Tin học 1B',N'Nguyễn Văn Thắng','CNTT',43)
INSERT INTO LOP VALUES('CTH2B', N'Tin học 2B',N'Nguyễn Văn Thắng','CNTT',43)
INSERT INTO LOP VALUES('DLS36A', N'Lịch sử 36A',N'Trần Văn Hải','LS',46)
INSERT INTO LOP VALUES('DSP35B', N'Sư phạm 35B',N'Nguyễn Hoàng Huế','SP',50)
INSERT INTO LOP VALUES('DTH2B', N'Tin học 2B',N'Nguyễn Văn Tùng','CNTT',40)
INSERT INTO LOP VALUES('DTH35A', N'Tin học 35A',N'Hoàng Văn Thạch','CNTT',45)
INSERT INTO LOP VALUES('DTH35B', N'Tin học 35B',N'Hoàng Văn Thạch','CNTT',45)

insert into sinhvien values('A202',N'Tạ Thành',N'Lâm','false','1996-11-01',N'172 Nguyễn Du',Null,'CKT2A','1')
insert into sinhvien values('A203',N'Hoàng Minh',N'Minh','true','1994-11-22',N'132/12 Lê Lợi',Null,'CKT2A','2')
insert into sinhvien values('A204',N'Lê Thị',N'Hoa','false','1996-03-12',N'98 Võ Văn Kiệt','0990789213','CKT2A','3')
insert into sinhvien values('B101',N'Lê Bá',N'Hải','true','1993-12-12',N'12 Trương Định','0909081312','CTH1B','4')
insert into sinhvien values('B102',N'Phạm Thị',N'Hoa','false','1993-01-09',N'5 Lê Lai Q1',Null,'CTH1B','5')
insert into sinhvien values('B103',N'Lê Vĩnh Phúc',N'Phúc','true','1995-01-04',N'12 Phan Văn Trị',Null,'CTH1B','6')
insert into sinhvien values('B104',N'Phạm Văn',N'Hùng','true','1994-9-04',N'50 Nguyễn Kiệt','0919095413','DLS36A','7')
insert into sinhvien values('B105',N'Nguyễn Thanh',N'Tâm','true','1991-05-07',N'45 Lê Quang Đị','01689908231','CTH1B','8')
insert into sinhvien values('B201',N'Đỗ',N'Hoàng','true','1996-09-11',N'12 Nguyễn Kiệ','01687990912','CTH2B','9')
insert into sinhvien values('B202',N'Trần Thị',N'Dung','false','1994-10-01',N'39/12a Nguyễn',Null,'CTH2B','10')
insert into sinhvien values('B203',N'Lê Văn',N'lợi','true','1993-01-12',N'145/1A Nguyễn',Null,'DSP35B','11')
insert into sinhvien values('B204',N'Đặng Trung',N'Tiến','true','1995-12-22',N'11/1E Lê Lợi GV',Null,'DTH2B','12')
insert into sinhvien values('C3501',N'Nguyễn Văn',N'Hùng','true','1995-12-12',N'45 Bạch Đằng BT',Null,'DTH35A','13')
insert into sinhvien values('C3504',N'Trần Hùng',N'Hùng','true','1990-12-12',N'45 Nguyễn Trãi','09907213131','DTH35B','16')
insert into sinhvien values('C3601',N'Nguyễn Hoàng',N'Nam','true','1996-07-12',N'12/A Võ Thị Sáu',Null,'DLS36A','19')


insert into HocPhan values ('CTR', N'Chính trị', 3)
insert into HocPhan values ('JAVA', N'Lập trình JAVA', 5)
insert into HocPhan values ('NMTH', N'Nhập môn tin học', 4)
insert into HocPhan values ('PPLT', N'Phương pháp lập trình', 5)
insert into HocPhan values ('PTWB', N'Phát triển web', 3)
insert into HocPhan values ('TRR', N'Toán rời rạc', 3)
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

BACKUP DATABASE QLSinhVien to disk='D:\Aoki\SQL\backup_bt1.bak'
restore database QLSinhVien from disk='D:\Aoki\SQL\backup_bt1.bak'

select sv.MaSV, HoDem +' '+ Ten as hoten, hp.TENHP, kq.DIEMLAN1, ketqua=
case  when  kq.DIEMLAN1>=5 then N'Đạt'
else N'Không Đạt'
end
from SinhVien sv, KETQUA kq, HOCPHAN hp 
where sv.MaSV=kq.MASV and hp.MAHP=kq.MAHP 

select sv.MaSV, sv.MALOP,hp.MAHP, sv.HoDem+' '+sv.Ten as hoten, ketqua=
case when kq.DIEMLAN1 >=5 then kq.DIEMLAN1
else (case when kq.DIEMLAN2 is not null then (case  when kq.DIEMLAN1<=kq.DIEMLAN2 then kq.DIEMLAN2 else kq.DIEMLAN1 end ) else 0 end)
end
from SinhVien sv, KETQUA kq, HOCPHAN hp
where sv.MaSV=kq.MASV and kq.MAHP=hp.MAHP

use QLSinhVien
go

With SV_DTB (masv, hodem, ten, mahp, DTB)
AS
(select sv.masv, sv.hodem, sv.ten, hp.mahp, 
		DTB=Round(Avg(IIF(kq.diemlan1 > ISNULL(kq.diemlan2,0),kq.diemlan1,kq.diemlan2)),1)
from KetQua kq, sinhvien sv, hocphan hp
where sv.MaSV=kq.MaSV and hp.MaHP=kq.MaHP
group by sv.masv, sv.hodem, sv.ten, hp.mahp)

select masv, hodem, ten, mahp, DTB, XepLoai=
		case when DTB>=8 then N'Giỏi' 
		     when DTB<8 and DTB>=6.5 then N'Khá'
			 when DTB<6.5 and DTB>=5 then N'TB'
			 else N'Yếu'
	    end 
from SV_DTB


select s.masv, s.hodem+s.ten as hoten,h.tenhp, k.diemlan1,k.diemlan2
from SinhVien s, ketqua k, hocphan h
where s.masv=k.masv and k.mahp=h.mahp

select s.masv, s.hodem+s.ten as hoten,h.tenhp, k.diemlan1,k.diemlan2
from SinhVien s, ketqua k, hocphan h, lop l
where s.masv=k.masv and k.mahp=h.mahp and l.MaLop=s.malop and l.TenLop like N'Tin học%'

select s.masv, s.hodem+s.ten as hoten,h.tenhp, k.diemlan1,k.diemlan2
from SinhVien s, ketqua k, hocphan h, lop l
where s.masv=k.masv and k.mahp=h.mahp and l.MaLop=s.malop and l.TenLop like N'Kinh %'

select s.masv, s.hodem+s.ten as hoten,h.tenhp, k.diemlan1,k.diemlan2
from SinhVien s, ketqua k, hocphan h, lop l
where s.masv=k.masv and k.mahp=h.mahp and l.MaLop=s.malop and k.diemlan2<5