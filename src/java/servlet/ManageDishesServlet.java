package servlet;

import dao.DishDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Dish;

@WebServlet(name = "ManageDishesServlet", urlPatterns = {"/ManageDishesServlet"})
public class ManageDishesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DishDAO dishDAO = new DishDAO();
        try {
            Dish[] dishes = dishDAO.getDishesList();
            request.setAttribute("dishes", dishes);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/Manager/IManageDishes.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ManageDishesServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
