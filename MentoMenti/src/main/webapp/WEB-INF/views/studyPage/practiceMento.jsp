<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.WebCompiler.WebCompiler" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>pracMento</title>
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
	}
	.function{
		width:100%;
		height:10%;
		background:white;
		padding:20px;
		clear: both;
		background:#white;
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
		width:100%;
		padding:30px;
		float:left;
		background:#A4E5F8;
	}
	.compiler, .input{
		height:70%;
		width:49%;
	}
	.result{
		margin-top:20px;
		height:30%;
		width:100%;
	}
	.compiler, .result{
		float:left;
	}
	.input{
		float:right;
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
	.list, .chating{
		overflow:auto;
		height:50vh;
	}
	</style>
</head>
<body>
	<input type="checkbox" id="menuicon">
		<label for="menuicon">
			<span></span>
			<span></span>
			<span></span>
		</label>
	<div class="sidebar">
		<div class="content">
			<div class="list">
				<h1>참여자</h1>
				<table class="table table-hover"">
					<thread>
						<th>No.</th>
						<th>이름</th>
						<th>역할</th>
					</thread>
					<tbody>
						<tr>
							<td>1</td>
							<td>홍길동</td>
							<td>멘티</td>
						</tr>
						<tr>
							<td >1</td>
							<td>홍길동</td>
							<td>멘티</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="chating">
				<h1>채팅</h1>
			</div>
		</div>
	</div>
	<div class="main">
		<div class="coding">
			<div class="compiler shadow img-rounded"><h1>compile</h1></div>
			<div class="input shadow img-rounded"><h1>input</h1></div>
			<div class="result shadow img-rounded"><h1>result</h1></div>
		</div>
	</div>

		<div class="function">
			<ul>					
				<li><a href="#"><i class="fas fa-pencil-alt fa-3x"></i></a></li>
				<li><a href="#"><i class="fas fa-eraser fa-3x"></i></a></li>
				<li><a href="#"><i class="fas fa-microphone fa-3x"></i></a></li>
				<li><a href="#"><i class="fas fa-desktop fa-3x"></i></a></li>
				<li><a href="#"><i class="fas fa-exchange-alt fa-3x"></i></a></li>
				<li class="exit"><a href="#"><i class="fas fa-sign-out-alt fa-2x"></i></a></li>
			</ul>
		</div>
</body>
</html>