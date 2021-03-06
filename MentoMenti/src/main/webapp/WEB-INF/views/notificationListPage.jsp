<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.NotificationDTO, Mento.Menti.Project.dao.NotificationDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupmateDTO, Mento.Menti.Project.dao.GroupmateDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.StringTokenizer" %>
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

<%
	String strPage = request.getParameter("page");
	int curPage;
	if (strPage == null)	//기본값은 1
		curPage = 1;
	else curPage = Integer.parseInt(strPage);
%>

<!-- 알림 목록 페이지 -->

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800">
		<a href="notifications" class="text-gray-800 font-weight-500" style="text-decoration:none;">알림 목록</a>
	</h1>
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
			if (notifications.size() == 0){
		%>
	</tbody>
</table>
	<div style="height:200px; text-align:center; line-height:200px">
		결과가 없습니다.		
	</div>
		<%
			} else {
				//for(NotificationDTO n: notifications) {
				for (int i=(curPage-1)*10; i<(curPage-1)*10+10;i++) {
					if(i==notifications.size()){
						break;
					}
					NotificationDTO n = notifications.get(i);
					HomeController.dao.getNotificationDAO().updateRead(n.getNotificationid());	//읽음으로 DB 반영
		%>
		<tr><td>
			<div style="overflow:hidden;">
				<div style="float:left; width:100px; text-align:center;">
					<%
						if (n.getContent().contains("수업")) {
					%>
					<img src="resources/img/icon_class.png" style="width:80px"/>
					<%
						} else if (n.getContent().contains("답변")) {
					%>
					<img src="resources/img/icon_comment.png" style="width:80px"/>
					<%
						} else if (n.getContent().contains("공지")) {
					%>
					<img src="resources/img/icon_newpost.png" style="width:80px"/>
					<%
						} else if (n.getContent().contains("그룹")) {
					%>
					<img src="resources/img/icon_group.png" style="width:80px"/>
					<%
						} else if (n.getContent().contains("축하")) {
					%>
					<img src="resources/img/icon_congratulations.png" style="width:80px"/>
					<%
						} else {
					%>
					<img src="resources/img/icon_comment.png" style="width:80px"/>
					<%
						}
					%>
				
				</div>
				
				<!-- 그룹 페이지로 이동하는 a태그 추가 -->
				
				<%
					int[] mentiGroupIdList = HomeController.dao.getGroupmateDAO().joinedGroupsId(id);	//가입한 그룹 아이디
					int[] mentoGroupIdList = HomeController.dao.getGroupDAO().searchMentoGroupIdsByUserId(id);	//개설한 그룹 아이디
					
					boolean find = false;
					for (int gi: mentiGroupIdList){
						String groupName = HomeController.dao.getGroupDAO().searchGroupByGroupid(gi).getName();	//가입한 그룹들 이름
						StringTokenizer st = new StringTokenizer(n.getContent(), "[]");
						if (st.nextToken().equals(groupName)){	//그룹 이름을 포함하고 있다면
							find = true;
				%>
				<a href="group?groupid=<%=gi%>">
					<div style="float:left; width:70%; padding:15px; text-align:left;">
						<div style="margin-bottom:10px"><%=n.getContent()%></div>
						<div style="font-size:12px"><%=n.getSendtime()%></div>
					</div>
				</a>
				<%
							break;
						}
					}
					
					for (int gi: mentoGroupIdList){
						String groupName = HomeController.dao.getGroupDAO().searchGroupByGroupid(gi).getName();	//개설한 그룹들 이름
						StringTokenizer st = new StringTokenizer(n.getContent(), "[]");
						if (st.nextToken().equals(groupName)){	//그룹 이름을 포함하고 있다면
							find = true;
				%>
				<a href="group?groupid=<%=gi%>">
					<div style="float:left; width:70%; padding:15px; text-align:left;">
						<div style="margin-bottom:10px"><%=n.getContent()%></div>
						<div style="font-size:12px"><%=n.getSendtime()%></div>
					</div>
				</a>
				<%
							break;
						}
					}
					
					if (find == false){	//그룹 이름 포함 X
				%>
				<div style="float:left; width:70%; padding:15px; text-align:left;">
					<div style="margin-bottom:10px"><%=n.getContent()%></div>
					<div style="font-size:12px"><%=n.getSendtime()%></div>
				</div>
				<%
					}
				%>
				
				<!-- 알림 삭제 버튼 -->
				<div style="float:right;">
					<input type="button" class="btn btn-danger deleteNotification" id="<%=n.getNotificationid()%>"
						value="X" style="font-size:14px; padding:0px 5px">
				</div>
			</div>
		</td></tr>
		<%
				}
		%>
	</tbody>
</table>
		<%
			}
		%>

<!-- 페이지 버튼 -->
<input type="hidden" id="curPage" value="<%=curPage%>"/>
<input type="hidden" id="notificationSize" value="<%=notifications.size()%>"/>

<div class="d-flex align-items-center justify-content-between">
		<nav aria-label="Page navigation example" style="margin: 0 auto;">
  			<ul class="pagination justify-content-center" id="list-body">
    			<!-- 페이징 생성 -->
 			</ul>
		</nav>
</div>

<%@include file="menuPart2.jsp"%>
<script>
	//알림 개수 가져오기
	var postData = document.getElementById("notificationSize").value;
	var curpage = document.getElementById("curPage").value;
	$(document).ready(function () {
		paging(postData,curpage);
		
		$(".deleteNotification").on('click', function(){
		    if (confirm("알림을 삭제하시겠습니까?")) {
		    	location.href = "processDeleteNotification?notificationid="+$(this).attr('id');	//알림 번호 전달
		    }
		});
	});

	function paging(totalData, currentPage){
		
		var dataPerPage = 10; //한 페이지에 보여지는 데이터 수
		var countPage = 5; //한번에 보여지는 페이지 수
		
		//총페이지수
		var totalPage = totalData / dataPerPage;
		if(totalData%dataPerPage>0){
			totalPage++;
		}
		
		//보여지는 페이지번호
		var startPage = Math.floor(((currentPage-1)/countPage))*countPage+1;
		var endPage = startPage + countPage-1;
		if(endPage>totalPage){
			endPage = totalPage;
		}
		const prev = startPage-1;
		const next = endPage+1;
		
		$('#list-body').empty();
		if(startPage > countPage){
			$("#list-body").append("<li class='page-item'><a class='page-link' href='notifications?page="+prev+"'"+" aria-label='Next'><span aria-hidden='true'>&laquo;</span></a></li>");	
		}
		for(var j=startPage ; j<=endPage ; j++){
			if(currentPage==(j)){
				$("#list-body").append("<li class='page-item active'><a class='page-link' href='notifications?page=" + j + "'>" + j + "</a></li>");
			}else if(j>0){
				$("#list-body").append("<li class='page-item'><a class='page-link' href='notifications?page=" + j + "'>" + j + "</a></li>");		
			}
		}
		if(next > 5 && next < totalPage)
		$("#list-body").append("<li class='page-item'><a class='page-link' href='notifications?page="+next+"'"+" aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>")

	} 
</script>