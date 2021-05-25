<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupmateDTO, Mento.Menti.Project.dao.GroupmateDAO"%>
<%@ page import="java.util.List"%>
<head>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<style>
/*수평 정렬*/
.wrapContents{
	overflow:hidden;
}

.content1{
	float:left;
	width:50%;
	margin-bottom:100px;
}

.content2{
	float:right;
	width:50%;
	margin-bottom:50px;
}

.text1{
	font-weight:300;
	margin-bottom:30px;
}

</style>


<title>MOCO</title>

<link href="resources/css/all.min.css" rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">
<link href="resources/css/component.css" rel="stylesheet"
	type="text/css">
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>

</head>

<%@include file="/WEB-INF/views/menuPart1.jsp"%>

<%
	int groupid = Integer.parseInt(request.getParameter("groupid"));
	GroupDTO group = HomeController.dao.getGroupDAO().searchGroupByGroupid(groupid);
	List<GroupmateDTO> groupmateList = HomeController.dao.getGroupmateDAO().selectMentiList(group.getGroupid());	//그룹에 참여한 멘티 목록
	
	//멘토만 그룹 관리 페이지 접근 가능
	boolean isMento = false;
	if (group.getMentoid().equals((String)session.getAttribute("userID")))	//개설한 그룹인 경우
		isMento = true;
	if (!isMento)	//해당 그룹의 멘토가 아니라면 접근 거부
		response.sendRedirect("rejectedAccess?type=notMento");
%>


<!-- Page Heading -->
<div id="pageHeading" style="margin-bottom:20px">
	<p><a href="main" style="text-decoration : none; color:gray">Home</a>
	> <a href="joininggroups" style="text-decoration : none; color:gray">가입한 그룹</a>
	> <a href="group?groupid=<%=groupid%>" style="text-decoration : none; color:gray"><%=group.getName()%></a></p>
</div>

<div class="d-sm-flex align-items-center justify-content-between mb-4" style="overflow:hidden;">
	<h1 class="h3 mb-0 text-gray-800" style="float:left">그룹 관리</h1>
</div>
<hr>

<div style="margin-bottom:50px">
<h5>멤버 관리</h5>
		<table class="table table-bordered" id="dataTable"
			cellspacing="0" role="grid" aria-describedby="dataTable_info"
			style="width: 80%; background: white; text-align: center; margin:0 auto;">
			<thead>
				<tr role="row">
					<th tabindex="0" rowspan="1" colspan="1" style="width:30%">닉네임</th>
					<th tabindex="0" rowspan="1" colspan="1">소개글</th>
					<th tabindex="0" rowspan="1" colspan="1" style="width:10%">강퇴</th>
				</tr>
			</thead>
			<tbody>
				<!-- 멘티 목록 -->
				<%
					if (groupmateList.size()==0) {	//멘티가 없으면
				%>
					<td colspan="3" style="height:100px; text-align:center; line-height:100px">멘티가 없습니다.</td>
				<%
					} else {
						for(GroupmateDTO gl: groupmateList) {
							String mentiId = gl.getId();
							UserDTO user = new UserDTO();
							user.setId(mentiId);
							UserDTO menti = HomeController.dao.getUserDAO().searchUserById(user).get(0);
				%>
				<tr>
					<td><%=menti.getNickname()%></td>
					<td><%=menti.getIntro() %></td>
					<td><input type="button" class="btn btn-danger" onclick="withdraw('<%=menti.getNickname()%>')"
						value="X" style="padding:2px 10px"></td>
				</tr>
				<%
						}
					}
				%>
			</tbody>
		</table>
</div>

<div style="margin-bottom:50px">
	<h5>그룹 정보 수정</h5>
	<div style="overflow:hidden; margin-right:10%">
		<form action="processModifyGroup" method="post" name="modifyGroupForm">
			<table class="table" style="float:left; text-align:center;">
				<!-- 
				<tr>
					<td width="30%">그룹 이름</td>
					<td><input type="text" style="width:100%; border:1px solid #e3e6f0; outline:none;"
						value="<%=group.getName()%>" id="modifyName"></td>
				<tr>
				-->
				<tr>
					<td width="30%">소개글</td>
					<td><textarea style="width:100%; resize:none; border:1px solid #e3e6f0; outline:none; height:80px"
						id="intro_text" name="intro"><%=group.getIntro()%></textarea></td>
				</tr>
			</table>
			<input type="text" name="groupId" value="<%=groupid%>" style="display:none;">
			<input type="button" class="btn btn-primary modifyGroup" value="수정하기" style="float:right" onclick="modifyInfo()">
		</form>
	</div>
</div>

<div style="margin-bottom:50px">
	<h5>그룹 해체</h5>
	<div style="overflow:hidden; margin-right:10%">
		<span style="float:left; margin-bottom:20px">운영중인 그룹을 해체하면 되돌릴 수 없습니다.</span>
		<input type="button" class="btn btn-danger deleteGroup" value="그룹 해체하기" style="float:right">
	</div>
</div>

<script type="text/javascript">
	function withdraw(menti){	//멘티 강퇴
		if (confirm("멘티 "+menti+"님을 그룹에서 탈퇴시키겠습니까?")){
			location.href="processWithdraw?groupid="+<%=group.getGroupid()%>+"&mentiNick="+menti;
		}
	}
	
	function modifyInfo(){	//그룹 정보 수정
		var form = document.modifyGroupForm;
		var intro = document.getElementById("intro_text").value;
		
		//소개글 길이 검사
		if(intro.length>100){
			alert("그룹 소개글은 100글자 이하로 작성해주세요");
			return;
		}
		
		//소개글 엔터 포함 여부 검사
		if(intro.indexOf('\n') != -1){
			alert("소개글에 엔터를 입력할 수 없습니다.");
			return;
		}
	
		if (confirm("그룹 정보를 수정하시겠습니까?")){
			form.submit();
		}
	}

	$(document).ready(function(){
		$(".deleteGroup").on('click', function(){	//그룹 해체
		    if (confirm("그룹을 해체하시겠습니까?")) {
		    	location.href = "processDeleteGroup?groupid="+<%=group.getGroupid()%>;
		    }
		});
	});
</script>

<%@include file="/WEB-INF/views/menuPart2.jsp"%>
</html>