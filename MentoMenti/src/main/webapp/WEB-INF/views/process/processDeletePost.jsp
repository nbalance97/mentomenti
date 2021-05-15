<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.PostDTO, Mento.Menti.Project.dao.PostDAO"%>
<%@ page import="java.util.List"%>
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
		int postid = Integer.parseInt(request.getParameter("postid"));
		PostDTO post = HomeController.dao.getPostDAO().searchByPostId(postid).get(0);
		String writerid = post.getUserid(); //작성자 아이디
	
		String loginid = (String) session.getAttribute("userID"); //로그인 아이디
	
		//로그인 사용자가 관리자인지 확인
		UserDTO user = new UserDTO();
		user.setId(loginid);
		boolean isAdmin = HomeController.dao.getUserDAO().searchUserById(user).get(0).is_admin();
	
		//본인이 댓글 작성자이거나 관리자일 때
		if (writerid.equals(loginid) || isAdmin) {
	
			boolean isNotice = HomeController.dao.getPostDAO().isNotice(postid);
			int groupid = HomeController.dao.getPostDAO().searchByPostId(postid).get(0).getGroupid();
	
			HomeController.dao.getPostDAO().deletePost(postid); //DB 반영
			pw.print("<script>alert('게시물이 삭제되었습니다.');</script>");
	
			String from = request.getParameter("from");
			if (from.equals("adminPage")) { //관리자가 게시물 관리 페이지에서 삭제했다면
				pw.print("<script>window.location=\"adminPostPage\"</script>;");
			} else if (isNotice) { //공지사항
				if (groupid > 0) //그룹 공지
			pw.print("<script>window.location=\"groupnotice?page=1&groupid=" + groupid + "\"</script>;");
				else
			pw.print("<script>window.location=\"notice?page=1\"</script>;");
			} else { //자유게시판
				if (groupid > 0)
			pw.print("<script>window.location=\"groupQnA?page=1&groupid=" + groupid + "\"</script>;");
				else
			pw.print("<script>window.location=\"freeBoard?page=1\"</script>;");
			}
		} else{	//접근 권한이 없는 사람일 때
			pw.print("<script>window.location=\"rejectedAccess?type=notPostWriter\"</script>;");
		}
	%>
</body>
</html>