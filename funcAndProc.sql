--PROCEDURE
--Liet ke danh sach sinh vien theo ma khoa
create proc lietKeTheoKhoa (@ma char(4))
as
select * from Khoa, Lop, SinhVien sv where sv.MALOP = lop.MaLop and lop.MAKHOA = Khoa.MaKhoa and khoa.MaKhoa = @ma

--Liet ke danh sach sinh vien theo ma lop
create proc lietKeTheoLop (@ma varchar(14))
as
select * from Lop, SinhVien sv where sv.MALOP = lop.MaLop and lop.MaLop = @ma

--Hien thi ket qua cua sinh vien theo ma sinh vien
create proc hienThiKetQua (@ma varchar(10))
as
select * from SinhVien sv, KETQUA kq, HOCPHAN hp where sv.MaSV = kq.MASV and hp.MAHP = kq.MAHP and sv.MaSV = @ma

--Tim kiem sinh vien theo ten hoac ho
create proc tkSV (@tim varchar(50))
as
select *
from SinhVien
where HoDem like '%'+@tim+'%' or Ten like '%'+@tim+'%'

--Tim kiem sinh vien theo ma sinh vien
create proc tkSVTheoMa (@tim varchar(50))
as
select *
from SinhVien
where MaSV = @tim

--Them sinh vien
create proc themSV (@nMaSV varchar(10),
					@nHoDem nvarchar(30),
					@nTen nvarchar(20),
					@nPhai bit,
					@nNgaySinh date,
					@nDiaChi nvarchar(50),
					@nDienThoai varchar(14),
					@nMaLop varchar(10),
					@nEmail varchar(30),
					@nSoCMND varchar(10))
as
begin
	insert into SinhVien values (@nMaSV, @nHoDem, @nTen, @nPhai, @nNgaySinh, @nDiaChi, @nDienThoai, @nMaLop, @nEmail, @nSoCMND)
	update Lop set SiSo = SiSo + 1 where MaLop = @nMaLop
end

-----------------------------------------------------------------------------------------------------------------------------
--FUNTION
--Diem trung binh cua sinh vien theo ma sinh vien
create function diemTB (@maSV varchar(10))
returns table
return select sv.MaSV, hp.MaHP, DTB = Round((kq.DiemGiuaHP + kq.DiemThi)/2,1) 
from SinhVien sv, KetQua kq, HocPhan hp
where sv.MaSV = kq.MaSV and sv.MaSV = @maSV and hp.MaHP = kq.MaHP

--Tim sinh vien theo ma sinh vien
create function timSV (@maS varchar(10))
returns table
return select * from SinhVien where MaSV = @maS