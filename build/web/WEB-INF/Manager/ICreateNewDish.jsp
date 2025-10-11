<%-- 
    Document   : IMenuManager
    Created on : Oct 1, 2025, 9:36:43 PM
    Author     : namv2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Dishes</title>
    </head>
    <body>
        <h1>Create New Dish</h1>
        <form action = "CreateNewDishServlet" method = "post">
            <label>Name:</label><br>
            <input type="text" name="name" required><br><br>

            <label>Description:</label><br>
            <input type="text" name="description" required><br><br>

            <label>Price</label><br>
            <input type="number" name="price" min="0" step="0.01" required><br><br>

            <label>Category</label><br>
            <select name="category" required>
                <option value="appetizer">Appetizer</option>
                <option value="mainDish">Main Dish</option>
                <option value="drink">Drink</option>
                <option value="dessert">Dessert</option>
            </select><br><br>

            
            <button type = "button" onclick="window.location.href='ManageDishesServlet'"> Cancel</button>           
            <button type = "submit">Confirm</button>
        </form>

    </body>
</html>
