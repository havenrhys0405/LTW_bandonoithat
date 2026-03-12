using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class SanPham : System.Web.UI.Page
{
    DAO_DANH_MUC DAO_DANH_MUC = new DAO_DANH_MUC();
    DAO_SAN_PHAM DAO_SAN_PHAM = new DAO_SAN_PHAM();

    int idDM = 0;
    int idLoai = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        // Lấy ID
        if (Request.QueryString["id"] != null)
            int.TryParse(Request.QueryString["id"], out idDM);

        if (Request.QueryString["idDM"] != null)
            int.TryParse(Request.QueryString["idDM"], out idDM);

        if (Request.QueryString["idLoai"] != null)
            int.TryParse(Request.QueryString["idLoai"], out idLoai);


        if (idDM == 0 && idLoai > 0)
        {
            DataSet ds = DAO_DANH_MUC.loai_id(idLoai);
            if (ds != null && ds.Tables[0].Rows.Count > 0)
                idDM = Convert.ToInt32(ds.Tables[0].Rows[0]["ID_DanhMuc"]);
        }

        if (!IsPostBack)
        {
            LoadDanhMuc();
            LoadSanPham();
        }
    }

    void LoadDanhMuc()
    {
        if (idDM > 0)
        {
            DataSet dsDM = DAO_DANH_MUC.danhmuc_id(idDM);
            if (dsDM != null && dsDM.Tables[0].Rows.Count > 0)
            {
                lbDanhMuc.Text = dsDM.Tables[0].Rows[0]["TenDanhMuc"].ToString();
                lbLoai.Text = "Tất cả sản phẩm";
            }
        }

        if (idLoai > 0)
        {
            DataSet dsLoai = DAO_DANH_MUC.loai_id(idLoai);
            if (dsLoai != null && dsLoai.Tables[0].Rows.Count > 0)
                lbLoai.Text = dsLoai.Tables[0].Rows[0]["TenLoai"].ToString();
        }

        if (idDM == 0 && idLoai == 0)
        {
            lbDanhMuc.Text = "Sản phẩm";
            lbLoai.Text = "Tất cả";
        }
    }

    void LoadSanPham()
    {
        DataSet dsSP = null;

        if (idLoai > 0)
            dsSP = DAO_SAN_PHAM.sanpham_theoloai(idLoai);
        else if (idDM > 0)
            dsSP = DAO_SAN_PHAM.sanpham_theo_danhmuc(idDM);
        else
            dsSP = DAO_SAN_PHAM.sanpham_all();

        if (dsSP != null && dsSP.Tables.Count > 0)
        {
            rptSanPham.DataSource = dsSP;
            rptSanPham.DataBind();
        }
    }

    protected void rptSanPham_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "addcart")
        {
            // Kiểm tra và lấy ID sản phẩm
            int idSP;
            if (!int.TryParse(e.CommandArgument.ToString(), out idSP)) return;

            // Lấy thông tin sản phẩm từ CSDL
            DataSet dsSP = DAO_SAN_PHAM.sanpham_id(idSP);
            if (dsSP == null || dsSP.Tables[0].Rows.Count == 0) return;

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

            // Kiểm tra xem sản phẩm đã có trong giỏ chưa
            DataRow[] rows = dtCart.Select("ID_SanPham=" + idSP);
            if (rows.Length > 0)
            {
                rows[0]["SoLuong"] = Convert.ToInt32(rows[0]["SoLuong"]) + 1;
            }
            else
            {
                // Chưa có -> Thêm mới
                DataRow r = dtCart.NewRow();
                r["ID_SanPham"] = idSP;
                r["TenSanPham"] = dsSP.Tables[0].Rows[0]["TenSanPham"];
                r["Gia"] = dsSP.Tables[0].Rows[0]["Gia"];
                r["Anh"] = dsSP.Tables[0].Rows[0]["Anh"];
                r["SoLuong"] = 1;
                dtCart.Rows.Add(r);
            }

            // Lưu lại vào Session GIOHANG
            Session["GIOHANG"] = dsCart;

            Response.Redirect(Request.RawUrl);
        }
    }
}