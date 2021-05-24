<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MOCO</title>
</head>
<body>
	<%
		//로그인 세션 해제
		session.removeAttribute("userID");
		session.removeAttribute("nickname");
		session.removeAttribute("pwChk");
		
		response.sendRedirect("main");	//로그인 화면으로 이동
	%>
</body>
</html>