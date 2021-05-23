<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController" %>
<%@ page import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO" %>
<%@ page import="Mento.Menti.Project.dto.GroupmateDTO, Mento.Menti.Project.dao.GroupmateDAO" %>
<%@ page import="Mento.Menti.Project.dto.NotificationDTO, Mento.Menti.Project.dao.NotificationDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>

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
		int groupid = Integer.parseInt(request.getParameter("groupid"));	//탈퇴할 그룹 아이디 (int)
		
		if (loginid == null) {	//로그인x 상태
			response.sendRedirect("loginPage?mode=nidLogin");
		}
		
		else { //그룹 탈퇴 진행
			GroupmateDTO groupmate = new GroupmateDTO(loginid, groupid);
			HomeController.dao.getGroupmateDAO().leaveGroup(groupmate);	//groupmate DB에서 delete
			
			GroupDTO group = HomeController.dao.getGroupDAO().searchGroupByGroupid(groupid);
		
			//현재 시각 구하기
			Calendar cal = Calendar.getInstance();
			int todayYear = cal.get(cal.YEAR);
			int todayMonth = cal.get(cal.MONTH)+1;
			int todayDate = cal.get(cal.DATE);
			String todaydate = todayYear+"-"+todayMonth+"-"+todayDate;
			int curHour = cal.get(cal.HOUR_OF_DAY);
			int curMin = cal.get(cal.MINUTE);
			int curSec = cal.get(cal.SECOND);
			DecimalFormat df = new DecimalFormat("00");	//두 자리로 형식 맞춤
			String leaveDatetime = todaydate + " " + df.format(curHour) + ":" + df.format(curMin) + ":" + df.format(curSec);
			
			//그룹 탈퇴 완료 알림 DB 추가
			NotificationDTO notification = new NotificationDTO();
			notification.setReceiverid(loginid);
			notification.setSendtime(leaveDatetime);
			notification.setContent("["+group.getName()+"] 그룹에서 탈퇴 완료되었습니다.");
			notification.setIsread(false);
			HomeController.dao.getNotificationDAO().insertNotification(notification);
		
			pw.println("<script>alert('그룹에서 탈퇴 완료되었습니다');</script>");
			pw.print("<script>window.location=\"joininggroups\"</script>;");
		}
	%>
</body>
</html>