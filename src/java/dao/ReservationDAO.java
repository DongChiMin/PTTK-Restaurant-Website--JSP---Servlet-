/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Reservation;
import java.sql.Connection;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Customer;

/**
 *
 * @author namv2
 */
public class ReservationDAO {

    private Connection conn;
    
    public ReservationDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean insertReservation(Reservation newReservation) {
        String sql = """
        INSERT INTO tblReservation (bookingTime, note, status, tblCustomerid)
        VALUES (?, ?, ?, ?)
    """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            LocalDateTime bookingTime = newReservation.getBookingTime();
            String note = newReservation.getNote();
            String status = newReservation.getStatus();
            Customer customer = newReservation.getCustomer();
            
            // Chuyển LocalDateTime sang Timestamp để lưu vào DB
            ps.setTimestamp(1, Timestamp.valueOf(bookingTime));
            //Kiểm tra note nếu rỗng thì set null vào CSDL
            if(note != null && !note.isEmpty()){
                ps.setString(2, note);
            }
            else{
                ps.setNull(2, java.sql.Types.VARCHAR);
            }      
            ps.setString(3, status);
            ps.setInt(4, customer.getId());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

}
