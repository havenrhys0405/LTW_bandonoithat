using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DangKy : System.Web.UI.Page
{
   
    DAO_KHACH_HANG dao = new DAO_KHACH_HANG();

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnDangKy_Click(object sender, EventArgs e)
    {
        
        if (txtUsername.Text == "" || txtHoTen.Text == "" ||
            txtSDT.Text == "" || txtMatKhau.Text == "")
        {
            lbThongBao.Text = "Vui lòng nhập đầy đủ thông tin";
            return;
        }

        try
        {
            
            dao.DangKyTaiKhoan(txtUsername.Text, txtMatKhau.Text, txtHoTen.Text, txtSDT.Text);

        
            lbThongBao.ForeColor = System.Drawing.Color.Green;
            lbThongBao.Text = "Đăng ký thành công! Bạn có thể đăng nhập ngay.";

            txtUsername.Text = "";
            txtHoTen.Text = "";
            txtSDT.Text = "";
        }
        catch (Exception ex)
        {
          
            lbThongBao.ForeColor = System.Drawing.Color.Red;
            lbThongBao.Text = "Lỗi: " + ex.Message;
        }
    }
}