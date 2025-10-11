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
import util.DBUtil;
/**
 *
 * @author namv2
 */
public class ReservationDetailDAO {

    public ReservationDetailDAO() {
    }
    
    public void insertReservationDetail(ReservationDetail reservationDetail) {
    String sql = """
        INSERT INTO tblReservationDetail (tblReservationid, tblTableid)
        VALUES (?, ?)
    """;

    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, reservationDetail.getTblReservationid());
        ps.setInt(2, reservationDetail.getTblTableid());

        ps.executeUpdate();
    } catch (SQLException ex) {
        Logger.getLogger(ReservationDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
    }
}

}
