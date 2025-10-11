<%-- 
    Document   : ISelectAvailableTables
    Created on : Oct 4, 2025, 9:15:32 AM
    Author     : namv2
--%>

<%@page import="java.util.Arrays"%>
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
            String bookingTime = (String) request.getAttribute("bookingTime");
            String endTime = (String) request.getAttribute("endTime");
            String bookingDate = (String) request.getAttribute("bookingDate");
            List<Table> tableList = (List<Table>) request.getAttribute("tableList");
            String[] selectedTableIds = (String[]) request.getAttribute("selectedTableIds");
 
            if (bookingTime == null) {
                bookingTime = "";
            }
            if(endTime == null){
                endTime = "";
            }
            if (bookingDate == null) {
                bookingDate = "";
            }
        %>
        <h1>Select Tables</h1>
        <p>Booking Hours: 08:00 - 23:00</p>
        <form action="SelectAvailableTablesServlet" method="get">
            <input type="date" id="date" name="date" value="<%=bookingDate%>" required>
            <input type="time" id="time" name="time" value="<%=bookingTime%>" required>
            <button type="submit">Check table</button>
        </form>

        <!--lấy dữ liệu từ bảng và gửi request-->
        <form id = "tableForm" action = "CreateReservationServlet" method = "get">
            <%
                if (bookingTime.isEmpty()) {
            %>
            <p>Please select arriving time above</p>
            <%
            } else if (tableList != null && !tableList.isEmpty()) {
            %>
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
                        <!--Kiểm tra xem bàn đã được chọn thì hiển thị đã chọn (Trường hợp quay lại từ trang confirm để chọn thêm bàn)-->
                        <%
                            boolean isSelected = false;
                            if (selectedTableIds != null) {
                                for (String selectedId : selectedTableIds) {
                                    if (selectedId.equals(String.valueOf(table.getId()))) {
                                        isSelected = true;
                                        break;
                                    }
                                }
                            }
                        %>
                        <input type="checkbox" name="tableIds" value="<%= table.getId()%>" class="table-checkbox" <%= isSelected ? "checked" : "" %> >
                    </td>
                </tr>

                <%
                    }
                %>
            </table>
            <p>Each table will be reserved for 3 hours.</p>
            <span>Booking Date: <%=bookingDate%> </span><br><br>
            <span>Booking Time: <%=bookingTime%> - <%=endTime%></span><br><br>
            <%
            } else {
            %>
            <p>No table available</p>
            <%
                }
            %>
            <button type = "button" onclick="window.location.href = 'MenuCustomerServlet'"> Cancel</button>   
            <input type="hidden" name="bookingTime" value="<%= bookingTime%>">
            <input type="hidden" name="endTime" value="<%=endTime%>">
            <input type="hidden" name="bookingDate" value="<%= bookingDate%>">
            <button type = "submit"> Continue </button>
        </form>

        <!--kiểm tra đã chọn giờ và bàn chưa trước khi gửi form-->
        <script>
            const form = document.getElementById('tableForm');
            form.addEventListener('submit', function (event) {
                // Lấy tất cả checkbox có class 'table-checkbox'
                const checkboxes = document.querySelectorAll('.table-checkbox');

                // Nếu danh sách bàn bị trống
                if (checkboxes.length === 0) {
                    alert('Please select available booking time and click "Check table"!');
                    event.preventDefault(); // Ngăn gửi form
                } else {
                    // Kiểm tra xem có ít nhất 1 checkbox được chọn không
                    let anyChecked = false;
                    for (let i = 0; i < checkboxes.length; i++) {
                        if (checkboxes[i].checked) {
                            anyChecked = true;
                            break;
                        }
                    }

                    if (!anyChecked) {
                        alert('Please select at least one table!');
                        event.preventDefault(); // Ngăn gửi form
                    }
                }
            });
        </script>
        <!--kiểm tra thời gian được phép đặt bàn (chỉ được đựat từ 8h-23h)-->
        <script>
            const bookingTime = document.getElementById("time");
            bookingTime.addEventListener("input", () => {
                const value = bookingTime.value;
                const min = "08:00";
                const max = "23:00";

                if (value < min || value > max) {
                    alert("Booking time: 08:00 - 23:00. Please select booking time again");
                    bookingTime.value = "";
                }
            });
        </script>
    </body>
</html>
