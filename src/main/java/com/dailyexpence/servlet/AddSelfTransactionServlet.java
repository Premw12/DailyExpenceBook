package com.dailyexpence.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dailyexpence.action.SelfTransactionAction;

/**
 * Servlet implementation class AddSelfTransactionServlet
 */
@WebServlet("/AddSelfTransactionServlet")
public class AddSelfTransactionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddSelfTransactionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		 String amountStr = request.getParameter("amount");
	        String category = request.getParameter("category");
	        String note = request.getParameter("note");
	        String type = request.getParameter("type");

	        try {
	            double amount = Double.parseDouble(amountStr);
	            
	            SelfTransactionAction dao = new SelfTransactionAction();
	            boolean success = dao.addTransaction(amount, category, note, type);

	            if (success) {
	                System.out.println("Self transaction added successfully!");
	                response.sendRedirect("SelfExpenseServlet");
	            } else {
	                System.out.println("Failed to add transaction!");
	                response.sendRedirect("addselftransaction.jsp?error=1");
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	            response.sendRedirect("addselftransaction.jsp?error=1");
	        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
