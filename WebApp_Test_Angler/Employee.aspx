<%@ Page Language="C#" AutoEventWireup="true" Debug="true" CodeFile="Employee.aspx.cs" Inherits="_Default" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>

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

            <h3>Employee Master</h3>

            <input type="hidden" id="hdEmpId" value="0" />


            <div class="card">
                <div class="card-header">
                    <div class="row g-3">

                        <div class="col-md-3">
                            <label>Employee Code</label>
                            <input id="txtCode" class="form-control required" maxlength="20" />
                        </div>

                        <div class="col-md-3">
                            <label>Employee Name</label>
                            <input id="txtName" class="form-control required" maxlength="100" />
                        </div>

                        <div class="col-md-3">
                            <label>Gender</label>
                            <select id="ddlGender" class="form-select required">
                                <option value="">Select</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>

                        <div class="col-md-3">
                            <label>Date of Birth</label>
                            <input type="date" id="txtDOB" class="form-control required" />
                        </div>

                        <div class="col-md-3">
                            <label>Date of Joining</label>
                            <input type="date" id="txtDOJ" class="form-control required" />
                        </div>

                        <div class="col-md-3">
                            <label>Salary</label>
                            <input type="number" id="txtSalary"
                                class="form-control required"
                                min="0" step="0.01" />
                        </div>

                        <div class="col-md-4">
                            <label>Address</label>
                            <input id="txtAddress" class="form-control" autocomplete="off" maxlength="250" />
                        </div>

                        <div class="col-md-2">
                            <label>Status</label>
                            <select id="ddlStatus" class="form-select">
                                <option value="Active">Active</option>
                                <option value="Inactive">Inactive</option>
                            </select>
                        </div>

                    </div>

                    <div class="mt-3 mb-4">
                        <button type="button" id="btnSave"
                            class="btn btn-primary">
                            Save</button>
                        <button type="button" id="btnClear"
                            class="btn btn-secondary">
                            Clear</button>
                    </div>
                </div>
                <div class="card-body">
                    <div style="overflow-x: auto">
                        <table id="employeeGrid"></table>
                        <div id="employeePager"></div>
                    </div>
                </div>
            </div>
        </div>

        <script>

            $(document).ready(function () {

                console.log("jQuery Version:", $.fn.jquery);

                if ($.fn.jqGrid) {
                    console.log("jqGrid Loaded Successfully");
                } else {
                    console.log("jqGrid Not Loaded");
                }

            });

            $(function () {

                var apiUrl = '<%= ResolveUrl("~/Employee.aspx") %>';

                function ajaxCall(method, data) {
                    return $.ajax({
                        type: "POST",
                        url: apiUrl + "/" + method,
                        data: JSON.stringify(data || {}),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json"
                    });
                }

                function loadEmployees() {
                    ajaxCall("GetEmployees", {})
                        .done(function (response) {
                            console.log(response);
                            var rows = response.d || [];
                            console.log(response.d);
                            $("#employeeGrid").jqGrid("clearGridData")
                                .jqGrid("setGridParam", {
                                    data: rows,
                                    page: 1
                                })
                                .trigger("reloadGrid");
                        })
                        .fail(function (xhr) {
                            alert("Unable to load employees.");
                            console.error(xhr.responseText);
                        });
                }

                $("#employeeGrid").jqGrid({
                    datatype: "local",
                    data: [],
                    colModel: [
                        { name: "EmpId", label: "ID", key: true, width: 55 },
                        { name: "EmpCode", label: "Code", width: 100 },
                        { name: "EmpName", label: "Name", width: 160 },
                        { name: "Gender", label: "Gender", width: 90 },
                        { name: "DOB", label: "DOB", width: 110 },
                        { name: "DOJ", label: "DOJ", width: 110 },
                        {
                            name: "Salary",
                            label: "Salary",
                            width: 110,
                            align: "right",
                            formatter: "number",
                            formatoptions: { decimalPlaces: 2 }
                        },
                        { name: "Address", label: "Address", width: 180 },
                        {
                            name: "Status",
                            label: "Status",
                            width: 90,
                            formatter: function (value) {
                                return value === true || value === "true"
                                    ? "Active" : "Inactive";
                            }
                        },
                        {
                            name: "Actions",
                            label: "Actions",
                            width: 145,
                            sortable: false,
                            formatter: function (value, options) {
                                var id = Number(options.rowId);

                                return `<button type="button"
                class="btn btn-sm btn-info btn-view" 
                data-id="${id}">View</button></br><button type="button"
                class="btn btn-sm btn-primary btn-edit"
                data-id="${id}">Edit</button></br><button type="button"
                class="btn btn-sm btn-danger btn-delete"
                data-id="${id}">Delete</button> 
        `;
                            }
                        }
                    ],
                    pager: "#employeePager",
                    rowNum: 10,
                    rowList: [5, 10, 20, 50],
                    viewrecords: true,
                    sortname: "EmpId",
                    sortorder: "asc",
                    height: "auto",
                    autowidth: true,
                    caption: "Employee Details"
                });

                $("#employeeGrid").jqGrid("filterToolbar", {
                    searchOnEnter: false,
                    defaultSearch: "cn"
                });

                function validateEmployee() {
                    var valid = true;

                    $(".required").each(function () {
                        var value = $(this).val();

                        if (value === null || String(value).trim() === "") {
                            $(this).addClass("is-invalid");
                            valid = false;
                        } else {
                            $(this).removeClass("is-invalid");
                        }
                    });

                    var dob = $("#txtDOB").val();
                    var doj = $("#txtDOJ").val();
                    var salary = $("#txtSalary").val();

                    if (dob && dob > new Date().toISOString().substring(0, 10)) {
                        $("#txtDOB").addClass("is-invalid");
                        valid = false;
                    }

                    if (dob && doj && doj < dob) {
                        $("#txtDOJ").addClass("is-invalid");
                        valid = false;
                    }

                    if (salary !== "" &&
                        (!Number.isFinite(Number(salary)) || Number(salary) < 0)) {
                        $("#txtSalary").addClass("is-invalid");
                        valid = false;
                    }

                    if (!valid) {
                        alert("Please enter valid employee details.");
                    }

                    return valid;
                }

                $("#btnSave").on("click", function () {

                    if (!validateEmployee()) return;

                    var emp = {
                        EmpId: parseInt($("#hdEmpId").val(), 10) || 0,
                        EmpCode: $("#txtCode").val().trim(),
                        EmpName: $("#txtName").val().trim(),
                        Gender: $("#ddlGender").val(),
                        DOB: $("#txtDOB").val(),
                        DOJ: $("#txtDOJ").val(),
                        Salary: Number($("#txtSalary").val()),
                        Address: $("#txtAddress").val().trim(),
                        Status: $("#ddlStatus").val() === "true"
                    };

                    ajaxCall("SaveEmployee", { emp: emp })
                        .done(function (response) {
                            alert("Employee saved successfully. ID: " + response.d);
                            clearForm();
                            loadEmployees();
                        })
                        .fail(function (xhr) {
                            alert("Unable to save employee.");
                            console.error(xhr.responseText);
                        });
                });

                $(document).on("click", ".btn-edit", function () {

                    var id = $(this).attr("data-id");
                    var row = $("#employeeGrid").jqGrid("getLocalRow", id);

                    if (!row) return;

                    $("#hdEmpId").val(row.EmpId);
                    $("#txtCode").val(row.EmpCode);
                    $("#txtName").val(row.EmpName);
                    $("#ddlGender").val(row.Gender);
                    $("#txtDOB").val(row.DOB);
                    $("#txtDOJ").val(row.DOJ);
                    $("#txtSalary").val(row.Salary);
                    $("#txtAddress").val(row.Address);
                    $("#ddlStatus").val(
                        row.Status === true || row.Status === "true"
                            ? "true" : "false"
                    );

                    $("#btnSave").text("Update");
                    window.scrollTo(0, 0);
                });

                $(document).on("click", ".btn-delete", function () {

                    var id = parseInt($(this).attr("data-id"), 10);

                    if (!confirm("Are you sure you want to delete this employee?"))
                        return;

                    ajaxCall("DeleteEmployee", { empId: id })
                        .done(function (response) {
                            if (response.d) {
                                alert("Employee deleted successfully.");
                                loadEmployees();
                            } else {
                                alert("Employee not found.");
                            }
                        })
                        .fail(function (xhr) {
                            alert("Unable to delete employee.");
                            console.error(xhr.responseText);
                        });
                });

                $(document).on("click", ".btn-view", function () {

                    var empId = $(this).attr("data-id");

                    window.location.href = "EmployeeView.aspx?EmpId=" +
                        encodeURIComponent(empId);

                });

                function clearForm() {

                    location.reload();
                    //$("#hdEmpId").val("0");
                    //$("#txtCode, #txtName, #txtDOB, #txtDOJ, #txtSalary, #txtAddress").val("");
                    //$("#ddlGender").val("");
                    //$("#ddlStatus").val("true");
                    //$(".is-invalid").removeClass("is-invalid");
                    //$("#btnSave").text("Save");
                }

                $("#btnClear").on("click", clearForm);

                loadEmployees();
            });


        </script>
    </form>
</body>
</html>
