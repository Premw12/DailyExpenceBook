package com.dailyexpence.action;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.dailyexpence.beans.LoginBean;





public class RegisterAction {

	
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	private String sql=null;
	private int i=0;
	
	public int addRegister(Connection con, LoginBean qb)
	{
		try
		{
			sql="INSERT INTO login(name,phoneno,email,newpassword,confirmpassword)VALUES(?,?,?,?,?)";
			ps=con.prepareStatement(sql);
			System.out.println(sql);
			ps.setString(1, qb.getName());
			
			ps.setString(2, qb.getPhoneno());
		
			ps.setString(3, qb.getEmail());
			ps.setString(4, qb.getNewpassword());
			ps.setString(5, qb.getConfirmpassword());
			
			i=ps.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return i;
	}
	
	
	
}
