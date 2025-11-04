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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Customer.css">
    </head>
    <body>
        <%
            //Các biến được chuyển sang từ trang trước đó
            String bookingDate = (String) request.getAttribute("bookingDate");
            String bookingTime = (String) request.getAttribute("bookingTime");
            String endTime = (String) request.getAttribute("endTime");
            String[] selectedTableIds = (String[]) request.getAttribute("selectedTableIds");
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

        <!-- Navbar -->
        <nav class="navbar">
            <a href="/RestaurantWeb" class="logo">Restman Restaurant</a>
        </nav>
        
        <!--Nút quay lại trang trước đó-->
        <div style=" display: flex; justify-content: flex-start; align-items: center;">
            <form action = "SelectAvailableTablesServlet" method = "get" style="padding-bottom: 0px">
            <input hidden name="bookingTime" value="<%= bookingTime%>">
            <input hidden name="bookingDate" value="<%= bookingDate%>">
            <%
                for (Table t : selectedTableList) {
            %>
            <input hidden name="selectedTableIds" value="<%= t.getId()%>">
            <%
                }
            %>
            <button type = "submit" style="margin-left: 50px; margin-top: 10px">< Go back</button>
        </form>
        </div>
            
        <!--Tên tiêu đề chính-->
        <div class="container" style="padding:20px">
            <div style="display: flex; align-items: center; justify-content: center; width: 100%">
                <h2 style="font-size: 32px">FILL RESERVATION INFORMATION</h2>
            </div>
        </div>    

        <!--Nội dung chính-->
        <div class="container">
            <!-- CARD Trái  -->
            <div class="card left">
                <!--phần form nhập số điện thoại-->
                <form id="phoneNumberForm" action = "CreateReservationServlet" method = "get">
                    <!--Các biến ẩn cần gửi--> 
                    <input hidden name="bookingTime" value="<%= bookingTime%>">
                    <input hidden name="endTime" value="<%= endTime%>">
                    <input hidden name="bookingDate" value="<%=bookingDate%>">
                    <%
                        for (String s : selectedTableIds) {
                    %>
                    <input hidden name="selectedTableIds" value="<%=s%>">
                    <%
                        }
                    %>

                    <!--Nội dung form-->
                    <h2>1. Check your Phone number</h2>
                    <label>Phone number (10 digits)<span style="color: red;">*</span></label>

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
                    <button type="submit" name="action" value="search">Search</button>

                </form>
                <!--Nếu không tồn tại sdt thì hiển thị thông báo nhỏ-->   
                <%
                    if (phoneNumberEntered) {

                        if (customer == null) {
                %>
                <p>No information detected for this phone number. Please create a new customer profile.</p>
                <%
                        }
                    }
                %>
            </div>

            <div class="card right">
                <!--Phần form điền thông tin để submit-->
                <form id="reservationForm" action = "CreateReservationServlet" method = "post">  
                    <input hidden name="bookingTime" value="<%= bookingTime%>">
                    <input hidden name="endTime" value="<%= endTime%>">
                    <input hidden name="bookingDate" value="<%=bookingDate%>">
                    <h2>2. Check your information</h2>
                    <%
                        //Nếu chưa nhập sdt: không hiển thị các ô thông tin
                        //Nếu đã nhập sdt (sdt không tồn tại trong hệ thống): Hiển thị các trường thông tin tạo khách hàng mới
                        //Nếu đã nhập sdt (sdt đã tồn tại): Hiển thị các trường thông tin readonly
                        if (phoneNumberEntered) {

                            if (customer == null) {
                    %>

                    <div style="display: flex; justify-content: space-between; gap:20px">
                        <div>
                            <label>Phone number:</label> <br>
                            <input id="phoneNumber" type="text" name="phoneNumber" value="<%=phoneNumber%>" readonly
                                    style="margin-top: 10px; width: 300px; background-color: #e9ecef; cursor: not-allowed;">
                        </div>


                        <div>     
                            <label>Name:</label><br>
                            <input type="text" name="name" required style="margin-top: 10px; width: 300px">
                        </div>     
                    </div>    

                    <div style="display: flex; justify-content: space-between; gap:20px">
                        <div>
                            <label>Email (optional):</label><br>
                            <input type="text" name="email" style="margin-top: 10px;  width: 300px">
                        </div>

                        <div>
                            <label>Date of Birth (optional):</label><br>
                            <input type="date" name="dateOfBirth" style="margin-top: 10px;  width: 300px">
                        </div>
                    </div>
                    <%
                    } else {
                    %>

                    <input hidden name="customerId" value="<%= customer.getId()%>">

                    <div style="display: flex; justify-content: space-between; gap:20px">
                        <div>
                            <label>Phone number:</label><br>
                            <input id="phoneNumber" type="text" name="phoneNumber" value="<%=phoneNumber%>" readonly
                                    style="background-color: #e9ecef; cursor: not-allowed; margin-top: 10px; width: 300px">
                        </div>

                        <div>       
                            <label>Name:</label><br>
                            <input type="text" name="name" value="<%=customer.getName()%>" readonly
                                   style="background-color: #e9ecef; cursor: not-allowed; margin-top: 10px; width: 300px">
                        </div>
                    </div>

                    <label>Email:</label>
                    <input type="text" name="email" value="<%=hiddenEmail%>" readonly
                           style="background-color: #e9ecef; cursor: not-allowed;">

                    <%
                        }
                    } else {
                    %>
                    <p style="text-align: center; color: red">Please fill your phoneNumber and click search</p>
                    <input hidden id="phoneNumber" value="">
                    <%
                        }
                    %>
                    <h2>3. Check Reservation information</h2>

                    <label>Booking Time</label>
                    <div>
                        <span><%= bookingDate%> (<%= bookingTime%> - <%= endTime%>)</span>
                    </div>

                    <label>Selected Table:</label>
                    <table border="1">
                        <tr>
                            <th>ID</th>
                            <th>Table name</th>
                            <th>Location</th>
                            <th>Capacity</th>
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

                    <label>Note (optional)</label>
                    <input type="text" name="note">
                    <button type = "submit" name="action" value="submit">Confirm</button>
                </form>
            </div>
        </div>

        <!--kiểm tra trước khi submit đã nhập sdt chưa-->
        <script>
            const form = document.getElementById('reservationForm');
            form.addEventListener('submit', function (event) {
                const phoneInput = document.getElementById("phoneNumber");
                const phoneNumber = phoneInput.value.trim();

                if (phoneNumber === "") {
                    alert("Please search by phone number before submit");
                    event.preventDefault(); // Chặn submit
                    return;
                }
            });
        </script>
        <!--Kiểm tra nếu có lỗi email tồn tại-->
        <%
            String emailError = (String) request.getAttribute("emailError");
            if(emailError != null && !emailError.isEmpty()){
                %>
                <script>
                    alert("This email address is already in use.");
                </script>
        <%
            }
            
        %>

    </body>
</html>
