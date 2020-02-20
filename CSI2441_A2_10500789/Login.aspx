<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CSI2441_A2_10500789.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>login</title>
    <style type="text/css">
        .auto-style1 {
            height: 45px;
            align-content:center;
        }
        .auto-style2 {
            margin-left: 0px;
        }
        .auto-style3 {
            margin-left: 14px;
        }
        .auto-style4 {
            margin-left: 68px;
        }
        .auto-style5 {
            margin-left: 67px;
        }
        .table-style{
           
            text-align:center;
               
        }
        .heading {
                margin-bottom: 68px;
                background-color:black;
                text-align:center;
                color:whitesmoke;
            }
        .login{
            text-align:center;
        }
        .div{
            
            width: 320px;
            padding: 10px;
            border: 5px solid gray;
            margin: 0;
        }

        
        .auto-style6 {
            text-align: center;
            width: 100%;
            height: 127px;
        }

        
    </style>
</head>
<body>
    <form id="form2" runat="server">
        <h1 class="heading" >Unit Management</h1>
         <h1 class="login">LOGIN</h1>
        <div>
        <table class="auto-style6">

            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label1" runat="server" Text="USERNAME"></asp:Label>
                    <asp:TextBox ID="username" runat="server" CssClass="auto-style4"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="username" ErrorMessage="USERNAME CANNOT BE EMPTY" ValidationGroup ="loginvalidator"></asp:RequiredFieldValidator>
                </td>
                
            </tr>
            <tr>
                <td class="auto-style1">
                    <asp:Label ID="Label2" runat="server" Text="PASSWORD"></asp:Label>
                    <asp:TextBox ID="password" runat="server" CssClass="auto-style5" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="password" ErrorMessage="PASSWORD CANNOT BE EMPTY" ValidationGroup="loginvalidator"></asp:RequiredFieldValidator>
                        </td>
                
            </tr>
            <tr>
                <td>
                   <asp:Label ID="Label3" runat="server" Text=" "></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnlogin" runat="server" CssClass="auto-style3" Text="LOGIN" Width="56px" OnClick="btnlogin_Click" ValidationGroup="loginvalidator" />
                    <asp:Button ID="btnclear" runat="server" CssClass="auto-style2" Text="CLEAR" type ="reset" OnClick="btnclear_Click" />
                </td>
                <td class="auto-style1"></td>
                <td class="auto-style1"></td>
            </tr>
        </table>
            </div>
    </form>
</body>
</html>
