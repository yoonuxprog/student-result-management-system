using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;

namespace CSI2441_A2_10500789
{
    public partial class MainMenu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void Bind()
        {
            OleDbConnection con = new OleDbConnection();
            con.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");
            con.Open();
            string sql = "SELECT UserName, UserType, LoginTime, Activity FROM eventlog  where UserType = 1";
            OleDbDataAdapter da = new OleDbDataAdapter(sql, con);

            DataSet ds = new DataSet();
            da.Fill(ds, "eventlog");
            GridView1.DataSource = ds.Tables["eventlog"].DefaultView;
            GridView1.DataBind();
            con.Close();

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageResults.aspx");
        }

        protected void manage_unit_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewReports.aspx");
        }

        protected void add_students_Click(object sender, EventArgs e)
        {
            Response.Redirect("students.aspx");
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

        protected void show_log_report_Click(object sender, EventArgs e)
        {
            GridView1.Visible = true;
            Hide_log_details.Visible = true;
            Bind();
        }

        protected void Hide_log_details_Click(object sender, EventArgs e)
        {
            GridView1.Visible = false;
            Hide_log_details.Visible = false;
        }
    }
}