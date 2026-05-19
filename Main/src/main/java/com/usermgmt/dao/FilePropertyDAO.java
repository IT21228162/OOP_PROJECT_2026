package com.usermgmt.dao;

import com.usermgmt.model.Property;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FilePropertyDAO {

    private static final String FILE_PATH = System.getProperty("user.home")
            + File.separator + "realestate_data" + File.separator + "properties.txt";

    public FilePropertyDAO() {
        File file = new File(FILE_PATH);
        if (!file.getParentFile().exists()) file.getParentFile().mkdirs();
        if (!file.exists()) {
            try { file.createNewFile(); }
            catch (IOException e) { throw new RuntimeException("Cannot create properties.txt", e); }
        }
    }

    public List<Property> getAllProperties() {
        List<Property> list = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                line = line.trim();
                if (line.isEmpty()) continue;
                Property p = Property.fromFileString(line);
                if (p != null) list.add(p);
            }
        } catch (IOException e) { e.printStackTrace(); }
        return list;
    }

    public Property getPropertyById(String propertyId) {
        if (propertyId == null || propertyId.isEmpty()) return null;
        for (Property p : getAllProperties()) {
            if (propertyId.equalsIgnoreCase(p.getPropertyId())) return p;
        }
        return null;
    }

    public boolean createProperty(Property property) {
        if (getPropertyById(property.getPropertyId()) != null) return false;
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            bw.write(property.toFileString());
            bw.newLine();
            return true;
        } catch (IOException e) { e.printStackTrace(); return false; }
    }

    public boolean updateProperty(String originalId, Property updated) {
        List<Property> list = getAllProperties();
        boolean found = false;
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).getPropertyId().equalsIgnoreCase(originalId)) {
                list.set(i, updated);
                found = true;
                break;
            }
        }
        if (!found) return false;
        return writeAllProperties(list);
    }

    public boolean deleteProperty(String propertyId) {
        List<Property> list = getAllProperties();
        boolean removed = list.removeIf(
                p -> p.getPropertyId().equalsIgnoreCase(propertyId)
        );
        if (!removed) return false;
        return writeAllProperties(list);
    }

    private boolean writeAllProperties(List<Property> list) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, false))) {
            for (Property p : list) {
                bw.write(p.toFileString());
                bw.newLine();
            }
            return true;
        } catch (IOException e) { e.printStackTrace(); return false; }
    }
}