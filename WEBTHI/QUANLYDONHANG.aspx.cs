using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class QUANLYDONHANG : System.Web.UI.Page
{
    DAO_DON_HANG dao = new DAO_DON_HANG();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UID_TenDN"] == null)
        {
            Response.Redirect("Login.aspx");
            return;
        }

        if (!IsPostBack)
        {
            LoadDonHang();
        }
    }

    void LoadDonHang()
    {
        DataSet ds = dao.DonHang_All();
        if (ds != null && ds.Tables.Count > 0)
        {
            grvDonHang.DataSource = ds.Tables[0];
            grvDonHang.DataBind();
        }
        else
        {
            grvDonHang.DataSource = new DataTable();
            grvDonHang.DataBind();
        }
    }

    protected void grvDonHang_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Sort" || e.CommandName == "Page") return;

        int id = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "xem")
        {
            Response.Redirect("ChiTietDonHang.aspx?id=" + id);
        }
        else if (e.CommandName == "duyet")
        {
            dao.DonHang_Duyet(id, 1);
            LoadDonHang();
        }
        else if (e.CommandName == "huy")
        {
            dao.DonHang_Huy(id, 2);
            LoadDonHang();
        }
    }
}