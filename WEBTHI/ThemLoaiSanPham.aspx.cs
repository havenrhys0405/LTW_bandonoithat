using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO; 

public partial class ThemLoaiSanPham : System.Web.UI.Page
{
    DAO_DANH_MUC DAO_DANH_MUC = new DAO_DANH_MUC();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDanhMuc();
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

    protected void btnLuu_Click(object sender, EventArgs e)
    {
        if (txtTenLoai.Text.Trim() == "")
        {
            lbThongBao.Text = "Vui lòng nhập tên loại sản phẩm";
            return;
        }

        string tenLoai = txtTenLoai.Text.Trim();
        int idDanhMuc = Convert.ToInt32(ddlDanhMuc.SelectedValue);
        string anhloai = "";  

        if (fulAnh.HasFile)
        {
            // Tạo tên file duy nhất (để tránh trùng lặp)
            string fileName = DateTime.Now.Ticks + "_" + fulAnh.FileName;

            string folder = Server.MapPath("~/anhloai/");

            // Nếu chưa có thư mục thì tạo mới 
            if (!Directory.Exists(folder))
            {
                Directory.CreateDirectory(folder);
            }

            fulAnh.SaveAs(folder + fileName);
            anhloai = fileName;
        }

        DAO_DANH_MUC.loai_them(tenLoai, anhloai, idDanhMuc);

        Response.Redirect("QUANLYLOAISANPHAM.aspx");
    }
}