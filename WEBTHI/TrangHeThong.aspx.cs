using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TrangHeThong : System.Web.UI.Page
{
    DAO_THONG_KE DAO_THONG_KE = new DAO_THONG_KE();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // === ẨN CÁC Ô NẾU LÀ NHÂN VIÊN ===
            if (Session["UID_Quyen"] != null && Session["UID_Quyen"].ToString() == "2")
            {
                // Quyền 2 = Nhân viên -> Ẩn Danh mục, Loại, Khách hàng
                boxDanhMuc.Visible = false;
                boxLoaiSP.Visible = false;
                boxKhachHang.Visible = false;
            }
            // ===================================================

            LoadThongKe();
        }
    }

    void LoadThongKe()
    {
        lbDanhMuc.Text = DAO_THONG_KE.TongDanhMuc().Tables[0].Rows[0][0].ToString();
        lbLoaiSP.Text = DAO_THONG_KE.TongLoaiSanPham().Tables[0].Rows[0][0].ToString();
        lbSanPham.Text = DAO_THONG_KE.TongSanPham().Tables[0].Rows[0][0].ToString();
        lbDonHang.Text = DAO_THONG_KE.TongDonHang().Tables[0].Rows[0][0].ToString();
        lbChoDuyet.Text = DAO_THONG_KE.DonChoDuyet().Tables[0].Rows[0][0].ToString();
        lbKhachHang.Text = DAO_THONG_KE.TongKhachHang().Tables[0].Rows[0][0].ToString();
    }
}