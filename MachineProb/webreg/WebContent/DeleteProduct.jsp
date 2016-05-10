<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<title> Delete Product </title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="style.css">
	<script src="jquery/jquery-1.12.3.js"></script>
</head>
<body style="background-color:skyblue">

	<script src="jsbootstrap/bootstrap.min.js"></script>
	
	<div class="container-fluid" style="background-color:#D46666">
		<div class="jumbotron">
			<h1> Siegfrid's Cafe </h1>
			<p> San Beda College Alabang </p>
		</div>
	</div>

	<div class="container-fluid" style="background-color:#4C4646">
		<div class="MenuContainer1" >	
			<ul class="nav navbar-nav">
				<li class="active"><a href="index.html">Home</a></li>
				<li><a href="Menu.jsp">Order</a></li>
				<!--  DROP DOWN MENU HERE -->
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">Product<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="AddProduct.html">Add Product</a></li>
						<li><a href="EditProduct.html">Edit Product</a></li>
						<li><a href="#">Delete Product</a></li>
					</ul>
				</li>
			</ul>				
		</div>
	</div>

	<!-- PRODUCT FORM -->
	<div class="container-fluid" style="padding-top:40px; width:500px; margin-left:20px;">
	
		<form role="form" action="DeleteSub.jsp" method="post">
			<div style="text-align:center">
				<label for="name">Product Form</label>
			</div>
			
			<%@ page import ="java.sql.*" %>
			<%@ page import ="javax.sql.*" %>	 
	
			<div class="form-group">
				<label for="name">Choose Product</label>
				<%	
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
						// Select Statement
						try
						{	
				%> 	 			 		
							<select class="form-control"  style="width:470px;"  name="select1"> 				
							<% 
							    try
							    {
							    	Statement statement1 = connection.createStatement();
									String query1 = "SELECT id,productname FROM tb_product";
									ResultSet resultSet1 = statement1.executeQuery(query1);
									
									while (resultSet1.next()) 
									{
										%>
									   		<option value='<%=resultSet1.getString(1) %>'><%=resultSet1.getString(1) %> <%=resultSet1.getString(2) %></option>
										<%
									}	
							    }
							    catch(Exception e)
							    {	
							    }
							%>			
							</select>	
							<% 
							connection.close();
						}catch(Exception e){	
						}
			
					}
					catch(Exception e)
					{
					}
							%>
			</div>
			<br>
			<input type="submit" id="submit" class="btn btn-default" value="submit" />
		</form>
	</div>
</body>
</html>