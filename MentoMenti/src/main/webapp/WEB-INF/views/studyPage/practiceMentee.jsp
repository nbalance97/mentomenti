<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.WebCompiler.WebCompiler" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8"> 
	<title>practiceMentee</title>
	<link href="/resources/css/bootstrap.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<link href="/resources/css/defaultStudyPractice.css" rel="stylesheet" type="text/css">
	<style>
	.coding{
		height:90%;
		padding:30px;
	}
	.problemImg{
		height:82vh;
		width:48%;
		float:left;
	}
	.codingFunc{
		width:48%;
		height:90%;
		float:right;
	}
	.compiler, .input, .result{
		height:20%;
		float:left;
		width:99%;
	}
	.compiler{
		height:50%;
	}
	.compiler, .input{
		margin-bottom:30px;
	}
	</style>
</head>
<body>
	<div class="main">
	
	
		<div class="coding">
			<div class="problemImg shadow img-rounded"><h1>problem</h1></div>
			<div class="codingFunc">
				<div class="compiler shadow img-rounded"><h1>compile</h1></div>
				<div class="input shadow img-rounded"><h1>input</h1></div>
				<div class="result shadow img-rounded"><h1>result</h1></div>
			</div>
		</div>
		
		
		<%@include file="functionMentee.jsp"%>
	</div>
</body>
</html>