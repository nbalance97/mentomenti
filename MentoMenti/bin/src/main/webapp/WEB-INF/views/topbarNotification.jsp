<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.NotificationDTO, Mento.Menti.Project.dao.NotificationDAO"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>

<!-- 메뉴 상단바의 알림 부분만 따로 분리 -->

<!-- Topbar Navbar -->
<ul class="navbar-nav ml-auto">

	<!-- Nav Item - Alerts -->
	<li class="nav-item dropdown no-arrow mx-1">
	<a class="nav-link dropdown-toggle" href="#" id="alertsDropdown"
		role="button" data-toggle="dropdown" aria-haspopup="true"
		aria-expanded="false">
		<i class="fas fa-bell fa-fw"></i>
		
		<!-- 안읽은 알림 개수 -->
		<%
			int notReadCnt = HomeController.dao.getNotificationDAO().countNotRead((String) session.getAttribute("userID"));
			if (notReadCnt != 0) {	//모든 알림을 다 읽었으면 개수 출력 x
		%>
		<span class="badge badge-danger badge-counter">
			<%=notReadCnt%>
		</span>
		<%} %>
	</a>
	
	<!-- 드롭다운 부분 -->
		<div
			class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
			aria-labelledby="alertsDropdown">
			<h4 class="font-weight-300" style="font-size:15px; background: black; border: 1px solid black; padding:10px; color:white;">알림</h4>

			<%
				//최근 알림 (최대 3개) 보여줌
			List<NotificationDTO> curNoti = HomeController.dao.getNotificationDAO().selectCurNotifications((String) session.getAttribute("userID"));
			for (NotificationDTO n : curNoti) {
			%>
			<a class="dropdown-item d-flex align-items-center" href="notifications">
				<div class="mr-3">
					<!-- 아이콘 나중에 바꿀지 고민 -->
					<div class="icon-circle">
										<%
						if (n.getContent().contains("수업")) {
					%>
					<img src="resources/img/icon_class.png" style="width:100%"/>
					<%
						} else if (n.getContent().contains("그룹")) {
					%>
					<img src="resources/img/icon_group.png" style="width:100%"/>
					<%
						} else if (n.getContent().contains("축하")) {
					%>
					<img src="resources/img/icon_congratulations.png" style="width:100%"/>
					<%
						} else {
					%>
					<img src="resources/img/icon_comment.png" style="width:100%"/>
					<%
						}
					%>
					</div>
				</div>
				<div>
					<div class="small text-gray-500"><%=n.getSendtime()%></div>
					<span><%=n.getContent()%></span>
				</div>
			</a>
			<%
				}
			%>
			<a class="dropdown-item text-center small text-gray-500" href="notifications">모든 알림 보기</a>
		</div></li>