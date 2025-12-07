/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;

/**
 *
 * @author namv2
 */
public class Bill {
    int id;
    LocalDateTime createAt;
    float totalPrice;
    String paymentMethod;
    Customer customer;
    Reservation reservation;
    Seller seller;

    public Bill() {
    }
    
    

    public Bill(int id, LocalDateTime createAt, float totalPrice, String paymentMethod, Customer customer, Reservation reservation, Seller seller) {
        this.id = id;
        this.createAt = createAt;
        this.totalPrice = totalPrice;
        this.paymentMethod = paymentMethod;
        this.customer = customer;
        this.reservation = reservation;
        this.seller = seller;
    }

    public int getId() {
        return id;
    }

    public LocalDateTime getCreateAt() {
        return createAt;
    }

    public float getTotalPrice() {
        return totalPrice;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public Customer getCustomer() {
        return customer;
    }

    public Reservation getReservation() {
        return reservation;
    }

    public Seller getSeller() {
        return seller;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setCreateAt(LocalDateTime createAt) {
        this.createAt = createAt;
    }

    public void setTotalPrice(float totalPrice) {
        this.totalPrice = totalPrice;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public void setReservation(Reservation reservation) {
        this.reservation = reservation;
    }

    public void setSeller(Seller seller) {
        this.seller = seller;
    }
    
    
}
