using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class QUANLYNHANVIEN : System.Web.UI.Page
{
    DAO_KHACH_HANG dao = new DAO_KHACH_HANG();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            LoadNhanVien();
    }

    void LoadNhanVien()
    {
        DataSet ds = dao.tk_all();

        if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
        {
            DataView dv = ds.Tables[0].DefaultView;

            dv.RowFilter = "ID_Quyen = 2";

            grvNhanVien.DataSource = dv;
            grvNhanVien.DataBind();
        }
    }

   
    protected void grvNhanVien_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DoiTrangThai")
        {
   
            string[] args = e.CommandArgument.ToString().Split('|');

            int idTaiKhoan = int.Parse(args[0]);
            string trangThaiString = args[1];

      
            bool trangThaiCu = false;
            if (!string.IsNullOrEmpty(trangThaiString))
            {
                trangThaiCu = Convert.ToBoolean(trangThaiString);
            }

            bool trangThaiMoi = !trangThaiCu;

            
            dao.KhachHang_DoiTrangThai(idTaiKhoan, trangThaiMoi);

            LoadNhanVien();
        }
    }
}