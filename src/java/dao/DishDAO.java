package dao;

import model.Dish;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DishDAO {

    private Connection conn;
    
    public DishDAO(Connection conn) {
        this.conn = conn;
    }

    public List<Dish> getDishesList() {
        String sql = "SELECT * FROM tblDish";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();

            List<Dish> dishList = new ArrayList<>();
            while (rs.next()) {
                Dish dish = new Dish();
                dish.setId(rs.getInt("id"));
                dish.setName(rs.getString("name"));
                dish.setDescription(rs.getString("description"));
                dish.setPrice(rs.getFloat("price"));
                dish.setCategory(rs.getString("category"));

                dishList.add(dish);
            }
            return dishList;
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public boolean insertDish(Dish newDish) {
        String sql = "INSERT INTO tblDish(name, description, price, category) VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newDish.getName());
            ps.setString(2, newDish.getDescription());
            ps.setDouble(3, newDish.getPrice());
            ps.setString(4, newDish.getCategory());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
