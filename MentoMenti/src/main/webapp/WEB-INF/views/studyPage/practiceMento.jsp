<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.WebCompiler.WebCompiler" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8"> 
	<title>practiceMento</title>
	<link href="/resources/css/bootstrap.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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
		height:20%;
		float:left;
		width:50%;
		margin-left:10px;
	}
	.compiler{
		height:50%;
	}
	.compiler, .input{
		margin-bottom:30px;
	}
	.problemImg{
		height:82vh;
		float:right;
		width:45%;
	}
	.execute{
		margin:20px;
		float: right;
	}
	h1{
		display:inline-block;
	}
		div[class="sidebar"]{
		width:300px;
		height:100%;
		position:fixed;
		top:0;
		background:#000;
		left:-300px;
		z-index:100;
		transition:all .35s;
		opacity: 0.8;
	}
	input[id="menuicon"]:checked +label + div{
		left:0;
	}
	input[id="menuicon"] +label {
		display:block;
		width:30px;
		height:25px;
		top:20px;
		position:fixed;
		left:0;
		transition:all .35s;
		cursor:pointer;
	}
	input[id="menuicon"]:checked +label {
		z-index:2;
		left:300px;
	}
	input[id="menuicon"]{
		display:none;
	}
	input[id="menuicon"]+label span{
		display:block;
		position:absolute;
		width:100%;
		height:5px;
		border-radius:30px;
		background:#fff;
		transition:all .35s;
	}
	input[id="menuicon"] + label span:nth-child(1){
		top:0;
	}
	input[id="menuicon"] + label span:nth-child(2){
		top:50%;
		transform:translateY(-50%);
	}
	input[id="menuicon"] + label span:nth-child(3){
		bottom:0;
	}
	input[id="menuicon"]:checked + label span:nth-child(1){
		top:50%;
		transform:translateY(-50%) rotate(45deg);
	}
	input[id="menuicon"]:checked + label span:nth-child(2){
		opacity:0;
	}
	input[id="menuicon"]:checked + label span:nth-child(3){
		bottom:50%;
		transform:translateY(50%) rotate(-45deg);
	}
	.content{ 
		color:white;
	}
	</style>
</head>
<body>
	<%@include file="studySidebar.jsp"%>
	<div class="main">
		<div class="coding">
			<div class="compiler shadow img-rounded"><h1>complie</h1>
			<button type="button" class="btn btn-info execute">execute</button>
			</div>
			<div class="problemImg shadow img-rounded"><h1>problem</h1></div>
			<div class="input shadow img-rounded"><h1>input</h1></div>
			<div class="result shadow img-rounded"><h1>result</h1></div>
		</div>
		<%@include file="studyPageFunction.jsp"%>
	</div>
</body>
</html>