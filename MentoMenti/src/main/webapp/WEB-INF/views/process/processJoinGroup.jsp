<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController" %>
<%@ page import="Mento.Menti.Project.dto.GroupmateDTO, Mento.Menti.Project.dao.GroupmateDAO" %>
<%@ page import="java.util.List" %>

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
	
		String loginid = (String)session.getAttribute("userID"); //현재 로그인한 아이디
		String mentoid = request.getParameter("mentoid");	//가입할 그룹 멘토 아이디
		int groupid = Integer.parseInt(request.getParameter("groupid"));	//가입할 그룹 아이디 (int)
		
		GroupmateDTO groupmate = new GroupmateDTO(loginid, groupid);
		
		
		if (loginid == null) {	//로그인x 상태
			response.sendRedirect("loginPage?mode=nidLogin");
		}
		
		
		else if (loginid.equals(mentoid)) { //로그인 아이디 = 그룹 멘토 아이디
			pw.print("<script>alert('자신이 개설한 그룹에 멘티로 참여할 수 없습니다!');</script>");
			pw.print("<script>window.location=\"openedGroups\"</script>;");
		}
		
		
		else if (HomeController.dao.getGroupmateDAO().alreadyJoined(groupmate).size() > 0) { //이미 가입한 그룹
			pw.println("<script>alert('이미 가입한 그룹입니다!');</script>");
			pw.print("<script>window.location=\"openedGroups\"</script>;");
		}
		
		
		else { //그룹 가입 진행, DB insert
			HomeController.dao.getGroupmateDAO().insertGroupmate(groupmate);
			pw.println("<script>alert('그룹에 가입되었습니다!');</script>");
			
			//가입한 그룹 페이지 완성되면 그 페이지로 이동하도록 수정할 예정
			pw.print("<script>window.location=\"openedGroups\"</script>;");
		}
	%>
</body>
</html>