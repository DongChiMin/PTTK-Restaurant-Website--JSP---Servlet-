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
public class Reservation {
    private int id;
    private LocalDateTime bookingTime;
    private String note;
    private String status;
    private int tblCustomerid;

    public Reservation() {
    }

    public Reservation(int id, LocalDateTime bookingTime, String note, String status, int tblCustomerid) {
        this.id = id;
        this.bookingTime = bookingTime;
        this.note = note;
        this.status = status;
        this.tblCustomerid = tblCustomerid;
    }

    public int getId() {
        return id;
    }

    public LocalDateTime getBookingTime() {
        return bookingTime;
    }

    public String getNote() {
        return note;
    }

    public String getStatus() {
        return status;
    }

    public int getTblCustomerid() {
        return tblCustomerid;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setBookingTime(LocalDateTime bookingTime) {
        this.bookingTime = bookingTime;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setTblCustomerid(int tblCustomerid) {
        this.tblCustomerid = tblCustomerid;
    }
    
    
}
