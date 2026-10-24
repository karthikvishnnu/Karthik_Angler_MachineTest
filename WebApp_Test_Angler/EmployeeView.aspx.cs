using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EmployeeView : System.Web.UI.Page
{
    string cs = ConfigurationManager
        .ConnectionStrings["testConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int empId;

            if (int.TryParse(Request.QueryString["EmpId"], out empId)
                && empId > 0)
            {
                LoadEmployee(empId);
                ViewState["EmpId"] = empId;
            }
            else
            {
                Response.Redirect("Employee.aspx");
            }
        }
    }

    private void LoadEmployee(int empId)
    {
        using (SqlConnection con = new SqlConnection(cs))
        using (SqlCommand cmd = new SqlCommand(
            @"SELECT EmpCode, EmpName, Gender, DOB, DOJ,
                     Salary, Address, Status
              FROM dbo.Employee
              WHERE EmpId = @EmpId", con))
        {
            cmd.Parameters.Add("@EmpId", SqlDbType.Int).Value = empId;

            con.Open();

            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                if (dr.Read())
                {
                    lblEmpCode.Text = dr["EmpCode"].ToString();
                    lblEmpName.Text = dr["EmpName"].ToString();
                    lblGender.Text = dr["Gender"].ToString();

                    lblDOB.Text = Convert.ToDateTime(
                        dr["DOB"]).ToString("dd/MM/yyyy");

                    lblDOJ.Text = Convert.ToDateTime(
                        dr["DOJ"]).ToString("dd/MM/yyyy");

                    lblSalary.Text = Convert.ToDecimal(
                        dr["Salary"]).ToString("N2");

                    lblAddress.Text = dr["Address"].ToString();

                    lblStatus.Text =
                        dr["Status"].ToString();   
                }
                else
                {
                    Response.Redirect("Employee.aspx");
                }
            }
        }
    }
}