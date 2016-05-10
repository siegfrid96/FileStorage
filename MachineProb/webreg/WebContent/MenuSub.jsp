<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title> Payment </title>
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
		int prodid=Integer.parseInt(request.getParameter("prodid")); 
		int prodamt=Integer.parseInt(request.getParameter("prodamt")); 
		String custname=request.getParameter("custname"); 
		
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

			int total = 0;
			String prodname1 =null;
			int availqty=0;
			int sqlprodid=0;
			try
			{
				Statement statement = connection.createStatement();
				String query = "SELECT price,productname,availableqty,id FROM tb_product where id="+prodid+"";
				ResultSet resultSet = statement.executeQuery(query);
				
				while(resultSet.next())
				{
					int priceval= resultSet.getInt(1);
					prodname1= resultSet.getString(2);
					availqty = resultSet.getInt(3);
					sqlprodid = resultSet.getInt(4);
					total = priceval * prodamt ;
					System.out.println("total: "+total);
					System.out.println(priceval);
					System.out.println(prodamt);
				}
				
				if(availqty<prodamt || sqlprodid!=prodid)
				{
				    // New location to be redirected
					String site = new String("OrderError.jsp");
					response.setStatus(response.SC_MOVED_TEMPORARILY);
					response.setHeader("Location", site); 
				}
				else
				{
					PreparedStatement statement11 = (PreparedStatement) connection.prepareStatement(
							
													"UPDATE " + "tb_product " +
												
													"SET availableqty=availableqty-?" +
													
													" WHERE id=?");
					
					statement11.setInt(1, prodamt);
					statement11.setInt(2, prodid);
					statement11.executeUpdate();
					
					PreparedStatement statement22 = (PreparedStatement) connection.prepareStatement(
							
													"INSERT INTO " + "machineprob.tb_order " +
												
													"(customer,productnameid,qty)" +
													
													" values(?,?,?) ");
					
					statement22.setString(1, custname);
					statement22.setInt(2, prodid);
					statement22.setInt(3, prodamt);
				
					statement22.executeUpdate();
					
					connection.close();
				}
			}
			catch(Exception e)
			{
				System.out.println("Exception error: " + e.getMessage());
			}
			%> <h1 style="text-align:center">Product Name: <%=prodname1%> </h1><%
			%> <h1 style="text-align:center">Customer Name:<%=custname%> </h1><% 
			%> <h1 style="text-align:center">Total Price:<%=total%> </h1><% 
		}
		catch(Exception e)
		{
			
		}
	%>
	
	<div class="container-fluid" style="text-align:center">
		<a href ="Menu.jsp" class="btn btn-info" style="background-color:black; align:center">Back</a>
	</div>
</body>
</html>