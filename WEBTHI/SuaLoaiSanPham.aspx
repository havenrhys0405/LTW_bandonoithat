<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SuaLoaiSanPham.aspx.cs" Inherits="SuaLoaiSanPham" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
    /* ===== NỀN ===== */
    .content-wrapper {
        background: #f4f6f9;
        padding: 24px;
    }

    /* ===== HEADER ===== */
    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 18px;
    }

    .page-title {
        font-size: 24px;
        font-weight: 700;
        display: flex;
        align-items: center;
        gap: 8px;
        margin: 0;
    }

    .breadcrumb {
        background: #eef1f4;
        padding: 8px 18px;
        border-radius: 10px;
        font-size: 15px;
        font-weight: 500;
    }

    /* ===== CARD ===== */
    .action-card {
        background: #ffffff;
        border-radius: 16px;
        padding: 30px 36px;
        box-shadow: 0 8px 24px rgba(0,0,0,0.08);
        max-width: 700px;
        margin: 0 auto;
    }

    /* ===== FORM ===== */
    .form-row {
        margin-bottom: 18px;
    }

    .form-row label {
        display: block;
        font-weight: 600;
        margin-bottom: 6px;
    }

    .form-row input,
    .form-row select {
        width: 100%;
        padding: 10px 12px;
        border-radius: 8px;
        border: 1px solid #ced4da;
        font-size: 14px;
    }

    .img-preview {
        margin-top: 8px;
        max-width: 160px;
        border-radius: 8px;
        border: 1px solid #ddd;
    }

    /* ===== BUTTON ===== */
    .form-actions {
        margin-top: 26px;
        text-align: center;
    }

    .btn-back {
        background: #e9ecef;
        color: #000;
        border: none;
        padding: 10px 22px;
        border-radius: 8px;
        margin-right: 10px;
        font-size: 14px;
        text-decoration: none;
        display: inline-block;
        font-weight: 500;
    }

    .btn-save {
        background: linear-gradient(135deg, #ffc107, #ffca2c);
        color: #000;
        border: none;
        padding: 10px 26px;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
    }

    /* ===== MESSAGE ===== */
    .msg {
        margin-top: 14px;
        text-align: center;
        color: red;
        font-weight: 500;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="content-wrapper">

    <!-- HEADER -->
    <div class="page-header">
        <h2 class="page-title">✏️ Sửa loại sản phẩm</h2>

        <div class="breadcrumb">
            <asp:HyperLink runat="server"
                NavigateUrl="~/TrangHeThong.aspx"
                CssClass="breadcrumb-link">
                Home
            </asp:HyperLink>
            /
            <span>Sửa loại sản phẩm</span>
        </div>
    </div>

    <!-- CARD -->
    <div class="action-card">

        <div class="form-row">
            <label>Danh mục</label>
            <asp:DropDownList ID="ddlDanhMuc"
                runat="server" />
        </div>

        <div class="form-row">
            <label>Tên loại sản phẩm</label>
            <asp:TextBox ID="txtTenLoai"
                runat="server" />
        </div>

        <div class="form-row">
            <label>Ảnh hiện tại</label>
            <asp:Image ID="imgAnhCu"
                runat="server"
                CssClass="img-preview" />
        </div>

        <div class="form-row">
            <label>Đổi ảnh mới (nếu có)</label>
            <asp:FileUpload ID="fulAnhMoi"
                runat="server" />
        </div>

        <!-- ACTION -->
        <div class="form-actions">
            <a href="QUANLYLOAISANPHAM.aspx"
                class="btn-back">
                Trở lại
            </a>

            <asp:Button ID="btnCapNhat"
                runat="server"
                Text="💾 Cập nhật"
                CssClass="btn-save"
                OnClick="btnCapNhat_Click" />
        </div>

        <asp:Label ID="lbThongBao"
            runat="server"
            CssClass="msg" />

    </div>

</div>
</asp:Content>

