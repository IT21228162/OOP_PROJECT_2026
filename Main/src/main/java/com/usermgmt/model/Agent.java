package com.usermgmt.model;

public class Agent {

    private String agentId;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String specialization;
    private String location;
    private String experience;
    private String status;

    public Agent() {}

    public Agent(String agentId, String firstName, String lastName,
                 String email, String phone, String specialization,
                 String location, String experience, String status) {
        this.agentId        = agentId;
        this.firstName      = firstName;
        this.lastName       = lastName;
        this.email          = email;
        this.phone          = phone;
        this.specialization = specialization;
        this.location       = location;
        this.experience     = experience;
        this.status         = status;
    }

    // ── File serialisation ────────────────────────────────
    public String toFileString() {
        return String.join("|",
                safe(agentId), safe(firstName), safe(lastName),
                safe(email), safe(phone), safe(specialization),
                safe(location), safe(experience), safe(status)
        );
    }

    public static Agent fromFileString(String line) {
        if (line == null || line.trim().isEmpty()) return null;
        String[] p = line.split("\\|", -1);
        if (p.length < 9) return null;
        return new Agent(p[0], p[1], p[2], p[3],
                p[4], p[5], p[6], p[7], p[8]);
    }

    private String safe(String s) { return s != null ? s : ""; }

    @Override
    public String toString() {
        return "Agent{id='" + agentId + "', name='" + firstName + " " + lastName + "'}";
    }

    // ── Getters & Setters ─────────────────────────────────
    public String getAgentId()                  { return agentId; }
    public void   setAgentId(String id)         { this.agentId = id; }
    public String getFirstName()                { return firstName; }
    public void   setFirstName(String fn)       { this.firstName = fn; }
    public String getLastName()                 { return lastName; }
    public void   setLastName(String ln)        { this.lastName = ln; }
    public String getEmail()                    { return email; }
    public void   setEmail(String e)            { this.email = e; }
    public String getPhone()                    { return phone; }
    public void   setPhone(String p)            { this.phone = p; }
    public String getSpecialization()           { return specialization; }
    public void   setSpecialization(String s)   { this.specialization = s; }
    public String getLocation()                 { return location; }
    public void   setLocation(String l)         { this.location = l; }
    public String getExperience()               { return experience; }
    public void   setExperience(String e)       { this.experience = e; }
    public String getStatus()                   { return status; }
    public void   setStatus(String s)           { this.status = s; }
}