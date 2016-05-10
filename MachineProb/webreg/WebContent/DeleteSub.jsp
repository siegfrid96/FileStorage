<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>OrderJsp</title>
</head>
<body>
	<%@ page import ="java.sql.*" %>
	<%@ page import ="javax.sql.*" %>
    <%= request.getParameter("custname")%>
    <%= request.getParameter("product")%>
    <%= request.getParameter("total")%>
	<%
		String item1=request.getParameter("select1"); 
		try
		{
			//Establish Driver
			Class driverClass = null;
			String driver = "com.mysql.jdbc.Driver";
			{
				try 
				{
					driverClass = Class.forName(driver);
				}
				catch (ClassNotFoundException e)  
				{
			      	System.out.println("Error loading driver: " + e);
				}
			
				System.out.println("Found driver: " + driverClass);
			}
			
			//Create Paramater Connection
			String protocol = "jdbc:mysql://"; 
			String server = "localhost";
			int port = 3306;
			String schema = "machineprob";
			String charSet = "?useUnicode=true&amp;characterEncoding=utf-8";
			String userName = "root";
			String password = "root";
			String url = protocol + server + ":" + port  + "/" + schema + charSet;		
			Connection connection=null;
			
			//Establish The Connection
			try 
			{
				connection = DriverManager.getConnection(url, userName, password);	
				try 
				{
					DatabaseMetaData dbMetaData =  (DatabaseMetaData) connection.getMetaData();	
			    	System.out.println ("Established connection to " + connection.getMetaData().getURL());
		    		String productName = dbMetaData.getDatabaseProductName();
		    		System.out.println("Database: " + productName);
			    	String productVersion = dbMetaData.getDatabaseProductVersion();
				    System.out.println("Version: " + productVersion);	
				}
				catch (Exception e) 
				{
					System.out.println("Unable to retrieve connection Meta Data: " + e);
				}
			} 
			catch (SQLException e) 
			{
				System.out.println("Unable to establish connection: " + e);
			}
					
			// Delete Statement
			PreparedStatement statement = (PreparedStatement) connection.prepareStatement(
					
											"DELETE FROM " + "machineprob.tb_product " +
											
											"WHERE id=?");
			
			statement.setString(1, item1);
			statement.executeUpdate();
	
			connection.close();
		}
		catch(Exception e)
		{
			
		}
	%>
	
	<%
	   // New location to be redirected
	   String site = new String("index.html");
	   response.setStatus(response.SC_MOVED_TEMPORARILY);
	   response.setHeader("Location", site); 
	%>
</body>
</html>