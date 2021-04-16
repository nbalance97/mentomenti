<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController" %>
<%@ page import="Mento.Menti.Project.dto.*, Mento.Menti.Project.dao.*" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MOCO</title>
</head>
<body>
	<%
		String id = request.getParameter("idInput");	//입력한 아이디
		String pw = request.getParameter("pwInput");	//입력한 비밀번호
		
		UserDTO user = new UserDTO(null, null, null, null, null, null, null, false, null);
		user.setId(id);
		user.setPw(pw);
		
		//user DB에서 일치하는 정보가 있는지 확인
		List<UserDTO> userAccount = HomeController.dao.getUserDAO().searchUserByIdPw(user);
		if (userAccount.size() > 0)	//일치하는 계정 있음
			response.sendRedirect("main");
		else
			response.sendRedirect("loginPage?mode=nidLogin");
	%>
</body>
</html>