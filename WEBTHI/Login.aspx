<%@ Page Title="" Language="C#" MasterPageFile="~/masterfrontend.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
   
/* LOGIN WRAP */
.login-wrap{
    width:900px;
    height:420px;
    margin:60px auto;
    display:flex;
    border:1px solid #c7b299;
    background:#f5efe6;
}

/* LEFT – LOGIN */
.login-left{
    width:50%;
    padding:40px;
    background:#f5efe6;
    color:#5b4636;
}

.login-left h2{
    margin-bottom:30px;
    color:#5b4636;
}

.input-box{
    position:relative;
    margin-bottom:25px;
}

.input-box input{
    width:100%;
    background:none;
    border:none;
    border-bottom:2px solid #c7b299;
    padding:8px 30px 8px 0;
    color:#5b4636;
}

.input-box input::placeholder{
    color:#9c8572;
}

.input-box i{
    position:absolute;
    right:0;
    top:8px;
    color:#9c8572;
}

/* BUTTON */
.btn-login{
    width:100%;
    margin-top:15px;
    padding:10px;
    border:none;
    border-radius:25px;
    background:#c7b299;
    color:#fff;
    font-weight:bold;
}

.btn-login:hover{
    background:#b89d82;
}

.login-link{
    margin-top:15px;
    font-size:14px;
}

.login-link a{
    color:#8a6f55;
    text-decoration:none;
    font-weight:bold;
}

.login-error{
    display:block;
    margin-top:10px;
    color:#c0392b;
}

/* RIGHT – WELCOME */
.login-right{
    width:50%;
    padding:40px;
    background:#e7dbc8;
    color:#5b4636;
    text-align:center;
}

.login-right h1{
    margin-top:60px;
    font-size:34px;
    color:#5b4636;
}

.login-right p{
    color:#6d5642;
    line-height:1.6;
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Breadcrumb" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="login-wrap">

    <!-- LOGIN -->
    <div class="login-left">
        <h2>ĐĂNG NHẬP</h2>

        <div class="input-box">
            <asp:TextBox ID="txt_TenDN" runat="server" placeholder="Tên đăng nhập" />
            <i class="fa-solid fa-user"></i>
        </div>

       <div class="input-box">
    <asp:TextBox ID="txt_matkhau" runat="server" TextMode="Password" placeholder="Mật khẩu" />
    <!-- icon khóa -->
    <i class="fa-solid fa-lock lock-icon"></i>
</div>

        <asp:Button ID="btnLogin" runat="server" Text="Login"
            CssClass="btn-login" OnClick="btnLogin_Click" />

        <div class="login-link">
            Khách hàng mới? 
            <a href="DangKy.aspx">Đăng ký</a>
        </div>

        <asp:Label ID="lbThongBao" runat="server" CssClass="login-error" />
    </div>

    <!-- WELCOME -->
    <div class="login-right">
        <h1>HELLO<br />WELCOME!</h1>
        <p>
            Đăng nhập để mua sắm. <br />
            <br />
            
        </p>
    </div>

</div>
</asp:Content>

