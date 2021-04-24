<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController" %>
<%@ page import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<style>
.text1{ font-family: 'Source Code Pro', monospace;}
.text2{ font-family: 'Source Code Pro', monospace;}

h1.text1{
font-size:30px;
COLOR : #000000;
left : 200;
margin-bottom : 30;
position : relative;
text-align: center;
}

h1.text2{
font-size:30px;
COLOR : #000000;
left : 700;
top : -439;
margin-bottom : 30;
position : relative;
}

</style>

<title>MOCO</title>

<link href="resources/css/all.min.css" rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">
<link href="resources/css/sidebar.css" rel="stylesheet" type="text/css">
<link href="resources/css/component.css" rel="stylesheet"
	type="text/css">

</head>

<%@include file="menuPart1.jsp"%>


<div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="text1">Mento Groups</h1>
</div>
<img src="resources/img/mento.png"
style = "display : block; margin-left : 200; width : 250px; height : 250px;">


 <div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="text2">Menti Groups</h1>
</div>

<img src="resources/img/menti.png"
style = "display : block; margin-left : 700px; width : 250px;
height : 250px; top : -439px; position : relative;">



<table class="table table-bordered dataTable" id="dataTable"
	width="100%" cellspacing="0" role="grid"
	aria-describedby="dataTable_info"
	style="width: 400px; background: white; text-align: center; top : -330; left: 100; position : relative;">
	<thead>
		<tr>
			<th style="width: 55px">그룹명</th>
			<th style="width: 25px;">멤버 수</th>

		</tr>
	</thead>

</table>

<table class="table table-bordered dataTable" id="dataTable"
	width="100%" cellspacing="0" role="grid"
	aria-describedby="dataTable_info"
	style="width: 400px; background: white; text-align: center; top : -395; left: 620; position : relative;">
	<thead>
		<tr>
			<th style="width: 55px" >그룹명</th>
			<th style="width: 25px;">멤버 수</th>

		</tr>
	</thead>

</table>

<%@include file="menuPart2.jsp"%>
</html>