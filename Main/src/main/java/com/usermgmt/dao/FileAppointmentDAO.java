package com.usermgmt.dao;

import com.usermgmt.model.Appointment;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileAppointmentDAO {

    private static final String FILE_PATH = System.getProperty("user.home")
            + File.separator + "realestate_data" + File.separator + "appointments.txt";

    public FileAppointmentDAO() {
        File file = new File(FILE_PATH);
        if (!file.getParentFile().exists()) file.getParentFile().mkdirs();
        if (!file.exists()) {
            try { file.createNewFile(); }
            catch (IOException e) { throw new RuntimeException("Cannot create appointments.txt", e); }
        }
    }

    public List<Appointment> getAllAppointments() {
        List<Appointment> list = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                line = line.trim();
                if (line.isEmpty()) continue;
                Appointment a = Appointment.fromFileString(line);
                if (a != null) list.add(a);
            }
        } catch (IOException e) { e.printStackTrace(); }
        return list;
    }

    public Appointment getAppointmentById(String id) {
        if (id == null || id.isEmpty()) return null;
        for (Appointment a : getAllAppointments()) {
            if (id.equalsIgnoreCase(a.getAppointmentId())) return a;
        }
        return null;
    }

    public boolean createAppointment(Appointment appointment) {
        if (getAppointmentById(appointment.getAppointmentId()) != null) return false;
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            bw.write(appointment.toFileString());
            bw.newLine();
            return true;
        } catch (IOException e) { e.printStackTrace(); return false; }
    }

    public boolean updateAppointment(String originalId, Appointment updated) {
        List<Appointment> list = getAllAppointments();
        boolean found = false;
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).getAppointmentId().equalsIgnoreCase(originalId)) {
                list.set(i, updated);
                found = true;
                break;
            }
        }
        if (!found) return false;
        return writeAll(list);
    }

    public boolean deleteAppointment(String id) {
        List<Appointment> list = getAllAppointments();
        boolean removed = list.removeIf(
                a -> a.getAppointmentId().equalsIgnoreCase(id)
        );
        if (!removed) return false;
        return writeAll(list);
    }

    private boolean writeAll(List<Appointment> list) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, false))) {
            for (Appointment a : list) {
                bw.write(a.toFileString());
                bw.newLine();
            }
            return true;
        } catch (IOException e) { e.printStackTrace(); return false; }
    }
}