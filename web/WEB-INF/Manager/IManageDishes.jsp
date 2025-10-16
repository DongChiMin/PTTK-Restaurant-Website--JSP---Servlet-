<%-- 
    Document   : IManageDishes
    Created on : Oct 1, 2025, 9:36:54 PM
    Author     : namv2
--%>

<%@page import="model.Dish"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Dishes</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Customer.css">
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar">
            <a href="/RestaurantWeb" class="logo">Restman Restaurant</a>
        </nav>

        <!--Nút quay lại trang trước đó-->
        <div style=" display: flex; justify-content: flex-start; align-items: center;">
            <button type="submit" onclick="window.location.href = 'MenuManagerServlet'" style="margin-left: 50px; margin-top: 10px">< Go back</button>
        </div>

        <!--Tên tiêu đề chính-->
        <div class="container" style="padding:20px">
            <div style="display: flex; align-items: center; justify-content: center; width: 100%">
                <h2 style="font-size: 32px">MANAGE ALL DISHES</h2>
            </div>
        </div>

        <!--Nội dung chính-->
        <div class="container">
            <div class="card left" style="width: 20%">
                <form action="CreateNewDishServlet" method="get">
                    <h2>Actions</h2>
                    <button type="submit">Create new Dish</button>
                </form>
            </div>
            <div class="card right" style="width: 80%">
                <h2 style="margin-bottom: 20px">Dishes list</h2>
                <table border="1">
                    <tr>
                        <td>id</td>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Category</th>
                        <th style="width: 25%">Action</th>
                    </tr>
                    <%
                        Dish[] dishesList = (Dish[]) request.getAttribute("dishesList");
                        if (dishesList != null) {
                            for (Dish dish : dishesList) {%>
                    <tr>
                        <td><%=dish.getId()%></td>
                        <td><%=dish.getName()%></td>
                        <td><%=dish.getDescription()%></td>
                        <td><%=dish.getPrice()%></td>
                        <td><%=dish.getCategory()%></td>
                        <td>
                            <button>Edit</button>
                            <button>Delete</button>
                        </td>
                    </tr>
                    <%}
                    } else {
                    %>
                    <tr>
                        <td>Không có dữ liệu</td>
                    </tr>
                    <%
                        }
                    %>

                </table>
            </div>
        </div>

    </body>
</html>
