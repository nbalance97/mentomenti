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
		String userid = request.getParameter("userid");	//접근 아이디
		String loginid = (String) session.getAttribute("userID"); //로그인 아이디
	
		//로그인 사용자가 관리자인지 확인
		UserDTO user = new UserDTO();
		user.setId(loginid);
		boolean isAdmin = HomeController.dao.getUserDAO().searchUserById(user).get(0).is_admin();
	
		//본인이 탈퇴신청을 했거나 관리자일 때
		if (userid.equals(loginid) || isAdmin) {
			HomeController.dao.getUserDAO().deleteUser(userid);	//DB에서 계정 삭제
	
			String from = request.getParameter("from");
			if (from != null) { //관리자가 탈퇴시킨 경우
				pw.print("<script>window.location=\"adminUserPage\"</script>;");
			} else { //본인이 탈퇴 신청을 했을 때
				pw.print("<script>alert('탈퇴 완료되었습니다.');</script>");
				pw.print("<script>window.location=\"loginPage\"</script>;");
			}
		} else{	//접근 권한이 없는 사람일 때
			pw.print("<script>window.location=\"rejectedAccess?type=notLoginUser\"</script>;");
		}
	%>
</body>
</html>