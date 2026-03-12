using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class QUANLYDANHMUC : System.Web.UI.Page
{
    DAO_DANH_MUC dao = new DAO_DANH_MUC();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UID_TenDN"] == null)
        {
            Response.Redirect("Login.aspx");
            return;
        }

        if (!IsPostBack)
        {
            LoadDanhMuc();
            XuLyPhanQuyen();
        }
    }

    void LoadDanhMuc()
    {
        var ds = dao.danhmuc_all();
        if (ds != null && ds.Tables.Count > 0)
        {
            grvDanhMuc.DataSource = ds.Tables[0];
            grvDanhMuc.DataBind();
        }
    }

    void XuLyPhanQuyen()
    {
        if (Session["UID_Quyen"] != null)
        {
            string quyen = Session["UID_Quyen"].ToString();

            if (quyen == "2")
            {
                pnlThem.Visible = false;
                if (grvDanhMuc.Columns.Count > 2)
                {
                    grvDanhMuc.Columns[2].Visible = false;
                }
            }
        }
    }

    protected void grv_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (Session["UID_Quyen"] == null || Session["UID_Quyen"].ToString() != "1")
        {
            Response.Write("<script>alert('Bạn không có quyền sửa!');</script>");
            return;
        }

        int id = Convert.ToInt32(grvDanhMuc.DataKeys[e.NewEditIndex].Value);
        Response.Redirect("SuaDanhMuc.aspx?id=" + id);
    }

    protected void grv_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        if (Session["UID_Quyen"] == null || Session["UID_Quyen"].ToString() != "1")
        {
            Response.Write("<script>alert('Bạn không có quyền xóa!');</script>");
            return;
        }

        try
        {
            int id = Convert.ToInt32(grvDanhMuc.DataKeys[e.RowIndex].Value);
            dao.danhmuc_xoa(id);
            LoadDanhMuc();
        }
        catch (Exception)
        {
            Response.Write("<script>alert('Lỗi khi xóa!');</script>");
        }
    }
}