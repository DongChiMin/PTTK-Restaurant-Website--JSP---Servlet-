package servlet;

import dao.DishDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Dish;

@WebServlet(name = "CreateNewDishServlet", urlPatterns = {"/CreateNewDishServlet"})
public class CreateNewDishServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/Manager/ICreateNewDish.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String category = request.getParameter("category");
        float price = Float.parseFloat(priceStr);
        
        //Đóng gói
        Dish newDish = new Dish(0, name, description, price, category);
        
        DishDAO dishDAO = new DishDAO();
        try {
            dishDAO.submitNewDish(newDish);
            response.sendRedirect("ManageDishesServlet");
        } catch (SQLException ex) {
            //Chưa xử lý
            Logger.getLogger(CreateNewDishServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
