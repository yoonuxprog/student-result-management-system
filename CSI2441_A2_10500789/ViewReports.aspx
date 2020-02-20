<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewReports.aspx.cs" Inherits="CSI2441_A2_10500789.ViewReports" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>viewreports</title>
    <style type="text/css">
        .heading 
        {
            margin-bottom: 68px;
            background-color:black;
            text-align: center;
            color: aqua;
        }
        .button {
          background-color: #e7e7e7; color: black; /* blue */
          border: none;
          
          padding: 7px 15px;
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
        .auto-style6 {
            height: 36px;
            text-align:left;
            align-content:center;
        }
        .buttonview{
            height: 36px;
            text-align:center;
            align-content:center;
        }
        .dropdown{
            margin-left: 26px;
        }
        .auto-style9 {
            margin-left: 76px;
        }
        .auto-style12 {
            margin-left: 105px;
        }
        .auto-style13 {
            height: 36px;
            text-align: center;
            align-content: center;
            margin-left: 79px;
        }
        .auto-style14 {
            height: 36px;
            text-align: center;
            align-content: center;
            margin-left: 78px;
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
        <table>
           
            <tr>
                <td class="auto-style6">
                <asp:Label ID="Label2" runat="server" Text="UnitCode"></asp:Label>
                <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems ="true" OnSelectedIndexChanged ="DropDownList1_SelectedIndexChanged" CssClass="auto-style14">
                <asp:ListItem Text="--Select--" Value="" />
                </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style6">
                <asp:Label ID="Label3" runat="server" Text="StudentId"></asp:Label>
                <asp:TextBox ID="TextBox2" runat="server" CssClass="auto-style9" ></asp:TextBox>
                <asp:RegularExpressionValidator ID="regexpvalidstdid" runat="server" ControlToValidate="TextBox2" ForeColor="Red" ErrorMessage="Invalid StudentId !" ValidationExpression="^[0-9]{8}$" ValidationGroup="onview"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
               <td class="auto-style6">
                <asp:Label ID="Label4" runat="server" Text="Semester"></asp:Label>
                <asp:DropDownList ID="Semesterdrpdown" runat="server" AppendDataBoundItems="true" CssClass="auto-style13">
                     <asp:ListItem Value="" Selected="True">--Select--</asp:ListItem>
                                  <asp:ListItem Value="1">1</asp:ListItem>
                                  <asp:ListItem Value="2">2</asp:ListItem>
                </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style6">
                <asp:Label ID="Label5" runat="server" Text="Year"></asp:Label>
                <asp:TextBox ID="TextBox4" runat="server" CssClass="auto-style12"></asp:TextBox>
                <asp:RegularExpressionValidator ID="regexpvalidyear" ControlToValidate="TextBox4" runat="server" ForeColor="Red" ValidationExpression="^[0-9]{4}$" ErrorMessage="Invalid Year !" ValidationGroup="onview"></asp:RegularExpressionValidator>
                             
                </td>
            </tr>
           
            <tr>
                <td class="buttonview">
                <asp:Button ID="viewgrid" runat="server" Text="View [Combination]" OnClick="viewgrid_Click" ValidationGroup="onview" CssClass="button" Height="40px" Width="216px"/> 
                </td>
            </tr> 
            <tr class="buttonview">
                <td>
                    <asp:Label ID="comberror" runat="server" Text="" ForeColor="Red"></asp:Label>
                </td>
            </tr>

             <tr>
                <td class="buttonview">
                <asp:Button ID="viewall" runat="server" Text="SHOW ALL" OnClick="viewall_Click" CssClass="button" Height="40px" Width="216px"/>
                </td>
            </tr> 
                
               
             
     </table>
         <asp:Label ID="label1" runat="server" Text=""></asp:Label>
            <br />
        <div>
            <asp:GridView ID="GridView1" runat="server"  OnRowCommand ="GridView1_RowCommand" AutoGenerateColumns="False" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowDataBound="GridView1_RowDataBound" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
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
                       </asp:TemplateField> 
                    <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="hunittitle" runat="server" Text="Unit Title"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="lblunittitle" runat="server" Text='<%# Eval("UnitTitle") %>'>  
                                </asp:Label>  
                            </ItemTemplate>  
                        </asp:TemplateField> 
                    <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="hstudentId" runat="server" Text="Student Id"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="lblstudentid" runat="server" Text='<%# Eval("StudentId") %>'> >  
                                </asp:Label>  
                            </ItemTemplate>  
                        </asp:TemplateField>
                     <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="hsemester" runat="server" Text="Semester"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="lblsemester" runat="server" Text='<%# Eval("Semester") %>'>  
                                </asp:Label>  
                            </ItemTemplate>  
                        </asp:TemplateField> 
                     <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="hyear" runat="server" Text="Year"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="lblyear" runat="server" Text='<%# Eval("Year") %>'>  
                                </asp:Label>  
                            </ItemTemplate>  
                      </asp:TemplateField> 
                    <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="hassesment1" runat="server" Text="Assesment 1"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="lblassessment1" runat="server" Text='<%# Eval("Assessment1") %>'>  
                                </asp:Label>  
                            </ItemTemplate>  
                     </asp:TemplateField>
                    <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="hassesment2" runat="server" Text="Assesment 2"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="lblassessment2" runat="server" Text='<%# Eval("Assessment2") %>'>  
                                </asp:Label>  
                            </ItemTemplate>  
                     </asp:TemplateField>
                    <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="hexam" runat="server" Text="Exam Score"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="lblexam" runat="server" Text='<%# Eval("ExamScore") %>'>  
                                </asp:Label>  
                            </ItemTemplate>  
                     </asp:TemplateField>
                    <asp:TemplateField>  
                            <HeaderTemplate>  
                                <asp:Label ID="hunitscore" runat="server" Text="Unit score"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="unit_score" runat="server" Text='<%# Convert.ToDecimal(Eval("Assessment1").ToString()) + Convert.ToDecimal(Eval("Assessment2").ToString()) + Convert.ToDecimal(Eval("ExamScore").ToString()) %>'>  
                                </asp:Label>  
                            </ItemTemplate> 
                     </asp:TemplateField>
                     <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="grade" runat="server" Text="Grade"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="lblgrade" runat="server">  
                                </asp:Label>  
                            </ItemTemplate>  
                     </asp:TemplateField>
                    <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="hphoto" runat="server" Text="StudentPhoto"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>  
                              <asp:Image ID="student_photo" runat="server" ImageUrl='  
                                    <%# Eval("StudentPhoto") %>' Height="100px" Width="100px" />     
                            </ItemTemplate>  
                        </asp:TemplateField>  
                     <asp:TemplateField>  
                            <HeaderStyle CssClass="hdrow" />  
                            <HeaderTemplate>  
                                <asp:Label ID="hsunitoutline" runat="server" Text="Unit outline"></asp:Label>  
                            </HeaderTemplate>  
                            <ItemTemplate>
                                  <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("Data") %>'  
                                            CommandName="Download" Text='<%# Eval("UnitOutline") %>' /> 
                            </ItemTemplate>
                        </asp:TemplateField>  
                </Columns>
                <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F7F7F7" />
                <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                <SortedDescendingCellStyle BackColor="#E5E5E5" />
                <SortedDescendingHeaderStyle BackColor="#242121" />
            </asp:GridView>

            <asp:Label ID="results" runat="server" Text=""></asp:Label>
            <br />
            <asp:Label ID="Avg" runat="server" Text=""></asp:Label>

        </div>
    </form>
</body>
</html>
