package com.lake.entities;

public class BookingEntities {

    private int    id;
    private String name;
    private String email;
    private long   phoneNo;
    private int    noPerson;
    private int    noKids;
    private String arrival_date;
    private String departure_date;
    private String tent_name;
    private int    totalCost;
    private String status;
    private String paymentMethod;  // ONLINE / OFFLINE
    private String paymentStatus;  // PAID / PENDING
    private String bookedBy;       // username

    public BookingEntities() {}

    public BookingEntities(int id, String name, String email, long phoneNo,
                           int noPerson, int noKids,
                           String arrival_date, String departure_date,
                           String tent_name, int totalCost, String status) {
        this.id             = id;
        this.name           = name;
        this.email          = email;
        this.phoneNo        = phoneNo;
        this.noPerson       = noPerson;
        this.noKids         = noKids;
        this.arrival_date   = arrival_date;
        this.departure_date = departure_date;
        this.tent_name      = tent_name;
        this.totalCost      = totalCost;
        this.status         = status;
    }

    // ── Getters & Setters ────────────────────────────────────────────────────
    public int    getId()                            { return id; }
    public void   setId(int id)                      { this.id = id; }
    public String getName()                          { return name; }
    public void   setName(String name)               { this.name = name; }
    public String getEmail()                         { return email; }
    public void   setEmail(String email)             { this.email = email; }
    public long   getPhoneNo()                       { return phoneNo; }
    public void   setPhoneNo(long phoneNo)           { this.phoneNo = phoneNo; }
    public int    getNoPerson()                      { return noPerson; }
    public void   setNoPerson(int noPerson)          { this.noPerson = noPerson; }
    public int    getNoKids()                        { return noKids; }
    public void   setNoKids(int noKids)              { this.noKids = noKids; }
    public String getArrival_date()                  { return arrival_date; }
    public void   setArrival_date(String d)          { this.arrival_date = d; }
    public String getDeparture_date()                { return departure_date; }
    public void   setDeparture_date(String d)        { this.departure_date = d; }
    public String getTent_name()                     { return tent_name; }
    public void   setTent_name(String tent_name)     { this.tent_name = tent_name; }
    public int    getTotalCost()                     { return totalCost; }
    public void   setTotalCost(int totalCost)        { this.totalCost = totalCost; }
    public String getStatus()                        { return status; }
    public void   setStatus(String status)           { this.status = status; }
    public String getPaymentMethod()                 { return paymentMethod; }
    public void   setPaymentMethod(String m)         { this.paymentMethod = m; }
    public String getPaymentStatus()                 { return paymentStatus; }
    public void   setPaymentStatus(String s)         { this.paymentStatus = s; }
    public String getBookedBy()                      { return bookedBy; }
    public void   setBookedBy(String bookedBy)       { this.bookedBy = bookedBy; }
}
