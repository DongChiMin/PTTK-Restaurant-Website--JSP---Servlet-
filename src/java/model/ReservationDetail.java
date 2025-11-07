/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author namv2
 */
public class ReservationDetail {
    private int id;
    private Reservation reservation;
    private Table table;

    public ReservationDetail() {
    }

    public ReservationDetail(int id, Reservation reservation, Table table) {
        this.id = id;
        this.reservation = reservation;
        this.table = table;
    }

    public int getId() {
        return id;
    }

    public Reservation getReservation() {
        return reservation;
    }

    public Table getTable() {
        return table;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setReservation(Reservation reservation) {
        this.reservation = reservation;
    }

    public void setTable(Table table) {
        this.table = table;
    }
    
    
}
