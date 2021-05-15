<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.CommentDTO, Mento.Menti.Project.dao.CommentDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Calendar"%>

<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MOCO</title>
</head>
<body>
	<%
		PrintWriter pw = response.getWriter();

		int commentid = Integer.parseInt(request.getParameter("commentid")); //댓글 번호
		CommentDTO comment = HomeController.dao.getCommentDAO().searchCommentByCommentId(commentid);
		String writerid = comment.getWriterid();
		String loginid = (String) session.getAttribute("userID"); //로그인 아이디
	
		//로그인 사용자가 관리자인지 확인
		UserDTO user = new UserDTO();
		user.setId(loginid);
		boolean isAdmin = HomeController.dao.getUserDAO().searchUserById(user).get(0).is_admin();
	
		//본인이 댓글 작성자이거나 관리자일 때
		if (writerid.equals(loginid) || isAdmin) {
	
			HomeController.dao.getCommentDAO().deleteComment(commentid);
			pw.print("<script>alert('댓글이 삭제되었습니다.');</script>");
	
			String from = request.getParameter("from");
			if (from.equals("adminPage")) { //관리자가 게시물 관리 페이지에서 삭제했다면
				pw.print("<script>window.location=\"adminCommentPage\"</script>;");
			}
	
			else {
				int postid = Integer.parseInt(request.getParameter("postid"));
				int groupid = HomeController.dao.getPostDAO().searchByPostId(postid).get(0).getGroupid();
	
				if (HomeController.dao.getPostDAO().isNotice(postid)) { //공지사항
			if (groupid > 0) //그룹 공지사항
				pw.print("<script>window.location=\"groupNoticeContent?postid=" + postid + "\"</script>;");
			else
				pw.print("<script>window.location=\"noticeContent?postid=" + postid + "\"</script>;");
				} else { //자유게시판
			if (groupid > 0)
				pw.print("<script>window.location=\"groupPostContent?postid=" + postid + "\"</script>;");
			else
				pw.print("<script>window.location=\"postContent?postid=" + postid + "\"</script>;");
				}
			}
		} else {	//접근 권한이 없는 사람일 때
			pw.print("<script>window.location=\"rejectedAccess?type=notCommentWriter\"</script>;");
		}
	%>
</body>
</html>