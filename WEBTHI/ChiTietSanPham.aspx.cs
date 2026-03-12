using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ChiTietSanPham : System.Web.UI.Page
{
    DAO_DANH_MUC DAO_DANH_MUC = new DAO_DANH_MUC();
    DAO_SAN_PHAM DAO_SAN_PHAM = new DAO_SAN_PHAM();
    int idSanPham = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["id"] == null) return;

        if (!int.TryParse(Request["id"], out idSanPham)) return;

        if (!IsPostBack)
        {
            lbSoLuong.Text = "1";
            LoadSP();
        }
    }

    void LoadSP()
    {
        DataSet ds = DAO_SAN_PHAM.sanpham_id(idSanPham);
        if (ds == null || ds.Tables[0].Rows.Count == 0) return;

        DataRow r = ds.Tables[0].Rows[0];

        lbTenSP.Text = r["TenSanPham"].ToString();

        
        string tenAnh = r["Anh"].ToString();
        imgSP.ImageUrl = "~/AnhSP/" + tenAnh;

        ltMoTa.Text = r["MoTa"] == DBNull.Value ? "Đang cập nhật nội dung..." : r["MoTa"].ToString();

        decimal gia = 0;
        if (r["Gia"] != DBNull.Value)
        {
            gia = Convert.ToDecimal(r["Gia"]);
        }
        lbGia.Text = gia.ToString("N0") + " đ";

        // ===============================================
        // XỬ LÝ TRẠNG THÁI (Còn hàng / Hết hàng)
        // ===============================================
        bool dangKinhDoanh = false;
        if (r["TrangThai"] != DBNull.Value)
        {
            dangKinhDoanh = Convert.ToBoolean(r["TrangThai"]);
        }

        int soLuongTon = 0;
        if (r["SoLuong"] != DBNull.Value)
        {
            soLuongTon = Convert.ToInt32(r["SoLuong"]);
        }

        if (dangKinhDoanh == false)
        {
            // Trường hợp: Ngừng kinh doanh
            lbTrangThai.Text = "⛔ Ngừng kinh doanh";
            lbTrangThai.CssClass = "ngung-kinh-doanh";

            // Khóa nút
            btnThemGio.Enabled = false;
            btnThemGio.Text = "NGỪNG KINH DOANH";
            btnThemGio.CssClass = "btn-cart btn-disabled";
        }
        else
        {
            // Trường hợp: Đang kinh doanh -> Xét số lượng
            if (soLuongTon > 0)
            {
                lbTrangThai.Text = "Còn hàng";
                lbTrangThai.CssClass = "con-hang";

                // Mở nút
                btnThemGio.Enabled = true;
                btnThemGio.Text = "🛒 THÊM VÀO GIỎ HÀNG";
                btnThemGio.CssClass = "btn-cart";
            }
            else
            {
                lbTrangThai.Text = "Tạm hết hàng";
                lbTrangThai.CssClass = "het-hang";

                // Khóa nút
                btnThemGio.Enabled = false;
                btnThemGio.Text = "TẠM HẾT HÀNG";
                btnThemGio.CssClass = "btn-cart btn-disabled";
            }
        }
        // ===============================================

        if (r["ID_Loai"] != DBNull.Value)
        {
            int idLoai = Convert.ToInt32(r["ID_Loai"]);
            DataSet dsLoai = DAO_DANH_MUC.loai_id(idLoai);
            if (dsLoai != null && dsLoai.Tables[0].Rows.Count > 0)
            {
                lbLoai.Text = dsLoai.Tables[0].Rows[0]["TenLoai"].ToString();
                LoadSanPhamLienQuan(idLoai);
            }
        }
    }

    void LoadSanPhamLienQuan(int idLoai)
    {
        DataSet dsLienQuan = DAO_SAN_PHAM.SanPham_LienQuan(idLoai, idSanPham);
        if (dsLienQuan != null && dsLienQuan.Tables[0].Rows.Count > 0)
        {
            pnlLienQuan.Visible = true;
            rptLienQuan.DataSource = dsLienQuan.Tables[0];
            rptLienQuan.DataBind();
        }
        else
        {
            pnlLienQuan.Visible = false;
        }
    }

    protected void Cong_Click(object sender, EventArgs e)
    {
        lbSoLuong.Text = (int.Parse(lbSoLuong.Text) + 1).ToString();
    }

    protected void Tru_Click(object sender, EventArgs e)
    {
        int sl = int.Parse(lbSoLuong.Text);
        if (sl > 1) lbSoLuong.Text = (sl - 1).ToString();
    }

    protected void ThemGioHangMoi_Click(object sender, EventArgs e)
    {
        int soLuong = int.Parse(lbSoLuong.Text);
        DataSet dsSP = DAO_SAN_PHAM.sanpham_id(idSanPham);
        if (dsSP == null || dsSP.Tables[0].Rows.Count == 0) return;

        DataRow sp = dsSP.Tables[0].Rows[0];
        DataSet dsCart;
        DataTable dt;

        if (Session["GIOHANG"] == null)
        {
            dsCart = new DataSet();
            dt = new DataTable("GioHang");
            dt.Columns.Add("ID_SanPham", typeof(int));
            dt.Columns.Add("TenSanPham");
            dt.Columns.Add("Gia", typeof(decimal));
            dt.Columns.Add("Anh");
            dt.Columns.Add("SoLuong", typeof(int));
            dsCart.Tables.Add(dt);
        }
        else
        {
            dsCart = (DataSet)Session["GIOHANG"];
            dt = dsCart.Tables[0];
        }

        DataRow[] rows = dt.Select("ID_SanPham=" + idSanPham);
        if (rows.Length > 0)
        {
            rows[0]["SoLuong"] = Convert.ToInt32(rows[0]["SoLuong"]) + soLuong;
        }
        else
        {
            DataRow r = dt.NewRow();
            r["ID_SanPham"] = idSanPham;
            r["TenSanPham"] = sp["TenSanPham"];
            r["Gia"] = sp["Gia"] == DBNull.Value ? 0 : sp["Gia"];
            r["Anh"] = sp["Anh"];
            r["SoLuong"] = soLuong;
            dt.Rows.Add(r);
        }

        Session["GIOHANG"] = dsCart;
        Response.Redirect("GioHang.aspx");
    }
}