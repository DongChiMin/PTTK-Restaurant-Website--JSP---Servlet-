<%-- 
    Document   : IManageDishes
    Created on : Oct 1, 2025, 9:36:54 PM
    Author     : namv2
--%>

<%@page import="java.util.List"%>
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
        <%
            String successMessage = (String) request.getAttribute("successMessage");
            List<Dish> dishesList = (List<Dish>) request.getAttribute("dishesList");
            
            if (successMessage != null && !successMessage.isEmpty()) {
        %>
        <script>
            alert("Add dish successfully!");
        </script>
        <%
            }
        %>

        <!-- Navbar -->
        <nav class="navbar">
            <a href="/RestaurantWeb" class="logo">Restman Restaurant</a>
        </nav>

        <!--Nút quay lại trang trước đó-->
        <div style=" display: flex; justify-content: flex-start; align-items: center;">
            <button type="submit" onclick="window.location.href = 'MenuManagerServlet'" style="margin-left: 50px; margin-top: 10px">< Go back</button>
        </div>

        <!--Nội dung chính-->
        <div class="container">
            <div class="card left" style="width: 20%">
                <form action="CreateNewDishServlet" method="get">
                    <h2>Manage all dishes</h2>
                    <button type="submit">Create new Dish</button>
                </form>
            </div>
            <div class="card right" style="width: 80%">
                <h2 style="margin-bottom: 20px">Dishes list</h2>
                <table border="1" id="tableList">
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Category</th>
                        <th style="width: 25%">Action</th>
                    </tr>
                    </thead>
                    <%
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
                
                <div id="pagination"></div>
            </div>
        </div>
        <!--Phân trang-->
        <script>
            const rowsPerPage = 4;
            const table = document.getElementById("tableList");
            const tbody = table.querySelector("tbody");
            const rows = Array.from(tbody.querySelectorAll("tr"));
            const pagination = document.getElementById("pagination");

            let currentPage = 1;
            const totalPages = Math.ceil(rows.length / rowsPerPage);

            function showPage(page) {
                currentPage = page;
                const start = (page - 1) * rowsPerPage;
                const end = start + rowsPerPage;

                rows.forEach((row, index) => {
                    row.style.display = (index >= start && index < end) ? "" : "none";
                });

                renderPagination();
            }

            function renderPagination() {
                pagination.innerHTML = "";

                // Previous button
                const prev = document.createElement("button");
                prev.textContent = "Prev";
                prev.disabled = currentPage === 1;
                prev.onclick = () => showPage(currentPage - 1);
                pagination.appendChild(prev);

                // Page numbers
                for (let i = 1; i <= totalPages; i++) {
                    const btn = document.createElement("button");
                    btn.textContent = i;
                    btn.disabled = i === currentPage;
                    btn.onclick = () => showPage(i);
                    pagination.appendChild(btn);
                }

                // Next button
                const next = document.createElement("button");
                next.textContent = "Next";
                next.disabled = currentPage === totalPages;
                next.onclick = () => showPage(currentPage + 1);
                pagination.appendChild(next);
            }

            // Initialize
            showPage(1);
        </script>
    </body>
</html>
