<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="QUANLYNHANVIEN.aspx.cs" Inherits="QUANLYNHANVIEN" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        /* ===== CONTENT ===== */
        .content-wrapper {
            background: #f4f6f9;
            padding: 24px;
            min-height: calc(100vh - 60px); 
        }

        /* ===== HEADER ===== */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
        }

        .page-title {
            font-size: 24px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 0;
            color: #333;
        }

        .breadcrumb {
            background: #eef1f4;
            padding: 8px 18px;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 500;
        }

        /* ===== CARD ===== */
        .action-card {
            background: #fff;
            border-radius: 16px;
            padding: 28px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.08);
        }

        /* ===== GRIDVIEW ===== */
        .gridview {
            width: 100%;
            border-collapse: collapse;
            font-size: 15px;
        }

        .gridview th {
            background: #f8f9fa;
            padding: 14px;
            font-weight: 600;
            text-align: center;
            border-bottom: 2px solid #dee2e6;
            color: #495057;
        }

        .gridview td {
            padding: 14px;
            border-bottom: 1px solid #eee;
            text-align: center;
            vertical-align: middle;
            color: #333;
        }

        .gridview tr:hover {
            background: #f5f7fa;
            transition: 0.2s;
        }

        /* ===== UTILS ===== */
        .text-left {
            text-align: left !important;
            padding-left: 24px !important;
        }

        /* ===== [MỚI] STYLE TRẠNG THÁI & NÚT BẤM ===== */
        .status-active {
            color: #27ae60; font-weight: 700;
            background: rgba(39, 174, 96, 0.1); padding: 6px 12px; border-radius: 20px;
        }
        .status-locked {
            color: #e74c3c; font-weight: 700;
            background: rgba(231, 76, 60, 0.1); padding: 6px 12px; border-radius: 20px;
        }

        .btn-action { text-decoration: none; font-weight: 600; padding: 6px 12px; border-radius: 6px; transition: 0.2s; font-size: 14px; display:inline-block; }
        
        .btn-lock { color: #e74c3c; border: 1px solid #e74c3c; }
        .btn-lock:hover { background: #e74c3c; color: #fff; }

        .btn-unlock { color: #27ae60; border: 1px solid #27ae60; }
        .btn-unlock:hover { background: #27ae60; color: #fff; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="content-wrapper">

        <div class="page-header">
            <h2 class="page-title">👔 Quản lý nhân viên</h2>
            <div class="breadcrumb">
                <a href="TrangHeThong.aspx" style="text-decoration:none; color:#333;">Home</a> / <span style="color:#333;">Nhân viên</span>
            </div>
        </div>

        <div class="action-card">
            <asp:GridView ID="grvNhanVien" 
                runat="server" 
                CssClass="gridview"
                AutoGenerateColumns="False" 
                DataKeyNames="ID_TaiKhoan"
                EmptyDataText="Không có dữ liệu nhân viên nào."
                OnRowCommand="grvNhanVien_RowCommand">

                <Columns>
                    <asp:BoundField DataField="ID_TaiKhoan" 
                        HeaderText="Mã NV" 
                        HeaderStyle-Width="80px" />

                    <asp:BoundField DataField="TenDN" 
                        HeaderText="Tên đăng nhập" 
                        ItemStyle-CssClass="text-left" 
                        HeaderStyle-CssClass="text-left" />

                    <asp:BoundField DataField="HoTen" 
                        HeaderText="Họ tên" 
                        ItemStyle-CssClass="text-left" 
                        HeaderStyle-CssClass="text-left" />

                    <asp:BoundField DataField="SDT" 
                        HeaderText="SĐT" 
                        HeaderStyle-Width="120px" />

                    <asp:TemplateField HeaderText="Trạng thái">
                        <ItemTemplate>
                            <asp:Label runat="server" 
                                Text='<%# Eval("TrangThai") != DBNull.Value && Convert.ToBoolean(Eval("TrangThai")) ? "Đang hoạt động" : "Đã khóa" %>'
                                CssClass='<%# Eval("TrangThai") != DBNull.Value && Convert.ToBoolean(Eval("TrangThai")) ? "status-active" : "status-locked" %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Hành động">
                        <ItemTemplate>
                            <asp:LinkButton runat="server"
                                CommandName="DoiTrangThai"
                                CommandArgument='<%# Eval("ID_TaiKhoan") + "|" + Eval("TrangThai") %>'
                                Text='<%# Eval("TrangThai") != DBNull.Value && Convert.ToBoolean(Eval("TrangThai")) ? "🔒 Khóa" : "🔓 Mở" %>'
                                CssClass='<%# Eval("TrangThai") != DBNull.Value && Convert.ToBoolean(Eval("TrangThai")) ? "btn-action btn-lock" : "btn-action btn-unlock" %>'
                                OnClientClick="return confirm('Bạn có chắc muốn thay đổi trạng thái nhân viên này?');"
                            />
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>

            </asp:GridView>
        </div>
    </div>
</asp:Content>