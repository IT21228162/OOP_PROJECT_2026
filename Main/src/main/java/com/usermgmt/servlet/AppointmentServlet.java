package com.usermgmt.servlet;

import com.usermgmt.dao.FileAppointmentDAO;
import com.usermgmt.model.Appointment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/AppointmentServlet")
public class AppointmentServlet extends HttpServlet {

    private FileAppointmentDAO appointmentDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        appointmentDAO = new FileAppointmentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":   handleList(req, resp);   break;
            case "search": handleSearch(req, resp); break;
            default: resp.sendRedirect("appointments.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "create": handleCreate(req, resp); break;
            case "update": handleUpdate(req, resp); break;
            case "delete": handleDelete(req, resp); break;
            default: resp.sendRedirect("appointments.jsp");
        }
    }

    private void handleList(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Appointment> list = appointmentDAO.getAllAppointments();
        req.setAttribute("appointments", list);
        req.getRequestDispatcher("appointments.jsp").forward(req, resp);
    }

    private void handleSearch(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String id = req.getParameter("appointmentId");
        req.setAttribute("searched", true);
        if (id != null && !id.trim().isEmpty()) {
            Appointment found = appointmentDAO.getAppointmentById(id.trim());
            if (found != null) {
                req.setAttribute("foundAppointment", found);
            } else {
                req.setAttribute("error", "No appointment found with ID: " + id);
            }
        }
        req.getRequestDispatcher("search-appointment.jsp").forward(req, resp);
    }

    private void handleCreate(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String appointmentId = trim(req.getParameter("appointmentId"));
        String clientName    = trim(req.getParameter("clientName"));
        String clientEmail   = trim(req.getParameter("clientEmail"));
        String clientPhone   = trim(req.getParameter("clientPhone"));
        String agentId       = trim(req.getParameter("agentId"));
        String propertyId    = trim(req.getParameter("propertyId"));
        String date          = trim(req.getParameter("date"));
        String time          = trim(req.getParameter("time"));
        String type          = trim(req.getParameter("type"));
        String status        = trim(req.getParameter("status"));
        String notes         = trim(req.getParameter("notes"));

        if (appointmentId.isEmpty() || clientName.isEmpty() || date.isEmpty()) {
            req.setAttribute("error", "Appointment ID, client name and date are required.");
            req.getRequestDispatcher("book-appointment.jsp").forward(req, resp);
            return;
        }

        Appointment a = new Appointment(appointmentId, clientName, clientEmail,
                clientPhone, agentId, propertyId, date, time, type, status, notes);
        boolean created = appointmentDAO.createAppointment(a);

        if (created) {
            req.setAttribute("success", "Appointment '" + appointmentId + "' booked successfully!");
        } else {
            req.setAttribute("error", "Appointment ID '" + appointmentId + "' already exists.");
        }
        req.getRequestDispatcher("book-appointment.jsp").forward(req, resp);
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String originalId  = trim(req.getParameter("originalId"));
        String clientName  = trim(req.getParameter("clientName"));
        String clientEmail = trim(req.getParameter("clientEmail"));
        String clientPhone = trim(req.getParameter("clientPhone"));
        String agentId     = trim(req.getParameter("agentId"));
        String propertyId  = trim(req.getParameter("propertyId"));
        String date        = trim(req.getParameter("date"));
        String time        = trim(req.getParameter("time"));
        String type        = trim(req.getParameter("type"));
        String status      = trim(req.getParameter("status"));
        String notes       = trim(req.getParameter("notes"));

        Appointment updated = new Appointment(originalId, clientName, clientEmail,
                clientPhone, agentId, propertyId, date, time, type, status, notes);
        boolean ok = appointmentDAO.updateAppointment(originalId, updated);

        req.setAttribute("searched", true);
        Appointment refreshed = appointmentDAO.getAppointmentById(originalId);
        req.setAttribute("foundAppointment", refreshed);

        if (ok) {
            req.setAttribute("success", "Appointment updated successfully.");
        } else {
            req.setAttribute("error", "Update failed.");
        }
        req.getRequestDispatcher("search-appointment.jsp").forward(req, resp);
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String id = trim(req.getParameter("appointmentId"));
        boolean deleted = appointmentDAO.deleteAppointment(id);
        List<Appointment> list = appointmentDAO.getAllAppointments();
        req.setAttribute("appointments", list);
        if (deleted) {
            req.setAttribute("success", "Appointment '" + id + "' cancelled successfully.");
        } else {
            req.setAttribute("error", "Failed to cancel appointment.");
        }
        req.getRequestDispatcher("appointments.jsp").forward(req, resp);
    }

    private String trim(String s) { return s != null ? s.trim() : ""; }
}