<%@ Page Title="" Language="C#" MasterPageFile="~/masterfrontend.master" AutoEventWireup="true" CodeFile="ThongTinCaNhan.aspx.cs" Inherits="ThongTinCaNhan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .info-wrapper { padding: 60px 0; background-color: #fcfcfc; display: flex; justify-content: center; }
        .info-card { background: #fff; width: 600px; padding: 40px 60px; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); border: 1px solid #e0e0e0; }
        .info-header { text-align: center; margin-bottom: 30px; }
        .info-header h2 { font-size: 22px; font-weight: 700; color: #444; text-transform: uppercase; letter-spacing: 1px; margin: 0; }
        .form-group { margin-bottom: 20px; }
        .form-label { display: block; font-weight: 700; font-size: 14px; color: #666; margin-bottom: 8px; }
        
        .form-control { width: 100%; padding: 12px 15px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; box-sizing: border-box; background-color: #fff; color: #333; transition: 0.3s; }
        .form-control:disabled { background-color: #f5f5f5; color: #888; border-color: #eee; cursor: default; }
        .form-control:focus { border-color: #b85c00; outline: none; box-shadow: 0 0 0 3px rgba(184, 92, 0, 0.1); }

        .action-area { margin-top: 30px; display: flex; justify-content: center; gap: 15px; }
        .btn-custom { padding: 12px 30px; border: none; border-radius: 4px; font-weight: 700; font-size: 13px; cursor: pointer; text-transform: uppercase; min-width: 120px; transition: 0.3s; }
        
        .btn-update { background-color: #333; color: #fff; }
        .btn-update:hover { background-color: #000; }
        .btn-save { background-color: #b85c00; color: #fff; }
        .btn-save:hover { background-color: #964b00; }
        .btn-cancel { background-color: #e0e0e0; color: #333; }
        .btn-cancel:hover { background-color: #d0d0d0; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Breadcrumb" Runat="Server">
    <div class="breadcrumb-mini">
        <a href="TrangChu.aspx">Trang chủ</a> / <span>Thông tin cá nhân</span>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="info-wrapper">
        <div class="info-card">
            <div class="info-header">
                <h2>Thông tin cá nhân</h2>
            </div>

            <div class="form-group">
                <label class="form-label">Tên đăng nhập</label>
                <asp:TextBox ID="txtTenDN" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
            </div>

            <div class="form-group">
                <label class="form-label">Họ và tên</label>
                <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
            </div>

            <div class="form-group">
                <label class="form-label">Số điện thoại</label>
                <asp:TextBox ID="txtSDT" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
            </div>

            <%-- ĐÃ XÓA CỘT ĐỊA CHỈ/GMAIL TẠI ĐÂY THEO YÊU CẦU --%>

            <div class="action-area">
                <asp:Button ID="btnCapNhat" runat="server" Text="Cập nhật" CssClass="btn-custom btn-update" OnClick="btnCapNhat_Click" />
                <asp:Button ID="btnLuu" runat="server" Text="Lưu" CssClass="btn-custom btn-save" Visible="false" OnClick="btnLuu_Click" />
                <asp:Button ID="btnHuy" runat="server" Text="Hủy bỏ" CssClass="btn-custom btn-cancel" Visible="false" OnClick="btnHuy_Click" />
            </div>

        </div>
    </div>
</asp:Content>