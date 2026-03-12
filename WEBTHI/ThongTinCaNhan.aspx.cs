using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ThongTinCaNhan : System.Web.UI.Page
{
    DAO_KHACH_HANG dao = new DAO_KHACH_HANG();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UID_TenDN"] == null)
        {
            Response.Redirect("Login.aspx");
            return;
        }

        if (!IsPostBack)
        {
            LoadThongTin();
        }
    }

    void LoadThongTin()
    {
        string tenDN = Session["UID_TenDN"].ToString();
        DataTable dt = dao.LayThongTinTheoTenDN(tenDN);

        if (dt != null && dt.Rows.Count > 0)
        {
            DataRow r = dt.Rows[0];
            txtTenDN.Text = r["TenDN"].ToString();
            txtHoTen.Text = r["HoTen"].ToString();
            txtSDT.Text = r["SDT"].ToString();
            // Đã xóa phần load DiaChi

            ViewState["ID_USER"] = r["ID_TaiKhoan"].ToString();
            ViewState["OLD_PASS"] = r["MatKhau"].ToString();
        }
    }

    protected void btnCapNhat_Click(object sender, EventArgs e)
    {
        BatCheDoSua(true);
    }

    protected void btnHuy_Click(object sender, EventArgs e)
    {
        BatCheDoSua(false);
        LoadThongTin();
    }

    protected void btnLuu_Click(object sender, EventArgs e)
    {
        try
        {
            int id = int.Parse(ViewState["ID_USER"].ToString());
            string oldPass = ViewState["OLD_PASS"].ToString();
            string tenDN = txtTenDN.Text;
            string hoTen = txtHoTen.Text;
            string sdt = txtSDT.Text;

            // Gọi hàm sửa mới (Không cần truyền địa chỉ nữa)
            dao.KhachSuaThongTin(id, tenDN, oldPass, hoTen, sdt);

            Response.Write("<script>alert('Cập nhật thông tin thành công!');</script>");

            BatCheDoSua(false);
            LoadThongTin();
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('Lỗi: " + ex.Message + "');</script>");
        }
    }

    void BatCheDoSua(bool choPhep)
    {
        txtTenDN.Enabled = false;
        txtHoTen.Enabled = choPhep;
        txtSDT.Enabled = choPhep;

        btnCapNhat.Visible = !choPhep;
        btnLuu.Visible = choPhep;
        btnHuy.Visible = choPhep;
    }
}