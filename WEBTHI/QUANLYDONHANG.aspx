<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="QUANLYDONHANG.aspx.cs" Inherits="QUANLYDONHANG" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .content-wrapper { background: #f4f6f9; padding: 24px; min-height: 500px; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 18px; }
        .page-title { font-size: 24px; font-weight: 700; display: flex; align-items: center; gap: 8px; margin: 0; color: #333; }
        .action-card { background: #fff; border-radius: 8px; padding: 20px; box-shadow: 0 4px 10px rgba(0,0,0,0.05); }
        .gridview { width: 100%; border-collapse: collapse; margin-top: 10px; }
        .gridview th { background: #2c3e50; color: white; padding: 12px; text-align: center; font-weight: 600; }
        .gridview td { padding: 12px; border-bottom: 1px solid #eee; text-align: center; color: #333; }
        .status-0 { color: #f39c12; font-weight: bold; background: #fef5e7; padding: 5px 10px; border-radius: 4px; }
        .status-1 { color: #27ae60; font-weight: bold; background: #eafaf1; padding: 5px 10px; border-radius: 4px; }
        .status-2 { color: #e74c3c; font-weight: bold; background: #fdedec; padding: 5px 10px; border-radius: 4px; }
        .action-btn { display: inline-flex; width: 32px; height: 32px; align-items: center; justify-content: center; border-radius: 5px; color: #fff; text-decoration: none; margin: 0 3px; font-size: 14px; border:none; cursor:pointer; }
        .btn-view { background: #3498db; }
        .btn-accept { background: #27ae60; }
        .btn-cancel { background: #e74c3c; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="content-wrapper">
        <div class="page-header">
            <h2 class="page-title">📦 Quản lý đơn hàng</h2>
            <div class="breadcrumb">
                 <a href="TrangHeThong.aspx" style="text-decoration:none; color:#333;">Home</a> / <span>Đơn hàng</span>
            </div>
        </div>
        <div class="action-card">
            <asp:GridView ID="grvDonHang" runat="server" 
                CssClass="gridview"
                AutoGenerateColumns="False"
                DataKeyNames="ID_DonHang"
                ShowHeaderWhenEmpty="true" 
                EmptyDataText="Hiện tại chưa có đơn hàng nào!"
                OnRowCommand="grvDonHang_RowCommand">
                <Columns>
                    <asp:BoundField DataField="ID_DonHang" HeaderText="Mã đơn" HeaderStyle-Width="80px" />
                    <asp:BoundField DataField="TenKhachHang" HeaderText="Khách hàng" ItemStyle-HorizontalAlign="Left" />
                    <asp:BoundField DataField="NgayDat" HeaderText="Ngày đặt" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                    <asp:BoundField DataField="TongTien" HeaderText="Tổng tiền" DataFormatString="{0:N0} đ" ItemStyle-Font-Bold="true" />
                    <asp:TemplateField HeaderText="Trạng thái">
                        <ItemTemplate>
                            <span class='<%# Eval("TrangThai").ToString()=="0" ? "status-0" : Eval("TrangThai").ToString()=="1" ? "status-1" : "status-2" %>'>
                                <%# Eval("TrangThai").ToString()=="0" ? "Chờ duyệt" : Eval("TrangThai").ToString()=="1" ? "Đã duyệt" : "Đã hủy" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Thao tác" HeaderStyle-Width="140px">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" CommandName="xem" CommandArgument='<%# Eval("ID_DonHang") %>'
                                CssClass="action-btn btn-view" ToolTip="Xem chi tiết">👁</asp:LinkButton>
                            <asp:LinkButton runat="server" CommandName="duyet" CommandArgument='<%# Eval("ID_DonHang") %>'
                                CssClass="action-btn btn-accept" Visible='<%# Eval("TrangThai").ToString()=="0" %>'
                                ToolTip="Duyệt đơn">✔</asp:LinkButton>
                            <asp:LinkButton runat="server" CommandName="huy" CommandArgument='<%# Eval("ID_DonHang") %>'
                                CssClass="action-btn btn-cancel" Visible='<%# Eval("TrangThai").ToString()=="0" %>'
                                OnClientClick="return confirm('Bạn chắc chắn muốn hủy đơn này?')"
                                ToolTip="Hủy đơn">✖</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>