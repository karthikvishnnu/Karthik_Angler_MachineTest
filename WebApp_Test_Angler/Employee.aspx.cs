using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
 
using System.Web.Services;
using System.Data.SqlClient;
using System.Web.Script.Services;
using System.Collections.Generic;

public partial class _Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private static readonly string cs =
        ConfigurationManager.ConnectionStrings["testConnectionString"]
        .ConnectionString;

    public class EmployeeModel
    {
        public int EmpId { get; set; }
        public string EmpCode { get; set; }
        public string EmpName { get; set; }
        public string Gender { get; set; }
        public string DOB { get; set; }
        public string DOJ { get; set; }
        public decimal Salary { get; set; }
        public string Address { get; set; }
        public string Status { get; set; }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<EmployeeModel> GetEmployees()
    {

       // System.Diagnostics.Debugger.Launch();
        var employees = new List<EmployeeModel>();

        using (SqlConnection con = new SqlConnection(cs))
        using (SqlCommand cmd = new SqlCommand(
            "dbo.Employee_List", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();

            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                while (dr.Read())
                {
                    employees.Add(new EmployeeModel
                    {
                        EmpId = Convert.ToInt32(dr["EmpId"]),
                        EmpCode = dr["EmpCode"].ToString(),
                        EmpName = dr["EmpName"].ToString(),
                        Gender = dr["Gender"].ToString(),
                        DOB = dr["DOB"].ToString(),
                        DOJ = dr["DOJ"].ToString(),
                        Salary = Convert.ToDecimal(dr["Salary"]),
                        Address = dr["Address"].ToString(),
                        Status = dr["Status"].ToString()
                    });
                }
            }
        }

        return employees;
    }

    [WebMethod]
    public static int SaveEmployee(EmployeeModel emp)
    {
        if (emp == null ||
            string.IsNullOrWhiteSpace(emp.EmpCode) ||
            string.IsNullOrWhiteSpace(emp.EmpName) ||
            emp.Salary < 0 ||
            (emp.Gender != "Male" &&
             emp.Gender != "Female" &&
             emp.Gender != "Other"))
            throw new ArgumentException("Invalid employee data.");

        DateTime dob = DateTime.ParseExact(
            emp.DOB, "yyyy-MM-dd",
            System.Globalization.CultureInfo.InvariantCulture);

        DateTime doj = DateTime.ParseExact(
            emp.DOJ, "yyyy-MM-dd",
            System.Globalization.CultureInfo.InvariantCulture);

        if (dob > DateTime.Today || doj < dob)
            throw new ArgumentException("Invalid DOB or DOJ.");

        using (SqlConnection con = new SqlConnection(cs))
        using (SqlCommand cmd = new SqlCommand(
            "dbo.Employee_Save", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@EmpId", SqlDbType.Int).Value = emp.EmpId;
            cmd.Parameters.Add("@EmpCode", SqlDbType.VarChar, 20).Value = emp.EmpCode;
            cmd.Parameters.Add("@EmpName", SqlDbType.NVarChar, 100).Value = emp.EmpName;
            cmd.Parameters.Add("@Gender", SqlDbType.VarChar, 10).Value = emp.Gender;
            cmd.Parameters.Add("@DOB", SqlDbType.Date).Value = dob;
            cmd.Parameters.Add("@DOJ", SqlDbType.Date).Value = doj;

            var salary = cmd.Parameters.Add("@Salary", SqlDbType.Decimal);
            salary.Precision = 18;
            salary.Scale = 2;
            salary.Value = emp.Salary;

            cmd.Parameters.Add("@Address", SqlDbType.NVarChar, 250).Value =
                (object)emp.Address ?? DBNull.Value;
            cmd.Parameters.Add("@Status", SqlDbType.VarChar).Value = emp.Status;

            con.Open();
            return Convert.ToInt32(cmd.ExecuteScalar());
        }
    }

    [WebMethod]
    public static bool DeleteEmployee(int empId)
    {
        if (empId <= 0)
            throw new ArgumentException("Invalid employee ID.");

        using (SqlConnection con = new SqlConnection(cs))
        using (SqlCommand cmd = new SqlCommand(
            "dbo.Employee_Delete", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@EmpId", SqlDbType.Int).Value = empId;

            con.Open();
            return cmd.ExecuteNonQuery() > 0;
        }
    }
}