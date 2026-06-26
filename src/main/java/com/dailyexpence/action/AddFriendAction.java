package com.dailyexpence.action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.dailyexpence.connection.MyConnection;

public class AddFriendAction {

    MyConnection myCon = new MyConnection();

    public boolean insertFriend(String name, String address, String phone) {
        boolean status = false;
        try {
            Connection con = myCon.config();
            String query = "INSERT INTO friends (name, address, phone) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, address);
            ps.setString(3, phone);
            int i = ps.executeUpdate();
            if (i > 0) status = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public String[] getFriendByName(String name) {
        String[] friend = null;
        try {
            Connection con = myCon.config();
            if (con == null) {
                System.out.println("ERROR: Connection NULL!");
                return null;
            }
            String query = "SELECT name, address, phone FROM friends WHERE name = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                friend = new String[]{
                    rs.getString("name"),
                    rs.getString("address"),
                    rs.getString("phone")
                };
                System.out.println("Friend found: " + friend[0]);
            } else {
                System.out.println("No friend found: " + name);
            }
        } catch (Exception e) {
            System.out.println("ERROR in getFriendByName:");
            e.printStackTrace();
        }
        return friend;
    }

    public boolean updateFriend(String oldName, String newName, String address, String phone) {
        boolean status = false;
        try {
            Connection con = myCon.config();
            String query = "UPDATE friends SET name = ?, address = ?, phone = ? WHERE name = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, newName);
            ps.setString(2, address);
            ps.setString(3, phone);
            ps.setString(4, oldName);
            int i = ps.executeUpdate();
            if (i > 0) {
                if (!oldName.equals(newName)) {
                    String updateExpenses = "UPDATE expenses SET friend_name = ? WHERE friend_name = ?";
                    PreparedStatement ps2 = con.prepareStatement(updateExpenses);
                    ps2.setString(1, newName);
                    ps2.setString(2, oldName);
                    ps2.executeUpdate();
                }
                status = true;
                System.out.println("Friend updated!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public boolean deleteFriend(String name) {
        boolean status = false;
        try {
            Connection con = myCon.config();
            String deleteExpenses = "DELETE FROM expenses WHERE friend_name = ?";
            PreparedStatement ps1 = con.prepareStatement(deleteExpenses);
            ps1.setString(1, name);
            ps1.executeUpdate();
            String query = "DELETE FROM friends WHERE name = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, name);
            int i = ps.executeUpdate();
            if (i > 0) {
                status = true;
                System.out.println("Friend deleted!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
    public List<String[]> getAllFriends() {
        List<String[]> list = new ArrayList<>();
        try {
            Connection con = myCon.config();
            if (con == null) {
                System.out.println("ERROR: Connection NULL!");
                return list;
            }

            // created_date hatao ORDER BY se
            String query = "SELECT name, address, phone FROM friends";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String name    = rs.getString("name");
                String address = rs.getString("address");
                String phone   = rs.getString("phone");
                System.out.println("Found friend: " + name);
                list.add(new String[]{name, address, phone});
            }
            System.out.println("Total friends: " + list.size());

        } catch (Exception e) {
            System.out.println("ERROR in getAllFriends: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }
}