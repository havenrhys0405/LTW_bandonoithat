using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SuaSanPham : System.Web.UI.Page
{
    DAO_SAN_PHAM DAO_SAN_PHAM = new DAO_SAN_PHAM();
    DAO_DANH_MUC DAO_DANH_MUC = new DAO_DANH_MUC();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadLoai();
            HienThiSanPham();
        }
    }

    void LoadLoai()
    {
        DataSet ds = DAO_DANH_MUC.loai_all();
        ddlLoai.DataSource = ds;
        ddlLoai.DataTextField = "TenLoai";
        ddlLoai.DataValueField = "ID_Loai";
        ddlLoai.DataBind();
    }

    void HienThiSanPham()
    {
        if (Request.QueryString["id"] == null) return;

        int id = Convert.ToInt32(Request.QueryString["id"]);
        DataSet ds = DAO_SAN_PHAM.sanpham_id(id);

        if (ds.Tables[0].Rows.Count > 0)
        {
            DataRow r = ds.Tables[0].Rows[0];

            txtTen.Text = r["TenSanPham"].ToString();
            txtGia.Text = r["Gia"].ToString();
            txtSoLuong.Text = r["SoLuong"].ToString();
            ftbMoTa.Text = r["MoTa"].ToString();

            
            imgAnhCu.ImageUrl = "~/AnhSP/" + r["Anh"].ToString();

           
            if (r["ID_Loai"] != DBNull.Value)
            {
                ddlLoai.SelectedValue = r["ID_Loai"].ToString();
            }
        }
    }

    protected void btnCapNhat_Click(object sender, EventArgs e)
    {
        if (txtTen.Text == "" || txtGia.Text == "")
        {
            lbThongBao.Text = "Vui lòng nhập đầy đủ thông tin";
            return;
        }

        int id = Convert.ToInt32(Request.QueryString["id"]);
        string ten = txtTen.Text;
        decimal gia = Convert.ToDecimal(txtGia.Text);
        int idLoai = Convert.ToInt32(ddlLoai.SelectedValue); 
        string mota = ftbMoTa.Text;
        string anh;

        DataSet ds = DAO_SAN_PHAM.sanpham_id(id);
        anh = ds.Tables[0].Rows[0]["Anh"].ToString();

        int soluong;
        if (!int.TryParse(txtSoLuong.Text, out soluong))
        {
            lbThongBao.Text = "Số lượng phải là số nguyên";
            return;
        }

        if (fuAnhMoi.HasFile)
        {
            string folder = Server.MapPath("~/AnhSP/"); 
            if (!Directory.Exists(folder))
            {
                Directory.CreateDirectory(folder);
            }

            string fileName = DateTime.Now.Ticks + Path.GetExtension(fuAnhMoi.FileName);
            fuAnhMoi.SaveAs(Path.Combine(folder, fileName));

            anh = fileName; 
        }

      
        DAO_SAN_PHAM.SanPham_Sua(id, idLoai, ten, anh, gia, soluong, mota);

        Response.Redirect("QuanLySanPham.aspx");
    }
}