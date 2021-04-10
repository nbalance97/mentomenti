<!-- 채팅기능 -->
<style>
	.chatSize{
		height:70%;
		z-index:500;
		color:black;
		margin-bottom:3%;
	}
</style>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="chating">
	<h1>채팅</h1>
	<div class="chatSize">
		<jsp:include page="../chatPage.jsp" flush="true"/>
	</div>
</div>