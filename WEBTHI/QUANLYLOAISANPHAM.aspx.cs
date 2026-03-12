using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class QUANLYLOAISANPHAM : System.Web.UI.Page
{
    DAO_DANH_MUC DAO_DANH_MUC=new DAO_DANH_MUC();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDanhMuc();
            LoadLoaiTatCa();
        }
    }

    void LoadDanhMuc()
    {
        DataSet ds = DAO_DANH_MUC.danhmuc_all();
        ddlDanhMuc.DataSource = ds.Tables[0];
        ddlDanhMuc.DataTextField = "TenDanhMuc";
        ddlDanhMuc.DataValueField = "ID_DanhMuc";
        ddlDanhMuc.DataBind();

        ddlDanhMuc.Items.Insert(0,
            new System.Web.UI.WebControls.ListItem("-- Tất cả --", "0"));
    }

    void LoadLoaiTatCa()
    {
        DataSet ds = DAO_DANH_MUC.loai_all();
        grvLoai.DataSource = ds.Tables[0];
        grvLoai.DataBind();
    }

    void LoadLoaiTheoDanhMuc(int idDanhMuc)
    {
        DataSet ds = DAO_DANH_MUC.loai_theodanhmuc(idDanhMuc);
        grvLoai.DataSource = ds.Tables[0];
        grvLoai.DataBind();
    }


    protected void ddlDanhMuc_SelectedIndexChanged(object sender, EventArgs e)
    {
        int id = int.Parse(ddlDanhMuc.SelectedValue);
        if (id == 0)
            LoadLoaiTatCa();
        else
            LoadLoaiTheoDanhMuc(id);
    }

    protected void grvLoai_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
    {
        int id = Convert.ToInt32(grvLoai.DataKeys[e.NewEditIndex].Value);
        Response.Redirect("SuaLoaiSanPham.aspx?id=" + id);
    }

    protected void grvLoai_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
    {
        int id = Convert.ToInt32(grvLoai.DataKeys[e.RowIndex].Value);
        DAO_DANH_MUC.loai_xoa(id);
        LoadLoaiTatCa();
    }
}