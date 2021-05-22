<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController" %>
<%@ page import="Mento.Menti.Project.dto.*, Mento.Menti.Project.dao.*" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#wrap{
		text-align:center;
	}
</style>
</head>
<body>
<script>
	function sendCheck(){
		window.opener.location="loginPage";
		self.close();
	}
</script>
	<%
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String birth = request.getParameter("birth");
		String email = request.getParameter("email");
		UserDTO user = new UserDTO(null, null, null, null, null, null, null, false, null);
		user.setId(id);
		user.setName(name);
		user.setBirth(birth);
		user.setEmail(email);
		
		List<UserDTO> userAccount = HomeController.dao.getUserDAO().searchUserByIdNameBirthEmail(user);
		if (userAccount.size() > 0){%>
			<%
				UserDTO me = userAccount.get(0);
				String pw = me.getPw();
				String myname = me.getName();
			%>
			<div id="wrap">
				<br/>
				<h4><%=myname%>님의 비밀번호는</h4>
				<h4><%=pw%></h4>
				<h4>입니다.</h4>
				<input type="button" value="확인" onclick="sendCheck()">
			</div>
		<%}else{%>
			<div id="wrap">
				<br/>
				<h4>일치하는 정보가 존재하지 않습니다.</h4>
				<input type="button" value="확인" onclick="window.close()">
			</div>
		<% }%>
</body>
</html>