using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class QUANLYSANPHAM : System.Web.UI.Page
{
    DAO_SAN_PHAM dao = new DAO_SAN_PHAM();
    DAO_DANH_MUC daoDM = new DAO_DANH_MUC(); 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadLoaiSanPham(); 
            LoadData(0);       
        }
    }

    void LoadLoaiSanPham()
    {
   
        DataSet ds = daoDM.loai_all();

        if (ds != null && ds.Tables.Count > 0)
        {
            ddlLoaiSP.DataSource = ds.Tables[0];
            ddlLoaiSP.DataTextField = "TenLoai";
            ddlLoaiSP.DataValueField = "ID_Loai"; 
            ddlLoaiSP.DataBind();
        }
        ddlLoaiSP.Items.Insert(0, new ListItem("--- Tất cả sản phẩm ---", "0"));
    }

    // Hàm nạp sản phẩm vào bảng và lọc 
    void LoadData(int idLoai)
    {
        DataSet ds;

        if (idLoai == 0)
        {   
            ds = dao.sanpham_all();
        }
        else
        {
            ds = dao.sanpham_theoloai(idLoai);
        }

        if (ds != null)
        {
            grvSanPham.DataSource = ds;
            grvSanPham.DataBind();
        }
    }

   
    protected void ddlLoaiSP_SelectedIndexChanged(object sender, EventArgs e)
    {
        // Lấy ID loại được chọn
        int idLoai = Convert.ToInt32(ddlLoaiSP.SelectedValue);

        // Gọi hàm nạp lại dữ liệu theo ID này
        LoadData(idLoai);
    }

    
    protected void grv_RowEditing(object sender, GridViewEditEventArgs e)
    {
        int idSP = Convert.ToInt32(grvSanPham.DataKeys[e.NewEditIndex].Value);
        Response.Redirect("ThemSanPham.aspx?id=" + idSP);
    }

  
    protected void grv_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int idSP = Convert.ToInt32(grvSanPham.DataKeys[e.RowIndex].Value);

      
        dao.SanPham_Xoa(idSP);

       
        int currentLoai = Convert.ToInt32(ddlLoaiSP.SelectedValue);
        LoadData(currentLoai);
    }
}