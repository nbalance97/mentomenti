<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.WebCompiler.WebCompiler" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>prac</title>
	<link rel="stylesheet" type="text/css" href="/resources/css/codemirror.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/mdn-like.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/dracula.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<link href="/resources/css/bootstrap.min.css" rel="stylesheet" />
	<script type="text/javascript" src="/resources/js/codemirror.js"></script>
	<script src="/resources/js/python.js"></script>
	<style>
	html,body{
		width:100%;
		height:100%;
		margin:0;
	}
	.main{
		width:100%;
		height:90%;
		background:#A4E5F8;
	}
	.function{
		width:100%;
		height:10%;
		background:white;
		padding:20px;
		clear: both;
	}
	ul{
		text-align:center;
	}
	li{
		margin-left:30px;
		display:inline-block;
	}
	.exit{
		float:right;
	}
	i{
		color:black;
	}
	
	.shadow {
    	box-shadow: 0 .15rem 1.75rem 0 rgba(58,59,69,.15)!important;
	}
	.coding{
		height:100%;
		padding:30px;
	}
	.compiler, .input, .result{
		height:30%;
		float:left;
		width:50%;
		margin-left:10px;
	}
	.compiler, .input{
		margin-bottom:30px;
	}
	.problemImg{
		height:82vh;
		float:right;
		width:45%;
	}
	</style>
</head>
<body>
	<div class="main">
		<div class="coding">
			<div class="compiler shadow img-rounded"><h1>complie</h1></div>
			<div class="problemImg shadow img-rounded"><h1>problem</h1></div>
			<div class="input shadow img-rounded"><h1>input</h1></div>
			<div class="result shadow img-rounded"><h1>result</h1></div>
		</div>
	</div>

		<div class="function">
			<ul>					
				<li><a href="#"><i class="fas fa-microphone fa-3x"></i></a></li>
				<li><a href="#"><i class="far fa-question-circle fa-3x"></i></a></li>
				<li class="exit"><a href="#"><i class="fas fa-sign-out-alt fa-2x"></i></a></li>
			</ul>
		</div>
</body>
</html>