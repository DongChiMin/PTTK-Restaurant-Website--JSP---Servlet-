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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Customer.css">
    </head>
    <body>
        <%
            //Các biến cần để hiển thị trên giao diện 
            String bookingTime = (String) request.getAttribute("bookingTime");
            String endTime = (String) request.getAttribute("endTime");
            String bookingDate = (String) request.getAttribute("bookingDate");
            List<Table> tableList = (List<Table>) request.getAttribute("tableList");
            String[] selectedTableIds = (String[]) request.getAttribute("selectedTableIds");

            if (bookingTime == null) {
                bookingTime = "";
            }
            if (endTime == null) {
                endTime = "";
            }
            if (bookingDate == null) {
                bookingDate = ""; 
            }
        %>
        <!-- Navbar -->
        <nav class="navbar">
            <a href="/RestaurantWeb" class="logo">Restman Restaurant</a>
        </nav>

        <!--Nút quay lại trang trước đó-->
        <div style=" display: flex; justify-content: flex-start; align-items: center;">
            <button type="submit" onclick="window.location.href = 'MenuCustomerServlet'" style="margin-left: 50px; margin-top: 10px">< Go back</button>
        </div>

        <!--Tên tiêu đề chính-->
        <div class="container" style="padding:20px">
            <div style="display: flex; align-items: center; justify-content: center; width: 100%">
                <h2 style="font-size: 32px">SELECT AVAILABLE TABLES</h2>
            </div>
        </div>

        <!--nội dung chính-->
        <div class="container">
            <div class="card left">
                <form id="bookingTimeForm" action="SelectAvailableTablesServlet" method="get">
                    <h2>1. Select booking time</h2>
                    <p>Available Hours: 08:00 - 23:00</p>
                    <input type="date" id="date" name="bookingDate" value="<%=bookingDate%>" required>
                    <input type="time" id="time" name="bookingTime" value="<%=bookingTime%>" required>
                    <button type="submit">Check table</button>
                </form>
            </div>
            <div class="card right">
                <!--lấy dữ liệu từ bảng và gửi request-->
                <form id = "tableForm" action = "CreateReservationServlet" method = "get">
                    <h2>2. Select Tables</h2>
                    <%
                        if (bookingTime.isEmpty()) {
                    %>
                    <p style="text-align: center;">Please select booking time beside.</p>
                    <%
                    } else if (tableList != null && !tableList.isEmpty()) {
                    %>
                    <p>Each table will be reserved for 3 hours.</p>
                    <table border="1">
                        <tr>
                            <th>ID</th>
                            <th>Table name</th>
                            <th>Location</th>
                            <th>Capacity</th>
                            <th>Select</th>
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
                                <!--Kiểm tra xem bàn đã được chọn thì hiển thị checkbox đã chọn (Trường hợp quay lại từ trang confirm để chọn thêm bàn)-->
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
                                <input type="checkbox" name="selectedTableIds" value="<%= table.getId()%>" class="table-checkbox" <%= isSelected ? "checked" : ""%> >
                            </td>
                        </tr>

                        <%
                            }
                        %>
                    </table>
                    <div>
                        <label>Booking Date: </label>
                        <span><%=bookingDate%> </span>
                    </div>
                    <div>
                        <label>Booking Time: </label>
                        <span><%=bookingTime%> - <%=endTime%></span>
                    </div>
                    <%
                    } else {
                    %>
                    <p style="color : red; text-align: center;">No table available, please try again.</p>
                    <%
                        }
                    %>
                    <input type="hidden" name="bookingTime" value="<%= bookingTime%>">
                    <input type="hidden" name="endTime" value="<%=endTime%>">
                    <input type="hidden" name="bookingDate" value="<%= bookingDate%>">
                    <%
                        if (tableList != null && tableList.isEmpty()) {
                    %>
                    <button type = "submit" name="action" value="loadReservationPage" disabled> Continue </button>
                    <%
                    } else {
                    %>
                    <button type = "submit" name="action" value="loadReservationPage"> Continue </button>
                    <%
                        }
                    %>
                </form>
            </div>
        </div>




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
        <!--kiểm tra thời gian được phép đặt bàn (chỉ được đặt từ 8h-23h, không được đặt trong quá khứ)-->
        <script>
            const bookingTimeInput = document.getElementById("time");
            const bookingDateInput = document.getElementById("date");
            const bookingTimeForm = document.getElementById("bookingTimeForm");

            bookingTimeForm.addEventListener("submit", function (event) {
                const bookingDate = bookingDateInput.value;
                const bookingTime = bookingTimeInput.value;
                const currentDate = new Date();  // Lấy ngày và giờ hiện tại
                const selectedDate = new Date(bookingDate + "T" + bookingTime);  // Chuyển ngày và giờ người dùng chọn thành đối tượng Date

                // Kiểm tra xem ngày giờ đã chọn có trong quá khứ không
                if (selectedDate < currentDate) {
                    alert("You cannot book a table for a past date/time. Please select a future date/time.");
                    event.preventDefault();  // Ngừng gửi form
                    return;
                }

                // Kiểm tra giờ đặt phải trong khoảng từ 08:00 - 23:00
                const minTime = "08:00";
                const maxTime = "23:00";

                if (bookingTime < minTime || bookingTime > maxTime) {
                    alert("Booking time must be between 08:00 and 23:00. Please select a valid time.");
                    event.preventDefault();  // Ngừng gửi form
                    return;
                }
            });

//                bookingTime.addEventListener("input", () => {
//                    const value = bookingTime.value;
//                    const min = "08:00";
//                    const max = "23:00";
//                    if (value < min || value > max) {
//                        alert("Booking time: 08:00 - 23:00. Please select booking time again");
//                        bookingTime.value = "";
//                    }
//                }
//                );
        </script>
    </body>
</html>
