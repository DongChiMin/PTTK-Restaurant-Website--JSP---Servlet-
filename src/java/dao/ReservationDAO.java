/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Reservation;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.DBUtil;

/**
 *
 * @author namv2
 */
public class ReservationDAO {

    public ReservationDAO() {
    }

    public int insertReservation(Reservation reservation) {
        String sql = """
        INSERT INTO tblReservation (bookingTime, note, status, tblCustomerid)
        VALUES (?, ?, ?, ?)
    """;

        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            // Chuyển LocalDateTime sang Timestamp để lưu vào DB
            ps.setTimestamp(1, java.sql.Timestamp.valueOf(reservation.getBookingTime()));

            ps.setString(2, reservation.getNote());
            ps.setString(3, reservation.getStatus());
            ps.setInt(4, reservation.getTblCustomerid());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1); // Trả về reservationId vừa tạo
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return -1;
    }

}
