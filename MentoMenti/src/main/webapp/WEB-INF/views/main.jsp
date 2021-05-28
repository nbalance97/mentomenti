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
<meta name="author" content="">
<meta property="og:title" content="모코(MOCO)">
<meta property="og:description" content="모두의 코딩교실, 모코(MOCO)">
<meta property="og:image" content="resources/img/logo3.png" />

<title>MOCO</title>

<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<link href="resources/css/all.min.css" rel="stylesheet" type="text/css">
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">
<link href="resources/css/slider.css" rel="stylesheet">

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
	
	/*기능 설명*/
	.fn{
		/* overflow:hidden; */
		height:350px;
	}
	.fnbox{
		width:45%;
		height:100%; 
		background : white;
		/* border:3px dashed gray; */
		filter: drop-shadow(0 0 10px #0001);
	}
	.fnboxl{
		float:left;
	}
	.fnboxr{
		float:right; 
	}
	.fnicon{
		/* width:30%; */
		width:150px;
		margin:15px;
		/* object-fit: contain; */
	}
	.fn_content{
		padding:15px 40px;
	}
	
	@media screen and (max-width:1000px){
	.fnboxl{
		width:100%;
		margin-bottom:70px;
	}
	.fnboxr{
		width:100%;
		margin-bottom:70px;
	}
}
</style>

<%@include file="menuPart1.jsp"%>

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4" style="margin-top:50px">
</div>

<!-- 이미지 슬라이드 -->

<div class="slidebox">
 	<ul class="slider">
 		<li class="slideitem">
 			<div>
 				<img name="j_test" src="resources/img/mainimg1_2.png">
 			</div>
 		</li>
 		 <li class="slideitem">
 			<div>
 				<img name="j_test" src="resources/img/slider/second_picture.png">
 			</div>
 		</li>
 		<li class="slideitem">
 			<div>
 				<img name="j_test" src="resources/img/3번슬라이드.png">
 			</div>
 		</li>
  		<li class="slideitem">
 			<div>
 				<img name="j_test" src="resources/img/4번슬라이드.png">
 			</div>
 		</li>
 	</ul>
		<button type="button" id="prev"></button>
		<button type="button" id="next"></button>
</div>

<!-- 사이트 설명 -->
<div class="list">
	<div class="up-on-scroll" id="site_intro1">
		<h3 class="font-weight-700" style="margin:100px; font-size:40px">Welcome to MOCO!</h3>
		<p>누구나 멘토가 될 수 있고</p>
		<p>누구나 멘티가 될 수 있는</p>
		<p>모두의 코딩 교실,</p>
		<p><b class="font-weight-500">모코(MOCO)</b>에 오신 것을 환영합니다!</p>
	</div>
	
	<div class="up-on-scroll" id="site_intro1">
		<p style="margin-top:50px;">MOCO는 <b class="font-weight-500">소규모 온라인 프로그래밍 스터디 사이트</b>입니다.</p>
		<p style="margin-bottom:50px">쉽고 간단한 온라인 프로그래밍 스터디 서비스를 위해 다음의 기능을 제공합니다.</p>
	</div>
	
	<div class="up-on-scroll fn" id="site_intro1">
		<div class="fnbox fnboxl">
			<div class="fn_content">
				<img class="fnicon" src="resources/img/mainfn/group.png">
				<p><b class="font-weight-500">스터디 그룹 참여</b></p>
				<p>원하는 스터디 그룹의 개설 및 참여를 통해</br> 멘토, 멘티를 쉽게 모집할 수 있습니다.</p>
			</div>
		</div>
		<div class="fnbox fnboxr">
			<div class="fn_content">
				<img class="fnicon" src="resources/img/mainfn/voice.png">
				<p><b class="font-weight-500">음성공유 및 채팅</b></p>
				<p>스터디 수업 진행 시 음성공유와 채팅을 이용한 원활한 실시간 소통이 가능합니다.</p>
			</div>
		</div>
	</div>
	
	<div class="up-on-scroll fn" id="site_intro1">
		<div class="fnbox fnboxl">
			<div class="fn_content">
				<img class="fnicon" src="resources/img/mainfn/board.png">
				<p><b class="font-weight-500">화이트보드</b></p>
				<p>양방향 필기기능을 이용한 1:1 피드백이</br>가능합니다.</p>
			</div>
		</div>
		<div class="fnbox fnboxr">
			<div class="fn_content">
				<img class="fnicon" src="resources/img/mainfn/screen.png">
				<p><b class="font-weight-500">화면공유</b></p>
				<p>온라인 스터디 수업에서 멘토의 화면공유를 통해 효과적인 스터디 진행이 가능합니다.</p>
			</div>
		</div>
	</div>
	
	<div class="up-on-scroll fn" id="site_intro1">
		<div class="fnbox fnboxl">
			<div class="fn_content">
				<img class="fnicon" src="resources/img/mainfn/emotion.png">
				<p><b class="font-weight-500">이모티콘</b></p>
				<p>온라인 스터디 중 멘티가 다른 그룹원에게</br> 자신의 상태를 공유할 수 있습니다.</p>
			</div>
		</div>
		<div class="fnbox fnboxr">
			<div class="fn_content">
				<img class="fnicon" src="resources/img/mainfn/compiler.png">
				<p><b class="font-weight-500">웹 컴파일러</b></p>
				<p>웹 컴파일러 기능을 제공하여 쉽고 빠른</br> 프로그래밍 실습을 진행할 수 있습니다.</p>
			</div>
		</div>
	</div>
	
	<div class="up-on-scroll">
		<h3 class="font-weight-700" style="margin: 30px;">모코가 처음이신가요?</h3>
		<a href="explain" class="btn btn-primary btn-lg" role="button" aria-pressed="true">모코 가이드 확인하기</a>
	</div>
</div>
<script>
$(function(){
	  var $slider = $('.slider'),
	      $firstSlide = $slider.find('li').first() // 첫번째 슬라이드
	      .stop(true).animate({'opacity':1},400); // 첫번째 슬라이드만 보이게 하기

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