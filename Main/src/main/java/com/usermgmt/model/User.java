package com.usermgmt.model;

/**
 * User entity — encapsulates all user data.
 * Demonstrates OOP: encapsulation via private fields + getters/setters.
 */
public class User {

    private String username;
    private String password;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String role;

    // ── Constructors ──────────────────────────────────────────────────────────

    public User() {}

    public User(String username, String password, String firstName,
                String lastName, String email, String phone, String role) {
        this.username  = username;
        this.password  = password;
        this.firstName = firstName;
        this.lastName  = lastName;
        this.email     = email;
        this.phone     = phone;
        this.role      = role;
    }

    // ── File serialisation ────────────────────────────────────────────────────

    /**
     * Converts User to a pipe-delimited string for storage in users.txt.
     * Format: username|password|firstName|lastName|email|phone|role
     */
    public String toFileString() {
        return String.join("|",
                safe(username),
                safe(password),
                safe(firstName),
                safe(lastName),
                safe(email),
                safe(phone),
                safe(role)
        );
    }

    /**
     * Parses a pipe-delimited line from users.txt back into a User object.
     */
    public static User fromFileString(String line) {
        if (line == null || line.trim().isEmpty()) return null;
        String[] parts = line.split("\\|", -1);
        if (parts.length < 7) return null;
        return new User(
                parts[0], parts[1], parts[2],
                parts[3], parts[4], parts[5], parts[6]
        );
    }

    private String safe(String s) {
        return s != null ? s : "";
    }

    // ── toString ──────────────────────────────────────────────────────────────

    @Override
    public String toString() {
        return "User{username='" + username + "', role='" + role + "'}";
    }

    // ── Getters & Setters ─────────────────────────────────────────────────────

    public String getUsername()              { return username;  }
    public void   setUsername(String u)      { this.username  = u; }

    public String getPassword()              { return password; }
    public void   setPassword(String p)      { this.password  = p; }

    public String getFirstName()             { return firstName; }
    public void   setFirstName(String fn)    { this.firstName = fn; }

    public String getLastName()              { return lastName;  }
    public void   setLastName(String ln)     { this.lastName  = ln; }

    public String getEmail()                 { return email;    }
    public void   setEmail(String e)         { this.email     = e; }

    public String getPhone()                 { return phone;    }
    public void   setPhone(String p)         { this.phone     = p; }

    public String getRole()                  { return role;     }
    public void   setRole(String r)          { this.role      = r; }
}