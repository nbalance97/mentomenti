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
		if (userAccount.size() > 0){	//일치하는 계정 있음
			session.setAttribute("userID", id);	//세션에 아이디 설정			
			
			//session.setMaxInactiveInterval(60 * 60 * 3); //세션 유효 시간 설정 얼마로 할지?
			
			response.sendRedirect("main");	//메인으로 이동
		}
		else
			response.sendRedirect("loginPage?mode=noAccount");	//로그인 화면으로 이동
	%>
</body>
</html>