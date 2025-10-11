package dao;

import com.mysql.cj.jdbc.CallableStatement;
import model.Table;
import util.DBUtil;

import java.time.LocalDateTime;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author namv2
 */
public class TableDAO {

    public TableDAO() {
    }

    //Lấy danh sách các bàn trống trong khoảng thời gian bookingTime + 3 tiếng
    public List<Table> getAvailableTables(LocalDateTime bookingTime) throws SQLException {
        List<Table> tableList = new ArrayList<>();
        
        String sql = """
            SELECT t.*
            FROM tblTable t
            WHERE t.id NOT IN (
                SELECT rd.tblTableid
                FROM tblReservationDetail rd
                JOIN tblReservation r ON rd.tblReservationid = r.id
                WHERE r.status = 'confirmed'
                AND r.bookingTime >= DATE_SUB(?, INTERVAL 3 HOUR)
            	AND r.bookingTime <= DATE_ADD(?, INTERVAL 3 HOUR)
                )

                     """;
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bookingTime.toString());
            ps.setString(2, bookingTime.toString());
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Table t = new Table();
                t.setId(rs.getInt("id"));
                t.setName(rs.getString("name"));
                t.setLocation(rs.getString("location"));
                t.setCapacity(rs.getInt("capacity"));
                tableList.add(t);
            }

        }
        return tableList;
    }

    //Lấy bàn theo ID
    public Table getTableById(String id) throws SQLException {
        Table t = null;

        String sql = """
            SELECT * FROM tblTable t
                     WHERE t.id = ?
                     """;

        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                t = new Table();
                t.setId(rs.getInt("id"));
                t.setName(rs.getString("name"));
                t.setLocation(rs.getString("location"));
                t.setCapacity(rs.getInt("capacity"));
            }
        }
        return t;
    }
}
