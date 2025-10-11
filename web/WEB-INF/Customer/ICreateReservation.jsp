<%-- 
    Document   : ICreateReservation
    Created on : Oct 4, 2025, 9:15:44 AM
    Author     : namv2
--%>

<%@page import="model.Customer"%>
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
            //Các biến được chuyển sang từ trang trước đó
            String bookingDate = (String) request.getAttribute("bookingDate");
            String bookingTime = (String) request.getAttribute("bookingTime");
            String endTime = (String) request.getAttribute("endTime");
            List<Table> selectedTableList = (List<Table>) request.getAttribute("selectedTableList");

            //Các biến xử lý trong trang
            Customer customer = (Customer) request.getAttribute("customer");
            String phoneNumber = (String) request.getAttribute("phoneNumber");
            Boolean phoneNumberEntered = (Boolean) request.getAttribute("phoneNumberEntered");
            String hiddenEmail = "";

            if (phoneNumber == null) {
                phoneNumber = "";
            }

            //Kiểm tra nếu khách hàng có email thì ẩn chữ cái trong email
            if (customer != null && customer.getEmail() != null && !customer.getEmail().isEmpty()) {
                String email = customer.getEmail();
                int index = email.indexOf('@');
                hiddenEmail = email.substring(0, 1) + "***" + email.charAt(index - 1) + email.substring(index);
            }
        %>

        <form id="reservationForm" action = "CreateReservationServlet" method = "post">
            <input hidden name="bookingTime" value="<%= bookingTime%>">
            <input hidden name="endTime" value="<%= endTime%>">
            <input hidden name="bookingDate" value="<%=bookingDate%>">
            <label>Phone number (10 digits):</label><br>
            <input 
                required 
                type="text" 
                name="phoneNumber" 
                pattern="[0-9]{10}" 
                value="<%= phoneNumber%>" 
                placeholder="e.g., 0981234567"
                <%= (phoneNumber != null && !phoneNumber.isEmpty()) ? "readonly style='background-color: #e9ecef; cursor: not-allowed;'" : ""%> 
            />
            <button type="submit" name="action" value="reset">Reset</button>
            <button type="submit" name="action" value="search">Search</button><br><br>

            <%
                //Nếu chưa nhập sdt: không hiển thị các ô thông tin
                //Nếu đã nhập sdt (sdt không tồn tại trong hệ thống): Hiển thị các trường thông tin tạo khách hàng mới
                //Nếu đã nhập sdt (sdt đã tồn tại): Hiển thị các trường thông tin readonly
                if (phoneNumberEntered) {

                    if (customer == null) {
            %>
            <p>Create new Customer</p><br>
            <label>Name:</label><br>
            <input type="text" name="name"><br><br>

            <label>Email (optional)</label><br>
            <input type="text" name="email"><br><br>

            <label>Date of Birth (optional)</label><br>
            <input type="text" name="dateOfBirth"><br><br>
            <%
            } else {
            %>
            <label>Name:</label><br>
            <input hidden name="customerId" value="<%= customer.getId()%>">
            <input type="text" name="name" value="<%=customer.getName()%>" readonly
                   style="background-color: #e9ecef; cursor: not-allowed;"><br><br>
            <label>Email (optional)</label><br>
            <input type="text" name="email" value="<%=hiddenEmail%>" readonly
                   style="background-color: #e9ecef; cursor: not-allowed;"><br><br>

            <%
                    }
                }
            %>


            <label>Note (optional)</label><br>
            <input type="text" name="note"><br><br>

            <span>Selected Table:
                <table border="1">
                    <tr>
                        <th>ID</th>
                        <th>Tên bàn</th>
                        <th>Vị trí</th>
                        <th>Sức chứa</th>
                    </tr>
                    <%
                        for (Table table : selectedTableList) {
                    %>
                    <tr>
                    <input hidden name="selectedTableIds" value="<%=table.getId()%>">
                    <td><%= table.getId()%></td>
                    <td><%= table.getName()%></td>
                    <td><%= table.getLocation()%></td>
                    <td><%= table.getCapacity()%></td>
                    </tr>

                    <%
                        }
                    %>
                </table>
            </span><br><br>
            <span>Phonenumber entered: <%= phoneNumber%></span><br><br>
            <span>Booking Date: <%= bookingDate%></span><br><br>
            <span>Booking Time: <%= bookingTime%> - <%= endTime%></span><br><br>
            <button type = "submit" name="action" value="submit">Confirm</button>

        </form>
        <form action = "SelectAvailableTablesServlet" method = "get">
            <input hidden name="bookingTime" value="<%= bookingTime%>">
            <input hidden name="bookingDate" value="<%= bookingDate%>">
            <%
                for (Table t : selectedTableList) {
            %>
            <input hidden name="selectedTableIds" value="<%= t.getId()%>">
            <%
                }
            %>
            <button type = "submit">Cancel</button>
        </form>
    </body>
</html>
