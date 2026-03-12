using System;
using System.Data;
using System.Web;
using System.Web.UI;

public partial class Login : System.Web.UI.Page
{
    DAO_KHACH_HANG dao = new DAO_KHACH_HANG();

    protected void Page_Load(object sender, EventArgs e)
    {
        // Nếu đã đăng nhập thì về trang chủ
        if (Session["UID_TenDN"] != null)
        {
            if (Session["UID_Quyen"].ToString() == "1") Response.Redirect("QUANLYSANPHAM.aspx");
            else Response.Redirect("TrangChu.aspx");
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string ten = txt_TenDN.Text.Trim();
        string mk = txt_matkhau.Text.Trim();

        if (ten == "" || mk == "")
        {
            lbThongBao.Text = "Vui lòng nhập đủ thông tin!";
            return;
        }

        DataSet ds = dao.dangnhap(ten, mk);
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            DataRow r = ds.Tables[0].Rows[0];

            // 1. LƯU SESSION
            Session["UID_TenDN"] = r["TenDN"].ToString();
            Session["UID_Quyen"] = r["ID_Quyen"].ToString();

            // 2. PHÂN QUYỀN
            string quyen = r["ID_Quyen"].ToString();

            if (quyen == "1")
            {
                // ADMIN (Quyền 1) -> Vào thẳng trang Quản Lý Sản Phẩm
                Response.Redirect("QUANLYSANPHAM.aspx");
            }
            else if (quyen == "2")
            {
                // NHÂN VIÊN (Quyền 2) -> Cũng cho vào quản lý
                Response.Redirect("QUANLYSANPHAM.aspx");
            }
            else
            {
                // KHÁCH HÀNG (Quyền 3) -> Về trang chủ mua hàng
                Response.Redirect("TrangChu.aspx");
            }
        }
        else
        {
            lbThongBao.Text = "Tên đăng nhập hoặc mật khẩu không đúng!";
        }
    }
}