<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title> Menu </title>
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
				<li><a href="#">Order</a></li>
				<!--  DROP DOWN MENU HERE -->
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">Product<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="AddProduct.html">Add Product</a></li>
						<li><a href="EditProduct.jsp">Edit Product</a></li>
						<li><a href="DeleteProduct.jsp">Delete Product</a></li>
					</ul>
				</li>
			</ul>				
		</div>
	</div>

	<%@ page import ="java.sql.*" %>
	<%@ page import ="javax.sql.*" %>	 
	
	<%
		String productname=request.getParameter("productname"); 
		String price=request.getParameter("price"); 
		String qty=request.getParameter("qty"); 
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
				Statement statement = connection.createStatement();
				String query = "SELECT * FROM tb_product";
				ResultSet resultSet = statement.executeQuery(query);	
	%> 	 			
				<div style="background-color:#5BE5DC; margin-top:-20px; padding-top:0px; height:100%;">
					<h2 style="text-align:center"> Menu </h2>
				</div>
				
				<form role="form" action="MenuSub.jsp" method="post">
				    <div class="table-responsive" style="height:200px; background-color:#4EA670; width:100%; ">          
					    <table class="table">
							<thead style="color:blue;">
								<tr>
								<th>ID</th>
								<th>Product</th>
								<th>Price</th>
								<th>Quantity</th>					
								</tr>
							</thead>
					   		<tbody style="color:white;">		
							    <%
								    String prmid;
									while (resultSet.next()) 
									{
									prmid=resultSet.getString(1);
								%>
						   		<tr>
								    <td><%=resultSet.getString(1) %></td>
								    <td><%=resultSet.getString(2) %></td>
								    <td><%=resultSet.getString(3) %></td>
								    <td><%=resultSet.getString(4) %></td> 
								</tr>	     			
								<%
									} 
							    %>
		     				</tbody>
		     			</table>
		     		</div>
		     	</form>
 				
 				<div class="container-fluid" style="width:500px">
 					<form role="form" action="MenuSub.jsp" method="post">
	 					<h3> Product ID</h3>
						<input class="form-control" id="ex2" type="number" name="prodid" required/>
	 					<h3> Customer Name</h3>
						<input class="form-control" id="ex2" type="text" name="custname" required/>
	 					<h3> Amount</h3>
						<input class="form-control" id="ex2" type="number" name="prodamt" required /><br>
						<input type="submit" id="submit" class="btn btn-default" value="Order" />
					</form>
 				</div>
			    <%   
				connection.close();
			}catch(Exception e){
				
			}

		}
		catch(Exception e)
		{
			
		}
				%>			
</body>
</html>