<%@ Page Title="" Language="C#" ValidateRequest="false"
    EnableEventValidation="false" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SuaSanPham.aspx.cs" Inherits="SuaSanPham" %>
<%@ Register Assembly="FreeTextBox"
    Namespace="FreeTextBoxControls"
    TagPrefix="FTB" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
    .content-wrapper {
        background: #f4f6f9;
        padding: 24px;
    }

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

    .action-card {
        background: #ffffff;
        border-radius: 16px;
        padding: 30px 36px;
        box-shadow: 0 8px 24px rgba(0,0,0,0.08);
        max-width: 900px;
        margin: 0 auto;
    }

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
        max-width: 220px;
        border-radius: 8px;
        margin-top: 8px;
        border: 1px solid #ddd;
    }

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
        background: linear-gradient(135deg, #ffc107, #ffda6a);
        color: #000;
        border: none;
        padding: 10px 26px;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
    }

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
        <h2 class="page-title">✏️ Sửa sản phẩm nội thất</h2>

        <div class="breadcrumb">
            <asp:HyperLink runat="server"
                NavigateUrl="~/TrangHeThong.aspx">
                Home
            </asp:HyperLink>
            /
            <span>Sửa sản phẩm</span>
        </div>
    </div>

    <!-- CARD -->
    <div class="action-card">

        <div class="form-row">
            <label>Loại sản phẩm</label>
            <asp:DropDownList ID="ddlLoai" runat="server" />
        </div>

        <div class="form-row">
            <label>Tên sản phẩm</label>
            <asp:TextBox ID="txtTen" runat="server" />
        </div>
  <div class="form-row">
            <label>Ảnh hiện tại</label>
            <asp:Image ID="imgAnhCu"
                runat="server"
                CssClass="img-preview" />
        </div>
        <div class="form-row">
            <label>Đổi ảnh mới (nếu có)</label>
            <asp:FileUpload ID="fuAnhMoi" runat="server" />
        </div>
        <div class="form-row">
            <label>Giá</label>
            <asp:TextBox ID="txtGia" runat="server" />
        </div>

      

        <div class="form-row">
    <label>Số lượng</label>
    <asp:TextBox ID="txtSoLuong" runat="server" />
</div>


        <div class="form-row">
            <label>Mô tả sản phẩm</label>
            <FTB:FreeTextBox
                ID="ftbMoTa"
                runat="server"
                Height="220px"
                Width="100%" />
        </div>

        <!-- ACTION -->
        <div class="form-actions">
            <a href="QUANLYSANPHAM.aspx" class="btn-back">
                Trở lại
            </a>

            <asp:Button ID="btnCapNhat"
                runat="server"
                Text="Cập nhật"
                CssClass="btn-save"
                OnClick="btnCapNhat_Click" />
        </div>

        <asp:Label ID="lbThongBao"
            runat="server"
            CssClass="msg" />

    </div>
</div>
</asp:Content>

