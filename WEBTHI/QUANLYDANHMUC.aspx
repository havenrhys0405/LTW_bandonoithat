<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="QUANLYDANHMUC.aspx.cs" Inherits="QUANLYDANHMUC" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        /* ===== CÁC CSS CŨ GIỮ NGUYÊN ===== */
        .content-wrapper { background: #f4f6f9; padding: 24px; min-height: 500px; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 18px; }
        .page-title { font-size: 24px; font-weight: 700; display: flex; align-items: center; gap: 8px; margin: 0; color: #333; }
        .breadcrumb { background: #eef1f4; padding: 8px 18px; border-radius: 10px; font-size: 15px; font-weight: 500; }
        .action-card { background: #ffffff; border-radius: 16px; padding: 28px; box-shadow: 0 8px 24px rgba(0,0,0,0.08); }
        
        .btn-add-strong {
            background: linear-gradient(135deg, #28a745, #20c997); color: #fff; border: none;
            padding: 12px 28px; border-radius: 12px; font-size: 15px; font-weight: 600;
            cursor: pointer; box-shadow: 0 4px 12px rgba(40,167,69,0.35);
        }

        .gridview { width: 100%; border-collapse: collapse; margin-top: 22px; }
        .gridview th { background: #2c3e50; color: white; padding: 14px; font-weight: 600; text-align: center; border: 1px solid #2c3e50; }
        .gridview td { padding: 14px; border-bottom: 1px solid #eee; text-align: center; vertical-align: middle; color: #333; }

        .col-id { width: 120px; text-align: center; }
        .col-name { text-align: left !important; padding-left: 24px !important; }
        .action-col { width: 150px; text-align: center; }

        
        .btn-img-action {
            width: 30px;         
            height: 30px;        
            object-fit: contain; /* Giữ tỷ lệ ảnh */
            margin: 0 5px;       /* Khoảng cách giữa các nút */
            cursor: pointer;
            border: none;
            background: transparent;
            vertical-align: middle;
            transition: transform 0.2s;
        }
        
        .btn-img-action:hover {
            transform: scale(1.2); /* Hiệu ứng phóng to khi di chuột */
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="content-wrapper">

        <div class="page-header">
            <h2 class="page-title">
                📁 Quản lý danh mục
            </h2>
            <div class="breadcrumb">
                <a href="TrangHeThong.aspx" style="text-decoration:none; color:#333;">Home</a>
                / <span>Danh mục</span>
            </div>
        </div>

        <div class="action-card">
            <asp:Panel ID="pnlThem" runat="server">
                <div style="text-align:right;">
                    <asp:Button runat="server"
                        Text="➕ THÊM DANH MỤC"
                        CssClass="btn-add-strong"
                        PostBackUrl="~/ThemDanhMuc.aspx" />
                </div>
            </asp:Panel>

            <asp:GridView ID="grvDanhMuc" runat="server"
                CssClass="gridview"
                AutoGenerateColumns="False"
                DataKeyNames="ID_DanhMuc"
                OnRowEditing="grv_RowEditing"
                OnRowDeleting="grv_RowDeleting">

                <Columns>
                    <asp:BoundField DataField="ID_DanhMuc" HeaderText="Mã DM"
                        ItemStyle-CssClass="col-id" HeaderStyle-CssClass="col-id" />

                    <asp:BoundField DataField="TenDanhMuc" HeaderText="Tên danh mục"
                        ItemStyle-CssClass="col-name" HeaderStyle-CssClass="col-name" />

                    <asp:TemplateField HeaderText="Thao tác"
                        ItemStyle-CssClass="action-col" HeaderStyle-CssClass="action-col">
                        <ItemTemplate>
                            
                            <%-- NÚT SỬA  --%>
                            <asp:ImageButton ID="btnSua" runat="server" 
                                CommandName="Edit" 
                                ImageUrl="~/anhuser/sua.jpg" 
                                CssClass="btn-img-action" 
                                ToolTip="Sửa danh mục" />

                            <%-- NÚT XÓA  --%>
                            <asp:ImageButton ID="btnXoa" runat="server" 
                                CommandName="Delete" 
                                ImageUrl="~/anhuser/xoa.jpg" 
                                CssClass="btn-img-action" 
                                ToolTip="Xóa danh mục" 
                                OnClientClick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');" />

                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>