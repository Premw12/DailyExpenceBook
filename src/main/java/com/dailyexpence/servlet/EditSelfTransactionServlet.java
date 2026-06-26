package com.dailyexpence.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dailyexpence.action.SelfTransactionAction;

@WebServlet("/EditSelfTransactionServlet")
public class EditSelfTransactionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
      

        String id = request.getParameter("id");
        String amountStr = request.getParameter("amount");
        String category = request.getParameter("category");
        String note = request.getParameter("note");
        String type = request.getParameter("type");

        try {
            double amount = Double.parseDouble(amountStr);
            
            SelfTransactionAction dao = new SelfTransactionAction();
            boolean success = dao.updateTransaction(id, amount, category, note, type);

            if (success) {
                System.out.println("Transaction updated successfully!");
                response.sendRedirect("SelfExpenseServlet");
            } else {
                System.out.println("Failed to update transaction!");
                response.sendRedirect("editselftransaction.jsp?id=" + id + "&error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("editselftransaction.jsp?id=" + id + "&error=1");
        }
    }
}