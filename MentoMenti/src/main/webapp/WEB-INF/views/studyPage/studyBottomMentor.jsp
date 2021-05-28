<!-- 수업 기능메뉴 -->
<!-- 멘토, 멘티따라 다른 기능메뉴 보여주기 & 실제기능추가필요(펜, 지우기, 음성, 화면공유, 실습하기, 나가기) -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<link href="/resources/css/bottomBar.css" rel="stylesheet" type="text/css"> 

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
		<div class="icon">
			<div class="icon screenbtn" style="padding:0;"><a href="javascript:void(0);" onclick="share_monitor()"><i class="fas fa-desktop fa-3x monitor"></i></a>
				<div class="screenExplain">
					화면공유
				</div>
			</div>
		</div>
		 <!-- 
		<div class="icon">
			<div class="icon movebtn" style="padding:0;"><a onclick="movePractice()" href="#"><i class="fas fa-exchange-alt fa-3x change"></i></a>
				<div class="moveExplain">
					실습페이지로 이동
				</div>
			</div>
		</div>
		 -->
	</div>
</div>
<span class="exit-box"><a id="exitBtn" onclick="exit()" href="#"><i class="fas fa-sign-out-alt fa-2x exit"></i></a></span>

<%
	int groupid_ = Integer.parseInt(request.getParameter("groupid"));
	GroupDTO group_ = HomeController.dao.getGroupDAO().searchGroupByGroupid(groupid_);
%>

<script>
	function exit(){
		if(confirm("스터디방에서 나가시겠습니까?")){
			location.replace("/main");
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
	document.querySelector('div.micbtn').addEventListener('click', function() {
		  this.classList.toggle('inactive');
		  this.classList.toggle('active');
		});
</script>
