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

<!-- 사이트 설명 -->
<div class="list">
	<div class="up-on-scroll" id="site_intro1">
		<img style="width:70%; object-fit: contain;" src="resources/img/2번슬라이드.png">
		<h3 class="font-weight-700" style="margin: 30px; font-size:70px;">Welcome to MOCO!</h3>
		</br>
		<p>누구나 멘토가 될 수 있고</p>
		<p>누구나 멘티가 될 수 있는</p>
		<p>모두의 코딩 교실,</p>
		<p>
			<span class="font-weight-500" style="background-color:#D9E5FF">모코(MOCO)</span>에 오신 것을 환영합니다!
		</p>
	</div>
	
	<div class="up-on-scroll" id="site_intro2">
		<h3 class="font-weight-700" style="margin: 30px">MOCO란?</h3>
		<p>온라인 스터디를 위한 사이트입니다.</p>
		<p><b class="font-weight-500">스터디의 모집</b>,</p>
		<p><b class="font-weight-500">프로그래밍 스터디에 특화된 기능</b>들,</p>
		<p><b class="font-weight-500">자체적인 온라인 스터디 서비스</b>를 제공하고 있습니다.</p>
	</div>
	
	<div class="up-on-scroll" id="site_intro2">
		<h3 class="font-weight-700" style="margin: 30px">MOCO의 서비스</h3>
		<p>쉽고 간편한 <b class="font-weight-500">스터디 그룹 생성과 모집</b></p>
		<p>해당 <b class="font-weight-500">스터디 그룹 전용 페이지</b>를 통한 소통</p>
		<p>스터디 모집 후 바로 스터디를 진행할 수 있는 <b class="font-weight-500">수업페이지</b></p>
		<p>멘토의 화면을 공유할 수 있는 <b class="font-weight-500">화면공유</b></p>
		<p>서로 대화하여 소통할 수 있는 <b class="font-weight-500">음성공유와 채팅</b></p>
		<p>다른 사람들에게 자신의 이해정도를 알릴 수 있는 <b class="font-weight-500">이모티콘</b></p>
		<p>프로그래밍 실습이 필요할 경우 활용할 수 있는 <b class="font-weight-500">웹컴파일러</b></p>
		<p>멘토와의 1:1 소통이 가능한 <b class="font-weight-500">화이트보드</b></p>
		<p><b class="font-weight-500">MOCO하나로 모두 가능합니다!</b></p>
	</div>

	<div class="up-on-scroll" id="site_intro2">
		<h3 class="font-weight-700" style="margin: 30px">그럼 이제 MOCO를 이용하기 위해서 
		<span class="font-weight-700" style="background-color:#D9E5FF">MOCO의 이용방법</span>을 알아볼까요?</h3>
	</div>
	
	<div class="up-on-scroll" id="site_intro2">
		<h3 class="font-weight-700" style="margin: 30px; font-size:30px;">MOCO사용법 - 스터디 참여</h3>
	</div>
	
	<div class="up-on-scroll" id="site_intro2">
		<h3 class="font-weight-700" style="margin: 30px; font-size:30px;">(1)</h3>
		<p>모코의 핵심적인 기능들을 사용하기 위해선 먼저 <b class="font-weight-500">로그인</b>이 필요합니다!</p>
		<p>회원가입으로 가입 후 로그인 해 주세요.</p>
		<img style="width:70%; object-fit: contain;" src="resources/img/2번슬라이드.png">
	</div>
	
	<div class="up-on-scroll" id="site_intro2">
		<h3 class="font-weight-700" style="margin: 30px; font-size:30px;">(2-1)</h3>
		<p>본격적으로 MOCO를 알아볼까요? 원하는 스터디에 참여하기 위해 <b class="font-weight-500">스터디 그룹에 가입</b>해야합니다!</p>
		<p>아래 그림과 같이 메뉴-그룹-개설된 그룹을 클릭해 원하는 그룹에 참여하세요.</p>
		<img style="width:70%; object-fit: contain;" src="resources/img/2번슬라이드.png">
	</div>

	<div class="up-on-scroll" id="site_intro2">
		<h3 class="font-weight-700" style="margin: 30px; font-size:30px;">(2-2)</h3>
		<p>만약 멘토가 되어 멘티를 모집하고 싶다면? 우선 멘티들을 모집하기 위해 <b class="font-weight-500">스터디 그룹을 개설</b>해야합니다!</p>
		<p>아래 그림과 같이 메뉴-그룹-그룹개설을 클릭해 스터디 그룹을 개설하세요.</p>
		<img style="width:70%; object-fit: contain;" src="resources/img/2번슬라이드.png">
	</div>
	
	<div class="up-on-scroll" id="site_intro2">
		<h3 class="font-weight-700" style="margin: 30px; font-size:30px;">(3)</h3>
		<p>이제 가입한 그룹 목록에서<b class="font-weight-500">해당 그룹의 페이지로 이동</b>할 수 있습니다!</p>
		<p>아래 그림과 같이 가입한 메뉴-그룹-가입한 그룹-원하는 그룹 페이지로 이동하세요.</p>
		<img style="width:70%; object-fit: contain;" src="resources/img/3번슬라이드.png">
	</div>
	
	<div class="up-on-scroll" id="site_intro2">
		<h3 class="font-weight-700" style="margin: 30px; font-size:30px;">(4)</h3>
		<p>이제 거의 끝났습니다! <b class="font-weight-500">입장버튼을 통해 수업페이지로 이동</b>하세요!</p>
		<p>아래 그림과 같이 해당 그룹 페이지의 입장버튼을 클릭하세요.</p>
		<img style="width:70%; object-fit: contain;" src="resources/img/4번슬라이드.png">
	</div>
	
	<div class="up-on-scroll" id="site_intro2">
		<h3 class="font-weight-700" style="margin: 30px; font-size:30px;">(5)</h3>
		<p><b class="font-weight-500">스터디의 준비가 끝났습니다!</b></p>
		<p>멘토, 멘티와 함께 스터디를 진행해봅시다</p>
		<img style="width:70%; object-fit: contain;" src="resources/img/4번슬라이드.png">
	</div>
	
	
	
	
	<div class="up-on-scroll" id="site_intro2">
		<h3 class="font-weight-700" style="margin: 30px; font-size:30px;">MOCO사용법 -온라인 스터디 기능 : 멘티</h3>
	</div>
	<div class="up-on-scroll" id="site_intro2">
		<h3 class="font-weight-700" style="margin: 30px; font-size:30px;">(1)</h3>
		<p><b class="font-weight-500">지금부터는 MOCO에서 제공하는 온라인 스터디의 기능을 알아보겠습니다!</b></p>
		<p>처음으로 수업페이지에 들어가면 아래와 같은 화면을 볼 수 있습니다.</p>
		<p>채팅, 참여한 인원의 리스트, 음성공유, 이모티콘, 실습페이지로 이동버튼이 존재합니다.</p>
		<img style="width:70%; object-fit: contain;" src="resources/img/4번슬라이드.png">
	</div>
	<div class="up-on-scroll" id="site_intro2">
		<h3 class="font-weight-700" style="margin: 30px; font-size:30px;">(2)</h3>
		<p><b class="font-weight-500">지금부터는 MOCO에서 제공하는 온라인 스터디의 기능을 알아보겠습니다!</b></p>
		
		<!-- 기본 수업 페이지에서 수업 진행 방식 설명 -->
		<p>멘토가 공유한 화면과 음성을 통해 수업이 진행됩니다.</p>
		<p>멘티 역시 음성을 통해 멘토와 원활한 소통을 가질 수 있습니다.</p>
		<p>수업의 이해 정도를 표시하기 위해 하단의 이모티콘을 이용할 수 있습니다.</p>
		<br>
		<!-- 사이드바 설명 (채팅창, 참여자 목록) -->
		<p>좌측 상단의 버튼을 클릭하여 사이드바를 확인할 수 있으며</p>
		<p>사이드바에서는 채팅창과 수업 참여자 목록을 확인할 수 있습니다.</p>
		<p>채팅 기능을 통해 멘토 및 수업에 참여한 다른 사람들과 소통을 할 수 있습니다.</p>
		<p>참여자 목록의 1:1 버튼을 클릭하여 화이트보드를 이용한 1:1 피드백 화면으로 이동할 수 있습니다.</p>
		<br>
		<!-- 실습 페이지 설명 -->
		<p>프로그래밍 실습이 필요하다면 실습페이지로 이동하세요!</p>
		<p>C언어, 자바, 파이썬 - 3가지 언어를 지원하는 웹 컴파일러가 준비되어 있습니다.</p>
		<p>컴파일러에 작성한 코드를 바로 실행시켜 결과를 확인할 수 있습니다.</p>
		<p>작성한 코드는 1:1 피드백 페이지 이동 시 멘토에게 공유됩니다.</p>
		<img style="width:70%; object-fit: contain;" src="resources/img/4번슬라이드.png">
	</div>
	
		<div class="up-on-scroll" id="site_intro2">
		<h3 class="font-weight-700" style="margin: 30px; font-size:30px;">MOCO사용법 -온라인 스터디 기능 : 멘토</h3>
	</div>
	<div class="up-on-scroll" id="site_intro2">
		<h3 class="font-weight-700" style="margin: 30px; font-size:30px;">(1)</h3>
		<p><b class="font-weight-500">지금부터는 MOCO에서 제공하는 온라인 스터디의 기능을 알아보겠습니다!</b></p>
		<p>처음으로 수업페이지에 들어가면 아래와 같은 화면을 볼 수 있습니다.</p>
		<p>채팅, 참여한 인원의 리스트, 음성공유, 화면공유, 실습페이지로 이동버튼이 존재합니다.</p>
		<img style="width:70%; object-fit: contain;" src="resources/img/4번슬라이드.png">
	</div>
	<div class="up-on-scroll" id="site_intro2">
		<h3 class="font-weight-700" style="margin: 30px; font-size:30px;">(2)</h3>
		<p><b class="font-weight-500">지금부터는 MOCO에서 제공하는 온라인 스터디의 기능을 알아보겠습니다!</b></p>
		기능을 하나씩 확인해보겠습니다. 채팅기능은 다른 사람들과 소통 가능
		멘티리스트는 현재 누가 참여했는지 알 수 있으며 이동 버튼을 통해 화이트 보드를 이용한 1:1피드백을 받을 수 있습니다.
		음성공유는 다른 그룹원과 소통할 수 있으며 끌 수 있습니다.
		프로그래밍 실습이 필요하다면 실습페이지로 이동 버튼 을 통해 이동하세요
		음성공유와 파일업로드,이동버튼, 웹컴파일러가 있습니다.
		파일업로드를 통해 코딩할 문제를 멘티들에게 공유해줄수있습니다.
		화이트보드?코드?
		<p>처음으로 수업페이지에 들어가면 아래와 같은 화면을 볼 수 있습니다.</p>
		<p>채팅, 참여한 인원의 리스트, 음성공유, 이모티콘, 실습페이지로 이동버튼이 존재합니다.</p>
		<img style="width:70%; object-fit: contain;" src="resources/img/4번슬라이드.png">
	</div>
</div>
<%@include file="menuPart2.jsp"%>