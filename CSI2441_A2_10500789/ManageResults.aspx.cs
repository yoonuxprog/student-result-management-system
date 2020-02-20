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
    public partial class ManageResults : System.Web.UI.Page
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
            string sql = "select t.StudentId, t.StudentPhoto, tt.UnitCode, tt.Semester, tt.Year, tt.Assessment1, tt.Assessment2, tt.ExamScore from student_details t inner join results tt on t.StudentId=tt.StudentId";
            OleDbDataAdapter SP = new OleDbDataAdapter(sql, conn);
            DataSet ds = new DataSet();
            SP.Fill(ds, "student_details");
            SP.Fill(ds, "Results ");
            gv1.DataSource = ds;
            gv1.DataBind();
            conn.Close();

        }
        


      

        protected void gv1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gv1.EditIndex = e.NewEditIndex;
            Bind();
        }

        protected void gv1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                OleDbConnection con = new OleDbConnection();
                con.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");
                con.Open();

                int index = e.RowIndex;

                GridViewRow row = (GridViewRow)gv1.Rows[index];

                
                Label editunit = (Label)row.FindControl("editunit");
                Label estudentId = (Label)row.FindControl("editstudentId");

                DropDownList esemester = (DropDownList)row.FindControl("edit_semester_id");
                TextBox eyear = (TextBox)row.FindControl("edit_year_id");
                TextBox eassessment1 = (TextBox)row.FindControl("edit_assessment_id");
                TextBox eassessment2 = (TextBox)row.FindControl("edit_assessment2_id");
                TextBox e_examscore = (TextBox)row.FindControl("edit_exam_score");

                string sqlstr = "update results set Semester=" + Convert.ToInt64(esemester.Text) + ",[Year]=" + Convert.ToInt64(eyear.Text) + ",Assessment1=" + Convert.ToInt64(eassessment1.Text) + ",Assessment2=" + Convert.ToInt64(eassessment2.Text) + ",ExamScore=" + Convert.ToInt64(e_examscore.Text) + " WHERE UnitCode = '" + editunit.Text + "' AND StudentId = '" + estudentId.Text + "'";


                OleDbCommand cmd1 = new OleDbCommand(sqlstr, con);
                //con.Open();
                int res1 = cmd1.ExecuteNonQuery();
                //logging the event
                string activity = "Updated Results Details of UnitCode: " + editunit.Text + "StudentId: " + estudentId.Text ;
                if (Session["UserName"] != null)
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
                gv1.EditIndex = -1;
                Bind();
            }
            catch (OleDbException)
            {
                Response.Write("<script>alert('StudentID with the same UnitCode You Entered Already Exist!')</script>");
            }
        }

        protected void gv1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gv1.EditIndex = -1;
            Bind();
        }

        protected void gv1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            OleDbConnection con = new OleDbConnection();
            con.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");
            con.Open();

            int index = e.RowIndex;

            GridViewRow row = (GridViewRow)gv1.Rows[index];

            Label unitcode = (Label)row.FindControl("unit_code");
            Label studentID = (Label)row.FindControl("student_id");
            string sqlcmd = "delete from results where UnitCode='" + unitcode.Text + "' AND StudentId='" + studentID.Text + "' ";

            OleDbCommand cmd = new OleDbCommand(sqlcmd, con);
            //con.Open();
            int res = cmd.ExecuteNonQuery();
            //logging the event
            string activity = "Deleted Results Details of UnitCode: " + unitcode.Text + "StudentId: " + studentID.Text;
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

        protected void gv1_RowCommand(object sender, GridViewCommandEventArgs e)

        {
            OleDbConnection con = new OleDbConnection();
            con.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");


            if (e.CommandName.Equals("ADD"))
            {
                
                try
                {
                    DropDownList addunit = (DropDownList)gv1.FooterRow.FindControl("addunit_code");
                    //TextBox addstudentid = (TextBox)gv1.FooterRow.FindControl("txtstudentid");
                    DropDownList addstudentid = (DropDownList)gv1.FooterRow.FindControl("student_id");
                    DropDownList addsemester = (DropDownList)gv1.FooterRow.FindControl("txtsemesterid");
                    TextBox addyear = (TextBox)gv1.FooterRow.FindControl("txtyear");
                    TextBox addassessment1 = (TextBox)gv1.FooterRow.FindControl("txtassessment1");
                    TextBox addassessment2 = (TextBox)gv1.FooterRow.FindControl("txtassessment2");
                    TextBox addexamscore = (TextBox)gv1.FooterRow.FindControl("txtexamscore");
                    con.Open();
                    int error_assessment1 = get_maxassessment1(addunit.Text, Convert.ToInt32(addassessment1.Text));
                    int error_assessment2 = get_maxassessment2(addunit.Text, Convert.ToInt32(addassessment2.Text));
                    int error_examscore = get_maxexamscore(addunit.Text, Convert.ToInt32(addexamscore.Text));
                    //checking whether the entered results is greater then the max marks described in the database Unit_Details table. 
                    if (error_assessment1==0 && error_assessment2==0 && error_examscore==0)
                    {
                        Label1.Text = "";
                        Label2.Text = "";
                        Label3.Text = "";
                        string str = "INSERT INTO [results] ([StudentId], [UnitCode], [Semester], [Year], [Assessment1], [Assessment2], [ExamScore]) VALUES (('" + addstudentid.Text + "'),('" + addunit.Text + "'),('" + addsemester.Text + "'),('" + addyear.Text + "'),('" + addassessment1.Text + "'),('" + addassessment2.Text + "'),('" + addexamscore.Text + "'))";
                        OleDbCommand myAccessCommand = new OleDbCommand(str, con);
                        myAccessCommand.ExecuteNonQuery();

                        //logging the event
                        string activity = "Added Results of UnitCode: " + addunit.Text + "StudentId: " + addstudentid.Text;
                        if (Session["UserName"] != null)
                        {
                            string logquery = "INSERT INTO [eventlog] ([UserName], [UserType], [LoginTime], [Activity])VALUES (('" + Session["UserName"] + "'),('" + Session["UserType"] + "'),('" + DateTime.Now.ToString() + "'),('" + activity + "'))";
                            OleDbCommand cmd3 = new OleDbCommand(logquery, con);
                            cmd3.ExecuteNonQuery();
                        }

                        con.Close();

                        Bind();
                    }
                    else
                    {
                        //showing the error messages if the marks in the prescribed in the unit table is greater than the entered results
                        if(error_assessment1==1)
                        {
                            Label1.Text = "Assessment 1 marks greater than prescribed marks";
                        }
                        if (error_assessment2 == 1)
                        {
                            Label2.Text = "Assessment 2 marks greater than prescribed marks";
                        }
                        if (error_examscore == 1)
                        {
                            Label3.Text = "Exam Score greater than prescribed Score";
                        }
                    }
                    
                }
                catch(OleDbException)
                {
                    Response.Write("<script>alert('StudentID with the same UnitCode You Entered Already Exist!')</script>");
                }

            }

        }

        protected void gv1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gv1.PageIndex = e.NewPageIndex;
            Bind();
        }

        protected void gv1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType== DataControlRowType.Footer)
            {
                //binding the units from unit table to dropdownlist in unitfeild in gridview footer
                OleDbConnection con = new OleDbConnection();
                con.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");
                con.Open();
                var dropdownunit = (DropDownList)e.Row.FindControl("addunit_code");
                var dropdownstudent = (DropDownList)e.Row.FindControl("student_id");
                string sql = "SELECT * FROM unit_details";
                string sql1 = "SELECT * FROM student_details";
                OleDbCommand cmd = new OleDbCommand(sql,con);
                OleDbCommand cmd1 = new OleDbCommand(sql1, con);
                OleDbDataAdapter oda = new OleDbDataAdapter(cmd);
                OleDbDataAdapter oda1 = new OleDbDataAdapter(cmd1);
                DataTable dt = new DataTable();
                oda.Fill(dt);
                DataTable dt_students = new DataTable();
                oda1.Fill(dt_students);
                con.Close();
                dropdownunit.DataSource = dt;
               
                dropdownunit.DataTextField = "UnitCode";
                dropdownunit.DataValueField = "UnitCode";
                dropdownunit.DataBind();

                dropdownstudent.DataSource = dt_students;
                dropdownstudent.DataTextField = "StudentId";
                dropdownstudent.DataValueField = "StudentId";
                dropdownstudent.DataBind();

            }

         
            
        }

        protected void gv1_DataBound(object sender, EventArgs e)
        {

        }


        public int get_maxassessment1(string unitcode, int assessment1)
        {
            int error = 0;
            string constring = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");
            string query = "SELECT MaxAssessment1Score FROM unit_details  WHERE UnitCode = '" + unitcode + "'";
            using (OleDbConnection con = new OleDbConnection(constring))
            {
                OleDbCommand command = new OleDbCommand(query, con);
                con.Open();
                OleDbDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {

                    while (reader.Read())
                    {

                        string assesment1max = reader.GetValue(0).ToString();

                        if (assessment1 > Convert.ToInt32(assesment1max))
                        {
                            
                            error = 1;
                        }
                       
                    }
                }
                reader.Close();

            }

            return error;
        }

        public int get_maxassessment2(string unitcode, int assessment2)
        {
            int error = 0;
            string constring = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");
            string query = "SELECT MaxAssessment2Score FROM unit_details  WHERE UnitCode = '" + unitcode + "'";
            using (OleDbConnection con = new OleDbConnection(constring))
            {
                OleDbCommand command = new OleDbCommand(query, con);
                con.Open();
                OleDbDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {

                    while (reader.Read())
                    {

                        string assesment2max = reader.GetValue(0).ToString();

                        if (assessment2 > Convert.ToInt32(assesment2max))
                        {

                            error = 1;
                        }

                    }
                }
                reader.Close();
            }

            return error;
        }

        public int get_maxexamscore(string unitcode, int examscore)
        {
            int error = 0;
            string constring = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");
            string query = "SELECT MaxExamScore FROM unit_details  WHERE UnitCode = '" + unitcode + "'";
            using (OleDbConnection con = new OleDbConnection(constring))
            {
                OleDbCommand command = new OleDbCommand(query, con);
                con.Open();
                OleDbDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {

                    while (reader.Read())
                    {

                        string exammarkmax = reader.GetValue(0).ToString();

                        if (examscore > Convert.ToInt32(exammarkmax))
                        {

                            error = 1;
                        }

                    }
                }
                reader.Close();
            }

            return error;
        }







        protected void CustomValidator_assessment1(object source, ServerValidateEventArgs args)
        {
            int error = 0;
            GridViewRow gvrow = (GridViewRow)(source as Control).Parent.Parent;
            Label addunit = (Label)gvrow.FindControl("editunit");
            int assignment1score = int.Parse(args.Value);
            error = get_maxassessment1(addunit.Text, assignment1score);

            if (error==1)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }

        }

        protected void CustomValidator_assessment2(object source, ServerValidateEventArgs args)
        {
            int error = 0;
            GridViewRow gvrow = (GridViewRow)(source as Control).Parent.Parent;
            Label addunit = (Label)gvrow.FindControl("editunit");
            int assignment2score = int.Parse(args.Value);
            error = get_maxassessment2(addunit.Text, assignment2score);

            if (error == 1)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }

        }

        protected void CustomValidator_examscore(object source, ServerValidateEventArgs args)
        {
            int error = 0;
            GridViewRow gvrow = (GridViewRow)(source as Control).Parent.Parent;
            Label addunit = (Label)gvrow.FindControl("editunit");
            int examscore = int.Parse(args.Value);
            error = get_maxexamscore(addunit.Text, examscore);

            if (error == 1)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }

        }

        protected void uploadexcel_Click(object sender, EventArgs e)
        {
            try
            {
                string excelPath = Server.MapPath("~/Files/") + Path.GetFileName(FileUpload2.PostedFile.FileName);
                FileUpload2.SaveAs(excelPath);

                string conString = string.Empty;
                string extension = Path.GetExtension(FileUpload2.PostedFile.FileName);
                switch (extension)
                {
                    case ".xls": //Excel 97-03
                        conString = ConfigurationManager.ConnectionStrings["Excel03ConString"].ConnectionString;
                        break;
                    case ".xlsx": //Excel 07 or higher
                        conString = ConfigurationManager.ConnectionStrings["Excel07+ConString"].ConnectionString;
                        break;

                }
                conString = string.Format(conString, excelPath);
                using (OleDbConnection excel_con = new OleDbConnection(conString))
                {
                    excel_con.Open();
                    string sheet1 = excel_con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null).Rows[0]["TABLE_NAME"].ToString();
                    DataTable dtExcelData = new DataTable();

                    //[OPTIONAL]: It is recommended as otherwise the data will be considered as String by default.
                    dtExcelData.Columns.AddRange(new DataColumn[7]
                        {   new DataColumn("UnitCode", typeof(String)),
                        new DataColumn("StudentId", typeof(int)),
                        new DataColumn("Semester", typeof(int)),
                        new DataColumn("Year", typeof(int)),
                        new DataColumn("Assessment1", typeof(int)),
                        new DataColumn("Assessment2", typeof(int)),
                        new DataColumn("ExamScore", typeof(int)),
                        }
                    );

                    using (OleDbDataAdapter oda = new OleDbDataAdapter("SELECT * FROM [" + sheet1 + "]", excel_con))
                    {
                        oda.Fill(dtExcelData);
                    }
                    excel_con.Close();


                    int res = 0;
                    OleDbConnection con = new OleDbConnection();
                    con.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("RMS_A2.mdb");
                    con.Open();
                    foreach (DataRow r in dtExcelData.Rows)
                    {
                        OleDbCommand comm = new OleDbCommand("insert into results(UnitCode, StudentId, Semester, [Year], Assessment1, Assessment2, ExamScore) values(@UnitCode, @StudentId, @Semester, @Year, @Assessment1, @Assessment2, @ExamScore)", con);
                        comm.Parameters.AddWithValue("@UnitCode", r[0]);
                        comm.Parameters.AddWithValue("@StudentId", r[1].ToString());
                        comm.Parameters.AddWithValue("@Semester", r[2].ToString());
                        comm.Parameters.AddWithValue("@Year", r[3].ToString());
                        comm.Parameters.AddWithValue("@Assessment1", r[4].ToString());
                        comm.Parameters.AddWithValue("@Assessment2", r[5].ToString());
                        comm.Parameters.AddWithValue("@ExamScore", r[6].ToString());
                        res = comm.ExecuteNonQuery();
                        
                    }
                    //logging the event
                    string activity = "Added Results through an ExcelFile";
                    if (Session["UserName"] != null)
                    {
                        string logquery = "INSERT INTO [eventlog] ([UserName], [UserType], [LoginTime], [Activity])VALUES (('" + Session["UserName"] + "'),('" + Session["UserType"] + "'),('" + DateTime.Now.ToString() + "'),('" + activity + "'))";
                        OleDbCommand cmd3 = new OleDbCommand(logquery, con);
                        cmd3.ExecuteNonQuery();
                    }
                    con.Close();
                }

                Bind();
            }catch (OleDbException )
            {
                Response.Write("<script> alert('Results for the StudentID with the same UnitCode You Entered Already Exist!')</script>");
            }
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