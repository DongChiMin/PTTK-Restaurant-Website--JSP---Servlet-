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
    private int tblReservationid;
    private int tblTableid;

    public ReservationDetail() {
    }

    public ReservationDetail(int id, int tblReservationid, int tblTableid) {
        this.id = id;
        this.tblReservationid = tblReservationid;
        this.tblTableid = tblTableid;
    }

    public int getId() {
        return id;
    }

    public int getTblReservationid() {
        return tblReservationid;
    }

    public int getTblTableid() {
        return tblTableid;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setTblReservationid(int tblReservationid) {
        this.tblReservationid = tblReservationid;
    }

    public void setTblTableid(int tblTableid) {
        this.tblTableid = tblTableid;
    }
    
    
}
