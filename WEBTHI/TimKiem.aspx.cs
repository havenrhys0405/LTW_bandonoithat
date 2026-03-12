using System;
using System.Data;
using System.Web.UI;

public partial class TimKiem : System.Web.UI.Page
{
    DAO_SAN_PHAM dao = new DAO_SAN_PHAM();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Lấy từ khóa từ URL 
            string tuKhoa = Request.QueryString["q"];

            if (!string.IsNullOrEmpty(tuKhoa))
            {
                lbTuKhoa.Text = tuKhoa;
                TimKiemSanPham(tuKhoa);
            }
            else
            {
                lbTuKhoa.Text = "---";
                lbKhongThay.Visible = true;
                lbKhongThay.Text = "Bạn chưa nhập từ khóa tìm kiếm.";
            }
        }
    }

    void TimKiemSanPham(string keyword)
    {
        DataSet ds = dao.sanpham_timkiem(keyword);
     
        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
        {
          
            rptKetQua.DataSource = ds.Tables[0];
            rptKetQua.DataBind();

           
            lbKhongThay.Visible = false;
        }
        else
        {           
            rptKetQua.DataSource = null;
            rptKetQua.DataBind();

            lbKhongThay.Visible = true;
            lbKhongThay.Text = "Không tìm thấy sản phẩm nào phù hợp với từ khóa: " + keyword;
        }
    }
}