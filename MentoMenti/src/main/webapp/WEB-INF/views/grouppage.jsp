<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<style>
.text1{ font-family: 'Nanum Gothic', sans-serif;}
.text2{ font-family: 'Nanum Gothic', sans-serif;}
.text3{ font-family: 'Nanum Gothic', sans-serif;}
.text4{ font-family: 'Nanum Gothic', sans-serif;}
h1.text1{
font-size:30px;
COLOR : #5F5F5F;
position : relative;

}

h1.text2{
font-size:30px;
COLOR : #5F5F5F;
position : relative;
left : 100;
top : -361;
text-align: center;
}

h1.text3{
font-size:30px;
COLOR : #5F5F5F;

}

h1.text4{
font-size:30px;
COLOR : #5F5F5F;
position : relative;
text-align: center;
left : 100;
top : -152;

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

<!-- 공지사항 페이지 -->

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="text1">가입멤버</h1>

</div>


<!-- 리스트1 -->
<table class="table table-bordered" id="dataTable" width="40%"
	cellspacing="0" role="grid" aria-describedby="dataTable_info"
	style="width: 40%; background: white; text-align: center;">
	<thead>
		<tr role="row">
			<th tabindex="0" rowspan="1" colspan="1" style="width: 90px;">역할</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 150px;">이름</th>
		</tr>
	</thead>
	<tbody>
		<%
			for (int i = 1; i < 5; i++) {
		%>
		<tr role="row" class="odd">
			<td><%= i %></TD>
			<td></td>
		</tr>
		<%
			}
		%>
	</tbody>
</table>

	<h1 class="text2">공지사항</h1>
	<h1 class="text3">개설수업</h1>


	 	<form>
    		<button type="submit" class="btn btn-primary" style="width: 40%; margin-bottom : 10px; margin-top : 20px" >입장</button>      
		</form>
    	 <form>
   			 <button type="submit" class="btn btn-info" style="width: 40%">개설</button>
   		 </form>
   		 
   		 
 	<h1 class="text4">Q & A</h1> 		 

<%@include file="menuPart2.jsp"%>
</html>