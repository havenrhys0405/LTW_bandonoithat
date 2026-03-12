using DataAccess;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;


public class DAO_KHACH_HANG : BASE
{

    public void DangKyTaiKhoan(string tendn, string matkhau, string hoten, string sdt)
    {
      
        SqlDataAccess.ExecuteNonQuery(
            Connection,
            "sp_taikhoan_dangky",
            tendn,
            matkhau,
            hoten,
            sdt       
        );
    }


    public DataSet tk_all()
    {
        return SqlDataAccess.ExecuteDataset(
            Connection,
            "sp_tk_all"
        );
    }

    public DataSet dangnhap(string tendn, string matkhau)
    {
        try
        {
            return SqlDataAccess.ExecuteDataset(
                Connection,
                "sp_tk_login",
                tendn, matkhau
            );
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

 
    public void DangKyKhach(string tendn, string hoten, string sdt, string matkhau)
    {
        SqlDataAccess.ExecuteNonQuery(
            Connection,
            "sp_tk_dangky",
            tendn, hoten, sdt, matkhau
        );
    }

    public void ThemNhanVien(string tendn, string matkhau, string hoten, string sdt)
    {
        SqlDataAccess.ExecuteNonQuery(
            Connection,
            "sp_tk_them_nhanvien",
            tendn, matkhau, hoten, sdt
        );
    }

    public void KhachSuaThongTin(int idtaikhoan, string tendn, string matkhau, string hoten, string sdt)
    {
        SqlDataAccess.ExecuteNonQuery(
            Connection,
            "sp_khach_sua",
            idtaikhoan, tendn, matkhau, hoten, sdt
        );
    }

    public void NhanVienSuaThongTin(int idtaikhoan, string hoten, string sdt)
    {
        SqlDataAccess.ExecuteNonQuery(
            Connection,
            "sp_nhanvien_sua",
            idtaikhoan, hoten, sdt
        );
    }

    public DataTable LayThongTinTheoTenDN(string tenDN)
    {
        DataSet ds = tk_all();

        if (ds != null && ds.Tables.Count > 0)
        {
            DataTable dt = ds.Tables[0];
            DataView dv = new DataView(dt);
            dv.RowFilter = "TenDN = '" + tenDN + "'"; // Lọc theo tên đăng nhập

            return dv.ToTable();
        }
        return null;
    }

    public void KhachHang_DoiTrangThai(int id, bool TrangThaiMoi)
    {
        SqlDataAccess.ExecuteNonQuery(
            Connection,
            "sp_taikhoan_doitrangthai",
            id,
            TrangThaiMoi
        );
    }
    public DAO_KHACH_HANG()
    {
        
    }
}