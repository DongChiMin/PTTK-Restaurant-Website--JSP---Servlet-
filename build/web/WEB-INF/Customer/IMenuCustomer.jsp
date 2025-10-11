<%-- 
    Document   : IMenuCustomer
    Created on : Oct 1, 2025, 10:40:13 PM
    Author     : namv2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu Customer</title>
    </head>
    <body>
        <%
            Boolean success = (Boolean) request.getAttribute("bookingTableSuccess");
            if(success != null){
                %>
                <script>
                    alert("Your table reservation has been successfully booked!");
                </script>
                <%
            }
        %>
        <h1>Menu Customer</h1>
        <form action = "SelectAvailableTablesServlet" method = "get">
            <button type="submit">
                Book table
            </button>
        </form>
    </body>
</html>
