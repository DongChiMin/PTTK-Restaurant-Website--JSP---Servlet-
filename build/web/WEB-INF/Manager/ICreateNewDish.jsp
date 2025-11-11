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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
    </head>
    <body>
        <div class="admin-container"  style="background: white;">
            <!-- Sidebar -->
            <nav class="sidebar">
                <a href="/RestaurantWeb"  class="logo" style="text-align: center">Restman Admin</a>
                <ul>
                    <li><a href="MenuManagerServlet"><i class="fas fa-home"></i> Main menu</a></li>
                    <li><a href="ManageDishesServlet" class="active"> <i class="fas fa-utensils"></i> Manage Dishes</a></li>

                </ul>
                <div style="margin-top: auto; /* đẩy xuống cuối */
                     border-top: 1px solid #44576b;
                     width: 100%;
                     text-align: center;
                     padding: 10px;">
                    <p>Hello, admin!</p>
                    <a href="MenuManagerServlet"  class="btn-logout" style="margin-top: 10px;">
                         <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </nav>

            <!-- Main content -->
            <main class="main-content">
                <div class="top-bar">
                    <form action="ManageDishesServlet" method="get" style="display:inline; margin-bottom: 0px">
                        <button type="submit" class="btn-create"><i class="fas fa-arrow-left"></i> Go back</button>
                    </form>
                </div>

                <div style="height: 2px; background-color: #e0e0e0; margin: 25px 0;"></div>

                <div class="container">
                    <form action = "CreateNewDishServlet" method = "post" style="width: 100%">   
                        <h2>Create new dish</h2>
                        <div style="display: flex; justify-content: space-between; gap:20px">
                            <div style="display: flex; flex-direction: column; gap:10px; width: 100%;">
                                <label>Name<span style="color: red;">*</span></label>
                                <input type="text" name="name" required placeholder="e.g., Banh mi">
                            </div>

                            <div style="display: flex; flex-direction: column; gap:10px; width: 100%;">
                                <label>Price<span style="color: red;">*</span></label>
                                <input type="number" name="price" min="0.01" step="0.01" required placeholder="e.g., 12.3">
                            </div>

                            <div style="display: flex; flex-direction: column; gap:10px; width: 100%;">
                                <label>Category<span style="color: red;">*</span></label>
                                <select name="category" required >
                                    <option value="Appetizer">Appetizer</option>
                                    <option value="MainDish">Main Dish</option>
                                    <option value="Drink">Drink</option>
                                    <option value="Dessert">Dessert</option>
                                </select>
                            </div>
                        </div>

                        <div style="display: flex; justify-content: space-between; gap:20px">


                            <div style="display: flex; flex-direction: column; gap:10px; width: 100%;">
                                <label>Description<span style="color: red;">*</span></label>
                                <textarea name="description" style="width: 100%; height: 100px; resize: vertical; padding: 8px;" required></textarea>
                            </div>
                        </div>
                        <button type = "submit">Add new dish</button>
                    </form>
                </div>
            </main>
        </div>

        <!--Nút quay lại trang trước đó-->
        <div style=" display: flex; justify-content: flex-start; align-items: center;">
        </div>

    </body>
</html>
