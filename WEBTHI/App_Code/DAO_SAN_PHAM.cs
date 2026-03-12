using DataAccess;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DAO_SAN_PHAM
/// </summary>
public class DAO_SAN_PHAM : BASE
{
    public DataSet sanpham_all()
    {
        return SqlDataAccess.ExecuteDataset(Connection, "sp_sanpham_all", null);
    }
    public DataSet sanpham_noibat()
    {
        return SqlDataAccess.ExecuteDataset(
            Connection,
            "sp_sanpham_noibat"
        );
    }
    public DataSet sanpham_theoloai(int idloai)
    {
        return SqlDataAccess.ExecuteDataset(Connection, "sp_sanpham_theo_loai", idloai);
    }
    public DataSet sanpham_id(int idsanpham)
    {
        return SqlDataAccess.ExecuteDataset(Connection, "sp_sanpham_chitiet", idsanpham);
    }
    public DataSet SanPham_LienQuan(int idLoai, int idSanPham)
    {
        return SqlDataAccess.ExecuteDataset(
            Connection,
            "sp_sanpham_lienquan",
            idLoai,
            idSanPham
        );
    }

    // Tìm kiếm sản phẩm theo từ khóa
    public DataSet sanpham_timkiem(string tuKhoa)
    {
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

        try
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("sp_sanpham_timkiem", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@TuKhoa", tuKhoa);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            return ds;
        }
        catch
        {
            return null;
        }
        finally
        {
            conn.Close();
        }
    }

    public void SanPham_Them(int x, string tensanpham, string anh, decimal gia, int soluong, string mota)
    {
        SqlDataAccess.ExecuteNonQuery(
            Connection,
            "sp_sanpham_them",
            x, tensanpham, anh, gia, soluong, mota
        );
    }
    public void SanPham_Sua(int idsanpham, int idLoai, string tensanpham, string anh, decimal gia, int soluong, string mota)
    {
        SqlDataAccess.ExecuteNonQuery(
            Connection,
            "sp_sanpham_sua",
            idsanpham,
            idLoai,
            tensanpham,
            anh,
            gia,
            soluong,
            mota
        );
    }

    public void SanPham_Xoa(int idsanpham)
    {
        SqlDataAccess.ExecuteNonQuery(
            Connection,
            "sp_sanpham_xoa",
            idsanpham
        );
    }

    /* ========================================================== */
    /* =====CHẠY MENU ĐA CẤP  ===== */
    /* ========================================================== */

  
    public DataTable LayDanhMuc()
    {
        DataSet ds = SqlDataAccess.ExecuteDataset(Connection, "sp_danhmuc_all");

        if (ds != null && ds.Tables.Count > 0)
            return ds.Tables[0];
        return null;
    }

    public DataTable LayLoaiTheoDanhMuc(int idDanhMuc)
    {
        DataSet ds = SqlDataAccess.ExecuteDataset(Connection, "sp_loai_theo_danhmuc", idDanhMuc);

        if (ds != null && ds.Tables.Count > 0)
            return ds.Tables[0];
        return null;
    }

    public DAO_SAN_PHAM()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    // Lấy sản phẩm theo ID Danh Mục 
    public DataSet sanpham_theo_danhmuc(int idDanhMuc)
    {
        return SqlDataAccess.ExecuteDataset(
            Connection,
            "sp_sanpham_theo_danhmuc",
            idDanhMuc
        );
    }

    // Hàm lấy Tên Danh Mục 
    public string LayTenDanhMuc(int idDanhMuc)
    {
        string sql = "SELECT TenDanhMuc FROM DanhMuc WHERE ID_DanhMuc = " + idDanhMuc;
        DataTable dt = SqlDataAccess.ExecuteDataset(Connection, CommandType.Text, sql).Tables[0];
        if (dt.Rows.Count > 0)
            return dt.Rows[0]["TenDanhMuc"].ToString();
        return "";
    }
}