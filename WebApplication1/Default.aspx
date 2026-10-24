<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1._Default" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <%--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />--%>
    <%--<link href="file:///g:\repos\webapplication1\content\bootstrap.min.css" rel="stylesheet" />--%>

    <script>

        $(document).ready(function () {
            $("#txt_EmployeeName").val("karthik");


            $.ajax({
                url: '<%= ResolveUrl("~/Default.aspx/GetCurrentDateTime") %>',
                type: "GET",
                contentType: "application/json; charset=utf-8",
                 
                dataType: "json",
                success: function (response) {
                    console.log("AJAX request successful. Response:", response);
                    console.log("Current Date and Time:", response.d);
                    var employeeName = response.d;
                    $("#txt_EmployeeName").val(employeeName);
                },
                error: function (xhr, status, error) {
                    console.error("Error occurred while fetching employee name:", error);
                }
            });

        });

    </script>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card">
        <div class="card-header">
            <div class="row" >
                <div class="form-gr">
                    <input type="text" id="txt_EmployeeName"  class="form-control form-control-sm" name="name" value="" />
                </div>
            </div>
        </div>
        <div class="card-body">
        </div>
        <div class="card-footer">

        </div>

    </div>
    <%--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>--%>
    <%--<script src="file:///g:\repos\webapplication1\scripts\bootstrap.bundle.min.js"></script>--%>
</asp:Content>
