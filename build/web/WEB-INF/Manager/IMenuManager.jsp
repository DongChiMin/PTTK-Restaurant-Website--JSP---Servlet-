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
        <title>Manager Menu</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Customer.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
    </head>
    <body>
        <div class="admin-container"  style="background: white;">
            <!-- Sidebar -->
            <nav class="sidebar">
                <h1 class="logo" style="text-align: center">Restman Admin</h1>
                <ul>
                    <li><a href="MenuManagerServlet" class="active"><i class="fas fa-home"></i> Main menu</a></li>
                    <li><a href="ManageDishesServlet"> <i class="fas fa-utensils"></i> Manage Dishes</a></li>

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
                <h2>Menu Manager</h2>
            </main>
        </div>
    </body>
</html>
