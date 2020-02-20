using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.OleDb;
using System.Configuration;
using System.Data;

namespace CSI2441_A2_10500789
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.RemoveAll();
        }

        protected void btnlogin_Click(object sender, EventArgs e)
        {
            OleDbConnection con = new OleDbConnection();
            // establish connection  
            con.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");

            con.Open();

            OleDbDataAdapter da = new OleDbDataAdapter("SELECT * FROM [user_details] WHERE [UserEmail]= '" + username.Text + "' AND [UserPassword]='" + password.Text + "'", con);

            DataSet ds = new DataSet();

            da.Fill(ds);



            if (ds.Tables[0].Rows.Count > 0)
            {

                if (ds.Tables[0].Rows[0]["UserType"].ToString() == "0")
                {
                    //activity for eventlog purpose
                    string activity = "logged In";
                    Session["UserType"] = 0;
                    Session["UserName"] = username.Text;
                    string query = "INSERT INTO [eventlog] ([UserName], [UserType], [LoginTime], [Activity])VALUES (('" + username.Text + "'),('" + Session["UserType"] + "'),('" + DateTime.Now.ToString() + "'),('" + activity + "'))";
                    OleDbCommand cmd = new OleDbCommand(query, con);
                    cmd.ExecuteScalar();
                    Response.Redirect("adminmenu.aspx");
                }


                if (ds.Tables[0].Rows[0]["UserType"].ToString() == "1")
                {
                    //activity for eventlog purpose
                    string activity = "logged In";
                    Session["UserType"] = 1;
                    Session["UserName"] = username.Text;
                    string query = "INSERT INTO [eventlog] ([UserName], [UserType], [LoginTime],[Activity])VALUES (('" + username.Text + "'),('" + Session["UserType"] + "'),('" + DateTime.Now.ToString() + "'),('" + activity + "'))";
          
                    OleDbCommand cmd = new OleDbCommand(query, con);
                    
                    cmd.ExecuteScalar();
                    Response.Redirect("MainMenu.aspx");
                }

            }
            else
                {
                    Label3.Text = "Invalid user name or Password!!";
                }

            con.Close();

        }

        protected void btnclear_Click(object sender, EventArgs e)
        {
            username.Text = string.Empty;
            password.Text = string.Empty;
        }
    }
}