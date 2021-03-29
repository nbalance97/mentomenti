<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<form name="compileView" method="post" action="./Compile">
		<label>Code Input</label> <br>
		<textarea rows=30 cols=30 name="CodeText"></textarea><br><br>
		<input type="submit" value="등록">
	</form>

</body>
</html>