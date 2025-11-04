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
         <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Customer.css">
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar">
            <a href="/RestaurantWeb" class="logo">Restman Restaurant</a>
        </nav>

        <!--Nút quay lại trang trước đó-->
        <div style=" display: flex; justify-content: flex-start; align-items: center;">
            <button type="submit" onclick="window.location.href = 'ManageDishesServlet'" style="margin-left: 50px; margin-top: 10px">< Go back</button>
        </div>

        <!--Tên tiêu đề chính-->
        <div class="container" style="padding:20px">
            <div style="display: flex; align-items: center; justify-content: center; width: 100%">
                <h2 style="font-size: 32px">MANAGE ALL DISHES</h2>
            </div>
        </div>

        <!--Nội dung chính-->
        <div class="container">
            <form action = "CreateNewDishServlet" method = "post" style="width: 100%">       
                        <label>Name<span style="color: red;">*</span></label>
                        <input type="text" name="name" required placeholder="e.g., Banh mi">
                 
                        <label>Price<span style="color: red;">*</span></label>
                        <input type="number" name="price" min="0.01" step="0.01" required placeholder="e.g., 12.3">
   
                        <label>Category<span style="color: red;">*</span></label>
                        <select name="category" required >
                            <option value="appetizer">Appetizer</option>
                            <option value="mainDish">Main Dish</option>
                            <option value="drink">Drink</option>
                            <option value="dessert">Dessert</option>
                        </select>
                 
                        <label>Description<span style="color: red;">*</span></label>
                        <input type="text" name="description" required >

            <button type = "submit">Add new dish</button>
        </form>
        </div>
       
    </body>
</html>
