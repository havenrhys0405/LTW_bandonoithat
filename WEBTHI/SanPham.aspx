<%@ Page Title="" Language="C#" MasterPageFile="~/masterfrontend.master" AutoEventWireup="true" CodeFile="SanPham.aspx.cs" Inherits="SanPham" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  <style>
    /* ===== 1. BREADCRUMB ===== */
    .breadcrumb-mini { font-size: 14px; color: #777; margin: 20px 0; }
    .breadcrumb-mini a { color: #999; text-decoration: none; transition: 0.3s; }
    .breadcrumb-mini a:hover { color: #c8a27a; }
    .breadcrumb-mini span { color: #333; font-weight: 500; }

    /* ===== 2. KHUNG LƯỚI SẢN PHẨM (GRID) ===== */
    .product-grid {
        display: grid !important; 
        grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); 
        gap: 25px; 
        
        width: 100%;
        min-height: 500px; 
        padding-bottom: 60px; 
        
     
        align-content: start; 
        
    }

    /* ===== 3. THẺ SẢN PHẨM ===== */
    .product-card {
        background: #fff;
        border: 1px solid #eee;
        border-radius: 12px; 
        padding: 15px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        transition: transform 0.3s;
        
        display: flex;
        flex-direction: column; 
        height: 100%; 
        position: relative;
    }

    .product-card:hover {
        transform: translateY(-5px);
        border-color: #c8a27a;
        box-shadow: 0 8px 20px rgba(0,0,0,0.1);
    }

    /* ===== 4. ẢNH SẢN PHẨM ===== */
    .product-img {
        width: 100%;
        height: 180px; 
        margin-bottom: 12px;
        border-radius: 8px;
        overflow: hidden;
        display: flex;
        align-items: center;
        justify-content: center;
        background: #fff;
    }

    .product-img img {
        width: 100%;
        height: 100%;
        object-fit: contain; 
        transition: transform 0.5s ease;
    }
    
    .product-card:hover .product-img img {
        transform: scale(1.05); 
    }

    /* ===== 5. THÔNG TIN & GIÁ ===== */
    .product-info {
        flex-grow: 1; 
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }

    .product-name {
        font-size: 15px;
        font-weight: 600;
        color: #333;
        margin-bottom: 5px;
        line-height: 1.3;
        
       
        display: -webkit-box;
        -webkit-line-clamp: 2; 
        -webkit-box-orient: vertical;
        overflow: hidden;
        min-height: 40px; 
    }

    .product-price {
        font-size: 16px;
        font-weight: 700;
        color: #b85c00; 
        margin-bottom: 15px;
    }

    /* ===== 6. NÚT BẤM  ===== */
    .product-actions {
        margin-top: auto;
        display: flex;
        gap: 8px;
    }

    .btn-action {
        flex: 1;
        padding: 8px 0;
        border-radius: 20px;
        text-align: center;
        text-decoration: none;
        font-weight: 600;
        font-size: 13px;
        cursor: pointer;
        display: flex; align-items: center; justify-content: center; gap: 4px;
        border: none;
        transition: 0.2s;
    }

    /* Nút thêm giỏ: */
    .btn-add { background: #8b5e3c; color: #fff; }
    .btn-add:hover { background: #6d462b; }

    /* Nút Chi tiết: */
    .btn-view { background: #e6dccf; color: #5d4037; }
    .btn-view:hover { background: #dccbb3; }
  </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Breadcrumb" Runat="Server">
      <div class="breadcrumb-mini">
            <a href="TrangChu.aspx">Trang chủ</a> /
            <asp:Label ID="lbDanhMuc" runat="server" /> /
            <asp:Label ID="lbLoai" runat="server" />
        </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
    <div class="product-grid">
        <asp:Repeater ID="rptSanPham" runat="server" OnItemCommand="rptSanPham_ItemCommand">
            <ItemTemplate>
                <div class="product-card">
                    
                    <div class="product-img">
                        <img src='<%# ResolveUrl("~/AnhSP/" + Eval("Anh")) %>' alt='<%# Eval("TenSanPham") %>' />
                    </div>
                    
                    <div class="product-info">
                        <div class="product-name">
                            <%# Eval("TenSanPham") %>
                        </div>
                        <div class="product-price">
                            <%# Eval("Gia","{0:N0} đ") %>
                        </div>
                    </div>
                    
                    <div class="product-actions">
                        <asp:LinkButton ID="btnAddCart" runat="server"
                            CssClass="btn-action btn-add"
                            CommandName="addcart"
                            CommandArgument='<%# Eval("ID_SanPham") %>'
                            CausesValidation="false">
                            <i class="fa fa-cart-plus"></i> Thêm giỏ
                        </asp:LinkButton>

                        <a class="btn-action btn-view" href="ChiTietSanPham.aspx?id=<%# Eval("ID_SanPham") %>">
                            Chi tiết
                        </a>
                    </div>

                </div> 
            </ItemTemplate>
        </asp:Repeater>
    </div>

</asp:Content>