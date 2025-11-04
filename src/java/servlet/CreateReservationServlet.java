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

    Customer customer = null;
    List<Table> selectedTableList = new ArrayList<>();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Các biến cần để hiển thị trên giao diện
        String[] selectedTableIds = request.getParameterValues("selectedTableIds");
        String bookingTime = request.getParameter("bookingTime");
        String endTime = request.getParameter("endTime");
        String bookingDate = request.getParameter("bookingDate");
        String phoneNumber = request.getParameter("phoneNumber");
        TableDAO tableDAO = new TableDAO();
        selectedTableList.clear();
        for (String tableId : selectedTableIds) {
            System.out.println(tableId);
            Table t = tableDAO.getTableById(tableId);
            selectedTableList.add(t);
        }

        //Các trường hợp xử lý theo nút bấm
        String action = request.getParameter("action");
        switch (action) {
            case "loadReservationPage" -> {
                //Set trạng thái đã chưa nhập sdt để JSP hiển thị thông tin
                request.setAttribute("phoneNumberEntered", false);
            }
            case "search" -> {
                CustomerDAO customerDAO = new CustomerDAO();
                phoneNumber = request.getParameter("phoneNumber");

                customer = customerDAO.getCustomerByPhone(phoneNumber);
                request.setAttribute("customer", customer);

                //Set trạng thái đã nhập sdt để JSP hiển thị thông tin
                request.setAttribute("phoneNumberEntered", true);
            }
            case "reset" -> {
                phoneNumber = "";
                request.setAttribute("phoneNumberEntered", false);

            }
        }

        //Set thuộc tính cho request để hiển thị trong trường hợp search hoặc reset
        request.setAttribute("endTime", endTime);
        request.setAttribute("selectedTableIds", selectedTableIds);
        request.setAttribute("selectedTableList", selectedTableList);
        request.setAttribute("bookingTime", bookingTime);
        request.setAttribute("bookingDate", bookingDate);
        request.setAttribute("phoneNumber", phoneNumber);

        //Chuyển trang
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/Customer/ICreateReservation.jsp");
        dispatcher.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Các thông tin về đặt bàn
        String bookingTime = request.getParameter("bookingTime");
        String bookingDate = request.getParameter("bookingDate");
        String note = request.getParameter("note");

        //Các thông tin về khách hàng trong trường hợp nhập mới
        String phoneNumber = request.getParameter("phoneNumber");
        String name = request.getParameter("name");
        String dateOfBirth = request.getParameter("dateOfBirth");
        String email = request.getParameter("email");
        String customerIdString = request.getParameter("customerId");
        //Nếu trong trang có thông tin customer rồi thì set customerId luôn, nếu không thì gán -1
        int customerId = customerIdString != null ? Integer.parseInt(customerIdString) : -1;

        //Khai báo DAO 
        CustomerDAO customerDAO = new CustomerDAO();
        ReservationDAO reservationDAO = new ReservationDAO();
        ReservationDetailDAO reservationDetailDAO = new ReservationDetailDAO();

        //BẮT ĐẦU TRANSACTION        
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            // 1. Lấy kết nối và tắt auto-commit để thực hiện transaction
            conn.setAutoCommit(false); // Tắt auto-commit để kiểm soát transaction

            //2. nếu id = -1 (Trên trang không có đối tượng customer) thì phải tạo mới và lưu vào CSDL
            if (customerId == -1) {
                if(email != null){
                    if(email.isEmpty()){
                        email = null;
                    }
                    else{
                    //kiểm tra email đã tồn tại chưa, nếu đã tồn tại thì quay lại trang và thông báo
                        Customer checkEmail = customerDAO.getCustomerByEmail(email);
                        if(checkEmail != null){
                            request.setAttribute("phoneNumberEntered", true);
                            request.setAttribute("emailError", "This email address is already in use.");
                            doGet(request, response);
                            return;
                        }
                        
                    }
                }
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

            //4. Lưu đối tượng reservationDetail
            for (Table t : selectedTableList) {
                ReservationDetail rDetail = new ReservationDetail(0, reservationId, t.getId());
                reservationDetailDAO.insertReservationDetail(rDetail);
            }

            //5. Commit transaction sau khi tất cả các thao tác thành công
            conn.commit();

            //6. Về trang chủ kèm thông báo thành công
            request.setAttribute("bookingTableSuccess", true);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/Customer/IMenuCustomer.jsp");
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

    }

}
