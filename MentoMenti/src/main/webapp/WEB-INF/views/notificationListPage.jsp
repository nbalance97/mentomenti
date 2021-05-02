<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.NotificationDTO, Mento.Menti.Project.dao.NotificationDAO"%>
<%@ page import="java.util.List"%>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>MOCO</title>

<link href="resources/css/all.min.css" rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<%@include file="menuPart1.jsp"%>

<!-- 알림 목록 페이지 -->

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800">알림 목록</h1>
</div>

<!-- 알림 목록 테이블 -->
<table class="table table-bordered dataTable" id="dataTable"
	width="100%" cellspacing="0" role="grid"
	aria-describedby="dataTable_info"
	style="width: 100%; background: white; text-align: center;">
	<tbody>
	
		<!-- 모바일, 태블릿 반응형 웹 수정 필요 -->
		
		<%
			//세션 아이디에 따라 알림 가져오기
			List<NotificationDTO> notifications = HomeController.dao.getNotificationDAO().selectNotifications(id);
			for(NotificationDTO n: notifications) {
				n.setIsread(true);	//읽음으로 DB 반영
		%>
		<tr><td>
			<div style="overflow:hidden;">
				<div style="float:left; width:100px; text-align:center;">
				
				
					<img src="resources/img/icon_comment.png" style="width:80px"/>
				
				
				</div>
				<div style="float:left; width:85%; padding:15px; text-align:left;">
					<div style="margin-bottom:10px"><%=n.getContent()%></div>
					<div style="font-size:12px"><%=n.getSendtime()%></div>
				</div>
			</div>
		</td></tr>
		<%
			}
		%>
		
	</tbody>
</table>

<%@include file="menuPart2.jsp"%>