<!-- 멘티리스트확인기능 -->
<!-- 리스트-다음버튼,DB연동 등 필요 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.list{
		float:right;
		width:25%;
		height:345px;<!--345-->
	}
</style>
</head>
<body>
	<div class="list img-rounded shadow">
		<h1>참여자</h1>
		<table class="table table-hover"">
			<thread>
				<th>No.</th>
				<th>이름</th>
				<th>역할</th>
			</thread>
			<tbody>
				<tr class="active">
					<td>1</td>
					<td>홍길동</td>
					<td>멘티</td>
				</tr>
				<tr class="active">
					<td >1</td>
					<td>홍길동</td>
					<td>멘티</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>