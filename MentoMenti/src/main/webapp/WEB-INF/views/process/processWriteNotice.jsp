<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController" %>
<%@ page import="Mento.Menti.Project.dto.PostDTO, Mento.Menti.Project.dao.PostDAO" %>
<%@ page import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO" %>
<%@ page import="Mento.Menti.Project.dto.GroupmateDTO, Mento.Menti.Project.dao.GroupmateDAO" %>
<%@ page import="Mento.Menti.Project.dto.NotificationDTO, Mento.Menti.Project.dao.NotificationDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MOCO</title>
</head>
<body>
	<%
		String userid = (String)session.getAttribute("userID");	//작성자 아이디
		String title = request.getParameter("title");	//제목
		String content = request.getParameter("content");	//내용
		
		Calendar cal = Calendar.getInstance();
		int year = cal.get(cal.YEAR);
		int month = cal.get(cal.MONTH)+1;
		int date = cal.get(cal.DATE);
		String postdate = year+"-"+month+"-"+date;	//작성일자
		
		PostDTO notice = new PostDTO();
		notice.setUserid(userid);
		notice.setTitle(title);
		notice.setContent(content);
		notice.setPostdate(postdate);
		
		//그룹 Q&A면 groupid 있음
		String groupid = request.getParameter("groupid");
		
		if (groupid == null) { //일반 공지사항
			HomeController.dao.getPostDAO().insertGeneralNotice(notice);
			response.sendRedirect("notice?page=1");	//공지사항 페이지로 이동
		} else {	//그룹 공지사항
			notice.setGroupid(Integer.parseInt(groupid));
			HomeController.dao.getPostDAO().insertGroupNotice(notice);	//DB반영
			
			/*그룹 멘티들에게 공지사항 업로드 알림*/
			
			//현재 시각 구하기
			String todaydate = year+"-"+month+"-"+date;
			int curHour = cal.get(cal.HOUR_OF_DAY);
			int curMin = cal.get(cal.MINUTE);
			int curSec = cal.get(cal.SECOND);
			DecimalFormat df = new DecimalFormat("00");	//두 자리로 형식 맞춤
			String uploadDatetime = todaydate + " " + df.format(curHour) + ":" + df.format(curMin) + ":" + df.format(curSec);
			
			String groupName = HomeController.dao.getGroupDAO().searchGroupByGroupid(Integer.parseInt(groupid)).getName();
			List<GroupmateDTO> mentiList = HomeController.dao.getGroupmateDAO().selectMentiList(Integer.parseInt(groupid));
			for (GroupmateDTO menti: mentiList){
				//알림 DB 추가
				NotificationDTO notification = new NotificationDTO();
				notification.setReceiverid(menti.getId());
				notification.setSendtime(uploadDatetime);
				notification.setContent(groupName+" 그룹에 공지사항이 등록되었습니다.");
				notification.setIsread(false);
				HomeController.dao.getNotificationDAO().insertNotification(notification);
			}
			
			response.sendRedirect("groupnotice?page=1&groupid="+groupid);
		}
	%>
</body>
</html>