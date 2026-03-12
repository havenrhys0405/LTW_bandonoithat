using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GioHang : System.Web.UI.Page
{
    DAO_SAN_PHAM dao = new DAO_SAN_PHAM();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           
            string idStr = Request.QueryString["id"];
            if (idStr != null)
            {
                int id = int.Parse(idStr);
                ThemVaoGio(id);
                
                Response.Redirect("GioHang.aspx");
            }
            else
            {
             
                LoadGioHang();
            }
        }
    }

 
    private void ThemVaoGio(int idSanPham)
    {
        // Lấy thông tin sản phẩm từ DB
        DataSet dsSP = dao.sanpham_id(idSanPham);
        if (dsSP.Tables[0].Rows.Count == 0) return; 

        DataRow sp = dsSP.Tables[0].Rows[0];

        DataSet dsCart;
        DataTable dt;

        // Khởi tạo hoặc lấy giỏ hàng từ cột 
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
        // số lượng sp trong giỏ
        DataRow[] rows = dt.Select("ID_SanPham=" + idSanPham);
        if (rows.Length > 0)
        {
            rows[0]["SoLuong"] = Convert.ToInt32(rows[0]["SoLuong"]) + 1;
        }
        else
        {
          
            DataRow r = dt.NewRow();
            r["ID_SanPham"] = idSanPham;
            r["TenSanPham"] = sp["TenSanPham"];
            r["Gia"] = sp["Gia"];
            r["Anh"] = sp["Anh"];
            r["SoLuong"] = 1; 
            dt.Rows.Add(r);
        }

    
        Session["GIOHANG"] = dsCart;
    }


    private void LoadGioHang()
    {
        if (Session["GIOHANG"] != null)
        {
            DataSet ds = (DataSet)Session["GIOHANG"];
            DataTable dt = ds.Tables[0];

            if (dt.Rows.Count > 0)
            {
                pnlCoSP.Visible = true;
                pnlTrong.Visible = false;
                rptGioHang.DataSource = dt;
                rptGioHang.DataBind();
                TinhTongTien(dt);
            }
            else
            {
                HienThiGioTrong();
            }
        }
        else
        {
            HienThiGioTrong();
        }
    }


    private void HienThiGioTrong()
    {
        pnlCoSP.Visible = false;
        pnlTrong.Visible = true;
    }


    private void TinhTongTien(DataTable dt)
    {
        decimal tong = 0;
        foreach (DataRow r in dt.Rows)
        {
            tong += Convert.ToDecimal(r["Gia"]) * Convert.ToInt32(r["SoLuong"]);
        }
        lbTamTinh.Text = tong.ToString("N0") + " đ";
        lbTong.Text = tong.ToString("N0") + " đ";
    }


    protected void rptGioHang_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int idSanPham = Convert.ToInt32(e.CommandArgument);
        DataSet ds = (DataSet)Session["GIOHANG"];
        DataTable dt = ds.Tables[0];
        DataRow row = null;

        // Tìm dòng sản phẩm cần xử lý
        foreach (DataRow r in dt.Rows)
        {
            if (Convert.ToInt32(r["ID_SanPham"]) == idSanPham)
            {
                row = r; break;
            }
        }

        if (row != null)
        {
            string cmd = e.CommandName;

            if (cmd == "remove")
            {
                row.Delete(); 
            }
            else if (cmd == "plus")
            {
                row["SoLuong"] = Convert.ToInt32(row["SoLuong"]) + 1;
            }
            else if (cmd == "minus")
            {
                int sl = Convert.ToInt32(row["SoLuong"]);
                if (sl > 1)
                    row["SoLuong"] = sl - 1;
                else
                    row.Delete(); 
            }
            dt.AcceptChanges(); 
            Session["GIOHANG"] = ds; 

            Response.Redirect(Request.RawUrl);
        }
    }


    protected void btnThanhToan_Click(object sender, EventArgs e)
    {
        Response.Redirect("DatHang.aspx");
    }
}