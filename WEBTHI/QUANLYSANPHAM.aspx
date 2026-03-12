<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="QUANLYSANPHAM.aspx.cs" Inherits="QUANLYSANPHAM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        /* ===== CSS TỔNG THỂ ===== */
        .content-wrapper { background: #f4f6f9; padding: 24px; min-height: 500px; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 18px; }
        .page-title { font-size: 24px; font-weight: 700; color: #333; margin: 0; }
        .breadcrumb { background: #eef1f4; padding: 8px 18px; border-radius: 10px; font-size: 15px; }

        /* ===== THANH CÔNG CỤ (ĐÃ SỬA) ===== */
        .toolbar {
            background: #fff; padding: 15px 20px; border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05); margin-bottom: 20px;
            display: flex; 
            /* Dùng space-between để tách 2 bên trái phải */
            justify-content: space-between; 
            align-items: center;
        }

        /* CSS CHO Ô LỌC (MỚI) */
        .filter-group { display: flex; align-items: center; gap: 10px; }
        .filter-label { font-weight: 600; color: #555; }
        .ddl-filter {
            padding: 8px 12px; border: 1px solid #ddd; border-radius: 6px;
            outline: none; min-width: 200px; font-size: 14px;
        }
        .ddl-filter:focus { border-color: #28a745; }

        .btn-add-strong {
            background: linear-gradient(135deg, #28a745, #20c997); color: #fff;
            border: none; padding: 10px 24px; border-radius: 8px;
            font-weight: 600; cursor: pointer; text-decoration: none;
            box-shadow: 0 4px 10px rgba(40,167,69,0.3);
        }

        /* ===== GRIDVIEW ===== */
        .gridview { width: 100%; border-collapse: collapse; background: #fff; border-radius: 10px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        .gridview th { background: #2c3e50; color: white; padding: 14px; font-weight: 600; text-align: center; }
        .gridview td { padding: 12px; border-bottom: 1px solid #eee; text-align: center; vertical-align: middle; color: #333; }
        
        /* ẢNH SẢN PHẨM TRONG BẢNG */
        .img-product {
            width: 60px; height: 60px; object-fit: cover;
            border-radius: 6px; border: 1px solid #eee;
        }

        /* CÁC NÚT THAO TÁC (SỬA/XÓA) */
        .btn-img-action {
            width: 28px; height: 28px; object-fit: contain;
            margin: 0 4px; cursor: pointer; transition: transform 0.2s;
            border: none; background: transparent;
        }
        .btn-img-action:hover { transform: scale(1.2); }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="content-wrapper">

        <%-- TIÊU ĐỀ --%>
        <div class="page-header">
            <h2 class="page-title">📦 Quản lý sản phẩm</h2>
            <div class="breadcrumb">
                <a href="TrangHeThong.aspx" style="text-decoration:none; color:#333;">Home</a> / <span>Sản phẩm</span>
            </div>
        </div>

        <%-- THANH CÔNG CỤ  --%>
        <div class="toolbar">
            
            <%-- PHẦN BỘ LỌC BÊN TRÁI --%>
            <div class="filter-group">
                <span class="filter-label">Lọc theo loại:</span>
                <asp:DropDownList ID="ddlLoaiSP" runat="server" 
                    CssClass="ddl-filter" 
                    AutoPostBack="true" 
                    OnSelectedIndexChanged="ddlLoaiSP_SelectedIndexChanged">
                </asp:DropDownList>
            </div>

            <%-- NÚT THÊM SP MỚI  --%>
            <a href="ThemSanPham.aspx" class="btn-add-strong" id="lnkThem" runat="server">➕ Thêm sản phẩm mới</a>
        </div>

        <%-- BẢNG DANH SÁCH SẢN PHẨM --%>
        <asp:GridView ID="grvSanPham" runat="server"
            CssClass="gridview"
            AutoGenerateColumns="False"
            DataKeyNames="ID_SanPham"
            OnRowEditing="grv_RowEditing"
            OnRowDeleting="grv_RowDeleting">

            <Columns>
                <asp:BoundField DataField="ID_SanPham" HeaderText="ID" ItemStyle-Width="50px" />
                
                <asp:TemplateField HeaderText="Ảnh" ItemStyle-Width="80px">
                    <ItemTemplate>
                        <img src='<%# ResolveUrl("~/AnhSP/" + Eval("Anh")) %>' class="img-product" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="TenSanPham" HeaderText="Tên sản phẩm" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="250px" />
                
                <asp:TemplateField HeaderText="Giá tiền">
                    <ItemTemplate>
                        <%# String.Format("{0:N0} đ", Eval("Gia")) %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="SoLuong" HeaderText="Kho" ItemStyle-Width="60px" />

                <asp:TemplateField HeaderText="Thao tác" ItemStyle-Width="100px">
                    <ItemTemplate>
                        <%-- Nút Sửa --%>
                        <asp:ImageButton ID="btnSua" runat="server" 
                            CommandName="Edit" 
                            ImageUrl="~/anhuser/sua.jpg" 
                            CssClass="btn-img-action" 
                            ToolTip="Sửa sản phẩm" />

                        <%-- Nút xóa --%>
                        <asp:ImageButton ID="btnXoa" runat="server" 
                            CommandName="Delete" 
                            ImageUrl="~/anhuser/xoa.jpg" 
                            CssClass="btn-img-action" 
                            ToolTip="Xóa sản phẩm" 
                            OnClientClick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');"
                            Visible='<%# Session["UID_Quyen"] != null && Session["UID_Quyen"].ToString() == "1" %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

            <EmptyDataTemplate>
                <div style="padding:20px; text-align:center; color:#888;">
                    Chưa có sản phẩm nào trong hệ thống.
                </div>
            </EmptyDataTemplate>

        </asp:GridView>

    </div>
</asp:Content>