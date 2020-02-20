using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.Data;
using System.IO;

namespace CSI2441_A2_10500789
{
    public partial class ViewReports : System.Web.UI.Page
    {
        string unitcode;
        string studentid;
        string semester;
        string year_id;

       
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                bind_dropdownlist();

            }


        }

        private void BindGrid(string varSearchTerm, string UnitTitle, String Semester,  string year)
        {

            //OleDbConnection conn = new OleDbConnection("YOUR CONNECTION STRING"); // calling up your connection string that was configured  in you Web Config File
            OleDbConnection conn = new OleDbConnection();
            conn.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");
 
            conn.Open();

            string sql1 = "SELECT results.StudentId, results.UnitCode, results.Semester, results.Year, results.Assessment1, results.Assessment2, results.ExamScore, unit_details.UnitTitle, unit_details.Data, unit_details.UnitOutline, student_details.StudentPhoto FROM unit_details INNER JOIN(student_details INNER JOIN results ON student_details.StudentId = results.StudentId) ON unit_details.UnitCode = results.UnitCode  where  results.UnitCode like '%" + unitcode + "%' and results.StudentId like '%" + studentid + "%' and results.Semester like '%" + Semester + "%'  and results.Year like '%" + year_id + "%'";
            OleDbDataAdapter SP = new OleDbDataAdapter(sql1, conn);
            DataSet ds = new DataSet();
            SP.Fill(ds, "results");
            SP.Fill(ds, "student_details");
            SP.Fill(ds, "unit_details ");

            GridView1.DataSource = ds;
            //GridView1.DataSource = SP.ExecuteReader();
            GridView1.DataBind();
            conn.Close();
        
        }

        

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
                
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // grading 
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label unitscore = e.Row.FindControl("unit_score") as Label;
                Label grade = e.Row.FindControl("lblgrade") as Label;
                if (unitscore != null)
                {
                    int marks = int.Parse(unitscore.Text);
                    grade.Text = getgrade(marks);

                }
            }
        

            // hiding columns based on search results
            if (unitcode != "")
            {
                e.Row.Cells[0].Visible = false;
            }

            if (studentid != "")
            {
                e.Row.Cells[2].Visible = false;
            }

            if (semester != "")
            {
                e.Row.Cells[3].Visible = false;
            }

            if (year_id != "")
            {
                e.Row.Cells[4].Visible = false;
            }

        }

        
        

        protected void viewgrid_Click(object sender, EventArgs e)
        {

            //unitcode = Request.Form["TextBox1"]; 
            
            unitcode = DropDownList1.SelectedItem.Value;
            studentid = Request.Form["TextBox2"];
            semester = Request.Form["Semesterdrpdown"];
            year_id = Request.Form["TextBox4"];

            string displayId = " ";
            string displayUnit = " ";
            string displaysemester = " ";
            string displayyear = " ";

            if (unitcode == "" && studentid == "" && semester == "" && year_id == "")
            {
                comberror.Text = "Please Fill Minimum OF One Data Feild";
            }
            else
            {
                comberror.Text = "";
                OleDbConnection con = new OleDbConnection();
                con.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");

                string activity = "Viewed Combinatorial Results";
                if (Session["UserName"] != null)
                {
                    string logquery = "INSERT INTO [eventlog] ([UserName], [UserType], [LoginTime], [Activity])VALUES (('" + Session["UserName"] + "'),('" + Session["UserType"] + "'),('" + DateTime.Now.ToString() + "'),('" + activity + "'))";
                    con.Open();
                    OleDbCommand cmd3 = new OleDbCommand(logquery, con);
                    cmd3.ExecuteNonQuery();
                    con.Close();
                }

                BindGrid(unitcode, studentid, semester, year_id);

                int totalresults = get_results();

                int totalscore = get_total();

                Avg.Text = "";
                label1.Text = "";

                if (studentid != "" || unitcode != "" || semester != "" || year_id != "")
                {
                    if (studentid != "")
                    {
                        displayId = "Student ID : " + studentid;
                    }
                    if (unitcode != "")
                    {
                        displayUnit = "UnitCode : " + unitcode;
                    }
                    if (semester != "")
                    {
                        displaysemester = " Semester : " + semester;
                    }
                    if (year_id != "")
                    {
                        displayyear = " " + year_id;
                    }
                    label1.Text = displayId + displayUnit + displaysemester + displayyear;

                }
                int average = 0;
                string grade;
                if (totalresults != 0)
                {
                    average = (totalscore / totalresults);
                    grade = getgrade(average);
                    if (studentid != "")
                    {
                        Avg.Text = "Course Average :" + average.ToString() + "(" + grade + ")";
                    }
                    else if ((unitcode != "" && studentid == ""))
                    {
                        Avg.Text = "Unit Average :" + average.ToString() + "(" + grade + ")";
                    }
                    else if ((semester != "" || year_id != "") && (studentid == "" && unitcode == ""))
                    {
                        Avg.Text = " Average :" + average.ToString() + "(" + grade + ")";
                    }
                    else if (semester == "" && year_id == "" && studentid == "" && unitcode == "")
                    {
                        Avg.Text = " Average :" + average.ToString() + "(" + grade + ")";
                    }


                }
            }
        }


        protected string getgrade(int marks)
        {
            string grade = " ";
            if (marks >= 50 && marks < 60)
            {
                grade = "Pass";
            }
            else if (marks >= 60 && marks < 70)
            {
                grade = "Cr";
            }
            else if (marks >= 70 && marks < 80)
            {
                grade = "D";
            }
            else if (marks >= 80 && marks <= 100)
            {
                grade = "HD";
            }
            else
            {
                grade = "Fail";
            }
            return grade;
        }

        protected int get_total()
        {
            var total = 0;
            foreach (GridViewRow row in GridView1.Rows)
            {
                var numberLabel = row.FindControl("unit_score") as Label;
                int number;
                if (int.TryParse(numberLabel.Text, out number))
                {
                    total += number;
                }
            }

            //Avg.Text = total.ToString();
            return total;
        }


        protected int get_results()
        {
            var colCount = GridView1.Rows.Count;
            if (colCount != 0)
            {
                results.Text = "Results :" + colCount;
            }
            else
            {
                results.Text = "Results : No Results Found !!!";
            }
            return colCount;
        }


        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Download"))
            {

                Response.Clear();
                Response.ContentType = "application/octet-stream";
                string path = Convert.ToString(e.CommandArgument);
                string filename = Path.GetFileName(path);
                Response.AppendHeader("Content-Disposition", "filename=" + filename);
                Response.TransmitFile(Server.MapPath("") + e.CommandArgument);
                Response.End();

            }
        }

        private void bind_dropdownlist()
        {
            
            string sql = "select * from unit_details";
            string connstring = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");
            OleDbDataAdapter dadapter = new OleDbDataAdapter(sql, connstring);
            DataSet dset = new DataSet();
            dadapter.Fill(dset);
            DropDownList1.DataSource = dset.Tables[0];
            DropDownList1.DataTextField = "UnitCode";
            DropDownList1.DataValueField = "UnitCode";
            DropDownList1.DataBind();
            
            //DropDownList1.Items.FindByValue("0").Selected = true;
            //DropDownList1.DataBind();
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            //unitcode = DropDownList1.Text;
        }

        protected void viewall_Click(object sender, EventArgs e)
        {
            unitcode = "";
            studentid = "";
            semester = "";
            year_id = "";
            //emptying the labels 
            label1.Text = "";
            //logging event
            OleDbConnection con = new OleDbConnection();
            con.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");

            string activity = "Viewd All Results";
            if (Session["UserName"] != null)
            {
                string logquery = "INSERT INTO [eventlog] ([UserName], [UserType], [LoginTime], [Activity])VALUES (('" + Session["UserName"] + "'),('" + Session["UserType"] + "'),('" + DateTime.Now.ToString() + "'),('" + activity + "'))";
                con.Open();
                OleDbCommand cmd3 = new OleDbCommand(logquery, con);
                cmd3.ExecuteNonQuery();
                con.Close();
            }

            BindGrid(unitcode, studentid, semester, year_id);

            int totalresults = get_results();

            int totalscore = get_total();
            int average = 0;
            string grade;
            average = (totalscore / totalresults);
            grade = getgrade(average);

            Avg.Text = " Average :" + average.ToString() + "(" + grade + ")";
        }

      
        protected void btnGoback_Click(object sender, EventArgs e)
        {
            Response.Redirect("MainMenu.aspx");
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
    }
}