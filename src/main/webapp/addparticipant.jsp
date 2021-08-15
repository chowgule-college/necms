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
<form action="RegisterParticipant" method="post">
		<input type="text" name="p_rollno" placeholder="Enter rollno">
		<input type="number" name="se_id" placeholder="Enter se_id">
		<input type="number" name="me_id" placeholder="Enter me_id">
		<button type="submit">submit</button>
	</form>
	<form action="RemoveParticipantByRollNo" method="post">
	<input type="text" name="p_rollno" placeholder="Enter rollno">
	<button type="submit">remove</button>
	</form>
</body>
</html>