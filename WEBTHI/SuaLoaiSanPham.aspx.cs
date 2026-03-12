using System;
using System.Collections.Generic;
using System.Data;
using System.IO; 
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SuaLoaiSanPham : System.Web.UI.Page
{
    DAO_DANH_MUC DAO_DANH_MUC = new DAO_DANH_MUC();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDanhMuc();
            HienThiLoai();
        }
    }

    void LoadDanhMuc()
    {
        DataSet ds = DAO_DANH_MUC.danhmuc_all();
        ddlDanhMuc.DataSource = ds;
        ddlDanhMuc.DataTextField = "TenDanhMuc";
        ddlDanhMuc.DataValueField = "ID_DanhMuc";
        ddlDanhMuc.DataBind();
    }

    void HienThiLoai()
    {
        if (Request.QueryString["id"] == null) return;

        int idLoai = Convert.ToInt32(Request.QueryString["id"]);
        DataSet ds = DAO_DANH_MUC.loai_id(idLoai);

        if (ds.Tables[0].Rows.Count > 0)
        {
            DataRow r = ds.Tables[0].Rows[0];

            txtTenLoai.Text = r["TenLoai"].ToString();

            
            string tenAnh = r["AnhLoai"].ToString();
            if (!string.IsNullOrEmpty(tenAnh))
            {
                // Xử lý TH DB lưu đường dẫn cũ
                if (tenAnh.StartsWith("AnhLoai/") || tenAnh.StartsWith("anhloai/"))
                {
                    imgAnhCu.ImageUrl = "~/" + tenAnh;
                }
                else
                {
                    imgAnhCu.ImageUrl = "~/AnhLoai/" + tenAnh;
                }
            }

            string idDanhMuc = r["ID_DanhMuc"].ToString();
            ddlDanhMuc.SelectedValue = idDanhMuc;
        }
    }

    protected void btnCapNhat_Click(object sender, EventArgs e)
    {
        if (txtTenLoai.Text.Trim() == "")
        {
            lbThongBao.Text = "Tên loại không được để trống";
            return;
        }

        int idLoai = Convert.ToInt32(Request.QueryString["id"]);
        string tenLoai = txtTenLoai.Text.Trim();
        int idDanhMuc = Convert.ToInt32(ddlDanhMuc.SelectedValue);
        string anhloai;

        if (fulAnhMoi.HasFile)
        {
            string folder = Server.MapPath("~/AnhLoai/");

          
            if (!Directory.Exists(folder))
            {
                Directory.CreateDirectory(folder);
            }

            string fileName = DateTime.Now.Ticks + "_" + fulAnhMoi.FileName;

        
            fulAnhMoi.SaveAs(Path.Combine(folder, fileName));
            
            anhloai = fileName;
        }
        else
        {
            if (!string.IsNullOrEmpty(imgAnhCu.ImageUrl))
            {
                anhloai = Path.GetFileName(imgAnhCu.ImageUrl);
            }
            else
            {
                anhloai = ""; 
            }
        }

        DAO_DANH_MUC.loai_sua(idLoai, tenLoai, anhloai, idDanhMuc);

        Response.Redirect("QUANLYLOAISANPHAM.aspx");
    }
}