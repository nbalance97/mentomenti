<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page import="java.util.List"%>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<style>
.filebox input[type="file"] {
	display:none;
	width: 1px;
	height: 1px;
	padding: 0;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

.filebox .upload-name {
	padding: .5em .75em; /* label의 패딩값과 일치 */
	font-size: inherit;
	font-family: inherit;
	vertical-align: middle;
	background-color: #f5f5f5;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
	-webkit-appearance: none; /* 네이티브 외형 감추기 */
	-moz-appearance: none;
	appearance: none;
}
</style>


<title>MOCO</title>

<link href="resources/css/all.min.css" rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">
<link href="resources/css/component.css" rel="stylesheet"
	type="text/css">
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
</head>

<%@include file="/WEB-INF/views/menuPart1.jsp"%>

<%
	if (id == null) { //로그인 안된 상태면 로그인 페이지로 이동
	response.sendRedirect("loginPage?mode=nidLogin");
} else {
%>


<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800">가입한 그룹</h1>
</div>

<div class="wrapContents">

	<div class="filebox preview-image" style="text-align:center;">
		<div class="profileImg rounded-circle" style="width:200px; height:200px; margin-bottom:30px;">
			<img src="/resources/img/user/user.png" style="width:100%; height:100%; object-fit: cover;">
		</div>
		
		<input class="upload-name" value="파일선택" disabled="disabled">
		<label for="ex_filename" class="btn btn-success">프로필 등록</label>
		<input type="file" id="ex_filename" class="upload-hidden">
	</div>
</div>

<%
	}
%>
<script type="text/javascript">
$(document).ready(function(){
	var fileTarget = $('.filebox .upload-hidden');
	fileTarget.on('change', function(){ // 값이 변경되면
		if(window.FileReader){ // modern browser
			var filename = $(this)[0].files[0].name;
		} else { // old IE
			var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출
		}
	
		// 추출한 파일명 삽입
		$(this).siblings('.upload-name').val(filename);
	});
	
	var imgTarget = $('.preview-image .upload-hidden');
	imgTarget.on('change', function(){
		var parent = $(this).parent();
		parent.children('.upload-display').remove();
		parent.children('.profileImg').remove();
		
		if(window.FileReader){
			if (!$(this)[0].files[0].type.match(/image\//)) return;
			var reader = new FileReader();
			reader.onload = function(e){
				var src = e.target.result;
				parent.prepend('<div class="upload-display profileImg rounded-circle" style="width:200px; height:200px; margin-bottom:30px;"><img src="'+src+'" style="width:100%; height:100%; object-fit: cover;"></div>');
			}
			reader.readAsDataURL($(this)[0].files[0]);
		} else {
			$(this)[0].select();
			$(this)[0].blur();
			var imgSrc = document.selection.createRange().text;
			parent.prepend('<div class="upload-display profileImg rounded-circle" style="width:200px; height:200px; margin-bottom:30px;"><img src="'+src+'" style="width:100%; height:100%; object-fit: cover;"></div>');
			
			var img = $(this).siblings('.upload-display').find('img');
			img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")";
		}
	});
});
</script>
<%@include file="/WEB-INF/views/menuPart2.jsp"%>
</html>