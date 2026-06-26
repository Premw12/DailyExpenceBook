package com.dailyexpence.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dailyexpence.action.SelfTransactionAction;

/**
 * Servlet implementation class SelfExpenseServlet
 */
@WebServlet("/SelfExpenseServlet")
public class SelfExpenseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelfExpenseServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 
		try {
	            SelfTransactionAction dao = new SelfTransactionAction();
	            
	            // Get all transactions
	            List<String[]> transactions = dao.getAllTransactions();
	            
	            // Get balance
	            double[] balance = dao.getSelfBalance();
	            
	            System.out.println("=== Self Expense ===");
	            System.out.println("Total Transactions: " + transactions.size());
	            System.out.println("Total Income: " + balance[0]);
	            System.out.println("Total Expense: " + balance[1]);
	            
	            request.setAttribute("transactions", transactions);
	            request.setAttribute("totalIncome", balance[0]);
	            request.setAttribute("totalExpense", balance[1]);
	            
	            request.getRequestDispatcher("selfexpense.jsp").forward(request, response);
	            
	        } catch (Exception e) {
	            e.printStackTrace();
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
