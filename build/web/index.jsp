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
    </head>
    <body>
        <form action="MenuManagerServlet" method="get">
            <button type="submit">Module 1: tạo món ăn mới</button>
        </form>
        <form action="MenuCustomerServlet" method="get">
            <button type="submit">Module 2: đặt bàn trực tuyến</button>
        </form>
    </body>
</html>
