
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
	   <%

HttpSession httpSession = request.getSession();
if(httpSession==null || httpSession.getAttribute("user")==null){
	response.sendRedirect("login.jsp");
	return;
		
}

String userName = (String) httpSession.getAttribute("user");
out.println("Welcome, " + userName);

%>

<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<title>UpTrend</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style type="text/css">



.product-card {
    transition: transform 0.2s, box-shadow 0.2s;
}

.product-card:hover {
    transform: scale(1.05);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}


.profile-icon {
	display: inline-block;
	font-size: 1.5em; /* Adjust size as needed */
}

.card-img-container {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 500px; /* Ensure this matches the height of the image */
	overflow: hidden;
}

.card-img-container img {
	max-width: 100%;
	max-height: 100%;
	object-fit: cover;
}
</style>

</head>
<body class="p-3 m-0 border-0 bd-example m-0 border-0">

	<!-- Example Code -->
<nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">UpTrend</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Women</a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="womendress.jsp">Dress</a></li>
                        <li><a class="dropdown-item" href="footwear.jsp">Footwears</a></li>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Men</a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="mendress.jsp">Dress</a></li>
                        <li><a class="dropdown-item" href="shoes.jsp">Shoes</a></li>
                    </ul>
                </li>
                <li class="nav-item"><a class="nav-link active" href="cart.jsp">Cart</a></li>
                <li class="nav-item"><a class="nav-link active" href="userorders.jsp">Orders</a></li>
                <li class="nav-item"><a class="nav-link active" href="contact.jsp">Contact</a></li>
            </ul>
            <a class="nav-link active" href="logout.jsp">Logout</a>
        </div>
    </div>
</nav>


	<div class="container" style="margin-top: 100px">
		<div class="row">
			<%
			// Database connection parameters
			String url = "jdbc:mysql://192.168.18.245:3306/pythondb_test";
			String username = "pythondb_test";
			String password = "PYt3StDB75S";
			Connection conn = null;
			Statement stmt = null;
			ResultSet rs = null;

			try {
				// Load the JDBC driver
				Class.forName("com.mysql.jdbc.Driver");

				// Establish the connection
				conn = DriverManager.getConnection(url, username, password);

				// Create a statement
				stmt = conn.createStatement();

				// Execute the query
				String sql = "SELECT * FROM product";
				rs = stmt.executeQuery(sql);

				// Iterate through the result set and display the data
				while (rs.next()) {
					String name = rs.getString("name");
					double price = rs.getDouble("price");
					String image = rs.getString("image_url");
					int product_id = rs.getInt("product_id");
			%>
			 <div class="col-md-4">
                <div class="card mb-4 shadow-sm bg-light product-card">
                    <a href="productdetails.jsp?productId=<%=product_id%>" class="card-img-container">
                        <img alt="<%=name%>" src="<%=image%>">
                    </a>
                    <div class="card-body">
						<h5 class="card-title"><%=name%></h5>
						<p class="card-text">
							<strong>Price:</strong>
							<%=price%><br>
						</p>
						<div class="d-flex justify-content-between">
							<form action="addtocart.jsp" method="post"
								style="display: inline;">
								<input type="hidden" name="product_id" value="<%=product_id%>">
								<button type="submit" class="btn btn-primary">Add to
									Cart</button>
							</form>
							<form action="buynow.jsp" method="post" style="display: inline;">
								<input type="hidden" name="product_id" value="<%=product_id%>">
								<button type="submit" class="btn btn-success">Buy Now</button>
							</form>
						</div>
					</div>
				</div>
			</div>

			<%
			}
			} catch (Exception e) {
			e.printStackTrace();
			} finally {
			// Close the resources
			if (rs != null)
			try {
				rs.close();
			} catch (SQLException ignore) {
			}
			if (stmt != null)
			try {
				stmt.close();
			} catch (SQLException ignore) {
			}
			if (conn != null)
			try {
				conn.close();
			} catch (SQLException ignore) {
			}
			}
			%>
		</div>
	</div>

</body>
</html>