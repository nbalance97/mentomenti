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
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">
<link href="resources/css/imgSlider.css" rel="stylesheet">

</head>

<!-- 스크롤 액션 -->
<script type="text/javascript">
function isElementUnderBottom(elem, triggerDiff) {
	  const { top } = elem.getBoundingClientRect();
	  const { innerHeight } = window;
	  return top > innerHeight + (triggerDiff || 0);
	}

	function handleScroll() {
	  const elems = document.querySelectorAll('.up-on-scroll');
	  elems.forEach(elem => {
	    if (isElementUnderBottom(elem, -20)) {
	      elem.style.opacity = "0";
	      elem.style.transform = 'translateY(150px)';
	    } else {
	      elem.style.opacity = "1";
	      elem.style.transform = 'translateY(0px)';
	    }
	  })
	}

	window.addEventListener('scroll', handleScroll);
</script>

<style>
	.list{
		width:100%;
	}

	.list .up-on-scroll{
		transition: transform 1s, opacity 1s;
	}
	
	.up-on-scroll{
		font-size:1.2em;
		text-align:center;
		margin:120px 0px;
	}
	
	div.container{
		overflow:hidden;
	}
	
	div.item{
		float:left;
		width:50%;
		padding:20px;
	}
	
	a, a:hover{
		text-decoration:none;
		color:gray;
	}
	
	.seeMore{
		font-size:0.6em;
	}
</style>

<%@include file="menuPart1.jsp"%>

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4" style="margin-top:50px">
</div>

<!-- 이미지 슬라이드 -->
<div class="slideSection" style="margin-bottom:100px;">
	<input type="radio" name="slide" id="slide01" checked>
	<input type="radio" name="slide" id="slide02">
	<input type="radio" name="slide" id="slide03">
	<div class="slidewrap">
		<ul class="slidelist" style="margin-bottom:0">
			<!-- 슬라이드 영역 -->
			<li class="slideitem">
				<a>
					<img src="resources/img/mainimg1_2.png">
				</a>
			</li>
			<li class="slideitem">
				<a>
					<img src="resources/img/programmer_img.jpg">
				</a>
			</li>
			<li class="slideitem">
				<a>
					<img src="resources/img/programmer_img2.jpg">
				</a>
			</li>
		</ul>
		
		<!-- 페이징 -->
		<ul class="slide-pagelist">
			<li><label for="slide01"></label></li>
			<li><label for="slide02"></label></li>
			<li><label for="slide03"></label></li>
		</ul>
	</div>
</div>



<!-- 사이트 설명 -->
<div class="list">
	<div class="up-on-scroll" id="site_intro1">
		<h3 class="font-weight-700" style="margin:50px">Welcome to MOCO!</h3>
		<p>누구나 멘토가 될 수 있고</p>
		<p>누구나 멘티가 될 수 있는</p>
		<p>모두의 코딩 교실,</p>
		<p><b class="font-weight-500">모코(MOCO)</b>에 오신 것을 환영합니다!</p>
	</div>
	
	<div class="up-on-scroll" id="site_intro2">
		<p>개설된 스터디 그룹 목록을 확인해보세요</p>
		<p>자유게시판에서 다른 사용자들과 소통해보세요</p>
		<p>그룹 가입 신청을 하세요</p>
		<p>가입된 그룹 페이지에서 수업에 참여할 수 있습니다</p>
		<p>...</p>
		<p>약간 이런 식으로 사이트 튜토리얼도 나쁘지 않을듯</p>
	</div>
	
	
	<div class="up-on-scroll">
	
		<!-- 가장 최근 공지사항 5개 -->
		<div class="item">
			<p class="font-weight-500"><b>공지사항</b></p>
			<table class="table table-bordered dataTable" id="dataTable" style="width: 100%; background: white; text-align: center;">
				<thead>
					<tr>
						<th>제목</th>
						<th>작성일자</th>
					</tr>
				</thead>
				
				<tbody>
					<%
						List<PostDTO> curNotices = HomeController.dao.getPostDAO().curGeneralNotices(5);
						for(PostDTO cn: curNotices){
					%>
					<tr>
						<td><a href="noticeContent?postid=<%=cn.getPostid()%>"><%=cn.getTitle()%></a></td>
						<td><%=cn.getPostdate() %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<div style="text-align:right"><p class="seeMore"><a href="notice">더보기>></a></p></div>
		</div>
		
		
		<!-- 가장 최근 자유게시판 글 5개 -->
		<div class="item">
			<p class="font-weight-500"><b>자유게시판</b></p>
			<table class="table table-bordered dataTable" id="dataTable" style="width: 100%; background: white; text-align: center;">
				<thead>
					<tr>
						<th>제목</th>
						<th>작성일자</th>
					</tr>
				</thead>
				
				<tbody>
					<%
						List<PostDTO> curPosts = HomeController.dao.getPostDAO().curGeneralPosts(5);
						for(PostDTO cp: curPosts){
					%>
					<tr>
						<td><a href="postContent?postid=<%=cp.getPostid()%>"><%=cp.getTitle()%></a></td>
						<td><%=cp.getPostdate() %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<div style="text-align:right"><p class="seeMore"><a href="freeBoard">더보기>></a></p></div>
		</div>
	</div>
</div>

<%@include file="menuPart2.jsp"%>