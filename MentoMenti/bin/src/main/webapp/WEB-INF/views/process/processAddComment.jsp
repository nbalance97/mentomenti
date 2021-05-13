<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.PostDTO, Mento.Menti.Project.dao.PostDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.CommentDTO, Mento.Menti.Project.dao.CommentDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Calendar"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MOCO</title>
</head>
<body>
	<%
		String writerid = (String) session.getAttribute("userID"); //작성자 id

	if (writerid == null) {
		response.sendRedirect("loginPage?mode=nidLogin");
	} else {

		int postid = Integer.parseInt(request.getParameter("postid")); //게시물 번호
		String content = request.getParameter("comment"); //댓글 내용

		Calendar cal = Calendar.getInstance();
		int todayYear = cal.get(cal.YEAR);
		int todayMonth = cal.get(cal.MONTH) + 1;
		int todayDate = cal.get(cal.DATE);
		String commentdate = todayYear + "-" + todayMonth + "-" + todayDate;

		CommentDTO newComment = new CommentDTO();
		newComment.setPostid(postid);
		newComment.setWriterid(writerid);
		newComment.setContent(content);
		newComment.setCommentdate(commentdate);

		HomeController.dao.getCommentDAO().insertComment(newComment); //DB 반영 완료
		
		int groupid = HomeController.dao.getPostDAO().searchByPostId(postid).get(0).getGroupid();

		if (HomeController.dao.getPostDAO().isNotice(postid)) { //공지
			if (groupid > 0)	//그룹 내 공지
				response.sendRedirect("groupNoticeContent?postid=" + postid);
			else response.sendRedirect("noticeContent?postid=" + postid);
		}
		else { //게시판
			if (groupid > 0)	//그룹 Q&A
				response.sendRedirect("groupPostContent?postid=" + postid);
			else response.sendRedirect("postContent?postid=" + postid);
		}
	}
	%>
</body>
</html>