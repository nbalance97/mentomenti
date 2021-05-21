<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String message = request.getParameter("type");
	
		PrintWriter pw = response.getWriter();
		if (message.equals("notMember")){
			pw.print("<script>alert('해당 그룹의 멤버가 아닙니다');</script>");
			pw.print("<script>window.location=\"joininggroups\"</script>;");	//자신의 그룹 목록 페이지로 이동
		}
		
		if (message.equals("notMento")){
			pw.print("<script>alert('해당 그룹의 멘토가 아닙니다');</script>");
			pw.print("<script>window.location=\"joininggroups\"</script>;");	//자신의 그룹 목록 페이지로 이동
		}
		
		if (message.equals("notAdmin")){
			pw.print("<script>alert('관리자만 접근할 수 있는 페이지입니다');</script>");
			pw.print("<script>window.location=\"main\"</script>;");	//메인 화면으로 이동
		}
		
		if (message.equals("notCommentWriter")){
			pw.print("<script>alert('자신의 댓글만 삭제할 수 있습니다');</script>");
			pw.print("<script>window.location=\"main\"</script>;");	//메인 화면으로 이동
		}
		
		if (message.equals("notPostWriter")){
			pw.print("<script>alert('자신의 게시물 삭제할 수 있습니다');</script>");
			pw.print("<script>window.location=\"main\"</script>;");	//메인 화면으로 이동
		}
		
		if (message.equals("notLoginUser")){
			pw.print("<script>alert('자신의 계정만 탈퇴시킬 수 있습니다');</script>");
			pw.print("<script>window.location=\"main\"</script>;");	//메인 화면으로 이동
		}
		
		//이런 식으로 접근 권한 없는 페이지 처리하면 됨
	%>
</body>
</html>