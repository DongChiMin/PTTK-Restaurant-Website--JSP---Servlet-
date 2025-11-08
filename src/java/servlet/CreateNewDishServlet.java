package servlet;

import dao.DishDAO;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Dish;
import util.DBUtil;

@WebServlet(name = "CreateNewDishServlet", urlPatterns = {"/CreateNewDishServlet"})
public class CreateNewDishServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/Manager/ICreateNewDish.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        //Các thuộc tính cần dùng
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String category = request.getParameter("category");
        float price = Float.parseFloat(priceStr);

        //Đóng gói
        Dish newDish = new Dish(0, name, description, price, category);

        //Khai báo lớp DAO
        DishDAO dishDAO = new DishDAO(DBUtil.getConnection());
        dishDAO.insertDish(newDish);

        //Chuyển trang
        HttpSession session = request.getSession();
        session.setAttribute("successMessage", "Dish added successfully!");
        response.sendRedirect("ManageDishesServlet");
    }
}
