/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.ReservationDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Reservation;
import model.Table;

/**
 *
 * @author namv2
 */
public class ReservationDetailDAO {

    private Connection conn;

    public ReservationDetailDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean insertReservationDetail(ReservationDetail newReservationDetail) {
        String sql = """
        INSERT INTO tblReservationDetail (tblReservationid, tblTableid)
        VALUES (?, ?)
    """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            Reservation reservation = newReservationDetail.getReservation();
            Table table = newReservationDetail.getTable();

            ps.setInt(1, reservation.getId());
            ps.setInt(2, table.getId());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

}
