package com.usermgmt.dao;

import com.usermgmt.model.User;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for User file storage.
 *
 * Demonstrates OOP:
 *  - Encapsulation: file path is private; all I/O goes through public methods
 *  - Single responsibility: this class owns all file read/write logic
 *
 * Storage format (users.txt):
 *   username|password|firstName|lastName|email|phone|role
 */
public class FileUserDAO {

    // Path to the data file — adjust to your project's data directory
    private static final String FILE_PATH = System.getProperty("user.home")
            + File.separator + "usermgmt_data" + File.separator + "users.txt";

    // ── Constructor: ensure directory and file exist ───────────────────────────

    public FileUserDAO() {
        File file = new File(FILE_PATH);
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }
        if (!file.exists()) {
            try {
                file.createNewFile();
            } catch (IOException e) {
                throw new RuntimeException("Cannot create users.txt: " + e.getMessage(), e);
            }
        }
    }

    // ── READ: load all users ──────────────────────────────────────────────────

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                User u = User.fromFileString(line);
                if (u != null) users.add(u);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return users;
    }

    // ── READ: find single user by username ────────────────────────────────────

    public User getUserByUsername(String username) {
        if (username == null || username.isEmpty()) return null;
        for (User u : getAllUsers()) {
            if (username.equalsIgnoreCase(u.getUsername())) return u;
        }
        return null;
    }

    // ── CREATE ────────────────────────────────────────────────────────────────

    /**
     * Adds a new user. Returns false if username already exists.
     */
    public boolean createUser(User user) {
        if (getUserByUsername(user.getUsername()) != null) {
            return false; // duplicate username
        }
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            bw.write(user.toFileString());
            bw.newLine();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── UPDATE ────────────────────────────────────────────────────────────────

    /**
     * Rewrites the file, replacing the matching user record.
     * If password field in updatedUser is blank, keeps the existing password.
     */
    public boolean updateUser(String originalUsername, User updatedUser) {
        List<User> users = getAllUsers();
        boolean found = false;

        for (int i = 0; i < users.size(); i++) {
            if (users.get(i).getUsername().equalsIgnoreCase(originalUsername)) {
                // Preserve password if not changed
                if (updatedUser.getPassword() == null || updatedUser.getPassword().isEmpty()) {
                    updatedUser.setPassword(users.get(i).getPassword());
                }
                users.set(i, updatedUser);
                found = true;
                break;
            }
        }

        if (!found) return false;
        return writeAllUsers(users);
    }

    // ── DELETE ────────────────────────────────────────────────────────────────

    public boolean deleteUser(String username) {
        List<User> users = getAllUsers();
        boolean removed = users.removeIf(u -> u.getUsername().equalsIgnoreCase(username));
        if (!removed) return false;
        return writeAllUsers(users);
    }

    // ── PRIVATE HELPER: overwrite file with full list ─────────────────────────

    private boolean writeAllUsers(List<User> users) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, false))) {
            for (User u : users) {
                bw.write(u.toFileString());
                bw.newLine();
            }
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── UTILITY: get file path (for display in viva) ──────────────────────────

    public String getFilePath() {
        return FILE_PATH;
    }
}