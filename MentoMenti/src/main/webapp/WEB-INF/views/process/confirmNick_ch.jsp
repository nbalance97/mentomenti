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
		opener.document.changeForm.NickDuplication.value = "NickCheck";
		self.close();
	}
</script>
	<%
		String nickname = request.getParameter("nickname");
		String origin = request.getParameter("origin");
		UserDTO user = new UserDTO(null, null, null, null, null, null, null, false, null);
		user.setNickname(nickname);
		
		List<UserDTO> userAccount = HomeController.dao.getUserDAO().searchUserByNick(user);
		if (userAccount.size() > 0 && !nickname.equals(origin)){%><!-- 내가쓰고 있는거 제외 -->
			<div id="wrap">
				<br/>
				<h4>이미 사용중인 닉네임입니다.</h4>
				<input type="button" value="확인" onclick="window.close()">
			</div>
		<%}
		else{%>
			<div id="wrap">
				<br/>
				<h4>사용가능한 닉네임입니다.</h4>
				<input type="button" value="확인" onclick="sendCheck()">
			</div>
		<% }%>
</body>
</html>