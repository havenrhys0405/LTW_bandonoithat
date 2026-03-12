using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SuaDanhMuc : System.Web.UI.Page
{
    DAO_DANH_MUC DAO_DANH_MUC = new DAO_DANH_MUC();
    int id;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["id"] == null)
            Response.Redirect("QUANLYDANHMUC.aspx");

        id = Convert.ToInt32(Request.QueryString["id"]);

        if (!IsPostBack)
            LoadDanhMuc();
    }

    void LoadDanhMuc()
    {
        DataSet ds = DAO_DANH_MUC.danhmuc_id(id);
        if (ds.Tables[0].Rows.Count > 0)
        {
            txtTenDanhMuc.Text = ds.Tables[0].Rows[0]["TenDanhMuc"].ToString();
        }
    }

    protected void btnCapNhat_Click(object sender, EventArgs e)
    {
        if (txtTenDanhMuc.Text.Trim() == "")
        {
            lbThongBao.Text = "Tên danh mục không được để trống";
            return;
        }

        DAO_DANH_MUC.danhmuc_sua(id, txtTenDanhMuc.Text.Trim());
        Response.Redirect("QUANLYDANHMUC.aspx");
    }
}