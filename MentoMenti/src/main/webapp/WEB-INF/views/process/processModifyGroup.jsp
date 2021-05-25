<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController" %>
<%@ page import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO" %>
<%@ page import="Mento.Menti.Project.dto.NotificationDTO, Mento.Menti.Project.dao.NotificationDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MOCO</title>
</head>
<body>
	<%
		int groupid = Integer.parseInt(request.getParameter("groupId"));	//그룹 아이디
		String intro = request.getParameter("intro");	//소개글
		
		String mentoid = HomeController.dao.getGroupDAO().searchGroupByGroupid(groupid).getMentoid();	//멘토 아이디
		String loginid = (String)session.getAttribute("userID");	//로그인 아이디
		
		if (mentoid.equals(loginid)){	//멘토 아이디 = 로그인 아이디
			GroupDTO group = new GroupDTO();
			group.setGroupid(groupid);
			group.setIntro(intro);
			HomeController.dao.getGroupDAO().updateGroupIntro(group);	//DB 반영
			response.sendRedirect("group?groupid="+groupid);	//그룹 메인 화면으로 이동
		} else {	//접근 권한이 없는 사용자
			response.sendRedirect("rejectedAccess?type=notMento");
		}
	%>
</body>
</html>