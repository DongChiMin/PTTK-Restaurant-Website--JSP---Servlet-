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

        <!--Nội dung chính-->
        <div class="container">
            <!-- CARD Trái  -->
            <div class="card left">
                <h2 style="font-size: 36px">Book a Reservation</h2>
                <p style="text-align: center">Please follow the steps below to complete your reservation.</p>

                <div style="margin-top: 40px">
                    <div class="timeline">
                        <div class="step">
                            <span class="circle"></span>
                            <span class="label">Select Tables</span>

                        </div>
                        <div class="step active">
                            <span class="circle"></span>
                            <span class="label">Fill Information</span>
                            <p style="margin-left: 10px; font-style: italic; font-size: 16px; color:black">Available Hours: 08:00 - 23:00. Each table will be reserved for 3 hours.</p>
                        </div>
                    </div>

                </div>
            </div>

            <div class="card right">
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
                    <div>
                        <label>Phone number (10 digits)<span style="color: red;">*</span></label>

                        <div style="display: flex; gap:20px; margin-top: 10px">
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
                        </div>
                    </div>
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

                <!--Phần form điền thông tin để submit-->
                <form id="reservationForm" action = "CreateReservationServlet" method = "post">  
                    <input hidden name="bookingTime" value="<%= bookingTime%>">
                    <input hidden name="endTime" value="<%= endTime%>">
                    <input hidden name="bookingDate" value="<%=bookingDate%>">
                    <%
                        //Nếu chưa nhập sdt: không hiển thị các ô thông tin
                        //Nếu đã nhập sdt (sdt không tồn tại trong hệ thống): Hiển thị các trường thông tin tạo khách hàng mới
                        //Nếu đã nhập sdt (sdt đã tồn tại): Hiển thị các trường thông tin readonly
                        if (phoneNumberEntered) {

                            if (customer == null) {
                    %>

                    <div style="display: flex; justify-content: space-between; gap:20px">
                        <input hidden id="phoneNumber" type="text" name="phoneNumber" value="<%=phoneNumber%>">

                        <div>     
                            <label>Name<span style="color: red;">*</span></label><br>
                            <input type="text" name="name" required style="margin-top: 10px; width: 300px">
                        </div>     
                    </div>    

                    <div style="display: flex; justify-content: space-between; gap:20px">
                        <div>
                            <label>Email</label><br>
                            <input type="text" name="email" style="margin-top: 10px;  width: 300px">
                        </div>

                        <div>
                            <label>Date of Birth</label><br>
                            <input type="date" name="dateOfBirth" style="margin-top: 10px;  width: 300px">
                        </div>
                    </div>
                    <%
                    } else {
                    %>

                    <input hidden name="customerId" value="<%= customer.getId()%>">
                    <input hidden id="phoneNumber" type="text" name="phoneNumber" value="<%=phoneNumber%>">

                    <div style="display: flex; justify-content: space-between; gap:20px">


                        <div>       
                            <label>Name<span style="color: red;">*</span></label><br>
                            <input type="text" name="name" value="<%=customer.getName()%>" readonly
                                   style="background-color: #e9ecef; cursor: not-allowed; margin-top: 10px; width: 300px">
                        </div>

                        <div>
                            <label>Email<span style="color: red;">*</span></label><br>
                            <input type="text" name="email" value="<%=hiddenEmail%>" readonly
                                   style="background-color: #e9ecef; cursor: not-allowed; margin-top: 10px; width: 300px">
                        </div>
                    </div>



                    <%
                        }

                    %>
                    <div>
                        <label >Selected Table<span style="color: red;">*</span></label>
                        <table border="1" style="margin-top: 10px">
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
                    </div>

                    <div style="display: flex; justify-content: space-between">

                        <div>
                            <label>Booking Time<span style="color: red;">*</span></label>
                            <div style="margin-top: 10px; padding: 8px 0px">
                                <span><%= bookingDate%> (<%= bookingTime%> - <%= endTime%>)</span>
                            </div>
                        </div>

                        <div>
                            <label>Note</label>
                            <div style="margin-top: 10px;">
                                <input type="text" name="note" style="width: 300px">
                            </div>

                        </div>


                    </div>

                    <%
                    } else {
                    %>
                    <input hidden id="phoneNumber" value="">



                    <%
                        }
                    %>
                </form>
                <div style="display: flex; justify-content: flex-start; align-items: center; gap:20px;">
                    <!--Nút quay lại trang trước đó-->

                    <form action = "SelectAvailableTablesServlet" method = "get" style="margin-bottom: 0px">
                        <input hidden name="bookingTime" value="<%= bookingTime%>">
                        <input hidden name="bookingDate" value="<%= bookingDate%>">
                        <%
                            for (Table t : selectedTableList) {
                        %>
                        <input hidden name="selectedTableIds" value="<%= t.getId()%>">
                        <%
                            }
                        %>
                        <button type = "submit" class="btn-cancel">< Go back</button>
                    </form>

                    <button type= "submit" name="action" value="submit" onclick="document.getElementById('reservationForm').submit();">Confirm</button>
                </div>


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
            if (emailError != null && !emailError.isEmpty()) {
        %>
        <script>
            alert("This email address is already in use.");
        </script>
        <%
            }

        %>

    </body>
</html>
