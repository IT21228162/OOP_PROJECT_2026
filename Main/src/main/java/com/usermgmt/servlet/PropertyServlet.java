package com.usermgmt.servlet;

import com.usermgmt.dao.FilePropertyDAO;
import com.usermgmt.model.Property;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/PropertyServlet")
public class PropertyServlet extends HttpServlet {

    private FilePropertyDAO propertyDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        propertyDAO = new FilePropertyDAO();
    }

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
                resp.sendRedirect("properties.jsp");
        }
    }

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
                resp.sendRedirect("properties.jsp");
        }
    }

    private void handleList(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Property> list = propertyDAO.getAllProperties();
        req.setAttribute("properties", list);
        req.getRequestDispatcher("properties.jsp").forward(req, resp);
    }

    private void handleSearch(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String propertyId = req.getParameter("propertyId");
        req.setAttribute("searched", true);
        if (propertyId != null && !propertyId.trim().isEmpty()) {
            Property found = propertyDAO.getPropertyById(propertyId.trim());
            if (found != null) {
                req.setAttribute("foundProperty", found);
            } else {
                req.setAttribute("error", "No property found with ID: " + propertyId);
            }
        }
        req.getRequestDispatcher("search-property.jsp").forward(req, resp);
    }

    private void handleCreate(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String propertyId = trim(req.getParameter("propertyId"));
        String title      = trim(req.getParameter("title"));
        String type       = trim(req.getParameter("type"));
        String location   = trim(req.getParameter("location"));
        String price      = trim(req.getParameter("price"));
        String bedrooms   = trim(req.getParameter("bedrooms"));
        String bathrooms  = trim(req.getParameter("bathrooms"));
        String area       = trim(req.getParameter("area"));
        String agentId    = trim(req.getParameter("agentId"));
        String status     = trim(req.getParameter("status"));

        if (propertyId.isEmpty() || title.isEmpty() || location.isEmpty()) {
            req.setAttribute("error", "Property ID, title and location are required.");
            req.getRequestDispatcher("add-property.jsp").forward(req, resp);
            return;
        }

        Property property = new Property(propertyId, title, type, location,
                price, bedrooms, bathrooms, area, agentId, status);
        boolean created = propertyDAO.createProperty(property);

        if (created) {
            req.setAttribute("success", "Property '" + propertyId + "' added successfully!");
        } else {
            req.setAttribute("error", "Property ID '" + propertyId + "' already exists.");
        }
        req.getRequestDispatcher("add-property.jsp").forward(req, resp);
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String originalId = trim(req.getParameter("originalId"));
        String title      = trim(req.getParameter("title"));
        String type       = trim(req.getParameter("type"));
        String location   = trim(req.getParameter("location"));
        String price      = trim(req.getParameter("price"));
        String bedrooms   = trim(req.getParameter("bedrooms"));
        String bathrooms  = trim(req.getParameter("bathrooms"));
        String area       = trim(req.getParameter("area"));
        String agentId    = trim(req.getParameter("agentId"));
        String status     = trim(req.getParameter("status"));

        Property updated = new Property(originalId, title, type, location,
                price, bedrooms, bathrooms, area, agentId, status);
        boolean ok = propertyDAO.updateProperty(originalId, updated);

        req.setAttribute("searched", true);
        Property refreshed = propertyDAO.getPropertyById(originalId);
        req.setAttribute("foundProperty", refreshed);

        if (ok) {
            req.setAttribute("success", "Property updated successfully.");
        } else {
            req.setAttribute("error", "Update failed.");
        }
        req.getRequestDispatcher("search-property.jsp").forward(req, resp);
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String propertyId = trim(req.getParameter("propertyId"));
        boolean deleted = propertyDAO.deleteProperty(propertyId);
        List<Property> list = propertyDAO.getAllProperties();
        req.setAttribute("properties", list);
        if (deleted) {
            req.setAttribute("success", "Property '" + propertyId + "' deleted.");
        } else {
            req.setAttribute("error", "Failed to delete property.");
        }
        req.getRequestDispatcher("properties.jsp").forward(req, resp);
    }

    private String trim(String s) { return s != null ? s.trim() : ""; }
}