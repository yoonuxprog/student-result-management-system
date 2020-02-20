<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="students.aspx.cs" Inherits="CSI2441_A2_10500789.students" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>student</title>
    <style>  
        .heading 
        {
            margin-bottom: 68px;
            background-color:black;
            text-align: center;
            color:white;
        }
         .gridview  
        {  
            width:50%;  
            background-color:white;  
            margin:0px auto;  
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
          .buttongoback
        {
            background-color: #555555;
            border: none;
            color: white;
            padding: 10px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            float:left;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <h1 style="width: 100%" class="heading">
         <asp:Button ID="btnGoback" runat="server" Text="Go Back" OnClick="btnGoback_Click" CssClass="buttongoback" Height="36px"  />
        <asp:Label ID="Label1" runat="server" Text="Student Details" ></asp:Label>
        <asp:Button ID="logoutbtn" runat="server" Text="LogOut" OnClick="logoutbtn_Click" CssClass="buttonlogout" Height="36px"  />
        

        </h1> 
        
        <div>
             <asp:GridView ID="std_gv" runat="server" AutoGenerateColumns="False" OnRowDataBound ="std_gv_RowDataBound" OnRowCommand ="std_gv_RowCommand" OnRowEditing="std_gv_RowEditing" OnRowUpdating="std_gv_RowUpdating" OnRowCancelingEdit="std_gv_RowCancelingEdit" OnRowDeleting="std_gv_RowDeleting"  PageSize="5" ShowFooter ="True" AllowPaging="True" CssClass="gridview" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black" >  
                    <Columns>  
                        <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="hlbleStudentId" runat="server" Text="StudentId "></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="student_id" runat="server" Text='<%# Eval("StudentId") %>'>  
                                </asp:Label>  
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtstudentid" runat="server" MaxLength="8" />
                                <asp:RequiredFieldValidator ID="validatestudentid" ControlToValidate="txtstudentid" Text ="*" ForeColor="Red" runat="server" ErrorMessage="StudentId Missing !" ValidationGroup="onadd"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtstudentid" runat="server" Text="*" ForeColor="Red" ValidationExpression="^[0-9]{8}$" ErrorMessage="Invalid StudentId !" ValidationGroup="onadd"></asp:RegularExpressionValidator>
                            </FooterTemplate>
                        </asp:TemplateField>  
                        <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="hlblimg" runat="server" Text="Student photo"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Image ID="student_photo" runat="server" ImageUrl='  
                                    <%# Eval("StudentPhoto") %>' Height="100px" Width="100px" />  
                                </ItemTemplate> 
                            <EditItemTemplate> 
                                    <asp:Image ID="edit_photo" runat="server" ImageUrl='<%# Eval("StudentPhoto") %>'  
                                         Height="80px" Width="100px" /><br />  
                                    <asp:FileUpload ID="edit_student_photo" runat="server" />
                                <asp:RegularExpressionValidator ID="check_pic_format" runat="server" ForeColor="Red" Text="*" ErrorMessage="Allowed Photo Formats - .JPG|.png|.bmp" ControlToValidate="edit_student_photo" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))+(.jpg|.JPG|.png|.PNG|.bmp|.BMP)$" ValidationGroup ="onedit"></asp:RegularExpressionValidator>
                            </EditItemTemplate>
                            <FooterTemplate>
                                 <asp:FileUpload ID="Photoupload" runat="server" />
                                 <asp:RequiredFieldValidator ID="validatestudentphoto" ControlToValidate="Photoupload" Text ="*" ForeColor="Red" runat="server" ErrorMessage="Student Photo Missing !" ValidationGroup="onadd"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="validateaddpicformat" runat="server" ForeColor="Red" Text="*" ErrorMessage="Allowed Photo Formats - .JPG|.png|.bmp" ControlToValidate="Photoupload" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))+(.jpg|.JPG|.png|.PNG|.bmp|.BMP)$" ValidationGroup ="onadd"></asp:RegularExpressionValidator>
                            
                            </FooterTemplate>
                            </asp:TemplateField>   
                            <asp:TemplateField>  
                                <HeaderStyle CssClass="hdrow" />  
                                <ItemTemplate>  
                                    <asp:Button ID="btnedit" runat="server" Text="Edit" CommandName="Edit" />  
                                    <asp:Button ID="btndelete" runat="server" Text="Delete" CommandName="Delete" OnClientClick="return confirm('Are you sure you want delete');" />  
                                </ItemTemplate>  
                                <EditItemTemplate>  
                                    <asp:Button ID="btnupdate" runat="server" Text="Update" CommandName="Update"  ValidationGroup="onedit"   />  
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CommandName="Cancel" />  
                                </EditItemTemplate>
                                <FooterTemplate>
                                 <asp:Button ID="btnAdd" runat="server" Text="ADD" CommandName="ADD" ValidationGroup="onadd"   />
                            </FooterTemplate>
                            </asp:TemplateField>  
                        </Columns>  
                   
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                    <RowStyle BackColor="White" />
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                   
                  </asp:GridView> 
               <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="onadd" ForeColor="Red" />
             <asp:ValidationSummary ID="ValidationSummary2" runat="server" ValidationGroup="onedit" ForeColor="Red" />
            
        </div>
    </form>
</body>
</html>
