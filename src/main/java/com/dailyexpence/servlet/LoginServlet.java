package com.dailyexpence.servlet;


import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dailyexpence.action.LoginAction;
import com.dailyexpence.beans.LoginBean;
import com.dailyexpence.connection.MyConnection;



/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		if(request.getParameter("login")!=null) {
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		LoginBean lb = new LoginBean();
		lb.setEmail(email);
		lb.setNewpassword(password);   // using password field

		MyConnection mcon = new MyConnection();
		Connection con = mcon.config();
		
		LoginAction la = new LoginAction();
		boolean status = la.checkLogin(con, lb);

		if(status)
		{
			HttpSession session = request.getSession();
			session.setAttribute("email", email);
			response.sendRedirect("DashboardServlet");
		}
		else
		{
			response.sendRedirect("login.jsp");
		}
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
