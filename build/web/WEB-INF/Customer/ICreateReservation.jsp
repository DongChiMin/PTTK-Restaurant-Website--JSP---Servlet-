<%-- 
    Document   : ICreateReservation
    Created on : Oct 4, 2025, 9:15:44 AM
    Author     : namv2
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="model.Table"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String bookingTimeText = (String) request.getAttribute("bookingTimeText");
            String bookingDate = bookingTimeText.split(" ")[0];
            String bookingTime = bookingTimeText.split(" ")[1];
            List<Table> tableList = (List<Table>) request.getAttribute("tableList");
        %>

        <form action = "CreateNewDishServlet" method = "post">
            <label>Name:</label><br>
            <input type="text" name="name" required><br><br>

            <label>Phone number:</label><br>
            <input type="text" name="phoneNumber" required><br><br>

            <label>Email (optional)</label><br>
            <input type="text" name="email"><br><br>

            <label>Note (optional)</label><br>
            <input type="text" name="note"><br><br>

            <span>Selected Table:
                <%
                    for (Table t : tableList) {
                %>
                <p><%= t.getName()%></p>  
                <%
                    }
                %>
            </span><br><br>
            <span>Booking Date: <%= bookingDate %></span><br><br>
            <span>Booking Time: <%= bookingTime %></span><br><br>
            <a href = "SelectAvailableTableServlet">
                <span style="display:inline-block; padding:6px 12px; background:#ccc; border-radius:4px; cursor:pointer;">
                    Cancel
                </span>
            </a>

            <button type = "submit">Confirm</button>
        </form>
    </body>
</html>
