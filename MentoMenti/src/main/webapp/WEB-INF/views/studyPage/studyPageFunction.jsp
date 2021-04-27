<!-- 수업 기능메뉴 -->
<!-- 멘토, 멘티따라 다른 기능메뉴 보여주기 & 실제기능추가필요(펜, 지우기, 음성, 화면공유, 실습하기, 나가기) -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="/resources/css/studyBottombar.css" rel="stylesheet" type="text/css">    

<div class="function">
	<ul>					
		<li><a href="#"><i class="fas fa-pencil-alt fa-3x"></i></a></li>
		<li><a href="#"><i class="fas fa-eraser fa-3x"></i></a></li>
		<li><a href="#"><i class="fas fa-microphone fa-3x"></i></a></li>
		<li><a href="javascript:void(0);" onclick="play()"><i class="fas fa-microphone fa-3x"></i></a></li>
		<li><a href="javascript:void(0);" onclick="share_monitor()"><i class="fas fa-desktop fa-3x"></i></a></li>
		<li><a href="https://kgu.mentomenti.kro.kr/practiceMento"><i class="fas fa-exchange-alt fa-3x"></i></a></li>
		<li class="exit"><a href="#"><i class="fas fa-sign-out-alt fa-2x"></i></a></li>
	</ul>
</div>
