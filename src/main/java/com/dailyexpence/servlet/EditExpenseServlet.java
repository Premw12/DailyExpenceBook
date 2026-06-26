package com.dailyexpence.servlet;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dailyexpence.action.ExpenseAction;

@WebServlet("/EditExpenseServlet")
public class EditExpenseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        String id         = request.getParameter("id");
        String friendName = request.getParameter("friendName");
        String amountStr  = request.getParameter("amount");
        String note       = request.getParameter("note");
        String type       = request.getParameter("type");

        System.out.println("=== EditExpenseServlet ===");
        System.out.println("ID: "         + id);
        System.out.println("FriendName: " + friendName);
        System.out.println("Amount: "     + amountStr);
        System.out.println("Note: "       + note);
        System.out.println("Type: "       + type);

        try {
            double amount = Double.parseDouble(amountStr);

            ExpenseAction dao = new ExpenseAction();
            boolean success = dao.updateExpense(id, amount, note, type);

            if (success) {
                System.out.println("Expense updated successfully!");
                response.sendRedirect("FriendDetailsServlet?friendName=" + friendName);
            } else {
                System.out.println("Failed to update expense!");
                response.sendRedirect("editexpense.jsp?id=" + id + "&error=1");
            }

        } catch (Exception e) {
            System.out.println("ERROR in EditExpenseServlet:");
            e.printStackTrace();
            response.sendRedirect("editexpense.jsp?id=" + id + "&error=1");
        }
    }

    // Also handle GET request just in case
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("DashboardServlet");
    }
}