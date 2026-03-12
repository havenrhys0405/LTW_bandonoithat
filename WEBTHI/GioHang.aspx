<%@ Page Title="" Language="C#" MasterPageFile="~/masterfrontend.master" AutoEventWireup="true" CodeFile="GioHang.aspx.cs" Inherits="GioHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   <style>
.cart-wrapper{ padding:40px 0; }
.cart-container{
    width:1200px; margin:auto;
    display:grid;
    grid-template-columns: 2.2fr 1fr;
    gap:30px;
}

/* BOX */
.cart-box{
    background:#fff;
    border-radius:16px;
    padding:24px;
    box-shadow:0 6px 18px rgba(0,0,0,0.08);
}

/* TITLE */
.cart-title{
    font-size:18px;
    font-weight:700;
    margin-bottom:18px;
}

/* HEADER */
.cart-header{
    display:grid;
    grid-template-columns: 3fr 1.2fr 1fr 40px;
    font-weight:700;
    border-bottom:1px solid #eee;
    padding-bottom:12px;
}

/* ROW */
.cart-row{
    display:grid;
    grid-template-columns: 3fr 1.2fr 1fr 40px;
    align-items:center;
    padding:16px 0;
    border-bottom:1px solid #eee;
}

/* PRODUCT */
.cart-product{
    display:flex;
    gap:14px;
    align-items:center;
}
.cart-product img{
    width:80px; height:80px;
    object-fit:cover;
    border-radius:10px;
}
.product-name{ font-weight:600; }
.product-price{ color:#888; font-size:14px; }

/* QTY */
.qty-box{
    display:flex;
    align-items:center;
    gap:8px;
}
.qty-btn{
    width:28px;
    height:28px;
    line-height:26px;
    text-align:center;
    border:1px solid #ccc;
    border-radius:50%;
    font-weight:700;
    text-decoration:none;
    color:#000;
    background:#f7f7f7;
}
.qty-value{
    min-width:32px;
    text-align:center;
    font-weight:600;
}

/* SUBTOTAL */
.subtotal{
    font-weight:600;
    color:#7a4a2e;
}

/* REMOVE */
.btn-remove{
    color:#1f3a8a;
    font-size:18px;
    text-decoration:none;
}

/* TOTAL */
.total-row{
    display:flex;
    justify-content:space-between;
    margin-bottom:14px;
    font-size:15px;
}
.total{
    font-size:20px;
    font-weight:700;
    color:#7a4a2e;
}

/* BUTTON */
.btn-main{
    width:100%;
    padding:14px;
    background:#c8a27a;
    color:#fff;
    border:none;
    border-radius:10px;
    font-weight:700;
    cursor:pointer;
}
.btn-sub{
    background:#eee;
    border:none;
    padding:10px 18px;
    border-radius:8px;
    font-weight:600;
    margin-right:10px;
}

/* EMPTY */
.empty-box{
    background:#fff;
    border-radius:16px;
    padding:60px;
    text-align:center;
    box-shadow:0 6px 18px rgba(0,0,0,0.08);
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Breadcrumb" Runat="Server">
 
  <%// link trang chu/gio hang  %>  
    
   <a href="TrangChu.aspx" style="text-decoration: none; color: #333;">Trang chủ</a> / Giỏ hàng
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Panel ID="pnlCoSP" runat="server" Visible="false">
<div class="cart-wrapper">
<div class="cart-container">

<div class="cart-box">
<div class="cart-title">SẢN PHẨM</div>

<div class="cart-header">
    <div>Sản phẩm</div>
    <div>Số lượng</div>
    <div>Tạm tính</div>
    <div></div>
</div>
<asp:Repeater ID="rptGioHang" runat="server"
    OnItemCommand="rptGioHang_ItemCommand">
<ItemTemplate>
<div class="cart-row">

    <div class="cart-product">
        <img src='<%# ResolveUrl("~/AnhSP/" + Eval("Anh")) %>' />
        <div>
            <div class="product-name"><%# Eval("TenSanPham") %></div>
            <div class="product-price"><%# Eval("Gia","{0:N0} đ") %></div>
        </div>
    </div>

    <div class="qty-box">
        <asp:LinkButton runat="server"
            CssClass="qty-btn"
            CommandName="minus"
            CommandArgument='<%# Eval("ID_SanPham") %>'>−</asp:LinkButton>

        <span class="qty-value"><%# Eval("SoLuong") %></span>

        <asp:LinkButton runat="server"
            CssClass="qty-btn"
            CommandName="plus"
            CommandArgument='<%# Eval("ID_SanPham") %>'>+</asp:LinkButton>
    </div>

    <div class="subtotal">
        <%# (Convert.ToDecimal(Eval("Gia")) * Convert.ToInt32(Eval("SoLuong"))).ToString("N0") %> đ
    </div>

    <asp:LinkButton runat="server"
        CssClass="btn-remove"
        CommandName="remove"
        CommandArgument='<%# Eval("ID_SanPham") %>'>✕</asp:LinkButton>

</div>
</ItemTemplate>
</asp:Repeater>

<br />
<asp:Button runat="server" CssClass="btn-sub"
    Text="Tiếp tục xem sản phẩm" PostBackUrl="~/TrangChu.aspx" />

</div>

<div class="cart-box">
<div class="cart-title">TỔNG CỘNG GIỎ HÀNG</div>

<div class="total-row">
    <span>Tạm tính</span>
    <span><asp:Label ID="lbTamTinh" runat="server" /></span>
</div>

<div class="total-row">
    <span>Tổng</span>
    <span class="total"><asp:Label ID="lbTong" runat="server" /></span>
</div>

<br />
<asp:Button runat="server" CssClass="btn-main"
    Text="TIẾN HÀNH THANH TOÁN"
    OnClick="btnThanhToan_Click" />

</div>

</div>
</div>
</asp:Panel>

<asp:Panel ID="pnlTrong" runat="server" Visible="false">
<div class="empty-box">
    <h3>Giỏ hàng của bạn đang trống.</h3><br />
    <a href="TrangChu.aspx" class="btn-main">Quay lại mua sắm</a>
</div>
</asp:Panel>
</asp:Content>