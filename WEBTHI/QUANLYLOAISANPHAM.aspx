<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="QUANLYLOAISANPHAM.aspx.cs" Inherits="QUANLYLOAISANPHAM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        /* ===== TỔNG THỂ ===== */
        .content-wrapper { background: #f4f6f9; padding: 24px; min-height: 80vh; }

        /* ===== HEADER ===== */
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .page-title { font-size: 24px; font-weight: 700; color: #2c3e50; margin: 0; display: flex; align-items: center; gap: 10px; }
        .breadcrumb { background: #eef1f4; padding: 8px 18px; border-radius: 10px; font-size: 14px; }

        /* ===== ACTION CARD ===== */
        .action-card { background: #ffffff; border-radius: 16px; padding: 25px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); }
        .filter-row { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }
        .filter-group { display: flex; align-items: center; gap: 12px; }
        .filter-group label { font-weight: 600; color: #4b5563; }

        /* ===== INPUT & DROPDOWN ===== */
        .select-modern {
            width: 250px; padding: 10px 15px; font-size: 14px; border: 2px solid #e5e7eb;
            border-radius: 8px; outline: none; transition: all 0.3s; background-color: #fff;
        }
        .select-modern:focus { border-color: #3b82f6; box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1); }

        /* ===== BUTTONS ===== */
        .btn-add-strong {
            background: linear-gradient(135deg, #10b981, #059669); color: white;
            border: none; padding: 10px 24px; border-radius: 8px; font-weight: 600;
            cursor: pointer; transition: opacity 0.2s; text-decoration: none;
        }
        .btn-add-strong:hover { opacity: 0.9; }

        /* ===== GRIDVIEW ===== */
        .gridview { width: 100%; border-collapse: collapse; overflow: hidden; border-radius: 12px; }
        .gridview th { background: #f9fafb; padding: 15px; font-weight: 600; color: #374151; border-bottom: 2px solid #f3f4f6; text-align: center; }
        .gridview td { padding: 12px; border-bottom: 1px solid #f3f4f6; text-align: center; vertical-align: middle; color: #4b5563; }
        .gridview tr:hover { background: #fbfcfe; }

        /* ===== CỘT ẢNH LOẠI SP ===== */
        .img-loai { 
            width: 80px; height: 50px; object-fit: cover; 
            border-radius: 8px; border: 1px solid #e5e7eb; background: #eee;
        }

        /* ===== NÚT THAO TÁC (SỬA/XÓA) ===== */
        .btn-img-action {
            width: 30px; height: 30px; object-fit: contain; margin: 0 6px;
            cursor: pointer; transition: transform 0.2s;
            border: none; background: transparent;
        }
        .btn-img-action:hover { transform: scale(1.15); opacity: 0.85; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="content-wrapper">
        <div class="page-header">
            <h2 class="page-title">📦 Quản lý loại sản phẩm</h2>
            <div class="breadcrumb">
                        <a href="TrangHeThong.aspx" style="text-decoration:none; color:#333;">Home</a> / <span>Loại sản phẩm</span>
          </div>
        </div>

        <div class="action-card">
            <div class="filter-row">
                <div class="filter-group">
                    <label>Danh mục:</label>
                    <asp:DropDownList ID="ddlDanhMuc" runat="server" CssClass="select-modern" 
                        AutoPostBack="true" OnSelectedIndexChanged="ddlDanhMuc_SelectedIndexChanged" />
                </div>
                <asp:Button ID="btnThem" runat="server" Text="➕ THÊM LOẠI MỚI" 
                    CssClass="btn-add-strong" PostBackUrl="~/ThemLoaiSanPham.aspx" />
            </div>

            <asp:GridView ID="grvLoai" runat="server" CssClass="gridview" 
                AutoGenerateColumns="False" DataKeyNames="ID_Loai" 
                OnRowEditing="grvLoai_RowEditing" OnRowDeleting="grvLoai_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="ID_Loai" HeaderText="Mã loại" HeaderStyle-Width="100px" />
                    
                    <asp:BoundField DataField="TenLoai" HeaderText="Tên loại sản phẩm" 
                        ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="col-name" 
                        ItemStyle-Font-Bold="true" />

                    <%-- CỘT ẢNH  --%>
                    <asp:TemplateField HeaderText="Hình ảnh" HeaderStyle-Width="150px">
                        <ItemTemplate>
                             <img src='<%# ResolveUrl("~/anhloai/" + Eval("AnhLoai")) %>' class="img-loai" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- CỘT THAO TÁC --%>
                    <asp:TemplateField HeaderText="Thao tác" HeaderStyle-Width="120px">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnSua" runat="server" 
                                CommandName="Edit" 
                                ImageUrl="~/anhuser/sua.jpg" 
                                ToolTip="Chỉnh sửa"
                                CssClass="btn-img-action" />
                            
                            <asp:ImageButton ID="btnXoa" runat="server" 
                                CommandName="Delete" 
                                ImageUrl="~/anhuser/xoa.jpg" 
                                ToolTip="Xóa loại" 
                                OnClientClick="return confirm('Bạn có chắc chắn muốn xóa loại sản phẩm này?')"
                                CssClass="btn-img-action" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div style="text-align:center; padding: 20px; color: #9ca3af;">
                        Không tìm thấy loại sản phẩm nào trong danh mục này.
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</asp:Content>