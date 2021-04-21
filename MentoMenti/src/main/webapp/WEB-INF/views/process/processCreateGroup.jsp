<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController" %>
<%@ page import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MOCO</title>
</head>
<body>
	<%
		//입력 양식에서 가져온 데이터
		String name = request.getParameter("groupName"); //그룹명
		int maxperson = Integer.parseInt(request.getParameter("maxPerson")); //최대 인원수(멘티수)
		String category = request.getParameter("category");	//분류
		if(category.equals("기타")){
			category = request.getParameter("categoryText");
		}
		String intro = request.getParameter("intro");	//소개글
	
		String mentoid = (String)session.getAttribute("userID");	//세션으로부터 멘토 아이디
		
		GroupDTO newGroup = new GroupDTO();
		newGroup.setName(name);
		newGroup.setMentoid(mentoid);
		newGroup.setMaxperson(maxperson);
		newGroup.setCategory(category);
		newGroup.setIntro(intro);
		
		HomeController.dao.getGroupDAO().insertGroup(newGroup);	//DB 반영 완료
		response.sendRedirect("openedGroups");	//나중에 해당 그룹 페이지로 이동하는걸로 수정할 것
	%>
</body>
</html>