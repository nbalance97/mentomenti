<!-- 수업 기능메뉴 -->
<!-- 멘토, 멘티따라 다른 기능메뉴 보여주기 & 실제기능추가필요(음성, 이모티콘, 나가기) -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="/resources/css/bottomBar.css" rel="stylesheet" type="text/css">
<style>


</style> 

<div class="function">
	<div class="icon-box">
		<span class="icon"><a id="muter" href="#"><i class="fas fa-microphone fa-3x mic"></i></a></span>
		<div class="dropdown">
			<span class="icon dropbtn"><a id="emotionSelect" href="#"><i class="far fa-hand-paper fa-3x emotion-select"></i></a></span>
			<div class="dropdown-content">
				<span class="icon"><a href="#"><i class="far fa-question-circle fa-3x emotion"></i></a></span>
				<span class="icon"><a href="#"><i class="far fa-check-circle fa-3x emotion"></i></a></span>
				<span class="icon"><a href="#"><i class="far fa-times-circle fa-3x emotion"></i></a></span>
			</div>
		</div>		
	</div>
</div>
<span class="exit-box"><a id="exitBtn" onclick="exit()" href="#"><i class="fas fa-sign-out-alt fa-2x exit"></i></a></span>


<script>
	function exit(){
		if(confirm("스터디방에서 나가시겠습니까?")){
			location.replace("/main");
		}else{
			
		}
	}
	const muter = document.querySelector("#muter");
	muter.addEventListener("click", (e) => {
	  ["fa-microphone", "fa-microphone-slash"].forEach(
	    c => e.target.classList.toggle(c));
	});
</script>
