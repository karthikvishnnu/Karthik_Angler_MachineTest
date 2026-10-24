<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication2._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script>
    $(document).ready(function () {
        // Get the current date
        var currentDate = new Date();
        // Format the date as "Month Day, Year"
        var options = { year: 'numeric', month: 'long', day: 'numeric' };
        var formattedDate = currentDate.toLocaleDateString('en-US', options);
        // Display the formatted date in the div with id "currentDate"
        $('#currentDate').text(formattedDate);

       <%-- $.ajax({
            url: '<%= ResolveUrl("~/Default.aspx/GetCurrentDateTime") %>',
            data: JSON.stringify({}),
            method: 'POST',
            success: function (data) {
                // Handle the response data
                console.log(data);
                // You can update the UI with the received data here
            },
            error: function (error) {
                console.error('Error fetching data:', error);
            }
        });--%>

        PageMethods.set_path('<%= ResolveUrl("~/Default.aspx") %>')
        PageMethods.GetCurrentDateTime(
            function (result) {
                console.log(result);
            },
            function (error) {
                console.error(error.get_message());
            }
        );

    });

    </script>
     
</asp:Content>
