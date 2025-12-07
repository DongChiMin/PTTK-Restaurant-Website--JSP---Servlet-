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
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Bill;
import model.Customer;
import model.Reservation;

/**
 *
 * @author namv2
 */
public class CustomerDAO {
    
    private Connection conn;

    public CustomerDAO(Connection conn) {
        this.conn = conn;
    }
    
    public List<Reservation> getReservationById(Customer customer){
        String sql = """
            SELECT r.*
            FROM tblReservation r
            WHERE r.tblCustomerid = ?
                     """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customer.getId());
            ResultSet rs = ps.executeQuery();
            
            List<Reservation> reservationList = new ArrayList<>();
            while (rs.next()) {
                Reservation reservation = new Reservation();
                reservation.setId(rs.getInt("id"));

                reservationList.add(reservation);
            }
            return reservationList;
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public List<Bill> getBillById(Customer customer){
        String sql = """
            SELECT t.*
            FROM tblBill t
            WHERE t.tblCustomerid = ?
                     """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customer.getId());
            ResultSet rs = ps.executeQuery();
            
            List<Bill> billList = new ArrayList<>();
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setTotalPrice(rs.getFloat("totalPrice"));

                billList.add(bill);
            }
            return billList;
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    //Lấy khách hàng theo số điện thoại định danh, nếu không tìm thấy (chưa tồn tại trong CSDL) thì trả null
    public Customer getCustomerByPhone(String phoneNumber) {
        String sql = """
                     SELECT * FROM tblCustomer c
                     WHERE c.phoneNumber = ?
                     """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
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
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
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
    
    public Customer getCustomerByEmail(String email){
        String sql = """
                     SELECT * FROM tblCustomer c
                     WHERE c.email = ?
                     """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
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

    public int insertCustomer(Customer newCustomer) {
        String sql = """
                 INSERT INTO tblCustomer (name, phoneNumber, email, dateOfBirth)
                 VALUES (?, ?, ?, ?)
                 """;

        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            LocalDate dob = newCustomer.getDateOfBirth();
            String email = newCustomer.getEmail();
            
            ps.setString(1, newCustomer.getName());
            ps.setString(2, newCustomer.getPhoneNumber());
            //Kiểm tra email null
            if(email != null && !email.isEmpty()){
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

            //Nếu lưu thành công, trả về true. Nếu không thì trả về false
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
