<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% request.setCharacterEncoding("utf-8"); %>
	<form name="compileView" method="post" action="./Compile.jsp">
		<label>Code Input</label>
		<input type="textarea" cols="50" rows="10" name="CodeText">
		<input type="submit" value="등록">
	</form>

</body>
</html>