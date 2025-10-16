/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Customer;
import util.DBUtil;

/**
 *
 * @author namv2
 */
public class CustomerDAO {

    public CustomerDAO() {
    }

    //Lấy khách hàng theo số điện thoại định danh, nếu không tìm thấy (chưa tồn tại trong CSDL) thì trả null
    public Customer getCustomerByPhone(String phoneNumber) {
        String sql = """
                     SELECT * FROM tblCustomer c
                     WHERE c.phoneNumber = ?
                     """;
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, phoneNumber);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Customer c = new Customer();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setPhoneNumber(rs.getString("phoneNumber"));
                c.setEmail(rs.getString("email"));
                String dob = rs.getString("dateOfBirth");
                if(dob != null && !dob.isEmpty()){
                    c.setDateOfBirth(LocalDate.parse(dob));
                }
                else{
                    c.setDateOfBirth(null);
                }

                return c;
            } else {
                return null;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public Customer getCustomerById(int customerId) {
        String sql = """
                     SELECT * FROM tblCustomer c
                     WHERE c.id = ?
                     """;
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Customer c = new Customer();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setPhoneNumber(rs.getString("phoneNumber"));
                c.setEmail(rs.getString("email"));
                c.setDateOfBirth(LocalDate.parse(rs.getString("dateOfBirth")));

                return c;
            } else {
                return null;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public int insertCustomer(Customer newCustomer) {
        String sql = """
                 INSERT INTO tblCustomer (name, phoneNumber, email, dateOfBirth)
                 VALUES (?, ?, ?, ?)
                 """;

        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            LocalDate dob = newCustomer.getDateOfBirth();
            String email = newCustomer.getEmail();
            
            ps.setString(1, newCustomer.getName());
            ps.setString(2, newCustomer.getPhoneNumber());
          
            //Kiểm tra email null
            if(email != null){
                  ps.setString(3, email);
            }
            else{
                ps.setNull(3, java.sql.Types.VARCHAR);
            }
            
            //Kiểm tra ngày sinh null
            if (dob != null) {
                ps.setDate(4, java.sql.Date.valueOf(dob));
            } else {
                ps.setNull(4, java.sql.Types.DATE);
            }

            //Nếu lưu thành công, trả về id. Nếu không thì trả về -1
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1); // Trả về reservationId vừa tạo
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }
}
