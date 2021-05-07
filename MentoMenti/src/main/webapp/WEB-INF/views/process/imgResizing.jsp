<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	.profileImg{
		display:block;
		overflow:hidden;
		margin:0 auto;
		
		background-position: center center;
		background-repeat:no-repeat;
		background-size: 100% 100%;
	}
</style>

<%
	String userId = (String)session.getAttribute("userID");
%>

<c:set var="userid" value="<%=userId%>"></c:set>

<script type="text/javascript">
	/*
	window.onload = function(){
		var pngImg = new Image();
		pngImg.src = ''.concat('resources/img/user/', "${userid}",".png");
		var jpgImg = new Image();
		jpgImg.src = ''.concat('resources/img/user/', "${userid}",".jpg");
		
		//원본 이미지 비율을 구하기 위해
		var originalPngImg = document.getElementById("originalPngImg");
		var originalJpgImg = document.getElementById("originalJpgImg");
		var imgWidth = 1;
		var imgHeight = 1;
		
		//class 이름에 따라 url 지정하기
		//png 파일
		var pngProfiles = document.getElementsByClassName('pngProfile');
		for (var a=0; a<pngProfiles.length; a++){
			pngProfiles[a].style.backgroundImage = ''.concat("url('", pngImg.src, "')");
			imgWidth = originalPngImg.width;
			imgHeight = originalPngImg.height;
			if (imgWidth>imgHeight)
				pngProfiles[a].style.backgroundSize = "auto 100%";
			else
				pngProfiles[a].style.backgroundSize = "100% auto";
		}
		
		//jpg 파일
		var jpgProfiles = document.getElementsByClassName('jpgProfile');
		for (var b=0; b<jpgProfiles.length; b++){
			jpgProfiles[b].style.backgroundImage = ''.concat("url('", jpgImg.src, "')");
			imgWidth = originalJpgImg.width;
			imgHeight = originalJpgImg.height;
			if (imgWidth>imgHeight)
				jpgProfiles[a].style.backgroundSize = "auto 100%";
			else
				jpgProfiles[a].style.backgroundSize = "100% auto";
		}
		
		//기본 프로필
		var defaultProfiles = document.getElementsByClassName('defaultProfile');
		for (var c=0; c<defaultProfiles.length; c++){
			defaultProfiles[c].style.backgroundImage = "url('/resources/img/user/user.png')";
			defaultProfiles[c].style.backgroundSize = "100% 100%";
		}
	}
	*/
</script>