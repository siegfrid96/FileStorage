<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title> Order Error </title>
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
						<li><a href="EditProduct.jsp">Edit Product</a></li>
						<li><a href="DeleteProduct.jsp">Delete Product</a></li>
					</ul>
				</li>	
			</ul>				
		</div>
	</div>
	
	<div class="container-fluid">
		<h1>ORDER ERROR!</h1>
		<h2>Following Causes: </h2>
		<p>Amount Bought is Greater than Stock Quantity!</p>
		<p>Invalid Product ID!</p>
		<p>ETC</p>
		<a href="Menu.jsp" class="btn btn-info" style="background-color:black">Go Back</a>
		<a href="Menu.jsp"></a>
	</div>
</body>
</html>