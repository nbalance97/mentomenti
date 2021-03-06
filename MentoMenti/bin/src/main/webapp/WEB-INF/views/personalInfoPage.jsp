<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>
<%@ page import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
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
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>

</head>

<%@include file="menuPart1.jsp"%>


<%
	if (id == null){	//로그인 안된 상태면 로그인 페이지로 이동
		response.sendRedirect("loginPage?mode=nidLogin");
	} else {
%>

<!-- 마이페이지 중 회원 정보 확인 페이지 -->

<div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800">회원 정보 확인</h1>
</div>

<div style="text-align: center">



	<!-- 프로필 이미지 -->
	<%
	
	File pngImg = new File("src/main/resources/static/img/user/"+id+".png");
	File jpgImg = new File("src/main/resources/static/img/user/"+id+".jpg");
	
	if (pngImg.exists()) {
	%>
		<div class="profileImg rounded-circle"
		style="width: 200px; height:200px; margin:0 auto; margin-bottom: 30px;
		background-image:url('resources/img/user/<%=id%>.png')"></div>
	<%
	} else if (jpgImg.exists()){
	%>
		<div class="profileImg rounded-circle"
		style="width: 200px; height:200px; margin:0 auto; margin-bottom: 30px;
		background-image:url('resources/img/user/<%=id%>.jpg')"></div>
	<%
	} else {	//기본 이미지
	%>
		<div class="profileImg rounded-circle"
		style="width: 200px; height:200px; margin:0 auto; margin-bottom: 30px;
		background-image:url('resources/img/user/user.png')"></div>
	<%
		}
	%>
	
	

	<%
		//세션에 등록된 아이디를 이용해 사용자 정보 가져오기
		UserDTO findUser = new UserDTO(null, null, null, null, null, null, null, false, null);
		findUser.setId(id);
		UserDTO loginUser = null;
		if (HomeController.dao.getUserDAO().searchUserById(findUser).size()>0){
			loginUser = HomeController.dao.getUserDAO().searchUserById(findUser).get(0);
		}
	%>

	<table class="table" style="width: 60%; margin: 0 auto;">
		<tr>
			<td style="width: 150px">이름</td>
			<td><%=loginUser.getName() %></td>
		</tr>
		<tr>
			<td>아이디</td>
			<td><%=loginUser.getId() %></td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td><%=loginUser.getNickname() %></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><%=loginUser.getEmail() %></td>
		</tr>
		<tr>
			<td>생일</td>
			<td><%=loginUser.getBirth() %></td>
		</tr>
		<tr>
			<td>소개글</td>
			<td><%=loginUser.getIntro() %></td>
		</tr>
		<tr>
			<td>가입 일자</td>
			<td><%=loginUser.getJoindate() %></td>
		</tr>
		
		<tr>
			<td>개설한 그룹</td>
			<!-- 그룹 이름 클릭하면 해당 그룹 페이지로 이동할 예정 -->
			<td>
			<%
			List<GroupDTO> mentoGroups = HomeController.dao.getGroupDAO().searchMentoGroupsByUserId(id);
			for(GroupDTO mg: mentoGroups){
			%>
				<a href="group?groupid=<%=mg.getGroupid()%>" style="text-decoration: none;"><%=mg.getName()%></a><br>
			<%
				}
			%>
			</td>
		</tr>
		<tr>
		
		
		<tr>
			<td>가입한 그룹</td>
			<!-- 그룹 이름 클릭하면 해당 그룹 페이지로 이동할 예정 -->
			<td>
			<%
			List<GroupDTO> joinGroups = HomeController.dao.getGroupDAO().searchJoinGroupsByUserId(id);
			for(GroupDTO jg: joinGroups){
			%>
				<a href="group?groupid=<%=jg.getGroupid()%>" style="text-decoration: none;"><%=jg.getName()%></a><br>
			<%
				}
			%>
			</td>
		</tr>
		<tr>
			<td style="text-align: left;"><a href="javascript:void(0);" onclick="withdrawUser('<%=loginUser.getId()%>')" class="btn btn-danger">회원탈퇴</a></td>
			<td style="text-align: right;"><a href="personalInfoChange" class="btn btn-primary">수정</a></td>
		</tr>
	</table>
</div>

<%
	}
%>
<script>
	function withdrawUser(userid){
		if (confirm("정말 탈퇴하시겠습니까?")){
			location.href="processDeleteUser?userid="+userid;
		}
	}
</script>
<%@include file="menuPart2.jsp"%>