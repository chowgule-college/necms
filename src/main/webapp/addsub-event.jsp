<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<a href="./index.jsp">home</a>
<form action="RegisterSubEvent" method="post">
		<input type="text" name="se_name" placeholder="Enter Event Name">
		<input type="number" name="se_hours" placeholder="Enter Hours">
		<input type="number" name="me_id" placeholder="Enter me_id">
		<button type="submit">submit</button>
	</form>
</body>
</html>