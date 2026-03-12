using System;
using System.Data;
using System.Web.UI;

public partial class DatHang : System.Web.UI.Page
{
    DAO_DON_HANG dao = new DAO_DON_HANG();

    protected void Page_Load(object sender, EventArgs e)
    {
        // 1. BẮT BUỘC ĐĂNG NHẬP
        // Kiểm tra Session tên đăng nhập. Nếu chưa có thì đẩy về trang Login
        if (Session["UID_TenDN"] == null)
        {
            Response.Redirect("Login.aspx?ReturnUrl=DatHang.aspx");
            return;
        }

        if (!IsPostBack)
        {
            LoadDonHang();

            // Tự động điền tên từ Session nếu đã đăng nhập thành công
            txtTen.Text = Session["UID_TenDN"].ToString();

            // muốn lưu gmail hoặc SĐT trong Session lúc Login thì điền thêm:
            // if (Session["UID_Email"] != null) txtEmail.Text = Session["UID_Email"].ToString();
        }
    }

    void LoadDonHang()
    {
        if (Session["GIOHANG"] == null) { Response.Redirect("GioHang.aspx"); return; }

        DataSet ds = (DataSet)Session["GIOHANG"];
        if (ds == null || ds.Tables[0].Rows.Count == 0) { Response.Redirect("GioHang.aspx"); return; }

        rptDonHang.DataSource = ds.Tables[0];
        rptDonHang.DataBind();

        decimal tong = 0;
        foreach (DataRow r in ds.Tables[0].Rows)
            tong += Convert.ToDecimal(r["Gia"]) * Convert.ToInt32(r["SoLuong"]);

        lbTamTinh.Text = tong.ToString("N0") + " đ";
        lbTong.Text = tong.ToString("N0") + " đ";
    }

    protected void btnDatHang_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["UID_TenDN"] == null) { Response.Redirect("Login.aspx"); return; }

            if (txtTen.Text == "" || txtDiaChi.Text == "" || txtSDT.Text == "")
            {
                Response.Write("<script>alert('Vui lòng nhập đầy đủ Tên, Địa chỉ và SĐT!');</script>");
                return;
            }

            if (Session["GIOHANG"] == null) return;
            DataTable dt = ((DataSet)Session["GIOHANG"]).Tables[0];

            // Tính tổng tiền
            decimal tongTien = 0;
            foreach (DataRow r in dt.Rows)
                tongTien += Convert.ToDecimal(r["Gia"]) * Convert.ToInt32(r["SoLuong"]);

 
            // đảm bảo lúc đăng nhập (Login.aspx.cs) có lưu Session["UID_ID"]
            object idTaiKhoan = DBNull.Value;
            if (Session["UID_ID"] != null)
            {
                idTaiKhoan = Convert.ToInt32(Session["UID_ID"]);
            }

            // LƯU ĐƠN HÀNG
            int idDonHangMoi = dao.ThemDonHang(
                tongTien,
                txtTen.Text,
                txtDiaChi.Text,
                txtSDT.Text,
                txtEmail.Text,
                txtGhiChu.Text,
                idTaiKhoan      
            );

            if (idDonHangMoi > 0)
            {
                // LƯU CHI TIẾT
                foreach (DataRow r in dt.Rows)
                {
                    dao.ThemChiTiet(
                        idDonHangMoi,
                        Convert.ToInt32(r["ID_SanPham"]),
                        Convert.ToInt32(r["SoLuong"]),
                        Convert.ToDecimal(r["Gia"])
                    );
                }

                // XÓA GIỎ 
                Session["GIOHANG"] = null;
                Response.Write("<script>alert('Đặt hàng thành công!');window.location='TrangChu.aspx';</script>");
            }
            else
            {
                Response.Write("<script>alert('Lỗi: Không tạo được đơn hàng!');</script>");
            }
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('CÓ LỖI XẢY RA: " + ex.Message + "');</script>");
        }
    }
}