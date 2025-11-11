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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
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
        <% } %>

        <div class="admin-container"  style="background: white;">
            <!-- Sidebar -->
            <nav class="sidebar">
                <h1 class="logo" style="text-align: center">Restman Admin</h1>
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
                    <h2>All Dishes in Restman</h2>
                    <form action="CreateNewDishServlet" method="get" style="display:inline; margin-bottom: 0px">
                        <button type="submit" class="btn-create"><i class="fas fa-plus"></i> Create new Dish</button>
                    </form>
                </div>

                <div style="height: 2px; background-color: #e0e0e0; margin: 25px 0;"></div>

                <div style="display: flex; flex-direction: column; min-height: 500px; justify-content: space-between;">
                    <table border="1" id="tableList">
                        <thead>
                            <tr>
                                <th style="width: 5%; text-align: center;">id</th>
                                <th style="width: 20%; text-align: center;">Name</th>
                                <th style="width: 30%; text-align: center;">Description</th>
                                <th style="width: 10%; text-align: center;">Price ($)</th>
                                <th style="width: 15%; text-align: center;">Category</th>
                                <th style="width: 20%; text-align: center;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (dishesList != null && !dishesList.isEmpty()) {
                                    for (Dish dish : dishesList) {
                            %>
                            <tr>
                                <td style="text-align: center;"><%=dish.getId()%></td>
                                <td><%=dish.getName()%></td>
                                <td><%=dish.getDescription()%></td>
                                <td style="text-align: right"><%=String.format("%.2f", dish.getPrice())%></td>
                                <td style="text-align: center;"><%=dish.getCategory()%></td>
                                <td style="text-align: center;">
                                    <button><i class="fas fa-pen"></i> Edit</button>
                                    <button><i class="fas fa-trash"></i> Delete</button>
                                </td>
                            </tr>
                            <% }
                        } else { %>
                            <tr>
                                <td colspan="6">No data available</td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>

                <div id="pagination"></div>
            </main>
        </div>

        <!-- Pagination Script -->
        <script>
            const rowsPerPage = 7;
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
                const prev = document.createElement("button");
                prev.textContent = "Prev";
                prev.disabled = currentPage === 1;
                prev.onclick = () => showPage(currentPage - 1);
                pagination.appendChild(prev);

                for (let i = 1; i <= totalPages; i++) {
                    const btn = document.createElement("button");
                    btn.textContent = i;
                    btn.disabled = i === currentPage;
                    btn.onclick = () => showPage(i);
                    pagination.appendChild(btn);
                }

                const next = document.createElement("button");
                next.textContent = "Next";
                next.disabled = currentPage === totalPages;
                next.onclick = () => showPage(currentPage + 1);
                pagination.appendChild(next);
            }

            showPage(1);
        </script>
    </body>

</html>
