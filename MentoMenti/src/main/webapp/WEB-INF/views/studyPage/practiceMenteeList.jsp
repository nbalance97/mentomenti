<!-- 멘티리스트확인기능 -->
<!-- 리스트-다음버튼,DB연동 등 필요 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
	th{
		font-weight:300px;
	}
</style>
    
<div class="list">
	<h3>피드백페이지 - 참여자</h3>
	<table class="table">
		<thead>
			<tr>
				<th>No.</th>
				<th>닉네임</th>
				<th>상태</th>
				<th>1:1</th>
			</tr>
		</thead>
		<tbody id="MemberTable">
		</tbody>
	</table>
</div>