using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ThemDanhMuc : System.Web.UI.Page
{
    DAO_DANH_MUC DAO_DANH_MUC = new DAO_DANH_MUC();
    protected void btnLuu_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrWhiteSpace(txtTen.Text))
        {
            lbThongBao.Text = "Chưa nhập tên danh mục!";
            lbThongBao.ForeColor = System.Drawing.Color.Red;
            return;
        }

        try
        {
            DAO_DANH_MUC.danhmuc_them(txtTen.Text.Trim());

            Response.Redirect("QUANLYDANHMUC.aspx");
        }
        catch (Exception ex)
        {
            lbThongBao.Text = "Lỗi: " + ex.Message;
            lbThongBao.ForeColor = System.Drawing.Color.Red;
        }
    }

}