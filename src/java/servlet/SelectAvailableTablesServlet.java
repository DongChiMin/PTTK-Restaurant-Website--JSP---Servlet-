package servlet;

import dao.TableDAO;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Table;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "SelectAvailableTablesServlet", urlPatterns = {"/SelectAvailableTablesServlet"})
public class SelectAvailableTablesServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        //Kiểm tra nếu trong request có thông tin về thời gian đặt bàn
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        if (date != null && !date.isEmpty() && time != null && !time.isEmpty()) {
            LocalDateTime startTime = LocalDateTime.of(LocalDate.parse(date), LocalTime.parse(time));
            LocalDateTime endTime = startTime.plusHours(3); //Mỗi đơn đặt được giữ chỗ 3 tiếng
            
            request.setAttribute("bookingDate", date);
            request.setAttribute("bookingTime", time);
            request.setAttribute("endTime", endTime.toLocalTime().toString());
            TableDAO tableDAO = new TableDAO();
            List<Table> tableList = new ArrayList<>();
                
                try {
                    tableList = tableDAO.getAvailableTables(startTime);
                    request.setAttribute("tableList", tableList);
                } catch (SQLException ex) {
                    Logger.getLogger(SelectAvailableTablesServlet.class.getName()).log(Level.SEVERE, null, ex);
                }    
        }
        
        //Kiểm tra nếu trong request có thông tin về bàn đã chọn
        String[] selectedTableIds = request.getParameterValues("selectedTableIds");
        if(selectedTableIds != null)
        {
            request.setAttribute("selectedTableIds", selectedTableIds);
        }
        //Chuyển trang
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/Customer/ISelectAvailableTables.jsp");
        dispatcher.forward(request, response);
    }
}
