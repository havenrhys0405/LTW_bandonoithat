<%@ Page Title="" Language="C#" MasterPageFile="~/masterfrontend.master" AutoEventWireup="true" CodeFile="LienHe.aspx.cs" Inherits="LienHe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        /* ===== CSS TRANG TRÍ ===== */
        .contact-container {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            padding: 40px;
            max-width: 800px;
            margin: 0 auto; 
            text-align: center;
        }

        .contact-title {
            font-size: 28px;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 20px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .contact-desc {
            font-size: 16px;
            color: #555;
            line-height: 1.6;
            margin-bottom: 30px;
        }

        .highlight-box {
            background: #fdfbf7; 
            border: 2px dashed #c8a27a; /* Viền nét đứt */
            padding: 25px;
            border-radius: 10px;
            display: inline-block;
            width: 100%;
            max-width: 500px;
        }

        .student-list {
            list-style: none;
            padding: 0;
            margin: 15px 0;
            font-size: 18px;
            font-weight: 600;
            color: #333;
        }
        
        .student-list li {
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .contact-info-line {
            margin-top: 25px;
            font-size: 16px;
            color: #444;
            font-weight: 500;
        }
        
        .contact-icon {
            color: #c8a27a;
            font-size: 20px;
            margin-right: 8px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="contact-container">
        <h2 class="contact-title">Thông Tin Liên Hệ</h2>

        <p class="contact-desc">
            Cảm ơn bạn đã ghé thăm Website Nội Thất của chúng tôi.<br />
            Đây là sản phẩm thực hành môn Lập trình web.
        </p>

        <div class="highlight-box">
            <h3 style="color: #c8a27a; margin-top:0;">THÔNG TIN NHÓM</h3>
            
            <p style="margin-bottom: 15px;">Lớp: <b>CNTTCT1C</b></p>
            
            <ul class="student-list">
                <li>
                    <i class="fa-solid fa-user-graduate contact-icon"></i> 
                    Lê Thị Vân
                </li>
                <li>
                    <i class="fa-solid fa-user-graduate contact-icon"></i> 
                    Vũ Thanh Thảo
                </li>
            </ul>
        </div>

        <div class="contact-info-line">
            <i class="fa-solid fa-envelope contact-icon"></i> 
            Liên hệ tại: <b>aabbcc</b>
        </div>
    </div>

</asp:Content>