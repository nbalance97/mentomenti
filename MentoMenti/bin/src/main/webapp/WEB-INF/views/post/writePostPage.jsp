<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>
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


<script type="text/javascript">
	function chkForm() {
		var form = document.writePostForm;
		var title = document.getElementById("title_text").value; //제목
		var content = document.getElementById("content_text").value; //내용

		if (title.length < 6 || title.length>30) {
			alert("제목은 6~30글자 사이로 입력해주세요");
			return;
		}

		if (content.length < 10) {
			alert("내용은 10글자 이상 입력해주세요");
			return;
		}

		form.submit();
	}
</script>

<%@include file="/WEB-INF/views/menuPart1.jsp"%>

<%
	if (id == null) { //로그인 안된 상태면 로그인 페이지로 이동
	response.sendRedirect("loginPage?mode=nidLogin");
} else {
	String strGroupid = request.getParameter("groupid");
%>

<!-- 
<style>
form {
	margin-top: 100px;
}
</style>
-->

<div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<!-- 여기에 margin-top 포함되어있음 -->
	<%
		if (strGroupid == null) { //자유게시판
	%>
	<h1 class="h3 mb-0 text-gray-800">게시물 작성</h1>
	<%
		} else { //그룹 Q&A
	%>
	<h1 class="h3 mb-0 text-gray-800">Q&A 작성</h1>
	<%
		}
	%>
</div>

<%
	if (strGroupid == null) { //자유게시판
%>
<form action="processWritePost" name="writePostForm">
	<div class="form-group">
		<label for="title_text">제목</label> <input type="text"
			class="form-control" id="title_text" name="title">
	</div>

	<div class="form-group">
		<label for="content_text">내용</label>
		<textarea class="form-control" id="content_text" name="content"
			rows="10"></textarea>
	</div>

	<div style="text-align: center;">
		<button type="button" class="btn btn-info" onclick="chkForm()">등록하기</button>
		<a href="freeBoard?page=1"><button type="button"
				class="btn btn-secondary">목록으로</button></a>
	</div>
</form>
<%
	} else { //그룹 Q&A
int groupid = Integer.parseInt(strGroupid);
%>
<form action="processWritePost" name="writePostForm">
	<div class="form-group">
		<label for="title_text">제목</label> <input type="text"
			class="form-control" id="title_text" name="title">
	</div>

	<div class="form-group">
		<label for="content_text">내용</label>
		<textarea class="form-control" id="content_text" name="content"
			rows="10"></textarea>
	</div>
	
	<!-- 그룹 아이디 넘기기 -->
	<input type="text" style="display:none" name="groupid" value=<%=groupid%> style="display:none;">

	<div style="text-align: center;">
		<button type="button" class="btn btn-info" onclick="chkForm()">등록하기</button>
		<a href="freeBoard?page=1"><button type="button" class="btn btn-secondary">목록으로</button></a>
	</div>
</form>
<%
	}
%>

<%
	}
%>

<%@include file="/WEB-INF/views/menuPart2.jsp"%>