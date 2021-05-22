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

<script type="text/javascript">
	alert(document.getElement)

</script>

<body>
	<%
		String id = (String)session.getAttribute("userID");	//세션으로부터 아이디 받아옴
	
		String nickname = request.getParameter("new_nickname");
		String pw = request.getParameter("new_pw");
		String email = request.getParameter("new_email");
		String intro = request.getParameter("new_intro");
		
		UserDTO user = new UserDTO(null, null, null, null, null, null, null, false, null);
		user.setId(id);
		user.setNickname(nickname);
		user.setEmail(email);
		user.setIntro(intro);
		
		if (pw.equals("")){	//비밀번호 변경 x
			user.setPw(HomeController.dao.getUserDAO().searchUser(user).get(0).getPw());
		} else {	//비밀번호 변경 o
			user.setPw(pw);
		}
		
		HomeController.dao.getUserDAO().updateUserInfo(user);	//DB update
		session.setAttribute("nickname", nickname);
		
		response.sendRedirect("personalInfoPage");
	%>
</body>
</html>