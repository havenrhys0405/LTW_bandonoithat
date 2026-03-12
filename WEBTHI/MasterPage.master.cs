using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
            if (Session["UID_TenDN"] == null)
            {
     
                Response.Redirect("Login.aspx");
                return;
            }

           
            lblTenDN.Text = Session["UID_TenDN"].ToString();

            phAdminOnly.Visible = false;

            if (Session["UID_Quyen"] != null)
            {
                string quyen = Session["UID_Quyen"].ToString();

                if (quyen == "1") 
                {
                    lblRole.Text = "Quản trị viên";
                    phAdminOnly.Visible = true; 
                }
                else 
                {
                    lblRole.Text = "Nhân viên";
                    phAdminOnly.Visible = false; 
                }
            }
        }
    }

    protected void btnDangXuat_Click(object sender, EventArgs e)
    { 
        Session.Abandon();
        Session.Clear();
        Session.RemoveAll();
        Response.Redirect("Login.aspx");
    }
}