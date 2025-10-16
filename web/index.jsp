<%-- 
    Document   : home
    Created on : Oct 1, 2025, 11:38:55 AM
    Author     : namv2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
                <h2 style="font-size: 32px">MODULES</h2>
            </div>
        </div>
        
        <div class="container">
            <div class="card left">
                <form action="MenuManagerServlet" method="get">
            <button type="submit">Module 1: tạo món ăn mới</button>
        </form>
   
            </div>
            <div class="card right">
                     <form action="MenuCustomerServlet" method="get">
            <button type="submit">Module 2: đặt bàn trực tuyến</button>
        </form>
            </div>
        </div>
    </body>
</html>
