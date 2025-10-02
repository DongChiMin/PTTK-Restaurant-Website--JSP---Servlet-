package dao;

import model.Dish;
import util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DishDAO {
    public Dish[] getDishesList() throws SQLException {
        String sql = "SELECT * FROM tblDish";
        
        try(Connection conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            
            List<Dish> dishList = new ArrayList<>();
            while(rs.next()){
                Dish dish = new Dish();
                dish.setId(rs.getInt("id"));
                dish.setName(rs.getString("name"));
                dish.setDescription(rs.getString("description"));
                dish.setPrice(rs.getFloat("price"));
                dish.setCategory(rs.getString("category"));
                
                dishList.add(dish);
            }
            
            return dishList.toArray(new Dish[0]);
        }
    }
    
    public void submitNewDish(String name, String description, float Price, String category) throws SQLException{
        String sql = "INSERT INTO tblDish(name, description, price, category) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            Dish newDish = new Dish(0, name, description, Price, category);
            
            ps.setString(1, newDish.getName());
            ps.setString(2, newDish.getDescription());
            ps.setDouble(3, newDish.getPrice());
            ps.setString(4, newDish.getCategory());

            //Nếu không Rows nào ảnh hưởng, trả về false
            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {

                throw new SQLException("Creating dish failed, no rows affected.");
            }
        }
    }
}
