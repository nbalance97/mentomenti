<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MOCO</title>
</head>
<body>
<%
	String id = (String) session.getAttribute("userID");
	UserDTO user = new UserDTO();
	user.setId(id);
	String curPw = HomeController.dao.getUserDAO().searchUserById(user).get(0).getPw();	//실제 비밀번호
	String inputPw = request.getParameter("input_pw");	//입력한 비밀번호
	
	if(curPw.equals(inputPw)){	//비밀번호 일치
		session.setAttribute("pwChk", "true");	//비밀번호 확인 했음을 세션에 등록
		response.sendRedirect("personalInfoChange");
	} else {
		response.sendRedirect("rejectedAccess?type=notCorrectPw");
	}
%>
</body>
</html>