<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController" %>
<%@ page import="Mento.Menti.Project.dto.PostDTO, Mento.Menti.Project.dao.PostDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MOCO</title>
</head>
<body>
	<%
		String userid = (String)session.getAttribute("userID");	//작성자 아이디
		String title = request.getParameter("title");	//제목
		String content = request.getParameter("content");	//내용
		
		Calendar cal = Calendar.getInstance();
		int year = cal.get(cal.YEAR);
		int month = cal.get(cal.MONTH)+1;
		int date = cal.get(cal.DATE);
		String postdate = year+"-"+month+"-"+date;	//작성일자
		
		PostDTO notice = new PostDTO();
		notice.setUserid(userid);
		notice.setTitle(title);
		notice.setContent(content);
		notice.setPostdate(postdate);
		
		HomeController.dao.getPostDAO().insertGeneralPost(notice);
		response.sendRedirect("freeBoard");	//자유게시판 페이지로 이동
	%>
</body>
</html>