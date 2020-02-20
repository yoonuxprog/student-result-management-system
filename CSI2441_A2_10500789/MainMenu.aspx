<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainMenu.aspx.cs" Inherits="CSI2441_A2_10500789.MainMenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Main Menu</title>
      <style type="text/css">
        .heading 
        {
            margin-bottom: 68px;
            background-color:black;
            text-align: center;
            color:white;
        }
        .button 
        {
            background-color: #555555;
            border: none;
            color: white;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;

        }
        .buttonlogout
        {
            background-color: #555555;
            border: none;
            color: white;
            padding: 10px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            float:right;
        }
          .table-style {
              text-align: center;
              
          }
          .rows{
              align-content:center;
          }

          .auto-style3 {
              margin-bottom: 68px;
              background-color: black;
              text-align: center;
              color: white;
              width: 100%;
          }
          .auto-style4 {
              margin-left: 394px;
          }
      </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1 class="auto-style3" >
        <asp:Label ID="Label1" runat="server" Text="Main Menu" ></asp:Label>
        <asp:Button ID="logoutbtn" runat="server" Text="LogOut" OnClick="logoutbtn_Click" CssClass="buttonlogout" Height="36px"  />
        </h1>
        <div>
        </div>

        
       

        
        <table style="width: 100%; height: 127px;" class="table-style">
             <tr>
                <td class="rows">
                     <asp:Button ID="add_students" runat="server" OnClick="add_students_Click" Text="ADD STUDENTS" Width="280px" CssClass="button" />
                </td>
            </tr>
            <tr>
                <td class="rows">
                     <asp:Button ID="manage_result" runat="server" OnClick="Button1_Click" Text="MANAGE RESULTS" Width="280px" CssClass="button" />
                </td>
            </tr>
              <tr>
                <td class="rows">
                     <asp:Button ID="view_reports" runat="server" Text="VIEW REPORTS" OnClick="manage_unit_Click" Width="280px" CssClass="button" />
                </td>
            </tr>
            <tr>
                <td class="rows">
                     <asp:Button ID="show_log_report" runat="server" Text="SHOW LOG REPORT" OnClick="show_log_report_Click" Width="280px" CssClass="button" />
                </td>
            </tr>
             <tr>
                <td class="rows">
                     <asp:Button ID="Hide_log_details" runat="server" Text="HIDE LOG REPORT" OnClick="Hide_log_details_Click" Visible="false" Width="280px" CssClass="button" />
                </td>
            </tr>
         <tr>
                <td class="rows">
           <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" CssClass="auto-style4" ForeColor="Black" GridLines="Vertical" Width="580px">
               <AlternatingRowStyle BackColor="White" />
               <FooterStyle BackColor="#CCCC99" />
               <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
               <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
               <RowStyle BackColor="#F7F7DE" />
               <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
               <SortedAscendingCellStyle BackColor="#FBFBF2" />
               <SortedAscendingHeaderStyle BackColor="#848384" />
               <SortedDescendingCellStyle BackColor="#EAEAD3" />
               <SortedDescendingHeaderStyle BackColor="#575357" />
           </asp:GridView>
          </td>
            </tr>
       </table>
        
    </form>
</body>
</html>
