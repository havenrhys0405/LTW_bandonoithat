<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ChiTietDonHang.aspx.cs" Inherits="ChiTietDonHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
    .wrapper {
        background: #f4f6f9;
        padding: 24px;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    /* HEADER */
    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }

    .header-left {
        display: flex;
        align-items: center;
        gap: 15px; 
    }

    .page-title {
        font-size: 22px;
        font-weight: 700;
        margin: 0; 
        color: #2c3e50;
    }

    /* NÚT QUAY LẠI */
    .btn-back-top {
        background: #fff;
        color: #1f3a5f;
        padding: 8px 16px;
        border-radius: 8px; 
        text-decoration: none;
        font-weight: 700;
        border: 1px solid #ddd;
        display: flex;
        align-items: center;
        gap: 8px; 
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        transition: all 0.2s ease;
        font-size: 14px;
        height: fit-content;
    }
    
    .btn-back-top:hover {
        background: #f1f3f5;
        transform: translateY(-2px); 
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        color: #000;
    }

    /* BREADCRUMB */
    .breadcrumb {
        background: #eef1f4;
        padding: 8px 16px;
        border-radius: 10px;
        font-size: 14px;
        color: #6c757d;
    }
    /* Thêm CSS cho Link trong Breadcrumb để đẹp hơn */
    .breadcrumb a {
        text-decoration: none;
        color: #333;
        font-weight: 600;
        transition: 0.2s;
    }
    .breadcrumb a:hover {
        color: #e74c3c;
        text-decoration: underline;
    }
    .breadcrumb span {
        cursor: default;
    }
    
    /* CARD STYLE */
    .card {
        background: #fff;
        border-radius: 12px;
        padding: 24px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        margin-bottom: 24px;
        border: 1px solid #e9ecef;
    }
    
    .card h3 {
        margin-top: 0;
        margin-bottom: 20px;
        font-size: 18px;
        color: #e74c3c; /* Màu đỏ nổi bật cho tiêu đề */
        font-weight: 700;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    /* INFO GRID: Chia layout thông tin đơn hàng */
    .info-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr); /* 2 cột */
        gap: 20px;
    }

    .info-item { 
        font-size: 15px; 
        color: #555;
        border-bottom: 1px dashed #eee;
        padding-bottom: 8px;
    }
    
    .info-item span { 
        font-weight: 600; 
        color: #333;
        display: inline-block; 
        margin-left: 5px; 
    }
    
    .status span { 
        padding: 4px 10px;
        border-radius: 4px;
        font-weight: bold;
    }

    /* GRIDVIEW SẢN PHẨM */
    .gridview { width: 100%; border-collapse: collapse; margin-top: 10px; }
    .gridview th { 
        background: #f8f9fa; 
        padding: 12px; 
        text-align: center; 
        font-weight: 600; 
        color: #495057;
        border-bottom: 2px solid #dee2e6;
    }
    .gridview td { 
        padding: 12px; 
        text-align: center; 
        border-bottom: 1px solid #eee; 
        vertical-align: middle; 
        color: #333;
    }
    .gridview tr:hover { background-color: #f8f9fa; }

    /* CSS cho ảnh trong GridView */
    .gridview img {
        width: 70px;  
        height: 70px;
        object-fit: cover; 
        border-radius: 8px;
        border: 1px solid #eee;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="wrapper"> <div class="page-header">
        <div class="header-left">
            <a href="QuanLyDonHang.aspx" class="btn-back-top">
                <i class="fas fa-arrow-left"></i> Quay lại
            </a>
            <div class="page-title">🧾 Chi tiết đơn hàng</div>
        </div>
        <div class="breadcrumb">
            <a href="TrangHeThong.aspx">Home</a> / 
            <a href="QuanLyDonHang.aspx">Đơn hàng</a> / 
            <span>Chi tiết</span>
        </div>
    </div> <div class="card">
        <h3>📌 Thông tin đơn hàng</h3>
        <div class="info-grid">
            <div class="info-item">
                Mã đơn: <span>#<asp:Label ID="lbMaDon" runat="server" /></span>
            </div>
            
            <div class="info-item">
                Người nhận: <span><asp:Label ID="lbKhach" runat="server" /></span>
            </div>

            <div class="info-item">
                Ngày đặt: <span><asp:Label ID="lbNgay" runat="server" /></span>
            </div>
            
            <div class="info-item">
                Trạng thái: <span class="status"><asp:Label ID="lbTrangThai" runat="server" /></span>
            </div>

            <div class="info-item">
                📞 Điện thoại: <span><asp:Label ID="lbSDT" runat="server" /></span>
            </div>

            <div class="info-item" style="grid-column: span 2;">
                📍 Địa chỉ giao: <span style="color:#d63031;"><asp:Label ID="lbDiaChi" runat="server" /></span>
            </div>
        </div>
    </div>

    <div class="card">
        <h3>📦 Sản phẩm trong đơn</h3>

        <asp:GridView ID="grvCTDH"
            runat="server"
            CssClass="gridview"
            AutoGenerateColumns="False"
            GridLines="None"
            EmptyDataText="Không có sản phẩm nào trong đơn hàng này.">

            <Columns>
                <asp:BoundField DataField="TenSanPham" HeaderText="Sản phẩm" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />

                <asp:ImageField DataImageUrlField="Anh"
                    DataImageUrlFormatString="~/AnhSP/{0}"
                    HeaderText="Ảnh">
                    <ItemStyle Width="100px" />
                </asp:ImageField>

                <asp:BoundField DataField="Gia"
                    HeaderText="Đơn giá"
                    DataFormatString="{0:N0} đ" />

                <asp:BoundField DataField="SoLuong" HeaderText="SL" />

                <asp:BoundField DataField="ThanhTien"
                    HeaderText="Thành tiền"
                    DataFormatString="{0:N0} đ" 
                    ItemStyle-Font-Bold="true" ItemStyle-ForeColor="#d63031"/>

            </Columns>

        </asp:GridView>

    </div>

    </div> </asp:Content>