<!-- 화면공유기능 -->
<!-- 화면공유기능 위치만 잡음 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.center { 
	margin-left: auto;
	margin-right: auto;
			  
	display: block
	}
</style>
<div class="screen" id="screens">
	<video class='center' id="v1" autoplay="true" width="80%" height="100%" onclick="this.play(); for (var key in pc) { if (document.getElementById(key) !== undefined) document.getElementById(key).play(); }"></video> 
</div> 