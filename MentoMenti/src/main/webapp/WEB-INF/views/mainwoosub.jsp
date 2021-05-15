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
<link href="resources/css/newSlider.css" rel="stylesheet">

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
		margin:100px 0px;
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
		font-size:0.7em;
	}
	
	/*메인 화면 이중 스크롤바 해결*/
	#content-wrapper{
		overflow:hidden;
	}
</style>

<%@include file="menuPart1.jsp"%>

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4" style="margin-top:50px">
</div>

<!-- 이미지 슬라이드 -->

<div class="slidebox">
	<input type="radio" name="slide" id="slide01" checked>
	<input type="radio" name="slide" id="slide02">
	<input type="radio" name="slide" id="slide03">
	<input type="radio" name="slide" id="slide04">
	<ul class="slidelist">
		<!-- 그림크기 resources/img/mainimg1_2.png크기랑 같게 ~> 안그러면 밀리는느낌잇 -->
		<li class="slideitem">
			<div>
				<label for="slide04" class="left"></label>
				<label for="slide02" class="right"></label>
				<a><img src="resources/img/mainimg1_2.png"></a>
			</div>
		</li>
		<li class="slideitem">
			<div>
				<label for="slide01" class="left"></label>
				<label for="slide03" class="right"></label>
				<a><img src="resources/img/2번슬라이드.png"></a>
			</div>
		</li>
		<li class="slideitem">
			<div>
				<label for="slide02" class="left"></label>
				<label for="slide04" class="right"></label>
				<a><img src="resources/img/3번슬라이드.png"></a>
			</div>
		</li>
		<li class="slideitem">
			<div>
				<label for="slide03" class="left"></label>
				<label for="slide01" class="right"></label>
				<a><img src="resources/img/4번슬라이드.png"></a>
			</div>
		</li>		
	</ul>
	<ul class="slide-pagelist">
		<li><label for="slide01"></label></li>
		<li><label for="slide02"></label></li>
		<li><label for="slide03"></label></li>
		<li><label for="slide04"></label></li>
	</ul>
</div>

<!-- 사이트 설명 -->
<div class="list">
	<div class="up-on-scroll" id="site_intro1">
		<h3 class="font-weight-700" style="margin:30px">Welcome to MOCO!</h3>
		<p>누구나 멘토가 될 수 있고</p>
		<p>누구나 멘티가 될 수 있는</p>
		<p>모두의 코딩 교실,</p>
		<p><b class="font-weight-500">모코(MOCO)</b>에 오신 것을 환영합니다!</p>
	</div>
	
	<div class="up-on-scroll" id="site_intro2">
		<p>개설된 스터디 그룹 목록을 확인해보세요</p>
		<p>가입된 그룹 페이지에서 수업에 참여할 수 있습니다</p>
		<p>자유게시판에서 다른 사용자들과 소통해보세요</p>

	</div>
	
	
</div>

<%@include file="menuPart2.jsp"%>