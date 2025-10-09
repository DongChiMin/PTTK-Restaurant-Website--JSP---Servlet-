<%-- 
    Document   : ISelectAvailableTables
    Created on : Oct 4, 2025, 9:15:32 AM
    Author     : namv2
--%>

<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Table" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String bookingTimeTimestamp = (String) request.getAttribute("bookingTimeTimestamp");
            String bookingTimeText = (String) request.getAttribute("bookingTimeText");
            if(bookingTimeText != null) {
                // 1. Parse chuỗi thành LocalDateTime
                LocalDateTime startTime = LocalDateTime.parse(bookingTimeTimestamp);

                // 2. Cộng thêm 4 giờ
                LocalDateTime endTime = startTime.plusHours(4);
                
                //Giờ mở cửa hàng
                int officeStartHour = 8;
                int officeEndHour = 24;
                
                // 3. Kiểm tra giờ đặt có nằm trong giờ mở cửa hàng ko
                boolean isWithinOfficeHours = (startTime.getHour() >= officeStartHour && startTime.getHour() < officeEndHour)
                                     && (endTime.getHour() <= officeEndHour);
                
            } else {
                bookingTimeTimestamp = "";
                bookingTimeText = " ";
            }  
        %>
        <h1>Select Tables</h1>
        <form action="SelectAvailableTableServlet" method="get">
            <input type="hidden" name="action" value="checkTable"/>
            <input type="datetime-local" id="timestamp" name="bookingTime" value="<%=bookingTimeTimestamp%>" required>
            <button type="submit">Check table</button>
        </form>

        <!--lấy dữ liệu từ bảng và gửi request-->
        <form id = "tableForm" action = "CreateReservationServlet" method = "get">
            <%
                List<Table> tableList = (List<Table>) request.getAttribute("tableList");
                if (bookingTimeTimestamp == "") {
            %>
            <p>Please select arriving time above</p>
            <%
            } else if (tableList != null && !tableList.isEmpty()) {
            %>
            <span>Booking Time: <%=bookingTimeText%> </span><br><br>
            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>Tên bàn</th>
                    <th>Vị trí</th>
                    <th>Sức chứa</th>
                    <th>Chọn</th>
                </tr>
                <%
                    for (Table table : tableList) {
                %>
                <tr>
                    <td><%= table.getId()%></td>
                    <td><%= table.getName()%></td>
                    <td><%= table.getLocation()%></td>
                    <td><%= table.getCapacity()%></td>
                    <td>
                        <input type="checkbox" name="tableIds" value="<%= table.getId()%>" class="table-checkbox" >
                    </td>
                </tr>

                <%
                    }
                %>
            </table>
            <%
            } else {
            %>
            <p>No table available</p>
            <%
                }
            %>


            <a href = "MenuCustomerServlet">
                <span style="display:inline-block; padding:6px 12px; background:#ccc; border-radius:4px; cursor:pointer;">
                    Cancel
                </span>
            </a>

            <input type="hidden" name="bookingTime" value="<%= bookingTimeTimestamp%>">
            <button type = "submit"> Continue </button>
        </form>

        <script>
            const form = document.getElementById('tableForm');
            form.addEventListener('submit', function (event) {
                // Lấy tất cả checkbox có class 'table-checkbox'
                const checkboxes = document.querySelectorAll('.table-checkbox');

                if (checkboxes.length === 0) {
                    alert('Please select booking time!');
                } else {
                    // Kiểm tra xem có ít nhất 1 checkbox được chọn không
                    const anyChecked = Array.from(checkboxes).some(chk => chk.checked);

                    if (!anyChecked) {
                        alert('Please select at least one table!');
                        event.preventDefault(); // Ngăn gửi form
                    }
                }
            });
        </script>  
    </body>
</html>
