package com.dailyexpence.action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.dailyexpence.connection.MyConnection;

public class ExpenseAction {

    MyConnection myCon = new MyConnection();

    // Add expense
    public boolean addExpense(String friendName, double amount, String note, String type) {
        boolean status = false;

        try {
            Connection con = myCon.config();

            String query = "INSERT INTO expenses (friend_name, amount, note, type) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, friendName);
            ps.setDouble(2, amount);
            ps.setString(3, note);
            ps.setString(4, type);

            int i = ps.executeUpdate();

            if (i > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // Get all expenses for a specific friend
    public List<String[]> getFriendExpenses(String friendName) {
        List<String[]> list = new ArrayList<>();

        try {
            Connection con = myCon.config();

            String query = "SELECT id, amount, note, type, created_date FROM expenses WHERE friend_name = ? ORDER BY created_date DESC";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, friendName);

            ResultSet rs = ps.executeQuery();
            SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, hh:mm a");

            while (rs.next()) {
                String id = rs.getString("id");
                String amount = rs.getString("amount");
                String note = rs.getString("note");
                String type = rs.getString("type");
                String date = sdf.format(rs.getTimestamp("created_date"));

                // Store: [id, amount, note, type, date]
                list.add(new String[]{id, amount, note != null ? note : "No note", type, date});
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Get total amount for a specific friend
    public double[] getFriendBalance(String friendName) {
        double get = 0;
        double gave = 0;

        try {
            Connection con = myCon.config();

            String query = "SELECT type, SUM(amount) as total FROM expenses WHERE friend_name = ? GROUP BY type";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, friendName);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String type = rs.getString("type");
                double total = rs.getDouble("total");

                if (type.equals("get")) {
                    get = total;
                } else if (type.equals("gave")) {
                    gave = total;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return new double[]{get, gave};
    }

    
    
    
    
 // GET EXPENSE BY ID
    public String[] getExpenseById(String id) {
        String[] expense = null;

        try {
            Connection con = myCon.config();

            if (con == null) {
                System.out.println("ERROR: Connection is NULL in getExpenseById!");
                return null;
            }

            String query = "SELECT id, friend_name, amount, note, type FROM expenses WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                expense = new String[]{
                    rs.getString("id"),
                    rs.getString("friend_name"),
                    rs.getString("amount"),
                    rs.getString("note") != null ? rs.getString("note") : "No note",
                    rs.getString("type")
                };
                
                System.out.println("Expense found - ID: " + expense[0] + 
                                 ", Friend: " + expense[1] + 
                                 ", Amount: " + expense[2] + 
                                 ", Type: " + expense[4]);
            } else {
                System.out.println("No expense found with ID: " + id);
            }

        } catch (Exception e) {
            System.out.println("ERROR in getExpenseById:");
            e.printStackTrace();
        }

        return expense;
    }
    
    
    // ==================== UPDATE EXPENSE ====================
    public boolean updateExpense(String id, double amount, String note, String type) {
        boolean status = false;

        try {
            Connection con = myCon.config();

            String query = "UPDATE expenses SET amount = ?, note = ?, type = ? WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setDouble(1, amount);
            ps.setString(2, note);
            ps.setString(3, type);
            ps.setString(4, id);

            int i = ps.executeUpdate();

            if (i > 0) {
                status = true;
                System.out.println("Expense updated successfully! ID: " + id);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // ==================== DELETE EXPENSE ====================
    public boolean deleteExpense(String id) {
        boolean status = false;

        try {
            Connection con = myCon.config();

            String query = "DELETE FROM expenses WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, id);

            int i = ps.executeUpdate();

            if (i > 0) {
                status = true;
                System.out.println("Expense deleted successfully! ID: " + id);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
    
    
    
    
    
    
    
    
    
    // Get overall balance (all friends)
    public double[] getOverallBalance() {
        double totalGet = 0;
        double totalGave = 0;

        try {
            Connection con = myCon.config();

            String query = "SELECT type, SUM(amount) as total FROM expenses GROUP BY type";
            PreparedStatement ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String type = rs.getString("type");
                double total = rs.getDouble("total");

                if (type.equals("get")) {
                    totalGet = total;
                } else if (type.equals("gave")) {
                    totalGave = total;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return new double[]{totalGet, totalGave};
    }
}