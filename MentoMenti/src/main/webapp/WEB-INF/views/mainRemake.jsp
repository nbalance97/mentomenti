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
<link href="resources/css/sliderRemake.css" rel="stylesheet">

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
.list {
	width: 100%;
}

.list .up-on-scroll {
	transition: transform 1s, opacity 1s;
}

.up-on-scroll {
	font-size: 1.2em;
	text-align: center;
	margin: 100px 0px;
}

div.container {
	overflow: hidden;
}

div.item {
	float: left;
	width: 50%;
	padding: 20px;
}

a, a:hover {
	text-decoration: none;
	color: gray;
}

.seeMore {
	font-size: 0.7em;
}

/*메인 화면 이중 스크롤바 해결*/
#content-wrapper {
	overflow: hidden;
}
</style>

<%@include file="menuPart1.jsp"%>

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4"
	style="margin-top: 50px"></div>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.css"
	rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.js"></script>

<!-- 이미지 슬라이드 -->
<section>
		<ul class="slider">
			<li><a>
				<img src="resources/img/mainimg1_2.png"> </a>
			<dl class="right">
         		 <dt>1/6</dt>
        	</dl>
			</li>
			<li><a><img src="resources/img/2번슬라이드.png"></a>
			<dl class="right">
         		 <dt>2/6</dt>
        	</dl>
			</li>
			<li><a><img src="resources/img/3번슬라이드.png"></a>
			<dl class="right">
         		 <dt>3/6</dt>
        	</dl>
			</li>
			<li><a><img src="resources/img/4번슬라이드.png"></a>
			<dl class="right">
         		 <dt>4/6</dt>
        	</dl>
			</li>
			<li><a href="notice">
				<img src="resources/img/mainimg1_2.png"></a>
			<dl class="right">
         		 <dt>5/6</dt>
        	</dl>
				</li>
			<li><a href="notice"><img src="resources/img/2번슬라이드.png"></a>
			<dl class="right">
         		 <dt>6/6</dt>
        	</dl>
			</li>
		</ul>
	<div class="btn">
		<button type="button" id="prev"></button>
		<button type="button" id="next"></button>
	</div>
</section>


<!-- 사이트 설명 -->
<div class="list">
	<div class="up-on-scroll" id="site_intro1">
		<h3 class="font-weight-700" style="margin: 30px">Welcome to MOCO!</h3>
		<p>누구나 멘토가 될 수 있고</p>
		<p>누구나 멘티가 될 수 있는</p>
		<p>모두의 코딩 교실,</p>
		<p>
			<b class="font-weight-500">모코(MOCO)</b>에 오신 것을 환영합니다!
		</p>
	</div>

	<div class="up-on-scroll" id="site_intro2">
		<p>개설된 스터디 그룹 목록을 확인해보세요</p>
		<p>가입된 그룹 페이지에서 수업에 참여할 수 있습니다</p>
		<p>자유게시판에서 다른 사용자들과 소통해보세요</p>

	</div>


</div>
<script>
$(function(){
	  var $slider = $('.slider'),
	      $firstSlide = $slider.find('li').first() // 첫번째 슬라이드
	      .stop(true).animate({'opacity':1},200); // 첫번째 슬라이드만 보이게 하기

	  function PrevSlide(){ // 이전버튼 함수
	    stopSlide();startSlide(); //타이머 초기화
	    var $lastSlide = $slider.find('li').last() //마지막 슬라이드
	    .prependTo($slider); //마지막 슬라이드를 맨 앞으로 보내기  
	    $secondSlide = $slider.find('li').eq(1)//두 번째 슬라이드 구하기
	    .stop(true).animate({'opacity':0},400); //밀려난 두 번째 슬라이드는 fadeOut 시키고
	    $firstSlide = $slider.find('li').first() //맨 처음 슬라이드 다시 구하기
	    .stop(true).animate({'opacity':1},400);//새로 들어온 첫 번째 슬라이드는 fadeIn 시키기
	  }
	  
	  function NextSlide(){ // 다음 버튼 함수
	    stopSlide();startSlide(); //타이머 초기화
	    $firstSlide = $slider.find('li').first() // 첫 번째 슬라이드
	    .appendTo($slider); // 맨 마지막으로 보내기
	    var $lastSlide = $slider.find('li').last() // 맨 마지막으로 보낸 슬라이드
	    .stop(true).animate({'opacity':0},400); // fadeOut시키기
	    $firstSlide = $slider.find('li').first()// 맨 처음 슬라이드
	    .stop(true).animate({'opacity':1},400);// fadeIn 시키기
	  }
	  
	  $('#next').on('click', function(){ //다음버튼 클릭
	    NextSlide();
	  });
	  $('#prev').on('click', function(){ //이전 버튼 클릭
	    PrevSlide();
	  });

	  startSlide(); // 자동 슬라이드 시작
	  
	  var theInterval;

	  function startSlide() {
	    theInterval = setInterval(NextSlide, 5000); //자동 슬라이드 설정
	  }

	  function stopSlide() { //자동 멈추기
	    clearInterval(theInterval);
	  }
	  
	  $('.slider').hover(function(){ //마우스 오버시 슬라이드 멈춤
	    stopSlide();
	  }, function (){
	    startSlide();
	  });
	});
</script>
<%@include file="menuPart2.jsp"%>