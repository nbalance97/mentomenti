<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page import="java.util.List"%>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<style>
.text1 {
	position: relative;
	margin-bottom:40px;
}

.wrapContents {
	width:100%;
	overflow: hidden;
	text-align:center;
}

.content1 {
	float: left;
	width: 50%;
	margin-bottom: 50px;
}

.content2 {
	float: left;
	width: 50%;
	margin-bottom: 50px;
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
	if (id == null){	//로그인 안된 상태면 로그인 페이지로 이동
		response.sendRedirect("loginPage?mode=nidLogin");
	} else {
%>


<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4" id="pageHeading">
</div>
	
<div class="wrapContents">

	<!-- 자신이 멘토인 그룹 목록 -->
	<div class="content1">
		<h4 class="text1 text-gray-800 font-weight-700">Mento Groups</h4>
		<img src="resources/img/mento.png"
			style="display: block; height: 200px; position: relative; margin:0 auto">

		<%
			//세션에 등록된 아이디를 이용해 사용자 정보 가져오기
		UserDTO findUser = new UserDTO(null, null, null, null, null, null, null, false, null);
		findUser.setId(id);
		UserDTO loginUser = null;
		if (HomeController.dao.getUserDAO().searchUserById(findUser).size() > 0) {
			loginUser = HomeController.dao.getUserDAO().searchUserById(findUser).get(0);
		}
		%>

		<table class="table table-bordered dataTable" id="dataTable"  cellspacing="0" role="grid"
			aria-describedby="dataTable_info"
			style="width:90%; background: white; position: relative; text-align: center; margin-top:30px">

			<thead>
				<tr role="row">
					<th tabindex="0" rowspan="1" colspan="1" style="width: 50%">그룹이름</th>
					<th tabindex="0" rowspan="1" colspan="1" style="width: 50%;">멘티 수</th>

				</tr>
			</thead>
			<thead>
				<%
					List<GroupDTO> mentoGroups = HomeController.dao.getGroupDAO().searchMentoGroupsByUserId(id);
				for (GroupDTO mg1 : mentoGroups) {
					//현재 멘티 수와 최대 멘티 수 (정원)
					int mentiCnt = HomeController.dao.getGroupmateDAO().cntMenti(mg1.getGroupid());
					int maxPerson = mg1.getMaxperson();
				%>
				<tr style="width: 200px">
					<td><a href="group?groupid=<%=mg1.getGroupid()%>" style="text-decoration: none;"><%=mg1.getName()%></a><br></td>
					<td><%=mentiCnt%> / <%=maxPerson%></td>
				</tr>
				<%
					}
				%>


			</tbody>

		</table>
	</div>


	<!-- 멘티로 참여한 그룹 목록 -->
	<div class="content2">
		<h4 class="text1 text-gray-800 font-weight-700">Menti Groups</h4>
		<img src="resources/img/menti.png"
			style="display: block; height: 200px; position: relative; margin:0 auto">

		<table class="table table-bordered dataTable" id="dataTable" cellspacing="0" role="grid"
			aria-describedby="dataTable_info"
			style="width:90%; background: white; position: relative; text-align: center; margin-top:30px">

			<thead>
				<tr role="row">
					<th tabindex="0" rowspan="1" colspan="1" style="width: 50%">그룹 이름</th>
					<th tabindex="0" rowspan="1" colspan="1" style="width: 50%;">멘토</th>
				</tr>
			</thead>


			<tbody>


				<%
					List<GroupDTO> mentoGroups2 = HomeController.dao.getGroupDAO().searchJoinGroupsByUserId(id);
					for (GroupDTO mg2 : mentoGroups2) {
						String mentoNick = HomeController.dao.getUserDAO().selectNicknameById(mg2.getMentoid());
				%>
				<tr style="width: 200px">
					<td><a href="group?groupid=<%=mg2.getGroupid()%>" style="text-decoration: none;"><%=mg2.getName()%></a><br></td>
					<td><%=mentoNick%></td>
				</tr>
				<%
					}
				%>

			</tbody>

		</table>
	</div>
</div>

<%
	}
%>

<%@include file="/WEB-INF/views/menuPart2.jsp"%>
</html>