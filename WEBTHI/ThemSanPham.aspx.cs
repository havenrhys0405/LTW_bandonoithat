using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ThemSanPham : System.Web.UI.Page
{
    DAO_SAN_PHAM DAO_SAN_PHAM = new DAO_SAN_PHAM();
    DAO_DANH_MUC DAO_DANH_MUC = new DAO_DANH_MUC();

    // Biến toàn cục để lưu ID sản phẩm (nếu đang sửa)
    int idSP = 0;

    protected void Page_Load(object sender, EventArgs e)
    {    
        if (Request.QueryString["id"] != null)
        {
            int.TryParse(Request.QueryString["id"], out idSP);
        }

        if (!IsPostBack)
        {
            LoadLoai();          
            if (idSP > 0)
            {
                LoadThongTinSanPham(idSP);
                // ===== CẬP NHẬT GIAO DIỆN LÚC THÊM/SỬA =====
                btnThem.Text = "Cập nhật sản phẩm";
                lbTieuDe.Text = "✏️ Sửa sản phẩm nội thất"; 
                lbBreadcrumb.Text = "Sửa sản phẩm";         
            }
        }
    }

    void LoadLoai()
    {
        DataSet ds = DAO_DANH_MUC.loai_all();
        ddlLoai.DataSource = ds.Tables[0];
        ddlLoai.DataTextField = "TenLoai";
        ddlLoai.DataValueField = "ID_Loai";
        ddlLoai.DataBind();

        ddlLoai.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Chọn loại --", "0"));
    }

   
    void LoadThongTinSanPham(int id)
    {
        DataSet ds = DAO_SAN_PHAM.sanpham_id(id);
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            DataRow r = ds.Tables[0].Rows[0];

            txtTen.Text = r["TenSanPham"].ToString();
            txtGia.Text = Convert.ToInt32(r["Gia"]).ToString(); 
            txtSoLuong.Text = r["SoLuong"].ToString();
            ddlLoai.SelectedValue = r["ID_Loai"].ToString();
            ftb_MoTa.Text = r["MoTa"].ToString();
            ViewState["AnhCu"] = r["Anh"].ToString();
        }
    }


    protected void btnThem_Click(object sender, EventArgs e)
    {
        // ===== TÊN SẢN PHẨM =====
        string tenSanPham = txtTen.Text.Trim();
        if (tenSanPham == "")
        {
            lbThongBao.Text = "Vui lòng nhập tên sản phẩm";
            return;
        }

        // ===== GIÁ =====
        decimal gia;
        string giaText = txtGia.Text.Replace(",", "").Replace(".", "");
        if (!decimal.TryParse(giaText, out gia))
        {
            lbThongBao.Text = "Giá phải là số hợp lệ";
            return;
        }

        // ===== LOẠI =====
        int idLoai;
        if (!int.TryParse(ddlLoai.SelectedValue, out idLoai) || idLoai == 0)
        {
            lbThongBao.Text = "Vui lòng chọn loại sản phẩm";
            return;
        }

        // ===== SỐ LƯỢNG =====
        int soLuong;
        if (!int.TryParse(txtSoLuong.Text, out soLuong))
        {
            lbThongBao.Text = "Số lượng phải là số nguyên";
            return;
        }

        // ===== ẢNH =====
        string tenAnh = "";

        if (fuAnh.HasFile) // Nếu người dùng chọn ảnh mới
        {
            string ext = Path.GetExtension(fuAnh.FileName).ToLower();
            if (ext != ".jpg" && ext != ".png" && ext != ".jpeg")
            {
                lbThongBao.Text = "Ảnh phải là JPG hoặc PNG";
                return;
            }

            // Tạo tên file ngẫu nhiên
            tenAnh = DateTime.Now.Ticks + ext;
            string path = Server.MapPath("~/AnhSP/");

            if (!Directory.Exists(path))
                Directory.CreateDirectory(path);

            fuAnh.SaveAs(path + tenAnh);
        }
        else
        {
            if (idSP > 0 && ViewState["AnhCu"] != null)
            {
                tenAnh = ViewState["AnhCu"].ToString();
            }
            else
            {
                tenAnh = "no-image.jpg";
            }
        }

        string moTa = ftb_MoTa.Text;

        try
        {
            if (idSP > 0)
            {
                // === SỬA ===
                DAO_SAN_PHAM.SanPham_Sua(idSP, idLoai, tenSanPham, tenAnh, gia, soLuong, moTa);
            }
            else
            {
                // ===  THÊM MỚI ===
                DAO_SAN_PHAM.SanPham_Them(idLoai, tenSanPham, tenAnh, gia, soLuong, moTa);
            }

            Response.Redirect("QUANLYSANPHAM.aspx");
        }
        catch (Exception ex)
        {
            lbThongBao.Text = "Lỗi: " + ex.Message;
        }
    }
}