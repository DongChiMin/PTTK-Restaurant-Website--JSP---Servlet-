package servlet;

import dao.CustomerDAO;
import dao.ReservationDAO;
import dao.ReservationDetailDAO;
import dao.TableDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Connection;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Table;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Customer;
import model.Reservation;
import model.ReservationDetail;
import util.DBUtil;

@WebServlet(name = "CreateReservationServlet", urlPatterns = {"/CreateReservationServlet"})
public class CreateReservationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String[] selectedTableIds = request.getParameterValues("tableIds");
        String bookingTime = request.getParameter("bookingTime");
        String endTime = request.getParameter("endTime");
        String bookingDate = request.getParameter("bookingDate");
        TableDAO tableDAO = new TableDAO();
        List<Table> tableList = new ArrayList<>();

        //Set các dữ liệu cần thiết cho trang
        try {
            for (String tableId : selectedTableIds) {
                Table t = tableDAO.getTableById(tableId);
                tableList.add(t);
            }
        } catch (SQLException ex) {
            //Chưa xử lý
            Logger.getLogger(CreateReservationServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.setAttribute("endTime", endTime);
        request.setAttribute("selectedTableList", tableList);
        request.setAttribute("bookingTime", bookingTime);
        request.setAttribute("bookingDate", bookingDate);
        request.setAttribute("phoneNumberEntered", false);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/Customer/ICreateReservation.jsp");
        dispatcher.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingTime = request.getParameter("bookingTime");
        String endTime = request.getParameter("endTime");
        String bookingDate = request.getParameter("bookingDate");
        String phoneNumber = request.getParameter("phoneNumber");
        String name = request.getParameter("name");
        String dateOfBirth = request.getParameter("dateOfBirth");
        String email = request.getParameter("email");
        String[] selectedTableIds = request.getParameterValues("selectedTableIds");
        String note = request.getParameter("note");
        TableDAO tableDAO = new TableDAO();
        CustomerDAO customerDAO = new CustomerDAO();
        ReservationDAO reservationDAO = new ReservationDAO();
        ReservationDetailDAO reservationDetailDAO = new ReservationDetailDAO();
        List<Table> selectedTableList = new ArrayList<>();
        String customerIdString = request.getParameter("customerId");
        int customerId = customerIdString != null ? Integer.parseInt(customerIdString) : -1;
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/Customer/ICreateReservation.jsp");
        try {
            for (String tableId : selectedTableIds) {
                Table t = tableDAO.getTableById(tableId);
                selectedTableList.add(t);
            }
        } catch (SQLException ex) {
            //Chưa xử lý
            Logger.getLogger(CreateReservationServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute("endTime", endTime);
        request.setAttribute("selectedTableList", selectedTableList);
        request.setAttribute("bookingTime", bookingTime);
        request.setAttribute("bookingDate", bookingDate);
        request.setAttribute("phoneNumber", phoneNumber);
        request.setAttribute("phoneNumberEntered", true);

        //Xử lý hành động của nút bấm
        String action = request.getParameter("action");

        switch (action) {
            case "search":
                Customer customer = customerDAO.getCustomerByPhone(phoneNumber);
                request.setAttribute("customer", customer);

                dispatcher = request.getRequestDispatcher("/WEB-INF/Customer/ICreateReservation.jsp");
                dispatcher.forward(request, response);

                break;

            case "reset":
                request.removeAttribute("phoneNumber");
                request.setAttribute("phoneNumberEntered", false);
                dispatcher = request.getRequestDispatcher("/WEB-INF/Customer/ICreateReservation.jsp");
                dispatcher.forward(request, response);
                break;

            case "submit":
                Connection conn = null;
                //BẮT ĐẦU TRANSACTION
                try {
                    conn = DBUtil.getConnection();
                    // 1. Lấy kết nối và tắt auto-commit để thực hiện transaction
                    conn.setAutoCommit(false); // Tắt auto-commit để kiểm soát transaction

                    //2. Lấy đối tượng Customer hoặc tạo mới và lưu
                    if (customerId != -1) {
                        customer = customerDAO.getCustomerById(customerId);
                    } else {
                        customer = new Customer(
                                0,
                                name,
                                phoneNumber,
                                email,
                                (dateOfBirth != null && !dateOfBirth.isEmpty()) ? LocalDate.parse(dateOfBirth) : null);
                        customerId = customerDAO.insertCustomer(customer);
                    }

                    //3. Lưu đối tượng reservation
                    Reservation reservation = new Reservation(
                            0,
                            LocalDateTime.of(LocalDate.parse(bookingDate), LocalTime.parse(bookingTime)),
                            note,
                            "pending",
                            customerId);
                    int reservationId = reservationDAO.insertReservation(reservation);
                    if (reservationId < 0) {
                        System.out.println("Lỗi trả về id reservation sai");
                        break;
                    }

                    //4. Lưu đối tượng reservationDetail
                    for (Table t : selectedTableList) {
                        ReservationDetail rDetail = new ReservationDetail(0, reservationId, t.getId());
                        reservationDetailDAO.insertReservationDetail(rDetail);
                    }

                    //5. Commit transaction sau khi tất cả các thao tác thành công
                    conn.commit();

                    //6. Về trang chủ kèm thông báo thành công
                    request.setAttribute("bookingTableSuccess", true);
                    dispatcher = request.getRequestDispatcher("/WEB-INF/Customer/IMenuCustomer.jsp");
                    dispatcher.forward(request, response);
                } catch (Exception e) {
                    if (conn != null) {
                        try {
                            conn.rollback(); // Rollback nếu có lỗi xảy ra
                        } catch (SQLException se) {
                            se.printStackTrace();
                        }
                    }
                    e.printStackTrace();
                } finally {
                    if (conn != null) {
                        try {
                            conn.setAutoCommit(true); // Khôi phục chế độ auto-commit về mặc định
                            conn.close();
                        } catch (SQLException se) {
                            se.printStackTrace();
                        }
                    }
                }
                break;
        }
    }

}
