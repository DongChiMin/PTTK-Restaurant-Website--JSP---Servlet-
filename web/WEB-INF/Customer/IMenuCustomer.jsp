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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Customer.css">
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar">
            <a href="/RestaurantWeb" class="logo">Restman Restaurant</a>
        </nav>

        <!--Tên tiêu đề chính-->
        <div class="container" style="padding:20px">
            <div style="display: flex; align-items: center; justify-content: center; width: 100%">
                <h2 style="font-size: 32px">CUSTOMER MENU</h2>
            </div>
        </div>
        <%
            Boolean success = (Boolean) request.getAttribute("bookingTableSuccess");
            if (success != null) {
        %>
        <script>
            alert("Your table reservation has been successfully booked!");
        </script>
        <%
            }
        %>
        <div class="container">
            <div style="display: flex; justify-items: center; justify-content: center; width: 100%">
                <form action = "SelectAvailableTablesServlet" method = "get">
                    <button type="submit">
                        Book table
                    </button>
                </form>
            </div>
        </div>
    </body>
</html>
