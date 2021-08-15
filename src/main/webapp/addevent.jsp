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
	<form action="RegisterMainEvent" method="post">
		<input type="text" name="me_name" placeholder="Enter Event Name">
		<input type="date" name="me_date">
		<button type="submit">submit</button>
	</form>
</body>
</html>