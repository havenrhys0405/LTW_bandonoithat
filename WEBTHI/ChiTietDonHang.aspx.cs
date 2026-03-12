using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class ChiTietDonHang : System.Web.UI.Page
{
    DAO_DON_HANG DAO_DON_HANG = new DAO_DON_HANG();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadChiTiet();
        }
    }

    void LoadChiTiet()
    {
        if (Request.QueryString["id"] == null) return;

        int id = Convert.ToInt32(Request.QueryString["id"]);

        DataSet dsDon = DAO_DON_HANG.DonHang_ID(id);

        if (dsDon.Tables[0].Rows.Count > 0)
        {
            DataRow r = dsDon.Tables[0].Rows[0];

            // --- CÁC CỘT CƠ BẢN ---
            lbMaDon.Text = r["ID_DonHang"].ToString();
            lbNgay.Text = Convert.ToDateTime(r["NgayDat"]).ToString("dd/MM/yyyy HH:mm");

  
            if (dsDon.Tables[0].Columns.Contains("TenNguoiNhan"))
                lbKhach.Text = r["TenNguoiNhan"].ToString();

            if (dsDon.Tables[0].Columns.Contains("DiaChi") && r["DiaChi"] != DBNull.Value)
            {
                lbDiaChi.Text = r["DiaChi"].ToString();
            }
            else
            {
                lbDiaChi.Text = "Không có địa chỉ";
            }

         
            if (dsDon.Tables[0].Columns.Contains("SDT") && r["SDT"] != DBNull.Value)
            {
                lbSDT.Text = r["SDT"].ToString();
            }
            // ------------------------------------------------

            int tt = Convert.ToInt32(r["TrangThai"]);
            lbTrangThai.Text = tt == 0 ? "Chờ duyệt" : tt == 1 ? "Đã duyệt" : "Đã hủy";

         
            if (tt == 0) lbTrangThai.ForeColor = System.Drawing.Color.Orange;
            else if (tt == 1) lbTrangThai.ForeColor = System.Drawing.Color.Green;
            else lbTrangThai.ForeColor = System.Drawing.Color.Red;
        }

        // 2. LẤY SẢN PHẨM TRONG ĐƠN 
        DataSet dsCT = DAO_DON_HANG.CTDH_TheoDon(id);
        grvCTDH.DataSource = dsCT.Tables[0];
        grvCTDH.DataBind();
    }
}