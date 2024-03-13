<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
String userName = (String) session.getAttribute("user-role");
if (userName == null) {
%>
    <p>Welcome, Guest! Please log in.</p>
<%
} else {
%>
    <p>Welcome, <%= userName %>! (User's name from session)</p>
<%
}
%>
</body>
</html>