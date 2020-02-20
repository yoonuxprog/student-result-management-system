<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageResults.aspx.cs" Inherits="CSI2441_A2_10500789.ManageResults" %>

<!DOCTYPE html>  
<html  
    xmlns="http://www.w3.org/1999/xhtml">  
    <head runat="server">  
        <title>ManageResults</title>  
        <style>  
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
        .hdrow 
        {  
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
            margin-left: 345px;
        }
        .auto-style2 {
            margin-left: 346px;
        }
        .auto-style3 {
            width: 476px;
        }
        .auto-style4 {
            margin-left: 112px;
        }
        .auto-style5 {
            margin-left: 84px;
        }
        </style>  
    </head>  
    <body>  
        <form id="form1" runat="server">
             <h1 style="width: 100%" class="heading">
                 <asp:Button ID="btnGoback" runat="server" Text="Go Back" OnClick="btnGoback_Click" CssClass="buttongoback" Height="36px"  />
                <asp:Label ID="headinglbl" runat="server" Text="Manage Results" ></asp:Label>
                <asp:Button ID="logoutbtn" runat="server" Text="LogOut" OnClick="logoutbtn_Click" CssClass="buttonlogout" Height="36px"  />
        </h1> 
            <div>  
                 <table>
                     <tr>
                         <td>
                              <asp:Label ID="textheader" runat="server" Text="IF YOU WISH TO UPLOAD RESULTS PLEASE ATTACH FILE !"></asp:Label>
                         </td>
                     </tr>
                    <tr>
                        <td>
                            <asp:Label ID="excelupload" runat="server" Text="Upload Results"></asp:Label>
                            <asp:FileUpload ID="FileUpload2" runat="server" CssClass="auto-style5" />
                            <asp:RequiredFieldValidator ID="validateuploadfile" runat="server" ControlToValidate="FileUpload2" ErrorMessage="RequiredFieldValidator" ForeColor="Red" Text="Please Attach Excel FIle" ValidationGroup="onupload"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                     <tr>
                        <td>
                            <asp:Button ID="uploadexcel" runat="server" Text="Upload"  ValidationGroup="onupload" OnClick="uploadexcel_Click" />
                        </td>    
                    </tr>
                </table>
                <asp:GridView ID="gv1" runat="server" AutoGenerateColumns="False" OnRowDataBound ="gv1_RowDataBound" OnRowCommand ="gv1_RowCommand" OnRowEditing="gv1_RowEditing" OnRowUpdating="gv1_RowUpdating" OnRowCancelingEdit="gv1_RowCancelingEdit" OnRowDeleting="gv1_RowDeleting" CssClass="gridview" PageSize="5" ShowFooter ="True" AllowPaging="True" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" >  
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>  
                        <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="hlbleid" runat="server" Text="UnitCode"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="unit_code" runat="server" Text='<%# Eval("UnitCode") %>'>  
                                </asp:Label>  
                            </ItemTemplate> 
                           <EditItemTemplate>  
                               <asp:Label ID="editunit" runat="server" Text='<%# Eval("UnitCode") %>'>     </asp:Label> 
                           </EditItemTemplate>
                            <FooterTemplate>
                                <asp:DropDownList ID="addunit_code" runat="server" AppendDataBoundItems ="true">
                                    <asp:ListItem Value ="" Selected="True">-- Select --</asp:ListItem>
                                </asp:DropDownList>
                                  <asp:RequiredFieldValidator ID="validateunitcode" ControlToValidate="addunit_code" Text ="*" ForeColor="Red" runat="server" ErrorMessage="Please select a UnitCode !" ValidationGroup="onadd"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>  
                        <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="hlbleStudentId" runat="server" Text="StudentId "></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="student_id" runat="server" Text='<%# Eval("StudentId") %>'>  
                                </asp:Label>  
                            </ItemTemplate> 
                             <EditItemTemplate>  
                               <asp:Label ID="editstudentId" runat="server" Text='<%# Eval("StudentId") %>'>     </asp:Label> 
                           </EditItemTemplate>
                            <FooterTemplate>
                                <asp:DropDownList ID="student_id" runat="server" AppendDataBoundItems="true">
                                    <asp:ListItem Value ="" Selected="True">-- Select --</asp:ListItem>
                                </asp:DropDownList>
                                
                                  <asp:RequiredFieldValidator ID="validatestudentID" ControlToValidate="student_id" Text ="*" ForeColor="Red" runat="server" ErrorMessage="Please select a student ID !" ValidationGroup="onadd"></asp:RequiredFieldValidator>
                           
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
                            </asp:TemplateField>  
                        <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="hlblsem" runat="server" Text="Semester"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="semester_id" runat="server" Text='<%# Eval("Semester") %>'>  
                                </asp:Label>  
                            </ItemTemplate>  
                            <EditItemTemplate>
                                <asp:DropDownList ID="edit_semester_id" runat="server" SelectedValue='<%#Bind("Semester")%>' AppendDataBoundItems="true">
                                  <asp:ListItem Value="" Selected="True">--Select--</asp:ListItem>
                                  <asp:ListItem Value="1">1</asp:ListItem>
                                  <asp:ListItem Value="2">2</asp:ListItem>
                                </asp:DropDownList>
                                  <asp:RequiredFieldValidator ID="validateeditsemester" ControlToValidate="edit_semester_id" Text ="*" ForeColor="Red" runat="server" ErrorMessage="Semester Missing !" ValidationGroup="onedit"></asp:RequiredFieldValidator>
                             </EditItemTemplate>
                            <FooterTemplate>
                                  <asp:DropDownList ID="txtsemesterid" runat="server">
                                      <asp:ListItem Value="" Selected="True">--Select--</asp:ListItem>
                                      <asp:ListItem Value="1">1</asp:ListItem>
                                      <asp:ListItem Value="2">2</asp:ListItem>
                                  </asp:DropDownList>
                                  <asp:RequiredFieldValidator ID="validatesemester" ControlToValidate="txtsemesterid" Text ="*" ForeColor="Red" runat="server" ErrorMessage="Semester Missing !" ValidationGroup="onadd"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>  
                        <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="hyear" runat="server" Text="Year"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="year_id" runat="server" Text='<%# Eval("Year") %>'>  
                                </asp:Label>  
                            </ItemTemplate>  
                            <EditItemTemplate>  
                                <asp:TextBox ID="edit_year_id" runat="server" Text='<%# Eval("Year") %>'>  
                                </asp:TextBox> 
                                  <asp:RequiredFieldValidator ID="validateedityear" ControlToValidate="edit_year_id" Text ="*" ForeColor="Red" runat="server" ErrorMessage="Year Missing !" ValidationGroup="onedit"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidatoryear" ControlToValidate="edit_year_id" runat="server" Text="*" ForeColor="Red" ValidationExpression="^[0-9]{4}$" ErrorMessage="Invalid Year !" ValidationGroup="onedit"></asp:RegularExpressionValidator>
                             </EditItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtyear" runat="server" />
                                  <asp:RequiredFieldValidator ID="validateyear" ControlToValidate="txtyear" Text ="*" ForeColor="Red" runat="server" ErrorMessage="Year Missing !" ValidationGroup="onadd"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate="txtyear" runat="server" Text="*" ForeColor="Red" ValidationExpression="^[0-9]{4}$" ErrorMessage="Invalid Year !" ValidationGroup="onadd"></asp:RegularExpressionValidator>
                             </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="hassessment1" runat="server" Text="Assessment1 score"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="assessment_id" runat="server" Text='<%# Eval("Assessment1") %>'>  
                                </asp:Label>  
                            </ItemTemplate>  
                            <EditItemTemplate>  
                                <asp:TextBox ID="edit_assessment_id" runat="server" Text='<%# Eval("Assessment1") %>'>  
                                </asp:TextBox>
                                <asp:RequiredFieldValidator ID="validateeditassessment1" ControlToValidate="edit_assessment_id" Text ="*" ForeColor="Red" runat="server" ErrorMessage="Assessment 1 score missing !" ValidationGroup="onedit"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="CustomValidatorassessment1" ControlToValidate="edit_assessment_id" runat="server" Text ="*"  ForeColor="Red" ErrorMessage="Entered Assessment 1 score greater than prespecified score" OnServerValidate="CustomValidator_assessment1" ValidationGroup="onedit"></asp:CustomValidator>
                                </EditItemTemplate> 
                            <FooterTemplate>
                                <asp:TextBox ID="txtassessment1" runat="server" MaxLength="2" />
                                <asp:RequiredFieldValidator ID="validateassessment1" ControlToValidate="txtassessment1" Text ="*" ForeColor="Red" runat="server" ErrorMessage="Assessment 1 score missing !" ValidationGroup="onadd"></asp:RequiredFieldValidator>  
                            </FooterTemplate>
                        </asp:TemplateField>  
                        <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="hassessment2" runat="server" Text="Assessment2 score"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="assessment2_id" runat="server" Text='<%# Eval("Assessment2") %>'>  
                                </asp:Label>  
                            </ItemTemplate>  
                            <EditItemTemplate>  
                                <asp:TextBox ID="edit_assessment2_id" runat="server" Text='<%# Eval("Assessment2") %>'>  
                                </asp:TextBox>
                                <asp:RequiredFieldValidator ID="validateeditassessment2" ControlToValidate="edit_assessment2_id" Text ="*" ForeColor="Red" runat="server" ErrorMessage="Assessment 2 score missing !" ValidationGroup="onedit"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="CustomValidatorassessment2" ControlToValidate="edit_assessment2_id" runat="server" Text ="*"  ForeColor="Red" ErrorMessage="Entered Assessment2 score greater than prespecified score" OnServerValidate="CustomValidator_assessment2" ValidationGroup="onedit"></asp:CustomValidator>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtassessment2" runat="server"  MaxLength="2"/>
                                  <asp:RequiredFieldValidator ID="validateassessment2" ControlToValidate="txtassessment2" Text ="*" ForeColor="Red" runat="server" ErrorMessage="Assessment 2 score Missing !" ValidationGroup="onadd"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField> 
                        <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="hexamscore" runat="server" Text="Exam score"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="exam_score" runat="server" Text='<%# Eval("ExamScore") %>'>  
                                </asp:Label>  
                            </ItemTemplate>  
                            <EditItemTemplate>  
                                <asp:TextBox ID="edit_exam_score" runat="server" Text='<%# Eval("ExamScore") %>' MaxLength="2">  
                                </asp:TextBox> 
                                  <asp:RequiredFieldValidator ID="validateeditexamscore" ControlToValidate="edit_exam_score" Text ="*" ForeColor="Red" runat="server" ErrorMessage="Exam score Missing !" ValidationGroup="onedit"></asp:RequiredFieldValidator>
                             <asp:CustomValidator ID="CustomValidatorexamscore" ControlToValidate="edit_exam_score" runat="server" Text ="*"  ForeColor="Red" ErrorMessage="Entered exam score greater than prespecified score" OnServerValidate="CustomValidator_examscore" ValidationGroup="onedit"></asp:CustomValidator>
                            </EditItemTemplate> 
                            <FooterTemplate>
                                <asp:TextBox ID="txtexamscore" runat="server" MaxLength="2" />
                                  <asp:RequiredFieldValidator ID="validateexamscore" ControlToValidate="txtexamscore" Text ="*" ForeColor="Red" runat="server" ErrorMessage="Exam score Missing !" ValidationGroup="onadd"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>  
                         <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="hunitscore" runat="server" Text="Unit score"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="unit_score" runat="server" Text='<%# Convert.ToDecimal(Eval("Assessment1").ToString()) + Convert.ToDecimal(Eval("Assessment2").ToString()) + Convert.ToDecimal(Eval("ExamScore").ToString()) %>'></asp:Label>  
                            </ItemTemplate>  
                        </asp:TemplateField> 
                            <asp:TemplateField>  
                                <HeaderStyle CssClass="hdrow" />  
                                <ItemTemplate>  
                                    <asp:Button ID="btnedit" runat="server" Text="Edit" CommandName="Edit" />  
                                    <asp:Button ID="btndelete" runat="server" Text="Delete" CommandName="Delete" OnClientClick="return confirm('Are you sure you want delete');" />  
                                </ItemTemplate>  
                                <EditItemTemplate>  
                                    <asp:Button ID="btnupdate" runat="server" Text="Update" CommandName="Update"  ValidationGroup="onedit" />  
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CommandName="Cancel" />  
                                </EditItemTemplate>
                                <FooterTemplate>
                                 <asp:Button ID="btnAdd" runat="server" Text="ADD" CommandName="ADD" ValidationGroup="onadd"  />
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
                <asp:ValidationSummary ID="ValidationSummary1" ForeColor="Red" runat="server"  ValidationGroup="onadd" CssClass="auto-style1"/>
                <asp:ValidationSummary ID="ValidationSummary2" ForeColor="Red" runat="server"  ValidationGroup="onedit" CssClass="auto-style2"/>
                <asp:Label ID="Label1" runat="server" Text="" ForeColor="Red"></asp:Label>
                <br />
                <asp:Label ID="Label2" runat="server" Text="" ForeColor="Red"></asp:Label>
                  <br />
                <asp:Label ID="Label3" runat="server" Text="" ForeColor="Red"></asp:Label>
                  <br />
              </div>  
        </form>  
    </body>  
</html>  
