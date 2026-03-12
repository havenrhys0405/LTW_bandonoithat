<%@ Page Title="" Language="C#" MasterPageFile="~/masterfrontend.master" AutoEventWireup="true" CodeFile="DatHang.aspx.cs" Inherits="DatHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
.checkout-wrapper{ padding:40px 0; }
.checkout-container{
    width:1200px; margin:auto;
    display:grid;
    grid-template-columns: 2fr 1fr;
    gap:30px;
}

/* BOX */
.box{
    background:#fff;
    border-radius:16px;
    padding:24px;
    box-shadow:0 6px 18px rgba(0,0,0,0.08);
}

/* TITLE */
.box-title{
    font-size:18px;
    font-weight:700;
    margin-bottom:18px;
}

/* FORM */
.form-group{ margin-bottom:14px; }
.form-group label{ font-weight:600; display:block; margin-bottom:6px; }
.form-group input, .form-group textarea{
    width:100%;
    padding:10px 12px;
    border:1px solid #ccc;
    border-radius:8px;
}

/* ORDER */
/* ===== ORDER BOX ===== */
.order-box{
    background:#fff;
    border:2px solid #333;
    padding:24px;
}

/* TITLE */
.order-title{
    font-size:18px;
    font-weight:700;
    margin-bottom:16px;
}

/* HEADER */
.order-header{
    display:flex;
    justify-content:space-between;
    font-weight:700;
    border-bottom:1px solid #ddd;
    padding-bottom:8px;
    margin-bottom:12px;
}

/* ITEM */
.order-item{
    display:flex;
    justify-content:space-between;
    padding:10px 0;
    border-bottom:1px solid #eee;
}

/* ROW */
.order-row{
    display:flex;
    justify-content:space-between;
    padding:10px 0;
    border-top:1px solid #eee;
}

.order-row.bold{
    font-weight:700;
}

/* PRICE */
.price{
    font-weight:600;
}

/* PAYMENT */
.payment-method{
    margin:16px 0;
    padding-top:12px;
    border-top:1px solid #eee;
}

.payment-method label{
    display:flex;
    align-items:center;
    gap:8px;
}

.payment-desc{
    font-size:14px;
    color:#555;
    margin:8px 0 0 22px;
}

/* BUTTON */
.btn-order{
    width:100%;
    background:#ff3d00;
    color:#fff;
    border:none;
    padding:14px;
    font-size:16px;
    font-weight:700;
    cursor:pointer;
    margin:16px 0;
}

/* NOTE */
.order-note{
    font-size:13px;
    color:#666;
    line-height:1.5;
}


/* RADIO */
.radio-group{ margin:12px 0; }
.radio-group label{ display:block; margin-bottom:6px; }

/* BUTTON */
.btn-main{
    width:100%;
    padding:14px;
    background:#ff3d00;
    color:#fff;
    border:none;
    border-radius:10px;
    font-weight:700;
    cursor:pointer;
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Breadcrumb" Runat="Server">
     Trang chủ / Đặt hàng
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Panel ID="pnlCheckout" runat="server">

<div class="checkout-wrapper">
<div class="checkout-container">

<!-- LEFT -->
<div class="box">
<div class="box-title">THÔNG TIN THANH TOÁN</div>

<div class="form-group">
    <label>Tên *</label>
    <asp:TextBox ID="txtTen" runat="server" />
</div>

<div class="form-group">
    <label>Địa chỉ *</label>
    <asp:TextBox ID="txtDiaChi" runat="server" />
</div>

<div class="form-group">
    <label>Số điện thoại *</label>
    <asp:TextBox ID="txtSDT" runat="server" />
</div>

<div class="form-group">
    <label>Email *</label>
    <asp:TextBox ID="txtEmail" runat="server" />
</div>

<div class="box-title">THÔNG TIN BỔ SUNG</div>

<div class="form-group">
    <label>Ghi chú đơn hàng (tùy chọn)</label>
    <asp:TextBox ID="txtGhiChu" runat="server" TextMode="MultiLine" Rows="4" />
</div>
</div>

<!-- RIGHT -->
<div class="order-box">

    <div class="order-title">ĐƠN HÀNG CỦA BẠN</div>

    <!-- HEADER -->
    <div class="order-header">
        <span>SẢN PHẨM</span>
        <span>TẠM TÍNH</span>
    </div>

    <!-- DANH SÁCH SẢN PHẨM -->
    <asp:Repeater ID="rptDonHang" runat="server">
        <ItemTemplate>
            <div class="order-item">
                <span>
                    <%# Eval("TenSanPham") %> × <%# Eval("SoLuong") %>
                </span>
                <span class="price">
                    <%# (Convert.ToDecimal(Eval("Gia")) * Convert.ToInt32(Eval("SoLuong"))).ToString("N0") %> đ
                </span>
            </div>
        </ItemTemplate>
    </asp:Repeater>

    <!-- TẠM TÍNH -->
    <div class="order-row">
        <span>Tạm tính</span>
        <span class="price">
            <asp:Label ID="lbTamTinh" runat="server" />
        </span>
    </div>

    <!-- TỔNG -->
    <div class="order-row bold">
        <span>Tổng</span>
        <span class="price">
            <asp:Label ID="lbTong" runat="server" />
        </span>
    </div>

    <!-- PHƯƠNG THỨC THANH TOÁN -->
    <div class="payment-method">
        <label>
            <asp:RadioButton ID="rdCOD" runat="server" Checked="true" />
            <b>Trả tiền mặt khi nhận hàng</b>
        </label>

        <p class="payment-desc">
            Thanh toán bằng tiền mặt khi đơn hàng được giao đến địa chỉ của bạn.
        </p>
    </div>

    <!-- NÚT ĐẶT HÀNG -->
    <asp:Button ID="btnDatHang" runat="server"
        Text="ĐẶT HÀNG"
        CssClass="btn-order"
        OnClick="btnDatHang_Click" />

    <!-- GHI CHÚ -->
    <p class="order-note">
        Thông tin cá nhân của bạn sẽ được sử dụng để xử lý đơn hàng, tăng trải nghiệm
        sử dụng website, và cho các mục đích cụ thể khác được mô tả trong chính sách
        riêng tư của chúng tôi.
    </p>

</div>


</div>
</div>

</asp:Panel>

</asp:Content>

