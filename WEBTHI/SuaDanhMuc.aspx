<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SuaDanhMuc.aspx.cs" Inherits="SuaDanhMuc" %>

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
            margin-bottom: 20px;
        }

        .page-title {
            font-size: 22px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .breadcrumb {
            background: #eef1f4;
            padding: 8px 18px;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 500;
        }

        /* ===== CARD FORM ===== */
        .form-card {
            background: #ffffff;
            border-radius: 14px;
            padding: 28px 32px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.08);
            max-width: 800px;
        }

        /* ===== FORM ROW ===== */
        .form-row {
            display: flex;
            align-items: center;
            margin-bottom: 18px;
        }

        .form-row label {
            width: 160px;
            font-weight: 600;
        }

        .form-row input[type=text] {
            flex: 1;
            padding: 10px 12px;
            border-radius: 6px;
            border: 1px solid #ced4da;
            font-size: 14px;
        }

        /* ===== BUTTON ===== */
        .form-actions {
            margin-top: 30px;
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
        }

        .btn-save {
            background: #6f7cff;
            color: #fff;
            border: none;
            padding: 10px 24px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
        }

        /* ===== MESSAGE ===== */
        .msg {
            margin-top: 15px;
            font-weight: 500;
            text-align: center;
            color: red;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="content-wrapper">

        <!-- HEADER -->
        <div class="page-header">
            <div class="page-title">
                ✏️ Sửa danh mục
            </div>
            <div class="breadcrumb">
                Home / Danh mục
            </div>
        </div>

        <!-- FORM -->
        <div class="form-card">

            <div class="form-row">
                <label>Tên danh mục</label>
                <asp:TextBox ID="txtTenDanhMuc" runat="server" />
            </div>

            <!-- ACTION -->
            <div class="form-actions">
                <asp:HyperLink runat="server"
                    NavigateUrl="~/QUANLYDANHMUC.aspx"
                    CssClass="btn-back">
                    Trở lại
                </asp:HyperLink>

                <asp:Button ID="btnCapNhat"
                    runat="server"
                    Text="Cập nhật danh mục"
                    CssClass="btn-save"
                    OnClick="btnCapNhat_Click" />
            </div>

            <asp:Label ID="lbThongBao"
                runat="server"
                CssClass="msg" />

        </div>

    </div>

</asp:Content>

