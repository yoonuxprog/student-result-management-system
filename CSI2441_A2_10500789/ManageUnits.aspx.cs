using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using System.Configuration;
using System.IO;

namespace CSI2441_A2_10500789
{
    public partial class ManageUnits : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Bind();
            }
        }

        public void Bind()
        {
            OleDbConnection con = new OleDbConnection();
            con.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");
            con.Open();
            string sql = "SELECT * FROM unit_details";
            OleDbDataAdapter da = new OleDbDataAdapter(sql, con);
 
            DataSet ds = new DataSet();
            da.Fill(ds, "unit_details");
            gv2.DataSource = ds.Tables["unit_details"].DefaultView;
            gv2.DataBind();
            con.Close();

        }

        protected void gv2_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gv2.EditIndex = e.NewEditIndex;
            Bind();
        }

        protected void gv2_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int checkdelete = 0;
            string filepath = "";

            
            try
            {
                OleDbConnection con = new OleDbConnection();
                con.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");
                con.Open();
                int res1 = 0;
                int index = e.RowIndex;

                GridViewRow row = (GridViewRow)gv2.Rows[index];

                TextBox eunitcode = (TextBox)row.FindControl("editunitcode");
                TextBox eunittitle = (TextBox)row.FindControl("edittitle");
                TextBox ecordinator = (TextBox)row.FindControl("editcordinator");
                TextBox eassessment1 = (TextBox)row.FindControl("editassessment1max");
                TextBox eassessment2 = (TextBox)row.FindControl("editassessment2max");
                TextBox editexamscore = (TextBox)row.FindControl("editexamscoremax");
                FileUpload unitoutline = (FileUpload)gv2.Rows[e.RowIndex].FindControl("editoutline");

                if (unitoutline.HasFile)
                {
                    //a variable to check a new file is being uploaded
                    checkdelete = 1;
                    String FileName = unitoutline.PostedFile.FileName;
                    string path = "/Uploads/";
                    FileName = unitoutline.PostedFile.FileName;
                    path += unitoutline.FileName;
                    unitoutline.SaveAs(MapPath(path));

                    //query to get file path to delete pdf document from app folder when updating a new file
                    string getfilepath = "select Data from unit_details where UnitCode='" + eunitcode.Text + "'";
                    OleDbCommand getpath = new OleDbCommand(getfilepath, con);
                    OleDbDataReader gtpath = getpath.ExecuteReader();
                    filepath = "";
                    while (gtpath.Read())
                    {
                        filepath = gtpath[0].ToString();
                    }

                    string sqlstr = "update unit_details set UnitCode='" + eunitcode.Text + "',UnitTitle='" + eunittitle.Text + "',UnitCordinator='" + ecordinator.Text + "',MaxAssessment1Score='" + eassessment1.Text + "',MaxAssessment2Score='" + eassessment2.Text + "',MaxExamScore='" + editexamscore.Text + "',UnitOutline='" + FileName + "',Data='" + path + "'  WHERE UnitCode = '" + eunitcode.Text + "'";
                    OleDbCommand cmd1 = new OleDbCommand(sqlstr, con);
                    res1 = cmd1.ExecuteNonQuery();

                }
                else
                {
                    string sqlstr1 = "update unit_details set UnitCode='" + eunitcode.Text + "',UnitTitle='" + eunittitle.Text + "',UnitCordinator='" + ecordinator.Text + "',MaxAssessment1Score='" + eassessment1.Text + "',MaxAssessment2Score='" + eassessment2.Text + "',MaxExamScore='" + editexamscore.Text + "'  WHERE UnitCode = '" + eunitcode.Text + "'";
                    OleDbCommand cmd2 = new OleDbCommand(sqlstr1, con);
                    res1 = cmd2.ExecuteNonQuery();
                }

                //after updation, deleting the previous file from application folder
                if (checkdelete ==1)
                {
                    if (File.Exists(Server.MapPath(filepath)))
                    {
                        //DELETING THE PDF FILE
                        File.Delete(Request.PhysicalApplicationPath + filepath);
                    }
                }

                //logging the event
                string activity = "Updated Unit Details of UnitCode: " + eunitcode.Text;
                if (Session["UserName"] !=null )
                {
                    string logquery = "INSERT INTO [eventlog] ([UserName], [UserType], [LoginTime], [Activity])VALUES (('" + Session["UserName"] + "'),('" + Session["UserType"] + "'),('" + DateTime.Now.ToString() + "'),('" + activity + "'))";
                    OleDbCommand cmd3 = new OleDbCommand(logquery, con);
                    cmd3.ExecuteNonQuery();
                }
                

                con.Close();

                if (res1 == 1)
                {
                    Response.Write("<script>alert('Updation done!')</script>");
                }
                gv2.EditIndex = -1;
                Bind();
            }
            catch (OleDbException)
            {
                Response.Write("<script>alert('UnitCode You Entered Already Exist!')</script>");
            }
        }

        protected void gv2_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gv2.EditIndex = -1;
            Bind();
        }

        protected void gv2_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            OleDbConnection con = new OleDbConnection();
            con.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");
            con.Open();

            int index = e.RowIndex;

            GridViewRow row = (GridViewRow)gv2.Rows[index];

            Label eunitcode = (Label)row.FindControl("lblunitcode");
            //query to get file path tp delete pdf document from app folder
            string getfilepath = "select Data from unit_details where UnitCode='" + eunitcode.Text + "'";
            //query to delete from unit table
            string sqlcmd = "delete from unit_details where UnitCode='" + eunitcode.Text + "'";
            //query to delete all results from this unit in results table
            string sqlcmd1 = "delete from results where UnitCode='" + eunitcode.Text + "'";

            OleDbCommand getpath = new OleDbCommand(getfilepath, con);
            OleDbDataReader gtpath = getpath.ExecuteReader();
            string filepath = "";
            while (gtpath.Read())
            {
                filepath = gtpath[0].ToString();
            }



            OleDbCommand cmd = new OleDbCommand(sqlcmd, con);
            OleDbCommand cmd1 = new OleDbCommand(sqlcmd1,con);
            //con.Open();
            //int res = 
            int res = cmd.ExecuteNonQuery();
            cmd1.ExecuteNonQuery();
            

            if (File.Exists(Server.MapPath(filepath)))
            {
                //DELETING THE PDF FILE
                File.Delete(Request.PhysicalApplicationPath + filepath);
            }

            //logging the event
            string activity = "Deleted Unit of UnitCode: " + eunitcode.Text;
            if (Session["UserName"] != null)
            {
                string logquery = "INSERT INTO [eventlog] ([UserName], [UserType], [LoginTime], [Activity])VALUES (('" + Session["UserName"] + "'),('" + Session["UserType"] + "'),('" + DateTime.Now.ToString() + "'),('" + activity + "'))";
                OleDbCommand cmd3 = new OleDbCommand(logquery, con);
                cmd3.ExecuteNonQuery();
            }
            con.Close();
            if (res == 1)
            {
                Response.Write("<script>alert('Deletion done!')</script>");
            }
            Bind();


        }

        protected void gv2_RowCommand(object sender, GridViewCommandEventArgs e)

        {
           
            if (e.CommandName.Equals("ADD"))

            {
                try
                {
                    OleDbConnection con = new OleDbConnection();
                    con.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");

                    TextBox unitcode = (TextBox)gv2.FooterRow.FindControl("addunitcode");
                    TextBox unittitle = (TextBox)gv2.FooterRow.FindControl("addunittitle");
                    TextBox unitcordinator = (TextBox)gv2.FooterRow.FindControl("addcordinator");
                    TextBox addassessment1 = (TextBox)gv2.FooterRow.FindControl("addassessment1max");
                    TextBox addassessment2 = (TextBox)gv2.FooterRow.FindControl("addassessment2max");
                    TextBox addexamscore = (TextBox)gv2.FooterRow.FindControl("addexamscoremax");

                    FileUpload addoutline = (FileUpload)gv2.FooterRow.FindControl("addpdf");
                    String FileName = "";
                    string path = "/Uploads/";
                    if (addoutline.HasFile)
                    {
                        path += addoutline.FileName;
                        addoutline.SaveAs(MapPath(path));
                        FileName = addoutline.PostedFile.FileName;
                    }

                   
                    

                    con.Open();
                    if (unitcode.Text != "")
                    {
                        string str = "INSERT INTO [unit_details] ([UnitCode], [UnitTitle], [UnitCordinator], [MaxAssessment1Score], [MaxAssessment2Score], [MaxExamScore], [UnitOutline], [Data]) VALUES (('" + unitcode.Text + "'),('" + unittitle.Text + "'),('" + unitcordinator.Text + "'),('" + addassessment1.Text + "'),('" + addassessment2.Text + "'),('" + addexamscore.Text + "'),('" + FileName + "'), ('" + path + "'))";
                        OleDbCommand myAccessCommand = new OleDbCommand(str, con);
                        myAccessCommand.ExecuteNonQuery();

                    }

                    //logging the event
                    string activity = "Added new Unit with UnitCode: " + unitcode.Text;
                    if (Session["UserName"] != null)
                    {
                        string logquery = "INSERT INTO [eventlog] ([UserName], [UserType], [LoginTime], [Activity])VALUES (('" + Session["UserName"] + "'),('" + Session["UserType"] + "'),('" + DateTime.Now.ToString() + "'),('" + activity + "'))";
                        OleDbCommand cmd3 = new OleDbCommand(logquery, con);
                        cmd3.ExecuteNonQuery();
                    }

                    con.Close();

                    Bind();
                }
                catch (OleDbException )
                {
                    Response.Write("<script>alert('UnitCode You Entered Already Exist!')</script>");
                }

            }

            if (e.CommandName.Equals("Download"))
            {
                Response.Clear();
                Response.ContentType = "application/octet-stream";
                string path = Convert.ToString(e.CommandArgument);
                string filename = Path.GetFileName(path);
                Response.AppendHeader("Content-Disposition", "filename="+ filename);
                Response.TransmitFile(Server.MapPath("")+ e.CommandArgument);
                Response.End();
            }
        }

        protected void gv2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gv2.PageIndex = e.NewPageIndex;
            Bind();
        }

        protected void gv2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void logoutbtn_Click(object sender, EventArgs e)
        {
            //logging the event
            OleDbConnection con = new OleDbConnection();
            con.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");

            string activity = "Logged Out";
            if (Session["UserName"] != null)
            {
                string logquery = "INSERT INTO [eventlog] ([UserName], [UserType], [LoginTime], [Activity])VALUES (('" + Session["UserName"] + "'),('" + Session["UserType"] + "'),('" + DateTime.Now.ToString() + "'),('" + activity + "'))";
                con.Open();
                OleDbCommand cmd3 = new OleDbCommand(logquery, con);
                cmd3.ExecuteNonQuery();
                con.Close();
            }


            Session.Abandon();
            Session.Remove("UserType");
            Response.Redirect("~/Login.aspx");
            
        }

        protected void btnGoback_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminmenu.aspx");
        }

        
    }


}