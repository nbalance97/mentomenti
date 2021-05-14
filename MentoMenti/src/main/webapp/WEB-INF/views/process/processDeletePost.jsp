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
		
		int groupid = HomeController.dao.getPostDAO().searchByPostId(postid).get(0).getGroupid();
		
		HomeController.dao.getPostDAO().deletePost(postid);	//DB 반영
		pw.print("<script>alert('게시물이 삭제되었습니다.');</script>");
		
		if (isNotice) { //공지사항
			if (groupid > 0) //그룹 공지
				pw.print("<script>window.location=\"groupnotice?page=1&groupid="+groupid+"\"</script>;");
			else pw.print("<script>window.location=\"notice?page=1\"</script>;");
		} else{	//자유게시판
			if (groupid > 0)
				pw.print("<script>window.location=\"groupQnA?page=1&groupid="+groupid+"\"</script>;");
			else pw.print("<script>window.location=\"freeBoard?page=1\"</script>;");
		}
	%>
</body>
</html>