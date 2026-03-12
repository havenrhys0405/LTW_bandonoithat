<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="TrangHeThong.aspx.cs" Inherits="TrangHeThong" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        h2 {
            margin-top: 10px;
            font-weight: 700;
            color: #000;
        }

        .dashboard {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 30px;
            margin-top: 30px;
        }

        .box {
            background: #ffffff;
            border-radius: 18px;
            padding: 28px;
            display: flex;
            align-items: center;
            gap: 22px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.06);
        }

        .icon-box {
            width: 80px;
            height: 80px;
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .icon-box i {
            font-size: 36px;
            color: #fff;
        }

        /* Màu icon */
        .bg-blue { background: #3b9ae1; }
        .bg-purple { background: #9b59b6; }
        .bg-orange { background: #e67e22; }
        .bg-green { background: #27ae60; }
        .bg-pink { background: #e84393; }

        .info p {
            margin: 0;
            font-size: 17px;
            font-weight: 600;
            color: #2c3e50;
        }

        .info label {
            display: block;
            margin-top: 6px;
            font-size: 28px;
            font-weight: bold;
            color: #000;
        }

        .sub-info {
            margin-top: 6px;
            font-size: 14px;
            display: flex;
            gap: 16px;
        }

        .pending {
            color: #f39c12; /* chờ duyệt */
        }

        .cancel {
            color: #e74c3c; /* hủy */
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <h2>THỐNG KÊ HỆ THỐNG</h2>

    <div class="dashboard">

        <div class="box" id="boxDanhMuc" runat="server">
            <div class="icon-box bg-blue">
                <i class="fa fa-folder"></i>
            </div>

            <div class="info">
                <p>Danh mục</p>
                <asp:Label ID="lbDanhMuc" runat="server" Text="0" />
            </div>
        </div>

        <div class="box" id="boxLoaiSP" runat="server">
            <div class="icon-box bg-purple">
                <i class="fa fa-layer-group"></i>
            </div>
            <div class="info">
                <p>Loại sản phẩm</p>
                <asp:Label ID="lbLoaiSP" runat="server" Text="0" />
            </div>
        </div>

        <div class="box">
            <div class="icon-box bg-orange">
                <i class="fa fa-couch"></i>
            </div>
            <div class="info">
                <p>Sản phẩm</p>
                <asp:Label ID="lbSanPham" runat="server" Text="0" />
            </div>
        </div>

        <div class="box"> 
            <div class="icon-box bg-green">
                <i class="fa fa-shopping-cart"></i>
            </div>
            <div class="info">
                <p>Đơn hàng</p>
                <asp:Label ID="lbDonHang" runat="server" Text="0" />
                <div class="sub-info">
                    <span class="pending">
                        Chờ duyệt: <asp:Label ID="lbChoDuyet" runat="server" Text="0" />
                    </span>
                    <span class="cancel">
                        Đã hủy: <asp:Label ID="lbDaHuy" runat="server" Text="0" />
                    </span>
                </div>
            </div>
        </div>

        <div class="box" id="boxKhachHang" runat="server">
            <div class="icon-box bg-pink">
                <i class="fa fa-users"></i>
            </div>
            <div class="info">
                <p>Khách hàng</p>
                <asp:Label ID="lbKhachHang" runat="server" Text="0" />
            </div>
        </div>

    </div>

</asp:Content>