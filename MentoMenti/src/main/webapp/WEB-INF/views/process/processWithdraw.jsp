<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		int groupid = Integer.parseInt(request.getParameter("groupid"));
		String mentiNick = request.getParameter("mentiNick");
		
	%>
	<%=groupid %>
	<%=mentiNick %>
</body>
</html>