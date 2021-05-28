<!-- 수업 기능메뉴 -->
<!-- 멘토, 멘티따라 다른 기능메뉴 보여주기 & 실제기능추가필요(음성, 이모티콘, 나가기) -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page
	import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<link href="/resources/css/bottomBar.css" rel="stylesheet" type="text/css">
<style>


</style> 
<%
	int groupid_ = Integer.parseInt(request.getParameter("groupid"));
	GroupDTO group_ = HomeController.dao.getGroupDAO().searchGroupByGroupid(groupid_);
%>

<div class="function">
	<div class="icon-box">
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
				</div>
				<div class="emotionExplain">
					이모티콘 전송
				</div>
			</div>
		</div>
		<div class="icon">
			<div class="icon screenbtn" style="padding:0;"><a href="javascript:void(0);" onclick="share_monitor()"><i class="fas fa-desktop fa-3x monitor"></i></a>
				<div class="screenExplain">
					화면공유
				</div>
			</div>
		</div>
		<div class="icon">
			<div class="icon movebtn" style="padding:0;"><a onclick="moveStudy()" href="#"><i class="fas fa-exchange-alt fa-3x change"></i></a>
				<div class="moveExplain">
					수업페이지로 이동
				</div>
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
	function moveStudy(){
		if(confirm("수업페이지로 이동하시겠습니까?")){
			location.replace("/studyPage/studyPageMentor?groupid=<%=group_.getGroupid()%>");
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
