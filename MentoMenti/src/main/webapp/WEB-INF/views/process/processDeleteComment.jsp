<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.CommentDTO, Mento.Menti.Project.dao.CommentDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Calendar"%>

<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MOCO</title>
</head>
<body>
	<%
		PrintWriter pw = response.getWriter();
	
		int commentid = Integer.parseInt(request.getParameter("commentid"));
		int postid = Integer.parseInt(request.getParameter("postid"));
		
		HomeController.dao.getCommentDAO().deleteComment(commentid);
		pw.print("<script>alert('댓글이 삭제되었습니다.');</script>");
		
		if (HomeController.dao.getPostDAO().isNotice(postid)) { //공지사항
			pw.print("<script>window.location=\"noticeContent?postid=" + postid + "\"</script>;");
		} else{	//자유게시판
			pw.print("<script>window.location=\"postContent?postid=" + postid + "\"</script>;");
		}
	%>
</body>
</html>