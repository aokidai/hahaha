use QLSinhVien
go
--Xem SV đạt hay không
select sv.MaSV, HoDem +' '+ Ten as hoten, hp.TENHP, kq.DiemThi, ketqua=
case  when  kq.DiemThi>=5 then N'Đạt'
else N'Không Đạt'
end
from SinhVien sv, KETQUA kq, HOCPHAN hp 
where sv.MaSV=kq.MASV and hp.MAHP=kq.MAHP 
--Xem kết quả sinh viên
select sv.MaSV, sv.MALOP,hp.MAHP, sv.HoDem+' '+sv.Ten as hoten, ketqua=
case when kq.DiemGiuaHP>=5 then kq.DiemGiuaHP
else (case when kq.DiemThi is not null then (case  when kq.DiemThi<=kq.DiemThi then kq.DiemThi else kq.DiemThi end ) else 0 end)
end
from SinhVien sv, KETQUA kq, HOCPHAN hp
where sv.MaSV=kq.MASV and kq.MAHP=hp.MAHP
--Xem loại của sinh viên
With SV_DTB (masv, hodem, ten, mahp, DTB)
AS
(select sv.masv, sv.hodem, sv.ten, hp.mahp, 
		DTB=Round(Avg(IIF(kq.diemgiuaHP > ISNULL(kq.diemthi,0),kq.diemgiuaHP,kq.diemthi)),1)
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
--Cho biết điểm thi của các sinh viên
select s.masv, s.hodem+s.ten as hoten,h.tenhp, k.diemgiuaHP,k.diemthi
from SinhVien s, ketqua k, hocphan h
where s.masv=k.masv and k.mahp=h.mahp
-- Cho xem danh sách các sinh viên thụôc các lớp Tin học thi cuối hp
select s.masv, s.hodem+s.ten as hoten,h.tenhp, k.diemgiuaHP,k.diemthi
from SinhVien s, ketqua k, hocphan h, lop l
where s.masv=k.masv and k.mahp=h.mahp and l.MaLop=s.malop and l.TenLop like N'Tin học%'
--Cho xem danh sách những sinh viên thi cuối hp
select s.masv, s.hodem+s.ten as hoten,h.tenhp, k.diemgiuaHP,k.diemthi
from SinhVien s, ketqua k, hocphan h, lop l
where s.masv=k.masv and k.mahp=h.mahp and l.MaLop=s.malop and l.TenLop like N'Kinh %'
--Cho xem danh sách các sinh viên thi cuối hp không đạt
select s.masv, s.hodem+s.ten as hoten,h.tenhp, k.diemgiuaHP,k.diemthi
from SinhVien s, ketqua k, hocphan h, lop l
where s.masv=k.masv and k.mahp=h.mahp and l.MaLop=s.malop and k.diemthi<5
--Ds SV có tuổi từ 20 đến 22
select *
from SinhVien s
where DATEDIFF(year, s.NGAYSINH ,GETDATE())>=20 and DATEDIFF(year, s.NGAYSINH ,GETDATE())<=25
--tính tổng số sinh viên theo lớp,
select s.MALOP, l.TenLop, l.MAGV, SiSoLop= COUNT(s.MaSV)
from SinhVien s, Lop l
where s.MALOP=l.MaLop group by s.MALOP, l.TenLop, l.MAGV
--tổng số sinh viên thi cuối hp theo lớp,
select lp.MaLop, lp.TenLop, TSSV_thicuoiki= count(kq.DiemThi)
from KETQUA kq, Lop lp, SinhVien s
where kq.MASV=s.MaSV and lp.MaLop=s.MALOP group by lp.MaLop, lp.TenLop
--biết tổng số sinh viên thi cuối hp theo môn học,
select hp.MAHP, hp.TENHP, TSSV_thicuoiki= count(kq.DiemThi)
from SinhVien s, HOCPHAN hp, KETQUA kq
where s.MaSV=kq.MASV and kq.MAHP=hp.MAHP group by hp.MAHP, hp.TENHP