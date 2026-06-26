package com.dailyexpence.servlet;



import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dailyexpence.action.RegisterAction;
import com.dailyexpence.beans.LoginBean;
import com.dailyexpence.connection.MyConnection;




/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out=response.getWriter();
		String name,phoneno,email,newpassword,confirmpassword;
		
		response.setContentType("text/html");
		
		if(request.getParameter("register")!=null) {
			
			 name=request.getParameter("name");
			
			 phoneno=request.getParameter("phoneno");
			 
			 email=request.getParameter("email");
			 newpassword=request.getParameter("newpassword");
			 confirmpassword=request.getParameter("confirmpassword");
			
			
			LoginBean qb=new LoginBean();
			qb.setName(name);
			
			qb.setPhoneno(phoneno);
		
			qb.setEmail(email);
			qb.setNewpassword(newpassword);
			qb.setConfirmpassword(confirmpassword);
			
			MyConnection mcon = new MyConnection();
			Connection con = mcon.config();
			
			RegisterAction qa = new RegisterAction();
			int i=qa.addRegister(con, qb);
			System.out.println(i);
			if(i>0) {
				//PrintWriter out = response.getWriter();
				out.println("<script>alert('Registration Successfully');window.location='login.jsp';</script>");
			}
			
			else {
				out.println("<script>alert('Registration Failed');window.location='registration.jsp';</script>");
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
