using System;
using System.Data;
using System.Data.SqlClient; 
using DataAccess;

public class DAO_DON_HANG : BASE
{
    // =============================================================
    // PHẦN 1: DÀNH CHO TRANG KHÁCH HÀNG 
    // =============================================================

    public int ThemDonHang(decimal tongTien, string ten, string diaChi, string sdt, string email, string ghiChu, object idTaiKhoan)
    {
     
        DataSet ds = SqlDataAccess.ExecuteDataset(Connection, "sp_donhang_them", tongTien, ten, diaChi, sdt, email, ghiChu, idTaiKhoan);
        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
        {
            return Convert.ToInt32(ds.Tables[0].Rows[0][0]);
        }
        return 0;
    }

    public void ThemChiTiet(int idDonHang, int idSanPham, int soLuong, decimal donGia)
    {
        SqlDataAccess.ExecuteNonQuery(Connection, "sp_ctdh_them", idDonHang, idSanPham, soLuong, donGia);
    }

    // =============================================================
    // PHẦN 2: DÀNH CHO TRANG QUẢN TRỊ 
    // =============================================================

    public DataSet DonHang_All()
    {
        return SqlDataAccess.ExecuteDataset(Connection, "sp_donhang_all");
    }

    // 1. Lấy thông tin chung (Tên khách, Ngày đặt, Trạng thái)
    public DataSet DonHang_ID(int id)
    {
        SqlParameter param = new SqlParameter("@ID_DonHang", id);

        return SqlDataAccess.ExecuteDataset(Connection, CommandType.StoredProcedure, "sp_donhang_thongtin", param);
    }

    // 2. Lấy danh sách sản phẩm (Ảnh, Giá, Thành tiền)
    public DataSet CTDH_TheoDon(int idDon)
    {
        SqlParameter param = new SqlParameter("@ID_DonHang", idDon);

        return SqlDataAccess.ExecuteDataset(Connection, CommandType.StoredProcedure, "sp_donhang_chitiet", param);
    }

    public void DonHang_Duyet(int id, int tt)
    {
        SqlDataAccess.ExecuteNonQuery(Connection, "sp_donhang_duyet", id, tt);
    }

    public void DonHang_Huy(int id, int tt)
    {
        SqlDataAccess.ExecuteNonQuery(Connection, "sp_donhang_huy", id, tt);
    }
}