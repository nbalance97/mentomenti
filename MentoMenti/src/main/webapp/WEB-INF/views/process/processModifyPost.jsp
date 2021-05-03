<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.PostDTO, Mento.Menti.Project.dao.PostDAO"%>
<%@ page import="java.util.List"%>
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
		int postid = Integer.parseInt(request.getParameter("postid"));
		boolean isNotice = HomeController.dao.getPostDAO().isNotice(postid);
		
		
		String newTitle = request.getParameter("title");
		String newContent = request.getParameter("content");
		
		PostDTO post = new PostDTO();
		post.setPostid(postid);
		post.setTitle(newTitle);
		post.setContent(newContent);
		
		HomeController.dao.getPostDAO().updatePost(post);	//DB 반영
		pw.print("<script>alert('게시물이 수정되었습니다.');</script>");
		
		if (isNotice) { //공지사항
			pw.print("<script>window.location=\"noticeContent?postid="+postid+"\"</script>;");
		} else{	//자유게시판
			pw.print("<script>window.location=\"postContent?postid="+postid+"\"</script>;");
		}
	%>
</body>
</html>