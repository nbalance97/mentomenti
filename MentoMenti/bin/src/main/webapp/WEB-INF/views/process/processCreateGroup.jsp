<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController" %>
<%@ page import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO" %>
<%@ page import="Mento.Menti.Project.dto.NotificationDTO, Mento.Menti.Project.dao.NotificationDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MOCO</title>
</head>
<body>
	<%
		//입력 양식에서 가져온 데이터
		String name = request.getParameter("groupName"); //그룹명
		int maxperson = Integer.parseInt(request.getParameter("maxPerson")); //최대 인원수(멘티수)
		String category = request.getParameter("category");	//분류
		if(category.equals("기타")){
			category = request.getParameter("categoryText");
		}
		String intro = request.getParameter("intro");	//소개글
	
		String mentoid = (String)session.getAttribute("userID");	//세션으로부터 멘토 아이디
		
		GroupDTO newGroup = new GroupDTO();
		newGroup.setName(name);
		newGroup.setMentoid(mentoid);
		newGroup.setMaxperson(maxperson);
		newGroup.setCategory(category);
		newGroup.setIntro(intro);
		
		//mmgroup DB 반영
		HomeController.dao.getGroupDAO().insertGroup(newGroup);
		
		
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
		String joinDatetime = todaydate + " " + df.format(curHour) + ":" + df.format(curMin) + ":" + df.format(curSec);
		
		//그룹 개설 완료 알림 DB 추가
		NotificationDTO notification = new NotificationDTO();
		notification.setReceiverid((String)session.getAttribute("userID"));
		notification.setSendtime(joinDatetime);
		notification.setContent(name+" 그룹 개설이 완료되었습니다.");
		notification.setIsread(false);
		HomeController.dao.getNotificationDAO().insertNotification(notification);
		
		response.sendRedirect("joininggroups");	//자신의 그룹 목록 페이지로 이동
	%>
</body>
</html>