package com.dailyexpence.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dailyexpence.action.ExpenseAction;

@WebServlet("/DeleteExpenseServlet")
public class DeleteExpenseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        String id         = request.getParameter("id");
        String friendName = request.getParameter("friendName");

        System.out.println("=== DeleteExpenseServlet ===");
        System.out.println("ID: "         + id);
        System.out.println("FriendName: " + friendName);

        try {
            ExpenseAction dao = new ExpenseAction();
            boolean success = dao.deleteExpense(id);

            if (success) {
                System.out.println("Expense deleted successfully!");
            } else {
                System.out.println("Failed to delete expense!");
            }

        } catch (Exception e) {
            System.out.println("ERROR in DeleteExpenseServlet:");
            e.printStackTrace();
        }

        // Always redirect back to friend details
        response.sendRedirect("FriendDetailsServlet?friendName=" + friendName);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}