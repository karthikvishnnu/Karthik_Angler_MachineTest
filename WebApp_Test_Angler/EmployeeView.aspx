<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EmployeeView.aspx.cs" Inherits="EmployeeView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
     rel="stylesheet" />

 <!-- jQuery UI CSS -->
 <link href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css"
     rel="stylesheet" />

 <!-- Free jqGrid CSS -->
 <link href="https://cdn.jsdelivr.net/npm/free-jqgrid@4.15.5/css/ui.jqgrid.min.css"
     rel="stylesheet" />


 <!-- jQuery -->
 <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

 <!-- jQuery UI -->
 <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.min.js"></script>

 <!-- Free jqGrid -->
 <script src="https://cdn.jsdelivr.net/npm/free-jqgrid@4.15.5/js/jquery.jqgrid.min.js"></script>

 <!-- Bootstrap JS -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
     
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-4">

            <h3>Employee Details</h3>
            <hr />

            <div class="row mb-3">
                <div class="col-md-3">
                    <b>Employee Code</b>
                </div>
                <div class="col-md-6">
                    <asp:Label ID="lblEmpCode" runat="server" />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-3">
                    <b>Employee Name</b>
                </div>
                <div class="col-md-6">
                    <asp:Label ID="lblEmpName" runat="server" />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-3">
                    <b>Gender</b>
                </div>
                <div class="col-md-6">
                    <asp:Label ID="lblGender" runat="server" />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-3">
                    <b>Date of Birth</b>
                </div>
                <div class="col-md-6">
                    <asp:Label ID="lblDOB" runat="server" />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-3">
                    <b>Date of Joining</b>
                </div>
                <div class="col-md-6">
                    <asp:Label ID="lblDOJ" runat="server" />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-3">
                    <b>Salary</b>
                </div>
                <div class="col-md-6">
                    <asp:Label ID="lblSalary" runat="server" />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-3">
                    <b>Address</b>
                </div>
                <div class="col-md-6">
                    <asp:Label ID="lblAddress" runat="server" />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-3">
                    <b>Status</b>
                </div>
                <div class="col-md-6">
                    <asp:Label ID="lblStatus" runat="server" />
                </div>
            </div>

            <button type="button"
                class="btn btn-secondary"
                onclick="window.location.href='Employee.aspx'">
                Back
            </button>

        </div>
    </form>
</body>
</html>
