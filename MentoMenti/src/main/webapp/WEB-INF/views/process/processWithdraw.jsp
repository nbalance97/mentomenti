<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>
<%@ page import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page import="Mento.Menti.Project.dto.GroupmateDTO, Mento.Menti.Project.dao.GroupmateDAO"%>
<%@ page import="Mento.Menti.Project.dto.NotificationDTO, Mento.Menti.Project.dao.NotificationDAO"%>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>
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
	
		String loginid = (String) session.getAttribute("userID"); //현재 로그인한 아이디	
		if (loginid == null) { //로그인x 상태
			response.sendRedirect("loginPage?mode=nidLogin");
		}
		
		int groupid = Integer.parseInt(request.getParameter("groupid"));
		String mentiNick = request.getParameter("mentiNick");
		UserDTO menti = new UserDTO();
		menti.setNickname(mentiNick);
		String mentiId = HomeController.dao.getUserDAO().searchUserByNick(menti).get(0).getId();
	
		GroupmateDTO gm = new GroupmateDTO(mentiId, groupid);
		HomeController.dao.getGroupmateDAO().leaveGroup(gm);	//그룹 강퇴 DB 반영
		
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
		String withDrawDatetime = todaydate + " " + df.format(curHour) + ":" + df.format(curMin) + ":" + df.format(curSec);
		
		//해당 멘티에게 그룹 강퇴 알림 DB 추가
		NotificationDTO notification = new NotificationDTO();
		notification.setReceiverid(mentiId);
		notification.setSendtime(withDrawDatetime);
		notification.setContent(group.getName()+" 그룹에서 강퇴되었습니다.");
		notification.setIsread(false);
		HomeController.dao.getNotificationDAO().insertNotification(notification);
	
		pw.print("<script>window.location=\"groupManage?groupid="+groupid+"\"</script>;");
	%>
</body>
</html>