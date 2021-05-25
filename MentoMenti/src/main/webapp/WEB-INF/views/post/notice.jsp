<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.PostDTO, Mento.Menti.Project.dao.PostDAO"%>
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
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<%@include file="/WEB-INF/views/menuPart1.jsp"%>

<%
	String strPage = request.getParameter("page");
	int curPage;
	if (strPage == null)	//기본값은 1
		curPage = 1;
	else curPage = Integer.parseInt(strPage);
%>

<!-- 공지사항 페이지 -->

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800">
		<a href="notice" class="text-gray-800 font-weight-500" style="text-decoration:none;">공지사항</a>
	</h1>
	<ul class="navbar-nav ml-auto">
		<li>
			<form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search"
				action="notice" method="GET">
				<div class="input-group">
					<input type="text" class="form-control border-0 small" name="keyword"
						placeholder="검색" aria-label="Search" aria-describedby="basic-addon2" id="searchText">
					<div class="input-group-append">
						<button class="btn btn-primary" type="submit">
							<img src="resources/img/menu/search.png" class="sidebar-icon" style="margin-right:0;">
						</button>
					</div>
				</div>
			</form>
		</li>
	</ul>
</div>
<p class="mb-4">모두의 코딩교실의 공지사항입니다.</p>


<!-- 리스트 -->
<table class="table table-bordered dataTable" id="dataTable"
	width="100%" cellspacing="0" role="grid"
	aria-describedby="dataTable_info"
	style="width: 100%; background: white; text-align: center;">
	<thead>
		<tr role="row">
			<th tabindex="0" rowspan="1" colspan="1" style="width: 60%">제목</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 15%;">작성자</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 15%;">작성 일자</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 10%;">조회수</th>
		</tr>
	</thead>
	
	<tbody>
		<%
			String kwd = request.getParameter("keyword");	//검색 키워드
			List<PostDTO> noticeList = null;
			if (kwd == null) {	//검색x, 전체 공지
				noticeList = HomeController.dao.getPostDAO().selectGeneralNotices();
			} else{	//검색o
				noticeList = HomeController.dao.getPostDAO().searchGeneralNotices(kwd);
			}
			
			
			if (noticeList.size() == 0){	//결과가 없다면
		%>
	</tbody>
</table>
	<div style="height:200px; text-align:center; line-height:200px">
		결과가 없습니다.		
	</div>
		
		<%
			}
			else {	//결과가 있다면
				for (int i=(curPage-1)*10; i<(curPage-1)*10+10;i++){
					//PostDTO gn: noticeList for(int i=(page-1)*3; i<(page-1)*3+3;i++) PostDTO post = posts.get(i);
					if(i==noticeList.size()){
						break;
					}
					PostDTO gn = noticeList.get(i);
					String writerNick = HomeController.dao.getUserDAO().selectNicknameById(gn.getUserid());	//작성자 아이디
					int cntComment = HomeController.dao.getCommentDAO().countComment(gn.getPostid());
		%>
		<tr role="row" class="odd">
			<td>
				<!-- 제목 -->
				<a href="noticeContent?postid=<%=gn.getPostid()%>" style="text-decoration: none; color: gray">
					<%=gn.getTitle() %>
					<% 
						if(cntComment > 0){	//댓글이 있는 게시물이면
					%>
					<span class="font-weight-500" style="color:#3162C7; margin:0px 3px">[<%=cntComment%>]</span>
					<%
						}
					%>
				</a>
			</td>
			<td><%=writerNick %></td>	<!-- 작성자 닉네임 -->
			<td><%=gn.getPostdate()%></td> <!-- 작성일자 -->
			<td><%=gn.getViewcount() %></td> <!-- 조회수 -->
		</tr>
		<%
				}
		%>
	</tbody>
</table>
		<%
			}
		%>


<!-- 페이지 버튼 -->
<input type="hidden" id="curPage" value="<%=curPage%>"/>
<input type="hidden" id="postSize" value="<%=noticeList.size() %>"/>
<input type="hidden" id="keyword" value="<%=kwd%>"/>	<!-- 검색 키워드 -->

<div class="d-flex align-items-center justify-content-between">
		<nav aria-label="Page navigation example" style="margin: 0 auto;">
  			<ul class="pagination justify-content-center" id="list-body">
    			<!-- 페이징 생성 -->
 			</ul>
		</nav>

	<%
		if (id != null) {	//로그인상태
			if (HomeController.dao.getUserDAO().isAdmin(id)){	//관리자일때
	%>

	<div class="d-sm-flex justify-content-between">
		<div style="margin: 0 auto; float: right">
			<a href="writeNoticePage" class="btn btn-secondary">작성</a>
		</div>
	</div>
	
	<%
			}
		}
	%>
	
</div>

<%@include file="/WEB-INF/views/menuPart2.jsp"%>
<script>
	//공지사항 개수 가져오기
	var postData = document.getElementById("postSize").value;
	var curpage = document.getElementById("curPage").value;
	var kwd = document.getElementById("keyword").value;
	$(document).ready(function () {
		paging(postData,curpage);
	});

	function paging(totalData, currentPage){
		
		var dataPerPage = 10; //한 페이지에 보여지는 데이터 수
		var countPage = 5; //한번에 보여지는 페이지 수
		
		//총페이지수
		var totalPage = totalData / dataPerPage;
		if(totalData%dataPerPage>0){
			totalPage++;
		}
		
		//보여지는 페이지번호
		var startPage = Math.floor(((currentPage-1)/countPage))*countPage+1;//이유모르겠는디 오름으로 인식함->floor로 내림을 해줘야함,,,
		var endPage = startPage + countPage-1;
		if(endPage>totalPage){
			endPage = totalPage;
		}
		const prev = startPage-1;
		const next = endPage+1;
		
		if (kwd=="null"){	//검색 x
			$('#list-body').empty();
			if(startPage > countPage){
				$("#list-body").append("<li class='page-item'><a class='page-link' href='notice?page="+prev+"'"+" aria-label='Next'><span aria-hidden='true'>&laquo;</span></a></li>");	
			}
			for(var j=startPage ; j<=endPage ; j++){
				if(currentPage==(j)){
					$("#list-body").append("<li class='page-item active'><a class='page-link' href='notice?page=" + j + "'>" + j + "</a></li>");
				}else if(j>0){
					$("#list-body").append("<li class='page-item'><a class='page-link' href='notice?page=" + j + "'>" + j + "</a></li>");		
				}
			}
			if(next > 5 && next < totalPage)
			$("#list-body").append("<li class='page-item'><a class='page-link' href='notice?page="+next+"'"+" aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>")
		}
		
		else {	//검색 o
			$('#list-body').empty();
			if(startPage > countPage){
				$("#list-body").append("<li class='page-item'><a class='page-link' href='notice?page="+prev+"&keyword="+kwd+"'"+" aria-label='Next'><span aria-hidden='true'>&laquo;</span></a></li>");	
			}
			for(var j=startPage ; j<=endPage ; j++){
				if(currentPage==(j)){
					$("#list-body").append("<li class='page-item active'><a class='page-link' href='notice?page=" + j + "&keyword="+kwd+ "'>" + j + "</a></li>");
				}else if(j>0){
					$("#list-body").append("<li class='page-item'><a class='page-link' href='notice?page=" + j + "&keyword="+kwd+ "'>" + j + "</a></li>");		
				}
			}
			if(next > 5 && next < totalPage)
			$("#list-body").append("<li class='page-item'><a class='page-link' href='notice?page="+next+"&keyword="+kwd+"'"+" aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>")
		}
	} 
</script>