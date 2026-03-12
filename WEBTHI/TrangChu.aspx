<%@ Page Title="" Language="C#" MasterPageFile="~/masterfrontend.master" AutoEventWireup="true" CodeFile="TrangChu.aspx.cs" Inherits="TrangChu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        /* ===== TỔNG THỂ ===== */
        .home-wrapper { background: #f6f5f3; padding: 40px 0 60px; }
        .home-container { max-width: 1200px; margin: 0 auto; padding: 0 20px; }

        /* ===== TIÊU ĐỀ ===== */
        .section-title {
            font-size: 26px; font-weight: 700; margin: 40px 0 30px;
            color: #2b2b2b; text-transform: uppercase; letter-spacing: 1px;
            text-align: center;
        }

        /* ===== GRID SẢN PHẨM NỔI BẬT ===== */
        .product-grid {
            display: grid; 
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 45px; 
            justify-content: center; 
            align-items: stretch;
            padding: 0 10px;
        }

        /* ===== CARD SẢN PHẨM ===== */
        .product-card {
            background: #ffffff; border-radius: 18px; padding: 18px;
            width: 100%; max-width: 280px; box-shadow: 0 8px 22px rgba(0,0,0,0.08);
            transition: transform .25s ease;
            margin: 0 auto;
        }
        .product-card:hover { transform: translateY(-6px); }

        /* ===== ẢNH SẢN PHẨM ===== */
        .product-img { 
            width: 100%; height: 200px; border-radius: 14px; 
            overflow: hidden; background: #fff; position: relative; 
        }
        .product-img img { width: 100%; height: 100%; object-fit: cover; }

        /* ===== TEM HẾT HÀNG ===== */
        .badge-hethang {
            position: absolute; top: 10px; right: 10px;
            background: #c0392b; color: #fff;
            padding: 5px 12px; font-size: 11px; font-weight: bold;
            border-radius: 4px; z-index: 5;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }

        /* ===== INFO SẢN PHẨM ===== */
        .product-name { margin-top: 14px; font-size: 16px; font-weight: 600; color: #2c2c2c; min-height: 44px; }
        .product-price { margin-top: 6px; font-size: 18px; font-weight: 700; color: #7a4a2e; }

        /* ===== ACTION ===== */
        .product-actions { margin-top: 16px; display: flex; justify-content: center; gap: 10px; min-height: 40px; align-items: center; }

        .btn-brown {
            background: #c8a27a; color: #fff; border-radius: 999px;
            padding: 10px 16px; font-size: 14px; font-weight: 600;
            text-decoration: none; transition: background .2s ease;
            cursor: pointer; border: none; 
            display: inline-block; 
        }
        .btn-brown:hover { background: #b18a62; }
        .text-soldout { color: #999; font-weight: 700; font-size: 14px; font-style: italic; }

        /* ===== DANH MỤC ===== */
        .category-grid {
            margin-top: 32px; display: flex; flex-wrap: wrap;         
            justify-content: center; gap: 28px;                
        }
        .category-card {
            background: #fff; border-radius: 16px; padding: 16px;
            width: 220px; box-shadow: 0 6px 18px rgba(0,0,0,0.08);
            text-decoration: none; color: #2b2b2b; display: flex;
            flex-direction: column; align-items: center; transition: transform .2s ease;
        }
        .category-card:hover { transform: translateY(-5px); }
        .category-card img { width: 90px; height: 90px; object-fit: contain; margin: 0 auto 10px; display: block; }
        .category-card div { margin-top: 8px; font-weight: 600; font-size: 15px; text-align: center; }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="home-wrapper">
        <div class="home-container">

            <%-- SẢN PHẨM NỔI BẬT --%>
            <div class="section-title">SẢN PHẨM NỔI BẬT</div>

            <div class="product-grid">
                <asp:Repeater ID="rptNoiBat" runat="server" OnItemCommand="rptNoiBat_ItemCommand">
                    <ItemTemplate>
                        <div class="product-card">
                            <a href="ChiTietSanPham.aspx?id=<%# Eval("ID_SanPham") %>" style="text-decoration:none;color:inherit">
                                <div class="product-img">
                                    <%# Convert.ToInt32(Eval("SoLuong")) <= 0 ? "<span class='badge-hethang'>HẾT HÀNG</span>" : "" %>
                                    <img src='<%# ResolveUrl("~/AnhSP/" + Eval("Anh")) %>' alt='<%# Eval("TenSanPham") %>' />
                                </div>
                                <div class="product-name"><%# Eval("TenSanPham") %></div>
                            </a>
                            <div class="product-price">
                                <%# String.Format("{0:N0} đ", Eval("Gia")) %>
                            </div>

                            <div class="product-actions">
                                <asp:PlaceHolder ID="phConHang" runat="server" Visible='<%# Convert.ToInt32(Eval("SoLuong")) > 0 %>'>
                                                                 
                                    <asp:LinkButton ID="btnAdd" runat="server" 
                                        CssClass="btn-brown"
                                        CommandName="addcart" 
                                        CommandArgument='<%# Eval("ID_SanPham") %>'
                                        CausesValidation="false">
                                        Thêm vào giỏ
                                    </asp:LinkButton>

                                    <a class="btn-brown" href="ChiTietSanPham.aspx?id=<%# Eval("ID_SanPham") %>">Chi tiết</a>
                                </asp:PlaceHolder>

                                <asp:PlaceHolder ID="phHetHang" runat="server" Visible='<%# Convert.ToInt32(Eval("SoLuong")) <= 0 %>'>
                                    <span class="text-soldout">Tạm hết hàng</span>
                                </asp:PlaceHolder>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <%-- DANH MỤC VÀ LOẠI SẢN PHẨM --%>
            <asp:Repeater ID="rptDanhMuc" runat="server" OnItemDataBound="rptDanhMuc_ItemDataBound">
                <ItemTemplate>
                    <div class="section-title" style="margin-top:60px">
                        <%# Eval("TenDanhMuc") %>
                    </div>
                    <div class="category-grid">
                        <asp:Repeater ID="rptLoai" runat="server">
                            <ItemTemplate>
                                <a class="category-card" href="SanPham.aspx?idLoai=<%# Eval("ID_Loai") %>">
                                    <img src='<%# ResolveUrl("~/anhloai/" + Eval("AnhLoai")) %>' alt='<%# Eval("TenLoai") %>' />
                                    <div><%# Eval("TenLoai") %></div>
                                </a>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

        </div>
    </div>
</asp:Content>