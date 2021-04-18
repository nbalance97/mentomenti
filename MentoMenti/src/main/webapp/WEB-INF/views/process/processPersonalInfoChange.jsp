<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController" %>
<%@ page import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MOCO</title>
</head>
<body>
	<%
		String id = (String)session.getAttribute("userID");	//세션으로부터 아이디 받아옴
	
		String nickname = request.getParameter("new_nickname");
		String pw = request.getParameter("new_pw");
		String email = request.getParameter("new_email");
		String intro = request.getParameter("new_intro");
		
		UserDTO user = new UserDTO(null, null, null, null, null, null, null, false, null);
		user.setNickname(nickname);
		user.setPw(pw);
		user.setEmail(email);
		user.setIntro(intro);
		
		HomeController.dao.getUserDAO().updateUserInfo(user);	//DB update
		
		response.sendRedirect("personalInfoPage");
	%>
</body>
</html>