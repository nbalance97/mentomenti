<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body{
		margin:0;
		padding:0;
	}
	.canvas{
		background:blue;
		width:75%;
		height:100vh;
		float:left;
	}
	.tool{
		background:red;
		width:25%;
		height:50vh;
		float:right;
	}
	.codeBox{
		background:#422351;
		width:25%;
		height:50vh;
		float:right;
	}
</style>
</head>
<body>
	<div class="fullScreen">
		<!-- 그림그리는 영역 -->
		<div class="canvas">
			<h1>canvas</h1>
		</div>
		<!-- 캔버스 도구 -->
		<div class="tool">
			<h1>tool</h1>
		</div>
		<!-- 코드 영역 -->
		<div class="codeBox">
			<h1>code</h1>
		</div>
	</div>
</body>
</html>