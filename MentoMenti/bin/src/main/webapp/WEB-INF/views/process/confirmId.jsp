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
		opener.document.signupForm.idDuplication.value = "idCheck";
		self.close();
	}
</script>
	<%
		String id = request.getParameter("id");
		UserDTO user = new UserDTO(null, null, null, null, null, null, null, false, null);
		user.setId(id);
		
		List<UserDTO> userAccount = HomeController.dao.getUserDAO().searchUserById(user);
		if (userAccount.size() > 0){%>
			<div id="wrap">
				<br/>
				<h4>이미 사용중인 아이디입니다.</h4>
				<input type="button" value="확인" onclick="window.close()">
			</div>
		<%}else{%>
			<div id="wrap">
				<br/>
				<h4>사용가능한 아이디입니다.</h4>
				<input type="button" value="확인" onclick="sendCheck()">
			</div>
		<% }%>
</body>
</html>