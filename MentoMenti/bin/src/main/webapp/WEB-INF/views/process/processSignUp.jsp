<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController" %>
<%@ page import="Mento.Menti.Project.dto.*, Mento.Menti.Project.dao.*" %>
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
		String id = request.getParameter("id");	//입력한 아이디
		String pw = request.getParameter("pw");	//입력한 비밀번호
		String name = request.getParameter("name");
		String nickname = request.getParameter("nickname");
		
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String birth = year+"-"+month+"-"+day;
		
		String email1 = request.getParameter("email1");
		String email2 = request.getParameter("email2");
		String email = email1+"@"+email2;
		
		String intro = request.getParameter("intro");
		
		//포맷 : 년도-월-일
		Calendar cal = Calendar.getInstance();
		int todayYear = cal.get(cal.YEAR);
		int todayMonth = cal.get(cal.MONTH)+1;
		int todayDate = cal.get(cal.DATE);
		String joindate = todayYear+"-"+todayMonth+"-"+todayDate;
		
		UserDTO user = new UserDTO(null, null, null, null, null, null, null, false, null);
		user.setId(id);
		user.setPw(pw);
		user.setName(name);
		user.setNickname(nickname);
		user.setBirth(birth);
		user.setEmail(email);
		user.setIntro(intro);
		user.setJoindate(joindate);
		
		//user에 계정 추가
		HomeController.dao.getUserDAO().insertUsers(user);
		
		//notification에 회원가입 축하 알림 추가
		int curHour = cal.get(cal.HOUR_OF_DAY);
		int curMin = cal.get(cal.MINUTE);
		int curSec = cal.get(cal.SECOND);
		DecimalFormat df = new DecimalFormat("00");	//두 자리로 형식 맞춤
		String joinDatetime = joindate + " " + df.format(curHour) + ":" + df.format(curMin) + ":" + df.format(curSec);
		NotificationDTO notification = new NotificationDTO();
		notification.setReceiverid(id);
		notification.setSendtime(joinDatetime);
		notification.setContent("MOCO 회원가입을 축하합니다!");
		notification.setIsread(false);
		HomeController.dao.getNotificationDAO().insertNotification(notification);
		
		//로그인 페이지로 이동
		response.sendRedirect("loginPage");
	    /*
	    @RequestMapping(value="/insert")
	    // select문, insert문 전용 테스트 함수
	    public String insert() throws Exception {
	    	UserDTO insUser = new UserDTO(null, null, null, null, null, null, null, false, null);
	    	insUser.setEmail("a@naver.com");
	     	List<UserDTO> temp = dao.getUserDAO().searchUser(insUser);
	     	for (UserDTO u: temp)
	     		System.out.println(u.getId() + "//" + u.getPw());
	    	return "insert";
	    }
	    */
	    /*  User 리스트중 첫번쨰 user의 데이터를 수정 후 insert
	     *  List<UserDTO> temp = dao.getUserDAO().selectUsers();
	    	UserDTO user = temp.get(0);
	    	user.setId("user4"); 
	    	dao.getUserDAO().insertUsers(user);
	     */
	%>
</body>
</html>