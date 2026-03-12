using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DataAccess;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for DAO_DANH_MUC
/// </summary>
public class DAO_DANH_MUC : BASE
{
    //danh muc//
    public DataSet danhmuc_all()
    {
        return SqlDataAccess.ExecuteDataset(Connection, "sp_dm_all", null);
    }
    public DataSet danhmuc_id(int id)
    {
        return SqlDataAccess.ExecuteDataset(
            Connection,
            "sp_dm_id",
            id
        );
    }
    public void danhmuc_them(string tendanhmuc)
    {
        SqlDataAccess.ExecuteNonQuery(Connection, "sp_dm_them", tendanhmuc);
    }
    public void danhmuc_sua(int iddanhmuc, string tendanhmuc)
    {
        SqlDataAccess.ExecuteNonQuery(Connection, "sp_dm_sua", iddanhmuc, tendanhmuc);
    }
    public void danhmuc_xoa(int iddanhmuc)
    {
        SqlDataAccess.ExecuteNonQuery(Connection, "sp_dm_xoa", iddanhmuc);
    }

    //loaisanpham//
    public DataSet loai_all()
    {
        return SqlDataAccess.ExecuteDataset(Connection, "sp_loai_all", null);
    }
    public DataSet loai_id(int idloai)
    {
        return SqlDataAccess.ExecuteDataset(Connection, "sp_loai_id", idloai);
    }

   
    public DataSet loai_theodanhmuc(int iddanhmuc)
    {
        return SqlDataAccess.ExecuteDataset(Connection, "sp_loai_theo_dm", iddanhmuc);
    }

    public void loai_them(string tenloai, string anhloai, int iddanhmuc)
    {
        SqlDataAccess.ExecuteNonQuery(Connection, "sp_loai_them", tenloai, anhloai, iddanhmuc);
    }

  
    public void loai_sua(int idloai, string tenloai, string anhloai, int iddanhmuc)
    {
        SqlDataAccess.ExecuteNonQuery(Connection, "sp_loai_sua", idloai, tenloai, anhloai, iddanhmuc);
    }

    public void loai_xoa(int idloai)
    {
        SqlDataAccess.ExecuteNonQuery(Connection, "sp_loai_xoa", idloai);
    }
    public DataSet loai_breadcrumb(int idLoai)
    {
        return SqlDataAccess.ExecuteDataset(Connection, "sp_loai_breadcrumb", idLoai);
    }

    public DAO_DANH_MUC()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}