<%@ Page Language="C#" MasterPageFile="~/masterfrontend.master"
    AutoEventWireup="true" CodeFile="ChiTietSanPham.aspx.cs"
    Inherits="ChiTietSanPham" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
<style>

    body, div, span, p, a, h1, h2, h3, li, label, .sp-title, .sp-price {
        text-shadow: none !important; 
    }

    /* ===== LAYOUT ===== */
    .detail-container{ width:1200px; margin:auto; padding:30px 0; display:grid; grid-template-columns:1.1fr 1.4fr 1fr; gap:30px; }

    /* ===== CỘT TRÁI (ẢNH) ===== */
    .sp-img{ background:#fff; padding:20px; border-radius:12px; }
    .sp-img img{ width:100%; }

    /* ===== CỘT GIỮA (INFO) ===== */
    .sp-title{ font-size:24px; font-weight:700; color: #222; }
    .sp-price{ color:#c0392b; font-size:26px; font-weight:700; margin:8px 0; }

    /* INFO BOX */
    .sp-info{ background:#f3efe6; border-radius:8px; margin:16px 0; border:1px solid #e0d6c5; }
    .sp-info-title{ background:#3b3b3b; color:#fff; padding:10px 14px; font-weight:700; }
    
    /* Nội dung mô tả */
    .sp-description { 
        padding: 14px 20px; 
        font-size: 15px; 
        color: #333; 
        line-height: 1.6;
    }

    /* QTY + CART */
    .buy-row{ display:flex; align-items:center; gap:14px; margin:16px 0; }
    .qty{ display:inline-flex; border:1px solid #ccc; border-radius:6px; overflow:hidden; }
    .qty a{ width:34px;height:34px; display:flex; align-items:center; justify-content:center; font-weight:700; text-decoration:none; color: #333; }
    .qty span{ width:40px; text-align:center; line-height:34px; border-left:1px solid #ccc; border-right:1px solid #ccc; font-weight: 600; }

    .btn-cart{ flex:1; padding:14px; font-weight:700; border:1px solid #ccc; background:#fff; border-radius:6px; cursor:pointer;}
    .btn-cart:hover { background: #f0f0f0; }

    /* ===== CSS TRẠNG THÁI ===== */
    .status-box { margin-bottom: 15px; font-weight: bold; font-size: 15px; }
    .con-hang { color: #27ae60; background: #eafaf1; padding: 5px 10px; border-radius: 4px; }
    .het-hang { color: #c0392b; background: #fdedec; padding: 5px 10px; border-radius: 4px; }
    .ngung-kinh-doanh { color: #555; background: #eee; padding: 5px 10px; border-radius: 4px; }

    
    .btn-disabled { background-color: #e0e0e0 !important; color: #999 !important; cursor: not-allowed; border: 1px solid #ccc; }

    /* ===== CỘT KHUYẾN MẠI ===== */
    .promo-box{ background:#f3efe6; border:1px solid #e0d6c5; border-radius:8px; margin-bottom:18px; font-size:14px; }
    .promo-title{ background:#7a4a2e; color:#fff; padding:10px 14px; font-weight:700; border-radius:8px 8px 0 0; }
    .promo-content{ padding:14px 18px; }
    .promo-content ul { padding-left: 20px; margin: 0; } 
    .promo-content li{ margin-bottom:8px; line-height:1.6; }
    .promo-note{ margin-top:10px; font-style:italic; color:#a00000; font-size:13px; }

    /* FEATURES */
    .features{ display:grid; grid-template-columns:1fr 1fr; gap:18px 30px; margin-top:20px; font-size:15px; }
    .features div{ display:flex; align-items:center; gap:10px; }
    .features i{ font-size:28px; }

    /* ===== SẢN PHẨM LIÊN QUAN ===== */
    .related{ width:1200px; margin:40px auto; }
    .related h2{ font-size:20px; font-weight:700; margin-bottom:20px; border-left: 5px solid #c8a27a; padding-left: 10px; color: #333; }
    .related-grid{ display:grid; grid-template-columns:repeat(5, 1fr); justify-content:center; gap:24px; }
    
    .related-item{ 
        background:#fff; border-radius:10px; padding:12px; text-align:center;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        transition: transform 0.3s ease, box-shadow 0.3s ease; height: 100%;
    }
    .related-item:hover { transform: translateY(-5px); box-shadow: 0 8px 20px rgba(0,0,0,0.12); cursor: pointer; }
    .related-item img{ width:100%; height:150px; object-fit:contain; margin-bottom: 10px; }
    .related-link { text-decoration: none; color: inherit; display: block; height: 100%; }
</style>
</asp:Content>


<asp:Content ContentPlaceHolderID="Breadcrumb" runat="server">
    <a href="TrangChu.aspx">Trang chủ</a> /
    <asp:Label ID="lbLoai" runat="server" />
</asp:Content>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="detail-container">

    <div class="sp-img">
        <asp:Image ID="imgSP" runat="server" />
    </div>

    <div>
        <div class="sp-title"><asp:Label ID="lbTenSP" runat="server" /></div>
        <div class="sp-price"><asp:Label ID="lbGia" runat="server" /></div>

        <div class="status-box">
            <asp:Label ID="lbTrangThai" runat="server" />
        </div>

        <div class="sp-info">
            <div class="sp-info-title">THÔNG TIN SẢN PHẨM</div>
            <div class="sp-description">
                <asp:Literal ID="ltMoTa" runat="server" />
            </div>
        </div>

        <div class="buy-row">
            <div class="qty">
                <asp:LinkButton runat="server" OnClick="Tru_Click">−</asp:LinkButton>
                <asp:Label ID="lbSoLuong" runat="server" Text="1" />
                <asp:LinkButton runat="server" OnClick="Cong_Click">+</asp:LinkButton>
            </div>

            <asp:Button ID="btnThemGio" runat="server"
                Text="🛒 THÊM VÀO GIỎ HÀNG"
                CssClass="btn-cart"
                OnClick="ThemGioHangMoi_Click" />
        </div>
    </div>

    <div>
        <div class="promo-box">
            <div class="promo-title">🎁 CHƯƠNG TRÌNH KHUYẾN MẠI</div>
            <div class="promo-content">
                <ul>
                    <li>Tặng quà cho đơn hàng từ <b>15.000.000đ</b>.</li>
                    <li>Giảm thêm đến <b>2.000.000đ</b> cho khách hàng thân thiết.</li>
                    <li>Tặng <b>Voucher 300.000đ</b> dịp sinh nhật.</li>
                    <li>Miễn phí đổi trả nếu sản phẩm lỗi.</li>
                </ul>
                <div class="promo-note">
                    Lưu ý: Không áp dụng đồng thời các chương trình khuyến mãi.
                </div>
            </div>
        </div>

        <div class="features">
            <div><i class="fa-solid fa-truck"></i> Giao hàng toàn quốc</div>
            <div><i class="fa-solid fa-rotate"></i> Dễ dàng đổi trả</div>
            <div><i class="fa-solid fa-cube"></i> Vật liệu chất lượng</div>
            <div><i class="fa-solid fa-truck-fast"></i> Miễn phí vận chuyển</div>
        </div>
    </div>

</div>

<asp:Panel ID="pnlLienQuan" runat="server" Visible="false">
    <div class="related">
        <h2>SẢN PHẨM LIÊN QUAN</h2>
        <div class="related-grid">
            <asp:Repeater ID="rptLienQuan" runat="server">
                <ItemTemplate>
                    <div class="related-item">
                        <a href="ChiTietSanPham.aspx?id=<%# Eval("ID_SanPham") %>" class="related-link">
                            <img src='<%# ResolveUrl("~/AnhSP/" + Eval("Anh")) %>' alt='<%# Eval("TenSanPham") %>' />
                            <div style="font-weight: 600; font-size: 15px; margin-bottom: 5px;">
                                <%# Eval("TenSanPham") %>
                            </div>
                            <div style="color: #c0392b; font-weight: 700;">
                                <%# Eval("Gia","{0:N0} đ") %>
                            </div>
                        </a>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Panel>

</asp:Content>