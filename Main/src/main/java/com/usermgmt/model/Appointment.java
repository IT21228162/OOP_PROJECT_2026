package com.usermgmt.model;

public class Appointment {

    private String appointmentId;
    private String clientName;
    private String clientEmail;
    private String clientPhone;
    private String agentId;
    private String propertyId;
    private String date;
    private String time;
    private String type;
    private String status;
    private String notes;

    public Appointment() {}

    public Appointment(String appointmentId, String clientName, String clientEmail,
                       String clientPhone, String agentId, String propertyId,
                       String date, String time, String type, String status, String notes) {
        this.appointmentId = appointmentId;
        this.clientName    = clientName;
        this.clientEmail   = clientEmail;
        this.clientPhone   = clientPhone;
        this.agentId       = agentId;
        this.propertyId    = propertyId;
        this.date          = date;
        this.time          = time;
        this.type          = type;
        this.status        = status;
        this.notes         = notes;
    }

    public String toFileString() {
        return String.join("|",
                safe(appointmentId), safe(clientName), safe(clientEmail),
                safe(clientPhone), safe(agentId), safe(propertyId),
                safe(date), safe(time), safe(type), safe(status), safe(notes)
        );
    }

    public static Appointment fromFileString(String line) {
        if (line == null || line.trim().isEmpty()) return null;
        String[] p = line.split("\\|", -1);
        if (p.length < 11) return null;
        return new Appointment(p[0], p[1], p[2], p[3], p[4],
                p[5], p[6], p[7], p[8], p[9], p[10]);
    }

    private String safe(String s) { return s != null ? s : ""; }

    public String getAppointmentId()              { return appointmentId; }
    public void   setAppointmentId(String id)     { this.appointmentId = id; }
    public String getClientName()                 { return clientName; }
    public void   setClientName(String n)         { this.clientName = n; }
    public String getClientEmail()                { return clientEmail; }
    public void   setClientEmail(String e)        { this.clientEmail = e; }
    public String getClientPhone()                { return clientPhone; }
    public void   setClientPhone(String p)        { this.clientPhone = p; }
    public String getAgentId()                    { return agentId; }
    public void   setAgentId(String a)            { this.agentId = a; }
    public String getPropertyId()                 { return propertyId; }
    public void   setPropertyId(String p)         { this.propertyId = p; }
    public String getDate()                       { return date; }
    public void   setDate(String d)               { this.date = d; }
    public String getTime()                       { return time; }
    public void   setTime(String t)               { this.time = t; }
    public String getType()                       { return type; }
    public void   setType(String t)               { this.type = t; }
    public String getStatus()                     { return status; }
    public void   setStatus(String s)             { this.status = s; }
    public String getNotes()                      { return notes; }
    public void   setNotes(String n)              { this.notes = n; }
}