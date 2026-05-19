package com.usermgmt.model;

public class Property {

    private String propertyId;
    private String title;
    private String type;
    private String location;
    private String price;
    private String bedrooms;
    private String bathrooms;
    private String area;
    private String agentId;
    private String status;

    public Property() {}

    public Property(String propertyId, String title, String type,
                    String location, String price, String bedrooms,
                    String bathrooms, String area, String agentId, String status) {
        this.propertyId = propertyId;
        this.title      = title;
        this.type       = type;
        this.location   = location;
        this.price      = price;
        this.bedrooms   = bedrooms;
        this.bathrooms  = bathrooms;
        this.area       = area;
        this.agentId    = agentId;
        this.status     = status;
    }

    public String toFileString() {
        return String.join("|",
                safe(propertyId), safe(title), safe(type),
                safe(location), safe(price), safe(bedrooms),
                safe(bathrooms), safe(area), safe(agentId), safe(status)
        );
    }

    public static Property fromFileString(String line) {
        if (line == null || line.trim().isEmpty()) return null;
        String[] p = line.split("\\|", -1);
        if (p.length < 10) return null;
        return new Property(p[0], p[1], p[2], p[3], p[4],
                p[5], p[6], p[7], p[8], p[9]);
    }

    private String safe(String s) { return s != null ? s : ""; }

    public String getPropertyId()             { return propertyId; }
    public void   setPropertyId(String id)    { this.propertyId = id; }
    public String getTitle()                  { return title; }
    public void   setTitle(String t)          { this.title = t; }
    public String getType()                   { return type; }
    public void   setType(String t)           { this.type = t; }
    public String getLocation()               { return location; }
    public void   setLocation(String l)       { this.location = l; }
    public String getPrice()                  { return price; }
    public void   setPrice(String p)          { this.price = p; }
    public String getBedrooms()               { return bedrooms; }
    public void   setBedrooms(String b)       { this.bedrooms = b; }
    public String getBathrooms()              { return bathrooms; }
    public void   setBathrooms(String b)      { this.bathrooms = b; }
    public String getArea()                   { return area; }
    public void   setArea(String a)           { this.area = a; }
    public String getAgentId()                { return agentId; }
    public void   setAgentId(String a)        { this.agentId = a; }
    public String getStatus()                 { return status; }
    public void   setStatus(String s)         { this.status = s; }
}