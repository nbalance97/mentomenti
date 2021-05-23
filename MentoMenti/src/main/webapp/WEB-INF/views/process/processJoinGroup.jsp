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
		String mentoid = request.getParameter("mentoid");	//가입할 그룹 멘토 아이디
		int groupid = Integer.parseInt(request.getParameter("groupid"));	//가입할 그룹 아이디 (int)
		
		//현재 그룹 멘티 수와 최대 멘티 수
		int mentiCnt = HomeController.dao.getGroupmateDAO().cntMenti(groupid);
		int maxPerson = HomeController.dao.getGroupDAO().searchGroupByGroupid(groupid).getMaxperson();
		
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
		
		else if (mentiCnt >= maxPerson){
			pw.print("<script>alert('그룹 인원이 마감되어 가입할 수 없습니다.');</script>");
			pw.print("<script>window.location=\"openedGroups\"</script>");
		}
		
		else { //그룹 가입 진행, DB insert
			HomeController.dao.getGroupmateDAO().insertGroupmate(groupmate);
			GroupDTO group = HomeController.dao.getGroupDAO().searchGroupByGroupid(groupid);	//가입한 그룹 객체
		
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
			
			//그룹 가입 완료 알림 DB 추가
			NotificationDTO notification = new NotificationDTO();
			notification.setReceiverid((String)session.getAttribute("userID"));
			notification.setSendtime(joinDatetime);
			notification.setContent("["+group.getName()+"] 그룹에 가입 완료되었습니다.");
			notification.setIsread(false);
			HomeController.dao.getNotificationDAO().insertNotification(notification);
		
			pw.println("<script>alert('그룹에 가입되었습니다!');</script>");
			pw.print("<script>window.location=\"joininggroups\"</script>;");
		}
	%>
</body>
</html>