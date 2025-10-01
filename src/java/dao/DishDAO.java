package dao;

import model.Dish;
import util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DishDAO {
    public Dish[] getDishesLít() throws SQLException {
        String sql = "SELECT * FROM dish";
        
        try(Connection conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            
        }
        return null;
    }
}
