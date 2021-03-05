<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Revenue by Customer</title>
	</head>
	<body>


		<% try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();

			String customer = request.getParameter("rCustomer");
			
			
			String sql = "SELECT r.TotalFare, r.ReservationNumber " +
					 "FROM reservation r " +
					 "WHERE r.Username=" + "'" + customer + "'";
			
			
			if(customer.isEmpty()){
				%>Please enter the name of the Customer.<%
			}
			else{
					out.println("Revenue for "+customer+":");
					%><br><%
					double total = 0;
					ResultSet rs = stmt.executeQuery(sql);
					while(rs.next()){
						String resNum = rs.getString("ReservationNumber");
						String fare = rs.getString("TotalFare");	
						%><br><%
						out.println("Reservation Number: " + resNum);
						%><br><%
						out.println("Fare: " + fare);
						%><br><%
						total += Double.parseDouble(fare);
					}
					
					%><br><%
					out.println("Total: " + total);
					%><br><%
			}		
			
			db.closeConnection(con);
			
			
		} catch (Exception e) {
			out.print(e);
		}%>
		
		<br>
		<form method="get" action="admin.jsp">
            <input type="submit" value="Return to Admin Tools">
        </form>
				
	</body>
</html>