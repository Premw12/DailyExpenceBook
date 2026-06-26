package com.dailyexpence.action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.dailyexpence.connection.MyConnection;

public class SelfTransactionAction {

    MyConnection myCon = new MyConnection();

    public boolean addTransaction(double amount, String category, String note, String type) {
        boolean status = false;

        try {
            Connection con = myCon.config();

            String query = "INSERT INTO selftransaction (amount, category, note, type) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setDouble(1, amount);
            ps.setString(2, category);
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

    // UPDATE TRANSACTION
    public boolean updateTransaction(String id, double amount, String category, String note, String type) {
        boolean status = false;

        try {
            Connection con = myCon.config();

            String query = "UPDATE selftransaction SET amount = ?, category = ?, note = ?, type = ? WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setDouble(1, amount);
            ps.setString(2, category);
            ps.setString(3, note);
            ps.setString(4, type);
            ps.setString(5, id);

            int i = ps.executeUpdate();

            if (i > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // DELETE TRANSACTION
    public boolean deleteTransaction(String id) {
        boolean status = false;

        try {
            Connection con = myCon.config();

            String query = "DELETE FROM selftransaction WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, id);

            int i = ps.executeUpdate();

            if (i > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // GET TRANSACTION BY ID
    public String[] getTransactionById(String id) {
        String[] transaction = null;

        try {
            Connection con = myCon.config();

            String query = "SELECT id, amount, category, note, type FROM selftransaction WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                transaction = new String[]{
                    rs.getString("id"),
                    rs.getString("amount"),
                    rs.getString("category"),
                    rs.getString("note"),
                    rs.getString("type")
                };
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return transaction;
    }

    public List<String[]> getAllTransactions() {
        List<String[]> list = new ArrayList<>();

        try {
            Connection con = myCon.config();

            String query = "SELECT id, amount, category, note, type, created_date FROM selftransaction ORDER BY created_date DESC";
            PreparedStatement ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();
            SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, hh:mm a");

            while (rs.next()) {
                String id = rs.getString("id");
                String amount = rs.getString("amount");
                String category = rs.getString("category");
                String note = rs.getString("note");
                String type = rs.getString("type");
                String date = sdf.format(rs.getTimestamp("created_date"));

                list.add(new String[]{id, amount, category != null ? category : "Other", 
                                      note != null ? note : "No note", type, date});
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public double[] getSelfBalance() {
        double totalIncome = 0;
        double totalExpense = 0;

        try {
            Connection con = myCon.config();

            String query = "SELECT type, SUM(amount) as total FROM selftransaction GROUP BY type";
            PreparedStatement ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String type = rs.getString("type");
                double total = rs.getDouble("total");

                if (type.equals("income")) {
                    totalIncome = total;
                } else if (type.equals("expense")) {
                    totalExpense = total;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return new double[]{totalIncome, totalExpense};
    }
}