<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- 햄버거버튼 -->
	<input type="checkbox" id="menuicon">
		<label for="menuicon">
			<span></span>
			<span></span>
			<span></span>
		</label>
	<div class="sidebar">
		<div class="content">
			<!-- 멘티리스트 -->
			<%@include file="studyPageMenteeList.jsp"%>
			<%@include file="studyPageChat.jsp"%>
		</div>
	</div>