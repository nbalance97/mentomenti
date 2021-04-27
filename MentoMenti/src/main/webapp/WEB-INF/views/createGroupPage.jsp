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

<script type="text/javascript">
	var categorySelect;
	var categoryText;

	window.onload = function() {
		categorySelect = document.getElementById('category_select');
		categoryText = document.getElementById('category_text');
	}

	function categoryChange() {
		if (categorySelect.value == "기타") {
			categoryText.disabled = false;
		} else {
			categoryText.disabled = true;
		}
	}
	
	function chkInput(){
		var form = document.createGroupForm;
		var groupName = document.getElementById("name_text").value;
		if(groupName.length < 5){
			alert("그룹 명은 5글자 이상으로 작성해주세요");
			return;
		}
		form.submit();
	}
</script>


<%@include file="menuPart1.jsp"%>

<%
	if (id == null){	//로그인 안된 상태면 로그인 페이지로 이동
		response.sendRedirect("loginPage?mode=nidLogin");
	} else {
%>

<div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800">그룹 개설하기</h1>
</div>

<div style="text-align: center">
	<form action="processCreateGroup" name="createGroupForm" method="post">
		<table class="table" style="width: 80%; margin: 0 auto;">
			<tr style="width: 50px">
				<td>그룹 이름</td>
				<td><input type="text" name="groupName" id="name_text" style="width: 60%" /></td>
			</tr>
			<tr>
				<td>최대 멘티 수</td> <!-- 멘티 1 ~ 5명 -->
				<td>
					<select name="maxPerson" id="max_person">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
					명
				</td>
			</tr>
			<tr>
				<td>그룹 분류</td>
				<td><select name="category" id="category_select" onChange="categoryChange()">
						<option value="C언어">C언어</option>
						<option value="Java">Java</option>
						<option value="Python">Python</option>
						<option value="기타">기타</option>
				</select> <input type="text" name="categoryText" id="category_text" placeholder="직접 입력"
					style="width: 40%" disabled />
			</tr>
			<tr>
				<td>소개글</td>
				<td><textarea name="intro" id="intro_text" rows="4" style="width: 80%"></textarea></td>
			</tr>
			<tr>
				<td></td>
				<td style="text-align: right;">
				<input type="button" onclick="chkInput()" class="btn btn-primary" value="완료"/></td>
			</tr>
		</table>
	</form>
</div>

<%
	}
%>

<%@include file="menuPart2.jsp"%>