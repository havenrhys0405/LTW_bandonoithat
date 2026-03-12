using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TrangChu : System.Web.UI.Page
{
    DAO_SAN_PHAM DAO_SAN_PHAM = new DAO_SAN_PHAM();
    DAO_DANH_MUC DAO_DANH_MUC = new DAO_DANH_MUC();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadNoiBat();
            LoadDanhMuc();
        }
    }

    void LoadNoiBat()
    {
        DataSet ds = DAO_SAN_PHAM.sanpham_noibat();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            rptNoiBat.DataSource = ds.Tables[0];
            rptNoiBat.DataBind();
        }
    }

    void LoadDanhMuc()
    {
        DataSet ds = DAO_DANH_MUC.danhmuc_all();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            rptDanhMuc.DataSource = ds.Tables[0];
            rptDanhMuc.DataBind();
        }
    }

    // === XỬ LÝ SỰ KIỆN THÊM GIỎ HÀNG ===
    protected void rptNoiBat_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "addcart")
        {
            // 1. Lấy ID sản phẩm
            int idSP;
            if (!int.TryParse(e.CommandArgument.ToString(), out idSP)) return;

            // 2. Lấy thông tin sản phẩm từ CSDL
            DataSet dsSP = DAO_SAN_PHAM.sanpham_id(idSP);
            if (dsSP == null || dsSP.Tables[0].Rows.Count == 0) return;

            // 3. Xử lý GIOHANG 
            DataSet dsCart;
            DataTable dtCart;

            if (Session["GIOHANG"] == null)
            {
                dsCart = new DataSet();
                dtCart = new DataTable("GioHang");
                dtCart.Columns.Add("ID_SanPham", typeof(int));
                dtCart.Columns.Add("TenSanPham", typeof(string));
                dtCart.Columns.Add("Gia", typeof(decimal));
                dtCart.Columns.Add("Anh", typeof(string));
                dtCart.Columns.Add("SoLuong", typeof(int));
                dsCart.Tables.Add(dtCart);
            }
            else
            {
                dsCart = (DataSet)Session["GIOHANG"];
                dtCart = dsCart.Tables["GioHang"];
            }

            // Kiểm tra sản phẩm đã có hay 0 
            DataRow[] rows = dtCart.Select("ID_SanPham=" + idSP);
            if (rows.Length > 0)
            {
                rows[0]["SoLuong"] = Convert.ToInt32(rows[0]["SoLuong"]) + 1;
            }
            else
            {
                DataRow r = dtCart.NewRow();
                r["ID_SanPham"] = idSP;
                r["TenSanPham"] = dsSP.Tables[0].Rows[0]["TenSanPham"];
                r["Gia"] = dsSP.Tables[0].Rows[0]["Gia"];
                r["Anh"] = dsSP.Tables[0].Rows[0]["Anh"];
                r["SoLuong"] = 1;
                dtCart.Rows.Add(r);
            }

            // Lưu lại Session
            Session["GIOHANG"] = dsCart;

            // Reload lại trang -> cập nhật số lượng trên gio hang
            Response.Redirect(Request.RawUrl);
        }
    }

    protected void rptDanhMuc_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView drv = (DataRowView)e.Item.DataItem;
            int idDanhMuc = Convert.ToInt32(drv["ID_DanhMuc"]);

            Repeater rptLoai = (Repeater)e.Item.FindControl("rptLoai");

            if (rptLoai != null)
            {
                DataSet dsLoai = DAO_DANH_MUC.loai_theodanhmuc(idDanhMuc);
                if (dsLoai != null && dsLoai.Tables[0].Rows.Count > 0)
                {
                    rptLoai.DataSource = dsLoai.Tables[0];
                    rptLoai.DataBind();
                }
            }
        }
    }
}