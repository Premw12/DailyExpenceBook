package com.dailyexpence.action;




import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.dailyexpence.beans.LoginBean;



public class LoginAction {

	PreparedStatement ps = null;
	ResultSet rs = null;
	String sql = null;

	public boolean checkLogin(Connection con, LoginBean lb)
	{
		boolean status = false;

		try
		{
			sql = "SELECT * FROM login WHERE email=? AND newpassword=?";
			ps = con.prepareStatement(sql);

			ps.setString(1, lb.getEmail());
			ps.setString(2, lb.getNewpassword());

			rs = ps.executeQuery();

			if(rs.next())
			{
				status = true;
			}

		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		return status;
	}
}