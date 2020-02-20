<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageUnits.aspx.cs" Inherits="CSI2441_A2_10500789.ManageUnits" %>

<!DOCTYPE html>

<html  
    xmlns="http://www.w3.org/1999/xhtml">  
    <head runat="server">  
        <title></title>  
        <style>  
        .hdrow {  
        text-align:center;  
        color:White;  
        background-color:black;  
        height:30px;  
        }  
        .gridview  
        {  
        width:50%;  
        background-color:white;  
        margin:0px auto;  
        }  
        .auto-style1 {
            margin-left: 343px;
        }
        .auto-style2 {
            margin-left: 345px;
        }
        .auto-style3 {
            margin-bottom: 68px;
            background-color:black;
            text-align: center;
            color:white;
        }
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
            <div>  
                <h1 style="width: 100%" class="heading">
                <asp:Button ID="btnGoback" runat="server" Text="Go Back" OnClick="btnGoback_Click" CssClass="buttongoback" Height="36px"  />
                <asp:Label ID="headinglbl" runat="server" Text="Manage Results" ></asp:Label>
                <asp:Button ID="logoutbtn" runat="server" Text="LogOut" OnClick="logoutbtn_Click" CssClass="buttonlogout" Height="36px"  />
        </h1> 
                <asp:GridView ID="gv2" runat="server" AutoGenerateColumns="False" OnRowCommand ="gv2_RowCommand" OnRowEditing="gv2_RowEditing" OnRowUpdating="gv2_RowUpdating" OnRowCancelingEdit="gv2_RowCancelingEdit" OnRowDeleting="gv2_RowDeleting" CssClass="gridview" OnPageIndexChanging="gv2_PageIndexChanging" PageSize="5" ShowFooter ="True" AllowPaging="True" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">  
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>  
                    
                        <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="hunitcode" runat="server" Text="Unit Code"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="lblunitcode" runat="server" Text='<%# Eval("UnitCode") %>'>  
                                </asp:Label>  
                            </ItemTemplate>  
                            <EditItemTemplate>  
                                <asp:TextBox ID="editunitcode" runat="server" Text='<%# Eval("UnitCode") %>' MaxLength="7"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="validateeditcode" ControlToValidate ="editunitcode" runat="server" Text="*"  ErrorMessage="UnitCode missing !" ForeColor="Red" ValidationGroup="editvalidator"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidatorunitcode" ControlToValidate="editunitcode" ValidationExpression="^[a-zA-Z]{3}[0-9]{4}$" runat="server" Text="*" ErrorMessage="Invalid UnitCode !" ForeColor="Red" ValidationGroup="editvalidator"></asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="addunitcode" runat="server"  MaxLength ="7"/>
                                <asp:RequiredFieldValidator ID="validateaddcode" ControlToValidate ="addunitcode" runat="server" Text="*"  ErrorMessage="UnitCode missing !" ForeColor="Red" ValidationGroup="addvalidator"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidatorunitcode" ControlToValidate="addunitcode" ValidationExpression="^[a-zA-Z]{3}[0-9]{4}$" runat="server" Text="*" ErrorMessage="Invalid UnitCode !" ForeColor="Red" ValidationGroup="addvalidator"></asp:RegularExpressionValidator>
                            </FooterTemplate>
                        </asp:TemplateField>  
                        <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="htitle" runat="server" Text="Unit  Title"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="lblunittitle" runat="server" Text='<%# Eval("UnitTitle") %>'>  
                                </asp:Label>  
                            </ItemTemplate>  
                            <EditItemTemplate>  
                                <asp:TextBox ID="edittitle" runat="server" Text='<%# Eval("UnitTitle") %>'></asp:TextBox> 
                                <asp:RequiredFieldValidator ID="validateedittitle" ControlToValidate ="edittitle" runat="server" Text="*"  ErrorMessage="Unit Title missing !" ForeColor="Red" ValidationGroup="editvalidator"></asp:RequiredFieldValidator>
                            </EditItemTemplate> 
                            <FooterTemplate>
                                <asp:TextBox ID="addunittitle" runat="server" />
                                 <asp:RequiredFieldValidator ID="validateaddunit" ControlToValidate ="addunittitle" runat="server" Text="*"  ErrorMessage="Unit Title is missing !" ForeColor="Red" ValidationGroup="addvalidator"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>  
                        <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="hcordinator" runat="server" Text="Unit Cordinator"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="lblcordinator" runat="server" Text='<%# Eval("UnitCordinator") %>'>  
                                </asp:Label>  
                            </ItemTemplate>  
                            <EditItemTemplate>  
                                <asp:TextBox ID="editcordinator" runat="server" Text='<%# Eval("UnitCordinator") %>'></asp:TextBox> 
                                <asp:RequiredFieldValidator ID="validateeditcordinator" ControlToValidate ="editcordinator" runat="server" Text="*"  ErrorMessage="Unit Cordinator missing !" ForeColor="Red" ValidationGroup="editvalidator"></asp:RequiredFieldValidator>
                            </EditItemTemplate> 
                            <FooterTemplate>
                                <asp:TextBox ID="addcordinator" runat="server" />
                                 <asp:RequiredFieldValidator ID="validateaddcordinator" ControlToValidate ="addcordinator" runat="server" Text="*"  ErrorMessage="Unit Cordinator is empty !" ForeColor="Red" ValidationGroup="addvalidator"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="Hmaxassessment1" runat="server" Text="Max Assessment 1 score"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="lblassessment1max" runat="server" Text='<%# Eval("MaxAssessment1Score") %>'>  
                                </asp:Label>  
                            </ItemTemplate>  
                            <EditItemTemplate>  
                                <asp:TextBox ID="editassessment1max" runat="server" Text='<%# Eval("MaxAssessment1Score") %>'></asp:TextBox> 
                                <asp:RequiredFieldValidator ID="validateassessment1max" ControlToValidate ="editassessment1max" runat="server" Text="*"  ErrorMessage="Assessment 1 score missing !" ForeColor="Red" ValidationGroup="editvalidator"></asp:RequiredFieldValidator>
                            </EditItemTemplate> 
                            <FooterTemplate>
                                <asp:TextBox ID="addassessment1max" runat="server" />
                                 <asp:RequiredFieldValidator ID="validateassessment1maxadd" ControlToValidate ="addassessment1max" runat="server" Text="*"  ErrorMessage="Assessment 1 score missing !" ForeColor="Red" ValidationGroup="addvalidator"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>
                         <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="Hmaxassessment2" runat="server" Text="Max Assessment 2 score"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="lblassessment2max" runat="server" Text='<%# Eval("MaxAssessment2Score") %>'>  
                                </asp:Label>  
                            </ItemTemplate>  
                            <EditItemTemplate>  
                                <asp:TextBox ID="editassessment2max" runat="server" Text='<%# Eval("MaxAssessment2Score") %>'></asp:TextBox> 
                                <asp:RequiredFieldValidator ID="validateassessment2max" ControlToValidate ="editassessment2max" runat="server" Text="*"  ErrorMessage="Assessment 2 score missing !" ForeColor="Red" ValidationGroup="editvalidator"></asp:RequiredFieldValidator>
                            </EditItemTemplate> 
                            <FooterTemplate>
                                <asp:TextBox ID="addassessment2max" runat="server" />
                                 <asp:RequiredFieldValidator ID="validateassessment2maxadd" ControlToValidate ="addassessment2max" runat="server" Text="*"  ErrorMessage="Assessment 2 score missing !" ForeColor="Red" ValidationGroup="addvalidator"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>
                         <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="Hmaxexamscore" runat="server" Text="Max Exam score"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="lblexamscore" runat="server" Text='<%# Eval("MaxExamScore") %>'>  
                                </asp:Label>  
                            </ItemTemplate>  
                            <EditItemTemplate>  
                                <asp:TextBox ID="editexamscoremax" runat="server" Text='<%# Eval("MaxExamScore") %>'></asp:TextBox> 
                                <asp:RequiredFieldValidator ID="validateexamedit" ControlToValidate ="editexamscoremax" runat="server" Text="*"  ErrorMessage="Max Exam score missing !" ForeColor="Red" ValidationGroup="editvalidator"></asp:RequiredFieldValidator>
                            </EditItemTemplate> 
                            <FooterTemplate>
                                <asp:TextBox ID="addexamscoremax" runat="server" />
                                 <asp:RequiredFieldValidator ID="validateexamadd" ControlToValidate ="addexamscoremax" runat="server" Text="*"  ErrorMessage="Max Exam score missing !" ForeColor="Red" ValidationGroup="addvalidator"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="lbloutline" runat="server" Text="Unit Outline"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>
                                  <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("Data") %>'  
                                            CommandName="Download" Text='<%# Eval("UnitOutline") %>' /> 
                            </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:FileUpload ID="editoutline" runat="server"   /> 
                                    <asp:RegularExpressionValidator ID="edit_pdfs" ForeColor="Red" Text="*" ErrorMessage="Please select a .PDF file !" runat="server" ValidationGroup="editvalidator" ControlToValidate="editoutline" ValidationExpression="^([a-zA-Z].*|[1-9].*)\.(((p|P)(d|D)(f|F)))$"> </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            <FooterTemplate>
                                <asp:FileUpload ID="addpdf" runat="server" /> 
                                 <asp:RequiredFieldValidator ID="validateaddunitoutline" ControlToValidate ="addpdf" runat="server" Text="*"  ErrorMessage="No Files found !" ForeColor="Red" ValidationGroup="addvalidator"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="add_pdfs" ForeColor="Red" Text="*" ErrorMessage="Please select a .PDF file !" runat="server" ValidationGroup="addvalidator" ControlToValidate="addpdf" ValidationExpression="^([a-zA-Z].*|[1-9].*)\.(((p|P)(d|D)(f|F)))$"> </asp:RegularExpressionValidator>
                                
                                </FooterTemplate>
                            </asp:TemplateField>  
                            <asp:TemplateField>  
                                <HeaderStyle CssClass="hdrow" />  
                                <ItemTemplate>  
                                    <asp:Button ID="btnedit" runat="server" Text="Edit" CommandName="Edit" />  
                                    <asp:Button ID="btndelete" runat="server" Text="Delete" CommandName="Delete" OnClientClick="return confirm('Are you sure you want delete');"/>  
                                </ItemTemplate>  
                                <EditItemTemplate>  
                                    <asp:Button ID="btnupdate" runat="server" Text="Update" CommandName="Update" ValidationGroup="editvalidator" />  
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CommandName="Cancel" />  
                                </EditItemTemplate> 
                                <FooterTemplate>
                                 <asp:Button ID="btnAdd" runat="server" Text="ADD" CommandName="ADD" ValidationGroup="addvalidator" />
                            </FooterTemplate>
                            </asp:TemplateField>  
                        </Columns>  
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                  </asp:GridView> 
              </div> 
                <asp:ValidationSummary ID="ValidationSummary1" ForeColor="Red" runat="server" ValidationGroup ="addvalidator" CssClass="auto-style1" Height="42px" Width="492px" />
            <asp:ValidationSummary ID="ValidationSummary2" runat="server" ForeColor ="Red" ValidationGroup="editvalidator" CssClass="auto-style2" />
        </form>  
    </body>  
</html> 