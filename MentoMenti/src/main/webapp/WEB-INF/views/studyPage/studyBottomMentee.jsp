<!-- 수업 기능메뉴 -->
<!-- 멘토, 멘티따라 다른 기능메뉴 보여주기 & 실제기능추가필요(펜, 음성, 나가기) -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="/resources/css/bottomBar.css" rel="stylesheet" type="text/css"> 

<%
	int groupid_ = Integer.parseInt(request.getParameter("groupid"));
	GroupDTO group_ = HomeController.dao.getGroupDAO().searchGroupByGroupid(groupid_);
%>

<div class="function">
	<div class="icon-box">
		<span class="icon"><a href="#"><i class="fas fa-pencil-alt fa-3x pen" aria-hidden="true"></i></a></span>
		<span class="icon"><a id="muter" href="#"><i class="fas fa-microphone fa-3x mic"></i></a></span>
		<div class="dropdown">
			<span class="icon dropbtn"><a id="emotionSelect" href="#"><i class="far fa-hand-paper fa-3x emotion-select"></i></a></span>
			<div class="dropdown-content">
				<span class="icon"><a onclick="changestatus('ques');"><i class="far fa-question-circle fa-3x emotion"></i></a></span>
				<span class="icon"><a onclick="changestatus('finish');"><i class="far fa-check-circle fa-3x emotion"></i></a></span>
				<span class="icon"><a onclick="changestatus('non-finish');"><i class="far fa-times-circle fa-3x emotion"></i></a></span>
			</div>
		</div>
		<span class="icon"><a onclick="movePractice()" href="#"><i class="fas fa-exchange-alt fa-3x change"></i></a></span>
	</div>
</div>
<span class="exit-box"><a id="exitBtn" onclick="exit()" href="#"><i class="fas fa-sign-out-alt fa-2x exit"></i></a></span>

<script>
	function exit(){
		if(confirm("스터디방에서 나가시겠습니까?")){
			location.replace("/main");//https://kgu.mentomenti.kro.kr/main
		}else{
			
		}
	}
	function movePractice(){
		if(confirm("실습페이지로 이동하시겠습니까?")){
			location.replace("/practiceMento?groupid=<%=group_.getGroupid()%>");
		}else{
			
		}
	}
	const muter = document.querySelector("#muter");
	muter.addEventListener("click", (e) => {
	  ["fa-microphone", "fa-microphone-slash"].forEach(
	    c => e.target.classList.toggle(c));
	});
</script>
