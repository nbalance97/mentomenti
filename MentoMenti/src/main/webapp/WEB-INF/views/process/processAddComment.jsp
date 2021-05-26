<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.PostDTO, Mento.Menti.Project.dao.PostDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.CommentDTO, Mento.Menti.Project.dao.CommentDAO"%>
<%@ page import="Mento.Menti.Project.dto.NotificationDTO, Mento.Menti.Project.dao.NotificationDAO" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MOCO</title>
</head>
<body>
	<%
		String commentWriterId = (String) session.getAttribute("userID"); //작성자 id

		if (commentWriterId == null) {
			response.sendRedirect("loginPage?mode=nidLogin");
		} else {
	
			int postid = Integer.parseInt(request.getParameter("postid")); //게시물 번호
			PostDTO post = HomeController.dao.getPostDAO().searchByPostId(postid).get(0);
			String content = request.getParameter("comment"); //댓글 내용
			String postWriterId = post.getUserid();	//게시물 작성자 아이디
	
			Calendar cal = Calendar.getInstance();
			int todayYear = cal.get(cal.YEAR);
			int todayMonth = cal.get(cal.MONTH) + 1;
			int todayDate = cal.get(cal.DATE);
			String commentdate = todayYear + "-" + todayMonth + "-" + todayDate;
	
			CommentDTO newComment = new CommentDTO();
			newComment.setPostid(postid);
			newComment.setWriterid(commentWriterId);
			newComment.setContent(content);
			newComment.setCommentdate(commentdate);
	
			HomeController.dao.getCommentDAO().insertComment(newComment); //DB 반영 완료
			
			int groupid = HomeController.dao.getPostDAO().searchByPostId(postid).get(0).getGroupid();	//그룹 아이디
			
			if (HomeController.dao.getPostDAO().isNotice(postid)) { //공지
				if (groupid > 0)	//그룹 내 공지
					response.sendRedirect("groupNoticeContent?postid=" + postid);
				else response.sendRedirect("noticeContent?postid=" + postid);
			}
			else { //게시판
				
				//자신이 올린 그룹 Q&A에 다른 사람이 댓글을 달았을 때
				//Q&A 작성자에게 답변 추가됨을 알림
				if (groupid > 0 && !postWriterId.equals(commentWriterId)) {
					
					//현재 시각 구하기
					String todaydate = todayYear+"-"+todayMonth+"-"+todayDate;
					int curHour = cal.get(cal.HOUR_OF_DAY);
					int curMin = cal.get(cal.MINUTE);
					int curSec = cal.get(cal.SECOND);
					DecimalFormat df = new DecimalFormat("00");	//두 자리로 형식 맞춤
					String addDatetime = todaydate + " " + df.format(curHour) + ":" + df.format(curMin) + ":" + df.format(curSec);
					//그룹 이름 찾기
					String groupName = HomeController.dao.getGroupDAO().searchGroupByGroupid(groupid).getName();
					
					//알림 DB 추가
					NotificationDTO notification = new NotificationDTO();
					notification.setReceiverid(post.getUserid());	//Q&A 작성자
					notification.setSendtime(addDatetime);
					notification.setContent("["+groupName+"] 작성한 Q&A에 답변이 등록되었습니다.");
					notification.setIsread(false);
					HomeController.dao.getNotificationDAO().insertNotification(notification);
					
					response.sendRedirect("groupPostContent?postid=" + postid);
				}
				else response.sendRedirect("postContent?postid=" + postid);
			}
		}
	%>
</body>
</html>