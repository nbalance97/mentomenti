<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
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

<title>MOCO</title>

<link href="resources/css/all.min.css" rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<%@include file="menuPart1.jsp"%>

<div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800">그룹 개설하기</h1>
</div>

<div style="text-align: center">

	<table class="table" style="width: 80%; margin: 0 auto;">
		<tr style="width: 50px">
			<td>그룹 이름</td>
			<td><input type="text" id="name_text" style="width: 60%" /></td>
		</tr>
		<tr>
			<td>최대 인원 수</td>
			<td><input type="text" id="maxperson_text" style="width: 60%" />
		</tr>
		<tr>
			<td>그룹 분류</td>
			<td><select name="category">
					<option value=""></option>
					<option></option>
			</select></td>
			<td><input type="password" id="pw_current_text"
				style="width: 60%" /> <a href="#" onClick="chkPW()"
				class="btn btn-warning btn-sm" style="margin-left: 10px">확인</a></td>
		</tr>
		<tr>
			<td>소개글</td>
			<td><textarea id="intro_text" rows="4" style="width: 80%"></textarea></td>
		</tr>
		<tr>
			<td></td>
			<td style="text-align: right;"><a href="#" onClick="chkInput()"
				class="btn btn-primary">완료</a></td>
		</tr>
	</table>
</div>


<%@include file="menuPart2.jsp"%>