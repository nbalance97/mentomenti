<!-- 수업 기능메뉴 -->
<!-- 멘토, 멘티따라 다른 기능메뉴 보여주기 & 실제기능추가필요(펜, 음성, 나가기) -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="/resources/css/bottomBar.css" rel="stylesheet" type="text/css"> 
<%@ page
	import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%
	int groupid_ = Integer.parseInt(request.getParameter("groupid"));
	GroupDTO group_ = HomeController.dao.getGroupDAO().searchGroupByGroupid(groupid_);
%>

<div class="function">
	<div class="icon-box">
		<!-- <span class="icon"><a href="#"><i class="fas fa-pencil-alt fa-3x pen" aria-hidden="true"></i></a></span> -->
		<div class="icon">
			<div class="icon micbtn inactive" style="padding:0;"><a id="muter" onclick="share_microphone();"><i class="fas fa-microphone-slash fa-3x mic"></i></a>
				<div class="nonemic_ex">
					마이크 켜기
				</div>
				<div class="usemic_ex">
					마이크 끄기
				</div>
			</div>
		</div>

		<div class="dropdown icon">
			<div class="icon dropbtn" style="padding:0;"><a id="emotionSelect" href="#"><i class="far fa-hand-paper fa-3x emotion-select"></i></a>
				<div class="dropdown-content">
					<span class="icon"><a onclick="changestatus('ques');"><i class="far fa-question-circle fa-3x emotion"></i></a></span>
					<span class="icon"><a onclick="changestatus('finish');"><i class="far fa-check-circle fa-3x emotion"></i></a></span>
					<span class="icon"><a onclick="changestatus('non-finish');"><i class="far fa-times-circle fa-3x emotion"></i></a></span>
					<span class="icon"><a onclick="changestatus('hand-up');"><i class="far fa-hand-paper fa-3x emotion"></i></a></span>
					<span class="icon"><a onclick="changestatus('thumb-up');"><i class="far fa-thumbs-up fa-3x emotion"></i></a></span>
				</div>
				<div class="emotionExplain">
					이모티콘 전송
				</div>
			</div>
		</div>
		
		<div class="icon">
			<div class="icon compilerbtn" style="padding:0;"><a onclick="openCompiler()" href="#"><i class="fas fa-laptop-code fa-3x change"></i></a>
				<div class="compilerExplain">
					컴파일러
				</div>
			</div>
		</div>
		<div class="icon">
			<div class="icon movebtn" style="padding:0;"><a onclick="movePractice()" href="#"><i class="fas fa-exchange-alt fa-3x change"></i></a>
				<div class="moveExplain">
					피드백 페이지로 이동
				</div>
			</div>
		</div>
	</div>
</div>
<span class="exit-box"><a id="exitBtn" onclick="exit()" href="#"><i class="fas fa-sign-out-alt fa-2x exit"></i></a></span>

<script>
	function exit(){
		if(confirm("스터디방에서 나가시겠습니까?")){
			location.replace("/group?groupid=<%=group_.getGroupid()%>");//https://kgu.mentomenti.kro.kr/main
		}else{
			
		}
	}
	
	function openCompiler(){
		var url = "/compiler";
		var name = "compiler";
		var popupWidth = 500;
		var popupHeight = 700;
		var popupX = (window.screen.width / 2) - (popupWidth / 2);
		var popupY = (window.screen.height / 2) - (popupHeight / 2);
		var option = "toolbar=no, location=no, status=no, scrollbars=no, resizable=no"
		myExternalWindow = window.open(url, name, option+ ', left='+ popupX + ', top='+ popupY);
		myExternalWindow.resizeTo(popupWidth,popupHeight);
	}
	
	function movePractice(){
		if(confirm("피드백 페이지로 이동하시겠습니까?")){
			location.replace("/practiceMento?groupid=<%=group_.getGroupid()%>");
		}else{
			
		}
	}
	const muter = document.querySelector("#muter");
	muter.addEventListener("click", (e) => {
	  ["fa-microphone", "fa-microphone-slash"].forEach(
	    c => e.target.classList.toggle(c));
	});
	
	document.querySelector('div.micbtn').addEventListener('click', function() {
		  this.classList.toggle('inactive');
		  this.classList.toggle('active');
		});
</script>
