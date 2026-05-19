package com.usermgmt.dao;

import com.usermgmt.model.Agent;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileAgentDAO {

    private static final String FILE_PATH = System.getProperty("user.home")
            + File.separator + "realestate_data" + File.separator + "agents.txt";

    public FileAgentDAO() {
        File file = new File(FILE_PATH);
        if (!file.getParentFile().exists()) file.getParentFile().mkdirs();
        if (!file.exists()) {
            try { file.createNewFile(); }
            catch (IOException e) { throw new RuntimeException("Cannot create agents.txt", e); }
        }
    }

    public List<Agent> getAllAgents() {
        List<Agent> agents = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                line = line.trim();
                if (line.isEmpty()) continue;
                Agent a = Agent.fromFileString(line);
                if (a != null) agents.add(a);
            }
        } catch (IOException e) { e.printStackTrace(); }
        return agents;
    }

    public Agent getAgentById(String agentId) {
        if (agentId == null || agentId.isEmpty()) return null;
        for (Agent a : getAllAgents()) {
            if (agentId.equalsIgnoreCase(a.getAgentId())) return a;
        }
        return null;
    }

    public boolean createAgent(Agent agent) {
        if (getAgentById(agent.getAgentId()) != null) return false;
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            bw.write(agent.toFileString());
            bw.newLine();
            return true;
        } catch (IOException e) { e.printStackTrace(); return false; }
    }

    public boolean updateAgent(String originalId, Agent updated) {
        List<Agent> agents = getAllAgents();
        boolean found = false;
        for (int i = 0; i < agents.size(); i++) {
            if (agents.get(i).getAgentId().equalsIgnoreCase(originalId)) {
                agents.set(i, updated);
                found = true;
                break;
            }
        }
        if (!found) return false;
        return writeAllAgents(agents);
    }

    public boolean deleteAgent(String agentId) {
        List<Agent> agents = getAllAgents();
        boolean removed = agents.removeIf(
                a -> a.getAgentId().equalsIgnoreCase(agentId)
        );
        if (!removed) return false;
        return writeAllAgents(agents);
    }

    private boolean writeAllAgents(List<Agent> agents) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, false))) {
            for (Agent a : agents) {
                bw.write(a.toFileString());
                bw.newLine();
            }
            return true;
        } catch (IOException e) { e.printStackTrace(); return false; }
    }
}