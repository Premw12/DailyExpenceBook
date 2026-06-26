package com.dailyexpence.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dailyexpence.action.AddFriendAction;
import com.dailyexpence.action.ExpenseAction;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
    	// Check session
    
        try {
            AddFriendAction friendDao = new AddFriendAction();
            ExpenseAction expenseDao = new ExpenseAction();
            
            // Get all friends (simple method)
            List<String[]> friendsBasic = friendDao.getAllFriends();
            
            // Create new list with balance
            List<String[]> friendsWithBalance = new ArrayList<>();
            
            for (String[] friend : friendsBasic) {
                String name = friend[0];
                
                // Get balance for this friend
                double[] balance = expenseDao.getFriendBalance(name);
                double totalGet = balance[0];
                double totalGave = balance[1];
                
                // Add to list: [name, totalGet, totalGave]
                friendsWithBalance.add(new String[]{
                    name, 
                    String.valueOf(totalGet), 
                    String.valueOf(totalGave)
                });
            }

            // Get overall balance
            double[] overallBalance = expenseDao.getOverallBalance();

            System.out.println("=== Dashboard Debug ===");
            System.out.println("Friends found: " + friendsWithBalance.size());
            System.out.println("Total Get: " + overallBalance[0]);
            System.out.println("Total Gave: " + overallBalance[1]);
            
            // Print each friend
            for (String[] f : friendsWithBalance) {
                System.out.println("Friend: " + f[0] + ", Get: " + f[1] + ", Gave: " + f[2]);
            }

            request.setAttribute("friends", friendsWithBalance);
            request.setAttribute("get", overallBalance[0]);
            request.setAttribute("give", overallBalance[1]);

            request.getRequestDispatcher("dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            System.out.println("ERROR in DashboardServlet:");
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}