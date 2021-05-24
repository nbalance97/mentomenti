<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.NotificationDTO, Mento.Menti.Project.dao.NotificationDAO"%>
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
		String loginId = (String) session.getAttribute("userID"); //로그인 아이디
		int notiId = Integer.parseInt(request.getParameter("notificationid"));
		String receiverId = HomeController.dao.getNotificationDAO().selectReceiverid(notiId);
	
		//로그인한 사용자가 받은 알림이 맞는지 receiverid 확인
		if (receiverId.equals(loginId)){
			HomeController.dao.getNotificationDAO().deleteNotification(notiId);
			pw.print("<script>alert('알림이 삭제되었습니다.');</script>");
			pw.print("<script>window.location=\"notifications\"</script>;");
		} else {	//접근 권한이 없는 사람일 때
			pw.print("<script>window.location=\"rejectedAccess?type=notNotiReceiver\"</script>;");
		}
	%>
</body>
</html>