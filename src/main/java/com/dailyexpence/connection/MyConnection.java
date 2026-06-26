package com.dailyexpence.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class MyConnection {
	
	private Connection con=null;
	
	public Connection config() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/dailyexpence","root","");
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return con;
		
	}

}



