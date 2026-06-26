package com.dailyexpence.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dailyexpence.action.SelfTransactionAction;

@WebServlet("/DeleteSelfTransactionServlet")
public class DeleteSelfTransactionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
      

        String id = request.getParameter("id");

        SelfTransactionAction dao = new SelfTransactionAction();
        boolean success = dao.deleteTransaction(id);

        if (success) {
            System.out.println("Transaction deleted successfully!");
        } else {
            System.out.println("Failed to delete transaction!");
        }

        response.sendRedirect("SelfExpenseServlet");
    }
}