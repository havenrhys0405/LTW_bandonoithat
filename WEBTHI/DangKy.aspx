<%@ Page Title="" Language="C#" MasterPageFile="~/masterfrontend.master" AutoEventWireup="true" CodeFile="DangKy.aspx.cs" Inherits="DangKy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .login-wrap{
    width:900px;
    margin:60px auto;
    display:flex;
    background:#f5efe6;
    border:1px solid #c7b299;
}

.login-left{
    width:50%;
    padding:40px;
    color:#5b4636;
}

.login-right{
    width:50%;
    padding:40px;
    background:#e7dbc8;
    text-align:center;
    color:#5b4636;
}

.input-box{
    position:relative;
    margin-bottom:20px;
}

.input-box input{
    width:100%;
    border:none;
    border-bottom:2px solid #c7b299;
    background:none;
    padding:8px 30px 8px 0;
}

.input-box i{
    position:absolute;
    right:0;
    top:8px;
    color:#9c8572;
}

.btn-login{
    width:100%;
    padding:10px;
    border:none;
    border-radius:25px;
    background:#c7b299;
    color:#fff;
    font-weight:bold;
}

.login-link{
    margin-top:15px;
    font-size:14px;
}

.login-link a{
    color:#8a6f55;
    font-weight:bold;
    text-decoration:none;
}

.login-error{
    display:block;
    margin-top:10px;
    color:#c0392b;
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Breadcrumb" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="login-wrap">

    <!-- LEFT -->
    <div class="login-left">
        <h2>Sign Up</h2>

        <div class="input-box">
            <asp:TextBox ID="txtUsername" runat="server" placeholder="Tên đăng nhập" />
            <i class="fa-solid fa-user"></i>
        </div>

        <div class="input-box">
            <asp:TextBox ID="txtHoTen" runat="server" placeholder="Họ tên" />
            <i class="fa-solid fa-id-card"></i>
        </div>

        <div class="input-box">
            <asp:TextBox ID="txtSDT" runat="server" placeholder="Số điện thoại" />
            <i class="fa-solid fa-phone"></i>
        </div>

        <div class="input-box">
            <asp:TextBox ID="txtMatKhau" runat="server"
                TextMode="Password" placeholder="Mật khẩu" />
            <i class="fa-solid fa-lock"></i>
        </div>

        <asp:Button ID="btnDangKy" runat="server"
            Text="Đăng ký"
            CssClass="btn-login"
            OnClick="btnDangKy_Click" />

        <div class="login-link">
            Đã có tài khoản?
            <a href="Login.aspx">Đăng nhập</a>
        </div>

        <asp:Label ID="lbThongBao" runat="server"
            CssClass="login-error" />
    </div>

    <!-- RIGHT -->
    <div class="login-right">
        <h1>JOIN WITH US?</h1>
        <p>
            Đăng ký tài khoản để mua sắm nội thất,
            theo dõi đơn hàng và nhận ưu đãi mới nhất.
        </p>
    </div>

</div>
</asp:Content>

