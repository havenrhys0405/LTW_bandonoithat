using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using DataAccess;

/// <summary>
/// Summary description for DAO_THONG_KE
/// </summary>
public class DAO_THONG_KE:BASE
{
    public DataSet TongDanhMuc()
    {
        return SqlDataAccess.ExecuteDataset(Connection, "sp_thongke_tongdanhmuc");
    }

    public DataSet TongLoaiSanPham()
    {
        return SqlDataAccess.ExecuteDataset(Connection, "sp_tk_tong_loaisanpham");
    }

    public DataSet TongSanPham()
    {
        return SqlDataAccess.ExecuteDataset(Connection, "sp_thongke_tongsanpham");
    }

    public DataSet TongDonHang()
    {
        return SqlDataAccess.ExecuteDataset(Connection, "sp_thongke_tongdonhang");
    }

    public DataSet DonChoDuyet()
    {
        return SqlDataAccess.ExecuteDataset(Connection, "sp_tk_don_cho_duyet");
    }

    public DataSet TongKhachHang()
    {
        return SqlDataAccess.ExecuteDataset(Connection, "sp_tk_tong_khachhang");
    }

public DAO_THONG_KE()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}