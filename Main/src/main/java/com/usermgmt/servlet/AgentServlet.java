package com.usermgmt.servlet;

import com.usermgmt.dao.FileAgentDAO;
import com.usermgmt.model.Agent;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/AgentServlet")
public class AgentServlet extends HttpServlet {

    private FileAgentDAO agentDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        agentDAO = new FileAgentDAO();
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
                resp.sendRedirect("agents.jsp");
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
                resp.sendRedirect("agents.jsp");
        }
    }

    private void handleList(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Agent> agents = agentDAO.getAllAgents();
        req.setAttribute("agents", agents);
        req.getRequestDispatcher("agents.jsp").forward(req, resp);
    }

    private void handleSearch(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String agentId = req.getParameter("agentId");
        req.setAttribute("searched", true);
        if (agentId != null && !agentId.trim().isEmpty()) {
            Agent found = agentDAO.getAgentById(agentId.trim());
            if (found != null) {
                req.setAttribute("foundAgent", found);
            } else {
                req.setAttribute("error", "No agent found with ID: " + agentId);
            }
        }
        req.getRequestDispatcher("search-agent.jsp").forward(req, resp);
    }

    private void handleCreate(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String agentId        = trim(req.getParameter("agentId"));
        String firstName      = trim(req.getParameter("firstName"));
        String lastName       = trim(req.getParameter("lastName"));
        String email          = trim(req.getParameter("email"));
        String phone          = trim(req.getParameter("phone"));
        String specialization = trim(req.getParameter("specialization"));
        String location       = trim(req.getParameter("location"));
        String experience     = trim(req.getParameter("experience"));
        String status         = trim(req.getParameter("status"));

        if (agentId.isEmpty() || firstName.isEmpty() || email.isEmpty()) {
            req.setAttribute("error", "Agent ID, first name and email are required.");
            req.getRequestDispatcher("register-agent.jsp").forward(req, resp);
            return;
        }

        Agent agent = new Agent(agentId, firstName, lastName, email,
                phone, specialization, location, experience, status);
        boolean created = agentDAO.createAgent(agent);

        if (created) {
            req.setAttribute("success", "Agent '" + agentId + "' registered successfully!");
        } else {
            req.setAttribute("error", "Agent ID '" + agentId + "' already exists.");
        }
        req.getRequestDispatcher("register-agent.jsp").forward(req, resp);
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String originalId     = trim(req.getParameter("originalId"));
        String firstName      = trim(req.getParameter("firstName"));
        String lastName       = trim(req.getParameter("lastName"));
        String email          = trim(req.getParameter("email"));
        String phone          = trim(req.getParameter("phone"));
        String specialization = trim(req.getParameter("specialization"));
        String location       = trim(req.getParameter("location"));
        String experience     = trim(req.getParameter("experience"));
        String status         = trim(req.getParameter("status"));

        Agent updated = new Agent(originalId, firstName, lastName, email,
                phone, specialization, location, experience, status);
        boolean ok = agentDAO.updateAgent(originalId, updated);

        req.setAttribute("searched", true);
        Agent refreshed = agentDAO.getAgentById(originalId);
        req.setAttribute("foundAgent", refreshed);

        if (ok) {
            req.setAttribute("success", "Agent updated successfully.");
        } else {
            req.setAttribute("error", "Update failed.");
        }
        req.getRequestDispatcher("search-agent.jsp").forward(req, resp);
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String agentId = trim(req.getParameter("agentId"));
        boolean deleted = agentDAO.deleteAgent(agentId);
        List<Agent> agents = agentDAO.getAllAgents();
        req.setAttribute("agents", agents);
        if (deleted) {
            req.setAttribute("success", "Agent '" + agentId + "' deleted successfully.");
        } else {
            req.setAttribute("error", "Failed to delete agent.");
        }
        req.getRequestDispatcher("agents.jsp").forward(req, resp);
    }

    private String trim(String s) { return s != null ? s.trim() : ""; }
}