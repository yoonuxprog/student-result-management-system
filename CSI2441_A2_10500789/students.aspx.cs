using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.Data;
namespace CSI2441_A2_10500789
{
    public partial class students : System.Web.UI.Page
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
           
            OleDbConnection conn = new OleDbConnection();
            conn.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");

            conn.Open();

            
            string sql = "select StudentId, StudentPhoto from student_details";

            OleDbDataAdapter SP = new OleDbDataAdapter(sql, conn);
            DataSet ds = new DataSet();
            SP.Fill(ds, "student_details");
            std_gv.DataSource = ds;
            std_gv.DataBind();
            conn.Close();

        }



        protected void std_gv_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

            OleDbConnection con = new OleDbConnection();
            con.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");
            con.Open();

            int index = e.RowIndex;

            GridViewRow row = (GridViewRow)std_gv.Rows[index];

            Label studentId = (Label)row.FindControl("student_id");
            //STRING TO GET PATH TO DELETE THE IMAGE file FROM THE APP DATA (IMAGE) FOLDER
            string getfilepath = "select StudentPhoto from student_details where StudentId='" + studentId.Text + "'";
            //deleting from student table
            string sqlcmd = "delete from student_details where StudentId='" + studentId.Text + "'";
            //sql command to delete all results belonging to this student
            string sqlcmd1 = "delete from results where StudentId='" + studentId.Text + "'";
            OleDbCommand getpath = new OleDbCommand(getfilepath,con);
            OleDbDataReader gtpath = getpath.ExecuteReader();
            string filepath = "";
            while (gtpath.Read())
            {
                filepath = gtpath[0].ToString();
            }

            //string test = "im here" + filepath;

            OleDbCommand cmd = new OleDbCommand(sqlcmd, con);
            OleDbCommand cmd1 = new OleDbCommand(sqlcmd1, con);
            //con.Open();
            int res = cmd.ExecuteNonQuery();
            cmd1.ExecuteNonQuery();
            con.Close();
            //CHECKING IF THE FILE EXISTS
            if (System.IO.File.Exists(Server.MapPath(filepath)))
            {
                //DELETING THE FILE
                System.IO.File.Delete(Request.PhysicalApplicationPath + filepath);
            }

            if (res == 1)
            {
                Response.Write("<script>alert('Deletion done!')</script>");
            }
            Bind();
        }

        protected void std_gv_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            std_gv.EditIndex = -1;
            Bind();
        }

        protected void std_gv_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

            OleDbConnection con = new OleDbConnection();
            con.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");
            con.Open();

            int index = e.RowIndex;
            int checkdeletefile = 0;

            GridViewRow row = (GridViewRow)std_gv.Rows[index];
            Label studentid = (Label)std_gv.Rows[e.RowIndex].FindControl("student_id");
            FileUpload fu = (FileUpload)std_gv.Rows[e.RowIndex].FindControl("edit_student_photo");
            string path = "/Images/";
            if (fu.HasFile)
            {
                path += fu.FileName;
                //save image in folder    
                fu.SaveAs(MapPath(path));
                //check to delete the existing picture from the app data folder
                checkdeletefile = 1;

            }
            else
            {
                // use previous user image if new image is not changed    
                Image img = (Image)std_gv.Rows[e.RowIndex].FindControl("edit_photo");
                path = img.ImageUrl;
            }
         
            
            string sqlstr = "update student_details set StudentPhoto='" + path + "' WHERE StudentId = '" + studentid.Text + "'";


            OleDbCommand cmd1 = new OleDbCommand(sqlstr, con);
            //con.Open();
            int res1 = cmd1.ExecuteNonQuery();
            con.Close();
            if (checkdeletefile==1)
            {
                Image img = (Image)std_gv.Rows[e.RowIndex].FindControl("edit_photo");
                path = img.ImageUrl;
                if (System.IO.File.Exists(Server.MapPath(path)))
                {
                    //DELETING THE FILE
                    System.IO.File.Delete(Request.PhysicalApplicationPath + path);
                }
            }
            if (res1 == 1)
            {
                Response.Write("<script>alert('Updation done!')</script>");
            }
            std_gv.EditIndex = -1;
            Bind();
        }

        protected void std_gv_RowEditing(object sender, GridViewEditEventArgs e)
        {
            std_gv.EditIndex = e.NewEditIndex;
            Bind();
        }

        protected void std_gv_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            OleDbConnection con = new OleDbConnection();
            con.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");


            if (e.CommandName.Equals("ADD"))
            {
               
                try
                { 
                    TextBox addstudentid = (TextBox)std_gv.FooterRow.FindControl("txtstudentid");
                    FileUpload addphoto = (FileUpload)std_gv.FooterRow.FindControl("Photoupload");
                    string path = "/Images/";
                    if (addphoto.HasFile)
                    {
                        // use previous user image if new image is not changed    
                        path += addphoto.FileName;
                        //save image in folder    
                        addphoto.SaveAs(MapPath(path));
                    }


                    con.Open();

                    string str = "INSERT INTO [student_details]  ([StudentId], [StudentPhoto]) VALUES (('" + addstudentid.Text + "'),('" + path + "'))";
                    OleDbCommand myAccessCommand = new OleDbCommand(str, con);
                    myAccessCommand.ExecuteNonQuery();

                    con.Close();

                    Bind();
                }
                catch (OleDbException)
                {
                    Response.Write("<script>alert('The StudentID You Entered Already Exist!')</script>");
                }

            }

            
        }

        protected void std_gv_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void btnGoback_Click(object sender, EventArgs e)
        {
            Response.Redirect("MainMenu.aspx");
        }

        protected void logoutbtn_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Session.Remove("UserType");

            Response.Redirect("~/Login.aspx");
        }
    }
}