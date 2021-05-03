<!-- 수업 기능메뉴 -->
<!-- 멘토, 멘티따라 다른 기능메뉴 보여주기 & 실제기능추가필요(펜, 문제게시, 음성, 수업하기, 나가기) -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="/resources/css/bottomBar.css" rel="stylesheet" type="text/css"> 

<div class="function">
	<div class="icon-box">
		<span class="icon"><a href="#"><i class="fas fa-pencil-alt fa-3x pen" aria-hidden="true"></i></a></span>
		<span class="icon"><a id="muter" href="#"><i class="fas fa-microphone fa-3x mic"></i></a></span>
		<span class="icon"><a href="#"><i class="fas fa-upload fa-3x upload" aria-hidden="true"></i></a></span>
		<span class="icon"><a onclick="moveStudy()" href="#"><i class="fas fa-exchange-alt fa-3x change"></i></a></span>
	</div>
</div>
<span class="exit-box"><a id="exitBtn" onclick="exit()" href="#"><i class="fas fa-sign-out-alt fa-2x exit"></i></a></span>

<script>
	function exit(){
		if(confirm("스터디방에서 나가시겠습니까?")){
			location.replace("https://kgu.mentomenti.kro.kr/main");
		}else{
			
		}
	}
	function moveStudy(){
		if(confirm("수업페이지로 이동하시겠습니까?")){
			location.replace("/studyPage/studyPageMentor");
		}else{
			
		}
	}
	const muter = document.querySelector("#muter");
	muter.addEventListener("click", (e) => {
	  ["fa-microphone", "fa-microphone-slash"].forEach(
	    c => e.target.classList.toggle(c));
	});
</script>
