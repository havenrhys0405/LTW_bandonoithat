using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class masterfrontend : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            CheckLogin();
            LoadDanhMuc();
        }

        // Load lại giỏ hàng mỗi lần load để cập nhật số lượng
        LoadGioHang();
    }

    void LoadDanhMuc()
    {
        DAO_SAN_PHAM dao = new DAO_SAN_PHAM();
        rptDanhMuc.DataSource = dao.LayDanhMuc();
        rptDanhMuc.DataBind();
    }

    protected void rptDanhMuc_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            int idDanhMuc = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "ID_DanhMuc"));
            Repeater rptCon = (Repeater)e.Item.FindControl("rptMenuCon");

            if (rptCon != null)
            {
                DAO_SAN_PHAM dao = new DAO_SAN_PHAM();
                rptCon.DataSource = dao.LayLoaiTheoDanhMuc(idDanhMuc);
                rptCon.DataBind();
            }
        }
    }

    void CheckLogin()
    {
        if (Session["UID_TenDN"] != null)
        {
            pnlChuaDangNhap.Visible = false;
            pnlDaDangNhap.Visible = true;
            // tên user ở trang chủ 
            lbTenUser.Text = Session["UID_TenDN"].ToString();
        }
        else
        {
            pnlChuaDangNhap.Visible = true;
            pnlDaDangNhap.Visible = false;
        }
    }

    protected void btnDangXuat_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Session.Clear();
        Session.RemoveAll();
        Response.Redirect("TrangChu.aspx");
    }

    void LoadGioHang()
    {
        if (Session["GIOHANG"] != null)
        {
            DataSet ds = (DataSet)Session["GIOHANG"];
            if (ds != null && ds.Tables.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                int tongSoLuong = 0;
                foreach (DataRow r in dt.Rows)
                {
                    tongSoLuong += Convert.ToInt32(r["SoLuong"]);
                }
                lbSoLuongGio.Text = tongSoLuong.ToString();
            }
        }
        else
        {
            lbSoLuongGio.Text = "0";
        }
    }

    protected void timerThongBao_Tick(object sender, EventArgs e)
    {
        Panel1.Visible = false;
        timerThongBao.Enabled = false;
    }

    protected void btnTim_Click(object sender, EventArgs e)
    {
        string keyword = txtTim.Text.Trim();
        if (!string.IsNullOrEmpty(keyword))
        {
            Response.Redirect("TimKiem.aspx?q=" + Server.UrlEncode(keyword));
        }
    }
}