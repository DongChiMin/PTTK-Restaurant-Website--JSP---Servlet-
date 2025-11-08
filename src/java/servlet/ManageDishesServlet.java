package servlet;

import dao.DishDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Dish;
import util.DBUtil;

@WebServlet(name = "ManageDishesServlet", urlPatterns = {"/ManageDishesServlet"})
public class ManageDishesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");        
        
        HttpSession session = request.getSession();
        String successMessage = (String) session.getAttribute("successMessage");
        if(successMessage != null && !successMessage.isEmpty()){
            request.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage");
        }
        
        DishDAO dishDAO = new DishDAO(DBUtil.getConnection());
        List<Dish> dishesList = dishDAO.getDishesList();
        request.setAttribute("dishesList", dishesList);
        //Chuyển trang
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/Manager/IManageDishes.jsp");
        dispatcher.forward(request, response);
    }
}
