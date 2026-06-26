package com.dailyexpence.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dailyexpence.action.ExpenseAction;

@WebServlet("/AddExpenseServlet")
public class AddExpenseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
    	
    	
        String friendName = request.getParameter("friendName");
        String amountStr = request.getParameter("amount");
        String note = request.getParameter("note");
        String type = request.getParameter("type");

        try {
            double amount = Double.parseDouble(amountStr);
            
            ExpenseAction dao = new ExpenseAction();
            boolean success = dao.addExpense(friendName, amount, note, type);

            if (success) {
                System.out.println("Expense added successfully!");
                // Redirect back to friend details page
                response.sendRedirect("FriendDetailsServlet?friendName=" + friendName);
            } else {
                System.out.println("Failed to add expense!");
                response.sendRedirect("addexpense.jsp?friendName=" + friendName + "&error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addexpense.jsp?friendName=" + friendName + "&error=1");
        }
    }
}