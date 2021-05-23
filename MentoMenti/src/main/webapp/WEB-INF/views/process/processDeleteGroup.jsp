<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupmateDTO, Mento.Menti.Project.dao.GroupmateDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.NotificationDTO, Mento.Menti.Project.dao.NotificationDAO"%>
<%@ page import="java.util.List"%>
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
	
		int groupid = Integer.parseInt(request.getParameter("groupid"));
		GroupDTO group = HomeController.dao.getGroupDAO().searchGroupByGroupid(groupid);
		String mentoid = group.getMentoid();	//멘토 아이디
		String loginid = (String)session.getAttribute("userID");	//로그인 아이디
		
		//로그인 사용자가 관리자인지 확인
		UserDTO user = new UserDTO();
		user.setId(loginid);
		boolean isAdmin = HomeController.dao.getUserDAO().searchUserById(user).get(0).is_admin();
		String from = request.getParameter("from");
		
		String groupName = group.getName();
		
		if (mentoid.equals(loginid) || isAdmin){	//멘토 아이디 = 로그인한 아이디인 경우 or 관리자인 경우에만 해체 진행
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
			String datetime = todaydate + " " + df.format(curHour) + ":" + df.format(curMin) + ":" + df.format(curSec);
			
			//그룹 해체 알림 DB 추가
			NotificationDTO notification = new NotificationDTO();
			notification.setReceiverid(mentoid);
			notification.setSendtime(datetime);
			notification.setContent("["+groupName+"] 그룹이 해체되었습니다.");
			notification.setIsread(false);
			HomeController.dao.getNotificationDAO().insertNotification(notification);	//멘토 알림
			
			List<GroupmateDTO> groupmates = HomeController.dao.getGroupmateDAO().selectMentiList(groupid);	//멘티들
			for (GroupmateDTO gm: groupmates){
				NotificationDTO n = new NotificationDTO();
				n.setReceiverid(gm.getId());
				n.setSendtime(datetime);
				n.setContent("["+groupName+"] 그룹이 해체되었습니다.");
				n.setIsread(false);
				HomeController.dao.getNotificationDAO().insertNotification(n);	//멘티 알림
			}
				
			HomeController.dao.getGroupDAO().deleteGroup(groupid);	//그룹 해체 진행
			
			if (from == null) { // 그룹 멘토
				pw.print("<script>alert('그룹이 해체되었습니다.');</script>");
				pw.print("<script>window.location=\"joininggroups\"</script>"); //자신의 그룹 목록 페이지로 이동
			} else {	//관리자
				pw.print("<script>window.location=\"adminGroupPage\"</script>");
			}
		} else { //접근 권한이 없는 사람
			pw.print("<script>window.location=\"rejectedAccess?type=notMento\"</script>;");
		}
	%>
</body>
</html>