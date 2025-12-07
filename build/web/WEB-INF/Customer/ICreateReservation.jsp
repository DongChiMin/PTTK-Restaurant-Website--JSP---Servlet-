<%-- 
    Document   : ICreateReservation
    Created on : Oct 4, 2025, 9:15:44 AM
    Author     : namv2
--%>

<%@page import="model.Reservation"%>
<%@page import="model.Bill"%>
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
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
            
            List<Bill> billList = (List<Bill>) request.getAttribute("billList");
            List<Reservation> reservationList = (List<Reservation>) request.getAttribute("reservationList");

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
                        <div class="step completed">
                            <span class="circle"></span>
                            <span class="label"><i class="fas fa-check"></i> Select Tables</span>

                        </div>
                        <div class="step active">
                            <span class="circle"></span>
                            <span class="label"><i class="fas fa-user-edit"></i> Fill Information</span>
                            <p style="margin-left: 10px; font-style: italic; font-size: 16px; color:black">Enter your phone number to search for an existing profile or create a new one then confirm the reservation.</p>
                        </div>
                    </div>

                </div>
            </div>

            <div class="card right">
                <div style="display: flex; justify-content: space-between; gap:20px">
                    <div>
                        <label><i class="fa-solid fa-calendar-days"></i> Booking time<span style="color: red;">*</span></label>
                        <div style="display: flex; gap:20px; margin-top: 10px">
                            <input type="date" id="date" name="bookingDate" value="<%=bookingDate%>" readonly
                                   style="background-color: #e9ecef; cursor: not-allowed; width: 100%">
                            <input type="time" id="time" name="bookingTime" value="<%=bookingTime%>" readonly
                                   style="background-color: #e9ecef; cursor: not-allowed; width: 100%">
                        </div>
                    </div>

                    <div style="width: 100%">
                        <label><i class="fa-solid fa-chair"></i> Booking Table(s)<span style="color: red;">*</span></label>
                        <div>
                            <%
                                StringBuilder tableSummary = new StringBuilder();
                                for (int i = 0; i < selectedTableList.size(); i++) {
                                    Table table = selectedTableList.get(i);
                                    tableSummary.append(table.getName());
                                    if (i < selectedTableList.size() - 1) {
                                        tableSummary.append(" + ");
                                    }
                                }
                            %>
                            <input value="<%=tableSummary.toString()%>" readonly
                                   style="background-color: #e9ecef; cursor: not-allowed; margin-top: 10px; width: 100%">
                        </div>

                    </div>
                </div>

                <div style="height: 2px; background-color: #e0e0e0; margin: 25px 0;"></div>

                <!--phần form nhập số điện thoại-->
                <form id="phoneNumberForm" action = "CreateReservationServlet" method = "get">
                    <!--Các biến ẩn cần gửi--> 
                    <input hidden name="bookingTime" value="<%= bookingTime%>">
                    <input hidden name="endTime" value="<%= endTime%>">
                    <input hidden name="bookingDate" value="<%=bookingDate%>">
                    <%
                        for (Table t : selectedTableList) {
                    %>
                    <input hidden name="selectedTableIds" value="<%=t.getId()%>">
                    <%
                        }
                    %>

                    <!--Nội dung form-->
                    <div>
                        <label><i class="fa-solid fa-phone"></i> Phone number (10 digits)<span style="color: red;">*</span></label>

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
                            <button type="submit" name="action" value="reset"><i class="fa-solid fa-rotate-left"></i> Reset</button>
                            <button type="submit" name="action" value="search"><i class="fa-solid fa-magnifying-glass"></i> Search</button>
                        </div>
                    </div>
                </form>

                <!--Phần form điền thông tin để submit-->
                <form id="reservationForm" action = "CreateReservationServlet" method = "post" style="margin-bottom: 0px">  
                    <input hidden name="bookingTime" value="<%= bookingTime%>">
                    <input hidden name="endTime" value="<%= endTime%>">
                    <input hidden name="bookingDate" value="<%=bookingDate%>">
                    <input hidden name="action" id="hiddenAction" value="">

                    <%
                        //Nếu chưa nhập sdt: không hiển thị các ô thông tin
                        //Nếu đã nhập sdt (sdt không tồn tại trong hệ thống): Hiển thị các trường thông tin tạo khách hàng mới
                        //Nếu đã nhập sdt (sdt đã tồn tại): Hiển thị các trường thông tin readonly
                        if (phoneNumberEntered) {

                            if (customer == null) {
                    %>  

                    <div style="display: flex; justify-content: space-between; gap:20px">
                        <input hidden id="phoneNumber" type="text" name="phoneNumber" value="<%=phoneNumber%>">

                        <div style="width: 35%">     
                            <label><i class="fa-solid fa-user"></i> Name<span style="color: red;">*</span></label><br>
                            <input id="nameInput" type="text" name="name" required style="margin-top: 10px; width: 100%">
                        </div>  

                        <div style="width: 35%">
                            <label><i class="fa-solid fa-envelope"></i> Email</label><br>
                            <input type="text" name="email" style="margin-top: 10px; width: 100%">
                        </div>

                        <div style="width: 30%">
                            <label><i class="fa-solid fa-calendar"></i> Date of Birth</label><br>
                            <input type="date" name="dateOfBirth" style="margin-top: 10px; width: 100%">
                        </div>
                    </div>
                    <%
                    } else {
                    %>

                    <input hidden name="customerId" value="<%= customer.getId()%>">
                    <input hidden id="phoneNumber" type="text" name="phoneNumber" value="<%=phoneNumber%>">

                    <div style="display: flex; justify-content: space-between; gap:20px">

                        <div style="width: 50%">       
                            <label><i class="fa-solid fa-user"></i> Name<span style="color: red;">*</span></label><br>
                            <input id="nameInput" type="text" name="name" value="<%=customer.getName()%>" readonly
                                   style="background-color: #e9ecef; cursor: not-allowed; margin-top: 10px; width: 100%">
                        </div>

                        <div style="width: 50%">
                            <label><i class="fa-solid fa-envelope"></i> Email<span style="color: red;">*</span></label><br>
                            <input type="text" name="email" value="<%=hiddenEmail%>" readonly
                                   style="background-color: #e9ecef; cursor: not-allowed; margin-top: 10px; width: 100%">
                        </div>
                    </div>

                    <%
                        }

                    %>

                    <div>
                        <label><i class="fa-solid fa-note-sticky" style="margin-top: 8px;"></i> Reservation note</label>
                        <div style="margin-top: 10px;">
                            <textarea name="note" style="width: 100%; height: 100px; resize: vertical; padding: 8px;"></textarea>
                        </div>
                    </div>
                    
                    <div>
                        <label><i class="fa-solid fa-note-sticky" style="margin-top: 8px;"></i> Billing detail</label>
                        <div style="margin-top: 10px;">
                            <textarea name="billingDetail" style="width: 100%; height: 100px; resize: vertical; padding: 8px;" disabled >
                                <%
                                    float totalBill = 0;
                                    for(Bill b : billList){
                                        totalBill += b.getTotalPrice();
                                    }
                                %>
Số lượng hóa đơn: <%= billList.size()%>
tổng hóa đơn: <%= totalBill%>
                                <%
                                    for(Reservation r : reservationList){
                                      
                                    }
%>
Số lượng đơn đặt bàn: <%= reservationList.size()%>                                
<%
                                %>
                            </textarea>
                        </div>
                    </div>

                    <%                    } else {
                    %>
                    <input hidden id="phoneNumber" value="">

                    <%
                        }
                    %>
                </form>

                <div style="height: 2px; background-color: #e0e0e0; margin: 25px 0;"></div>

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
                        <button type = "submit" class="btn-cancel"><i class="fas fa-arrow-left"></i>  Go back</button>
                    </form>

                    <%
                        if (phoneNumberEntered) {
                    %>
                    <button type= "submit" name="action" value="submit" onclick="validateAndSubmit()"><i class="fa-solid fa-check"></i> Confirm</button>
                    <%
                    } else {
                    %>
                    <button type= "submit" name="action" value="submit" onclick="validateAndSubmit()" disabled><i class="fa-solid fa-check"></i> Confirm</button>
                    <%
                        }
                    %>
                </div>


            </div>
        </div>

        <!--kiểm tra trước khi submit đã nhập sdt chưa-->
        <script>
            function validateAndSubmit() {
                const phoneInput = document.getElementById("phoneNumber");
                const nameInput = document.getElementById("nameInput");
                const phoneValue = phoneInput.value.trim();
                const nameValue = nameInput.value.trim();

                if (phoneValue === "") {
                    alert("Please search by phone number before submit");
                    return;
                }
                if(nameValue === ""){
                    alert("Please enter name before submit");
                    return;
                }
                
                document.getElementById('reservationForm').submit();
            }
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
