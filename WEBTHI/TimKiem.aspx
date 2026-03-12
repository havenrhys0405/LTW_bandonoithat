<%@ Page Title="" Language="C#" MasterPageFile="~/masterfrontend.master" AutoEventWireup="true" CodeFile="TimKiem.aspx.cs" Inherits="TimKiem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .search-title { font-size: 24px; font-weight: bold; margin-bottom: 20px; color: #333; }
        .product-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; }
        .product-card { background: #fff; padding: 15px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center; }
        .product-card img { width: 100%; height: 180px; object-fit: contain; }
        .product-name { font-weight: bold; margin: 10px 0; display: block; color: #333; }
        .product-price { color: #d35400; font-weight: bold; font-size: 16px; }
        .no-result { text-align: center; font-size: 18px; color: #777; margin-top: 50px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2 class="search-title">
        Kết quả tìm kiếm cho: "<asp:Label ID="lbTuKhoa" runat="server" Text="..." />"
    </h2>

    <div class="product-grid">
        <asp:Repeater ID="rptKetQua" runat="server">
            <ItemTemplate>
                <div class="product-card">
                    <a href="ChiTietSanPham.aspx?id=<%# Eval("ID_SanPham") %>">
                        <img src='<%# ResolveUrl("~/AnhSP/" + Eval("Anh")) %>' />
                        <span class="product-name"><%# Eval("TenSanPham") %></span>
                    </a>
                    <div class="product-price"><%# String.Format("{0:N0} đ", Eval("Gia")) %></div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <asp:Label ID="lbKhongThay" runat="server" CssClass="no-result" Visible="false" 
        Text="Không tìm thấy sản phẩm nào phù hợp." />
</asp:Content>