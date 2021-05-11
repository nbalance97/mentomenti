<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.PostDTO, Mento.Menti.Project.dao.PostDAO"%>
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


<script type="text/javascript">
	function chkForm(){
		var form = document.writePostForm;
		var title = document.getElementById("title_text").value; //제목
		var content = document.getElementById("content_text").value; //내용
		
		if (title.length < 6) {
			alert("제목은 6글자 이상 입력해주세요");
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
	int postid = Integer.parseInt(request.getParameter("postid"));
	List<PostDTO> findPost = HomeController.dao.getPostDAO().searchByPostId(postid);
	String title = findPost.get(0).getTitle(); //기존에 작성한 제목
	String content = findPost.get(0).getContent(); //기존에 작성한 내용
	
	String backToList = "";
	if (HomeController.dao.getPostDAO().isNotice(postid)){
		backToList = "notice";
	} else {
		backToList = "freeBoard";
	}
	

	if (id == null) { //로그인 안된 상태면 로그인 페이지로 이동
	response.sendRedirect("loginPage?mode=nidLogin");
}
	else {
%>

<div class="d-sm-flex align-items-center justify-content-between mb-4" id="pageHeading"> <!-- 여기에 margin-top 포함되어있음 -->
</div>

<form action="processModifyPost" name="writePostForm" method="post">
	<input type="text" name="postid" value="<%=postid%>" style="display:none;">

	<div class="form-group">
		<label for="title_text">제목</label>
		<input type="text" class="form-control" id="title_text" name="title" value="<%=title%>"></input>
	</div>

	<div class="form-group">
		<label for="content_text">내용</label>
		<textarea class="form-control" id="content_text" name="content" rows="10"><%=content%></textarea>
	</div>
	
	<div style="text-align:center;">
		<button type="button" class="btn btn-info" onclick="chkForm()">수정 완료</button>
		<a href=<%=backToList%>><button type="button" class="btn btn-secondary">목록으로</button></a>
	</div>
</form>

<%
	}
%>

<%@include file="/WEB-INF/views/menuPart2.jsp"%>