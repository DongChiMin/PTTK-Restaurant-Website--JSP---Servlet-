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
        <link rel="stylesheet" href="css/IManageDishes.css">
    </head>
    <body>
        <h1>Manage All Dishes</h1>
        <table border="1">
            <tr>
                <td>id</td>
                <th>Name</th>
                <th>Description</th>
                <th>Price</th>
                <th>Category</th>
                <th>Action</th>
            </tr>
            <%
                Dish[] dishes = (Dish[]) request.getAttribute("dishes");
                if (dishes != null) {
                    for (Dish dish : dishes) {%>
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
            <a href = "MenuManagerServlet">
                <span style="display:inline-block; padding:6px 12px; background:#ccc; border-radius:4px; cursor:pointer;">
                    Cancel
                </span>
            </a>
            <form action="CreateNewDishServlet" method="get">
                <button type="submit">Create new Dish</button>
            </form>
    </body>
</html>
