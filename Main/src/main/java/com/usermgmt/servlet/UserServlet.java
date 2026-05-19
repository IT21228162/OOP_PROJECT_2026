package com.usermgmt.servlet;

import com.usermgmt.dao.FileUserDAO;
import com.usermgmt.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * UserServlet — central controller for all user management operations.
 *
 * Demonstrates OOP:
 *  - Inheritance:   extends HttpServlet
 *  - Polymorphism:  overrides doGet() and doPost()
 *  - Encapsulation: delegates data logic to FileUserDAO
 *
 * URL mapping: /UserServlet
 *
 * Actions handled:
 *   GET  action=list   → list all users (users.jsp)
 *   GET  action=search → search user by username (search.jsp)
 *   POST action=create → register new user
 *   POST action=update → update existing user
 *   POST action=delete → delete user
 */
public class UserServlet extends HttpServlet {

    private FileUserDAO userDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new FileUserDAO();
    }

    // ═══════════════════════════════════════════════════════════════════════════
    // GET — Read operations
    // ═══════════════════════════════════════════════════════════════════════════

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {

            case "list":
                handleList(req, resp);
                break;

            case "search":
                handleSearch(req, resp);
                break;

            default:
                resp.sendRedirect("users.jsp");
        }
    }

    // ═══════════════════════════════════════════════════════════════════════════
    // POST — Create / Update / Delete operations
    // ═══════════════════════════════════════════════════════════════════════════

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) action = "";

        switch (action) {

            case "create":
                handleCreate(req, resp);
                break;

            case "update":
                handleUpdate(req, resp);
                break;

            case "delete":
                handleDelete(req, resp);
                break;

            default:
                resp.sendRedirect("users.jsp");
        }
    }

    // ═══════════════════════════════════════════════════════════════════════════
    // Handlers
    // ═══════════════════════════════════════════════════════════════════════════

    /**
     * READ — Fetch all users and forward to users.jsp
     */
    private void handleList(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<User> users = userDAO.getAllUsers();
        req.setAttribute("users", users);
        req.getRequestDispatcher("users.jsp").forward(req, resp);
    }

    /**
     * READ — Search for a user by username and forward to search.jsp
     */
    private void handleSearch(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        req.setAttribute("searched", true);

        if (username != null && !username.trim().isEmpty()) {
            User found = userDAO.getUserByUsername(username.trim());
            if (found != null) {
                req.setAttribute("foundUser", found);
            } else {
                req.setAttribute("error", "No user found with username: " + username);
            }
        }
        req.getRequestDispatcher("search.jsp").forward(req, resp);
    }

    /**
     * CREATE — Register a new user
     */
    private void handleCreate(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username  = trim(req.getParameter("username"));
        String password  = trim(req.getParameter("password"));
        String firstName = trim(req.getParameter("firstName"));
        String lastName  = trim(req.getParameter("lastName"));
        String email     = trim(req.getParameter("email"));
        String phone     = trim(req.getParameter("phone"));
        String role      = trim(req.getParameter("role"));

        // Basic validation
        if (username.isEmpty() || password.isEmpty() || firstName.isEmpty()
                || lastName.isEmpty() || email.isEmpty()) {
            req.setAttribute("error", "All required fields must be filled in.");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }

        if (password.length() < 6) {
            req.setAttribute("error", "Password must be at least 6 characters.");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }

        User newUser = new User(username, password, firstName, lastName, email, phone, role);
        boolean created = userDAO.createUser(newUser);

        if (created) {
            req.setAttribute("success", "User '" + username + "' registered successfully!");
        } else {
            req.setAttribute("error", "Username '" + username + "' is already taken. Choose another.");
        }
        req.getRequestDispatcher("register.jsp").forward(req, resp);
    }

    /**
     * UPDATE — Modify an existing user's details
     */
    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String originalUsername = trim(req.getParameter("originalUsername"));
        String firstName = trim(req.getParameter("firstName"));
        String lastName  = trim(req.getParameter("lastName"));
        String email     = trim(req.getParameter("email"));
        String phone     = trim(req.getParameter("phone"));
        String role      = trim(req.getParameter("role"));
        String password  = trim(req.getParameter("password")); // may be blank

        if (firstName.isEmpty() || lastName.isEmpty() || email.isEmpty()) {
            req.setAttribute("error", "First name, last name, and email are required.");
            handleSearchByUsername(req, resp, originalUsername);
            return;
        }

        // Keep same username on update (username is the key)
        User updatedUser = new User(originalUsername, password, firstName,
                lastName, email, phone, role);

        boolean updated = userDAO.updateUser(originalUsername, updatedUser);

        if (updated) {
            req.setAttribute("success", "User '" + originalUsername + "' updated successfully.");
        } else {
            req.setAttribute("error", "Update failed. User not found.");
        }

        // Re-show search page with the updated user
        req.setAttribute("searched", true);
        User refreshed = userDAO.getUserByUsername(originalUsername);
        req.setAttribute("foundUser", refreshed);
        req.getRequestDispatcher("search.jsp").forward(req, resp);
    }

    /**
     * DELETE — Remove a user from the file
     */
    private void handleDelete(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = trim(req.getParameter("username"));
        boolean deleted = userDAO.deleteUser(username);

        List<User> users = userDAO.getAllUsers();
        req.setAttribute("users", users);

        if (deleted) {
            req.setAttribute("success", "User '" + username + "' has been deleted.");
        } else {
            req.setAttribute("error", "Failed to delete user. They may not exist.");
        }
        req.getRequestDispatcher("users.jsp").forward(req, resp);
    }

    // ── Helper: re-fetch user for search page after update ────────────────────

    private void handleSearchByUsername(HttpServletRequest req, HttpServletResponse resp,
                                        String username) throws ServletException, IOException {
        req.setAttribute("searched", true);
        User found = userDAO.getUserByUsername(username);
        req.setAttribute("foundUser", found);
        req.getRequestDispatcher("search.jsp").forward(req, resp);
    }

    // ── Utility: null-safe trim ───────────────────────────────────────────────

    private String trim(String s) {
        return s != null ? s.trim() : "";
    }
}