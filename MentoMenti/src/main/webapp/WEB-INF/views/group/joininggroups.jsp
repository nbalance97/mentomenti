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
	text-align:center;
	overflow: hidden;
}

.content1 {
	float: left;
	width: 50%;
	margin-bottom: 50px;
	padding:15px;
}

.content2 {
	float: left;
	width: 50%;
	margin-bottom: 50px;
	padding:15px;
}

@media screen and (max-width:930px){
	.content1{width:100%}
	.content2{width:100%}
}

</style>


<title>MOCO</title>

<link href="resources/css/all.min.css" rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">
<link href="resources/css/component.css" rel="stylesheet" type="text/css">
<link href="resources/css/groupCard.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
</head>

<%@include file="/WEB-INF/views/menuPart1.jsp"%>

<%
	if (id == null){	//로그인 안된 상태면 로그인 페이지로 이동
		response.sendRedirect("loginPage?mode=nidLogin");
	} else {
		//세션에 등록된 아이디를 이용해 사용자 정보 가져오기
		UserDTO findUser = new UserDTO(null, null, null, null, null, null, null, false, null);
		findUser.setId(id);
		UserDTO loginUser = null;
		if (HomeController.dao.getUserDAO().searchUserById(findUser).size() > 0) {
			loginUser = HomeController.dao.getUserDAO().searchUserById(findUser).get(0);
		}
%>


<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4" id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800">가입한 그룹</h1>
</div>
	
<div class="wrapContents">

	<div class="content1">
		<div>
			<h4 class="text1 text-gray-800 font-weight-500">개설한 그룹</h4>
			<img src="resources/img/mento.png"
				style="display: block; width:40%; max-width:200px; position: relative; margin:0 auto">
		</div>
		<%
		List<GroupDTO> mentoGroups = HomeController.dao.getGroupDAO().searchMentoGroupsByUserId(id);
		String myNick = HomeController.dao.getUserDAO().selectNicknameById(id);
		for (GroupDTO mg1 : mentoGroups) {
			int mentiCnt = HomeController.dao.getGroupmateDAO().cntMenti(mg1.getGroupid());
			int maxPerson = mg1.getMaxperson();
		%>
		<div class="col-lg-12" style="margin:20px 0px">
			<div class="card shadow mb-4">
				<a href="group?groupid=<%=mg1.getGroupid()%>" id="sortAction">
				<div class="sortscreen">
					<span style="background:#4e73df;"></span>
					<span style="background:#4e73df;"></span>
					<span style="background:#4e73df;"></span>
					<span id="sortscreen-4th-child" style="background:#4e73df;"></span>
					<div class="card-header py-3">
						<h5 class="m-0 text-primary">
						<span class="font-weight-500"><%=mg1.getName()%></span>
					</div>
					<div class="card-body">
						<span class="font-weight-500" style="color:gray">과목 </span><%=mg1.getCategory()%></p>
						<span class="font-weight-500" style="color:gray">멘토 </span><%=myNick%></p>
						<span class="font-weight-500" style="color:gray">현재 인원 수 </span><%=mentiCnt%>/<%=maxPerson%></p>
					</div>
				</div>
				</a>
			</div>
		</div>
		<%
		}
		%>
	</div>
		
	<!-- 멘티로 참여한 그룹 목록 -->
	<div class="content2">
		<div>
			<h4 class="text1 text-gray-800 font-weight-500">가입한 그룹</h4>
			<img src="resources/img/menti.png"
				style="display: block; width:40%; max-width:200px; position: relative; margin:0 auto">
		</div>
		<%
		List<GroupDTO> mentoGroups2 = HomeController.dao.getGroupDAO().searchJoinGroupsByUserId(id);
		for (GroupDTO mg2 : mentoGroups2) {
			int mentiCnt = HomeController.dao.getGroupmateDAO().cntMenti(mg2.getGroupid());
			int maxPerson = mg2.getMaxperson();
			String mentoNick = HomeController.dao.getUserDAO().selectNicknameById(mg2.getMentoid());
		%>
		<div class="col-lg-12" style="margin:20px 0px">
			<div class="card shadow mb-4">
				<a href="group?groupid=<%=mg2.getGroupid()%>" id="sortAction">
				<div class="sortscreen">
					<span style="background:#4e73df;"></span>
					<span style="background:#4e73df;"></span>
					<span style="background:#4e73df;"></span>
					<span id="sortscreen-4th-child" style="background:#4e73df;"></span>
					<div class="card-header py-3">
						<h5 class="m-0 text-primary">
						<span class="font-weight-500"><%=mg2.getName()%></span>
					</div>
					<div class="card-body">
						<span class="font-weight-500" style="color:gray">과목 </span><%=mg2.getCategory()%></p>
						<span class="font-weight-500" style="color:gray">멘토 </span><%=mentoNick%></p>
						<span class="font-weight-500" style="color:gray">현재 인원 수 </span><%=mentiCnt%>/<%=maxPerson%></p>
					</div>
				</div>
				</a>
			</div>
		</div>
		<%
		}
		%>
	</div>
</div>

<%
	}
%>

<%@include file="/WEB-INF/views/menuPart2.jsp"%>
</html>