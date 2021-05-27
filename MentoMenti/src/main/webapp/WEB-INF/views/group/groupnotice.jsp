<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.PostDTO, Mento.Menti.Project.dao.PostDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupmateDTO, Mento.Menti.Project.dao.GroupmateDAO"%>
	
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

<%@include file="/WEB-INF/views/menuPart1.jsp"%>

<%
	int groupid = Integer.parseInt(request.getParameter("groupid"));
	GroupDTO group = HomeController.dao.getGroupDAO().searchGroupByGroupid(groupid);
	List<GroupmateDTO> groupmateList = HomeController.dao.getGroupmateDAO().selectMentiList(group.getGroupid());
	UserDTO user = new UserDTO();
	user.setId(id);
	boolean isAdmin = HomeController.dao.getUserDAO().searchUserById(user).get(0).is_admin();
	
	//자신이 개설 or 가입한 그룹 페이지에만 접근할 수 있도록
	boolean isMember = false;
	if (group.getMentoid().equals((String) session.getAttribute("userID")))
		isMember = true;
	for (GroupmateDTO gl : groupmateList) { //가입한 그룹인 경우
		if (gl.getId().equals((String) session.getAttribute("userID")))
			isMember = true;
	}
	if (!isMember && !isAdmin) { //관리자x & 해당 그룹의 멤버가 아니라면 접근 거부
		response.sendRedirect("rejectedAccess?type=notMember");
	}
%>
<%
	String strPage = request.getParameter("page");
	int curPage;
	if (strPage == null)	//기본값은 1
		curPage = 1;
	else curPage = Integer.parseInt(strPage);
	
	String groupname = HomeController.dao.getGroupDAO().searchGroupByGroupid(groupid).getName();
%>

<!-- 그룹 공지사항 페이지 -->

<div id="pageHeading" style="margin-bottom:20px">
	<p><a href="main" style="text-decoration : none; color:gray">Home</a>
	> <a href="joininggroups" style="text-decoration : none; color:gray">가입한 그룹</a>
	> <a href="group?groupid=<%=groupid%>" style="text-decoration : none; color:gray"><%=group.getName()%></a></p>
</div>

<div class="d-sm-flex align-items-center justify-content-between mb-4">
	
	<h1 class="h3 mb-0 text-gray-800">
		<a href="groupnotice?groupid=<%=groupid%>" class="text-gray-800 font-weight-500" style="text-decoration:none;">그룹 공지사항</a>
	</h1>
	<ul id="searchForm">
		<li>
			<form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search"
				action="groupnotice" method="GET">
				<div class="input-group">
					<input type="text" class="form-control border-0 small" name="keyword"
						placeholder="검색" aria-label="Search" aria-describedby="basic-addon2" id="searchText">
					<div class="input-group-append">
						<button class="btn btn-primary" type="submit">
							<img src="resources/img/menu/search.png" class="sidebar-icon" style="margin-right:0;">
						</button>
					</div>
				</div>
				<!-- 그룹 아이디 넘기기 -->
				<input type="text" name="groupid" value=<%=groupid%> style="display:none;"/>
			</form>
		</li>
	</ul>
</div>
<p class="mb-4"><a href="group?groupid=<%=groupid%>"><%=group.getName()%>
	그룹</a>의 공지사항입니다.
</p>


<!-- 리스트 -->
<table class="table table-bordered dataTable" id="dataTable"
	width="100%" cellspacing="0" role="grid"
	aria-describedby="dataTable_info"
	style="width: 100%; background: white; text-align: center;">
	<thead>
		<tr role="row">
			<th tabindex="0" rowspan="1" colspan="1" style="width: 60%">제목</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 15%;">작성자</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 15%;">작성일자</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 10%;">조회수</th>
		</tr>
	</thead>
	
	<tbody>
		<%
			String kwd = request.getParameter("keyword");	//검색 키워드
			List<PostDTO> groupNotices = null;
			if (kwd == null) {	//검색x, 그룹 공지 전체
				groupNotices = HomeController.dao.getPostDAO().selectGroupNotices(group.getGroupid());
			} else{	//검색o
				PostDTO searchNotice = new PostDTO();
				searchNotice.setTitle(kwd);
				searchNotice.setGroupid(groupid);	//검색 키워드, 그룹 아이디 넘김
				groupNotices = HomeController.dao.getPostDAO().searchGroupNotices(searchNotice);
			}
			
			if (groupNotices.size() == 0){
		%>
	</tbody>
</table>
	<div style="height:200px; text-align:center; line-height:200px">
		결과가 없습니다.		
	</div>
	
		<%
			} else {	//결과 있음
				for (int i=(curPage-1)*10; i<(curPage-1)*10+10;i++) {
					if(i==groupNotices.size()){
						break;
					}
					PostDTO gn = groupNotices.get(i);
					String writerNick = HomeController.dao.getUserDAO().selectNicknameById(gn.getUserid());	//작성자 아이디
					int cntComment = HomeController.dao.getCommentDAO().countComment(gn.getPostid());
		%>
		<tr role="row" class="odd">
			<td><!-- 제목 -->
				<a href="groupNoticeContent?postid=<%=gn.getPostid()%>"
					style="text-decoration: none; color: gray">
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
			<td><%=writerNick %></td> <!-- 작성자 -->
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
<input type="hidden" id="postSize" value="<%=groupNotices.size() %>"/>
<input type="hidden" id="gid" value="<%=groupid %>"/>
<input type="hidden" id="keyword" value="<%=kwd%>"/>	<!-- 검색 키워드 -->

<div class="d-flex align-items-center justify-content-between">
		<nav aria-label="Page navigation example" style="margin: 0 auto;">
  			<ul class="pagination justify-content-center" id="list-body">
    			<!-- 페이징 생성 -->
 			</ul>
		</nav>


	<%
		if (group.getMentoid().equals(id)){	//멘토인 경우에만 작성 버튼
	%>
	<div class="d-sm-flex justify-content-between">
		<div style="margin: 0 auto; float: right">
			<a href="writeGroupNoticePage?groupid=<%=groupid%>" class="btn btn-secondary">작성</a>
		</div>
	</div>
	<%
		}
	%>

</div>

<%@include file="/WEB-INF/views/menuPart2.jsp"%>
<script>
	//작성한 글 개수 가져오기
	var postData = document.getElementById("postSize").value;
	var curpage = document.getElementById("curPage").value;
	var groupid = document.getElementById("gid").value;
	var kwd = document.getElementById("keyword").value;
	$(document).ready(function () {
		paging(postData,curpage);//작성글수, 현재페이지 : activity?page=1??? getParameter
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
		
		if (kwd=="null")	{	//검색 x
			$('#list-body').empty();
			if(startPage > countPage){
				$("#list-body").append("<li class='page-item'><a class='page-link' href='groupnotice?page="+prev+"&groupid="+groupid+"'"+" aria-label='Next'><span aria-hidden='true'>&laquo;</span></a></li>");	
			}
			for(var j=startPage ; j<=endPage ; j++){
				if(currentPage==(j)){
					$("#list-body").append("<li class='page-item active'><a class='page-link' href='groupnotice?page=" + j + "&groupid="+groupid+"'>" + j + "</a></li>");
				}else if(j>0){
					$("#list-body").append("<li class='page-item'><a class='page-link' href='groupnotice?page=" + j + "&groupid="+groupid+"'>" + j + "</a></li>");		
				}
			}
			if(next > 5 && next < totalPage)
			$("#list-body").append("<li class='page-item'><a class='page-link' href='groupnotice?page="+next+"&groupid="+groupid+"'"+" aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>")
		}
		
		else {	//검색 o
			$('#list-body').empty();
			if(startPage > countPage){
				$("#list-body").append("<li class='page-item'><a class='page-link' href='groupnotice?page="+prev+"&groupid="+groupid+"&keyword="+kwd+"'"+" aria-label='Next'><span aria-hidden='true'>&laquo;</span></a></li>");	
			}
			for(var j=startPage ; j<=endPage ; j++){
				if(currentPage==(j)){
					$("#list-body").append("<li class='page-item active'><a class='page-link' href='groupnotice?page=" + j + "&groupid="+groupid+"&keyword="+kwd+"'>" + j + "</a></li>");
				}else if(j>0){
					$("#list-body").append("<li class='page-item'><a class='page-link' href='groupnotice?page=" + j + "&groupid="+groupid+"&keyword="+kwd+"'>" + j + "</a></li>");		
				}
			}
			if(next > 5 && next < totalPage)
			$("#list-body").append("<li class='page-item'><a class='page-link' href='groupnotice?page="+next+"&groupid="+groupid+"&keyword="+kwd+"'"+" aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>")
		}
	}
</script>