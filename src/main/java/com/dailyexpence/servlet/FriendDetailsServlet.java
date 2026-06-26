package com.dailyexpence.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dailyexpence.action.ExpenseAction;

@WebServlet("/FriendDetailsServlet")
public class FriendDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
    	
        String friendName = request.getParameter("friendName");
        
        try {
            ExpenseAction dao = new ExpenseAction();
            
            // Get friend's all expenses
            List<String[]> expenses = dao.getFriendExpenses(friendName);
            
            // Get friend's balance
            double[] balance = dao.getFriendBalance(friendName);
            
            System.out.println("=== Friend Details ===");
            System.out.println("Friend: " + friendName);
            System.out.println("Total Expenses: " + expenses.size());
            System.out.println("Will Get: " + balance[0]);
            System.out.println("You Gave: " + balance[1]);
            
            request.setAttribute("friendName", friendName);
            request.setAttribute("expenses", expenses);
            request.setAttribute("totalGet", balance[0]);
            request.setAttribute("totalGave", balance[1]);
            
            request.getRequestDispatcher("frienddetails.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("DashboardServlet");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}