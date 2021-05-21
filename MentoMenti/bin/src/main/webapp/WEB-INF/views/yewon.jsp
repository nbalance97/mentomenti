<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
<link href="resources/css/groupCard.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>

</head>

<%@include file="/WEB-INF/views/menuPart1.jsp"%>

<div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800">개설된 그룹</h1>
	<ul class="navbar-nav ml-auto">
		<li>
			<!-- 그룹 검색 기능 구현해야 함 -->
			<form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search"
				action="openedGroups" method="GET">
				<div class="input-group">
					<input type="text" class="form-control border-0 small" name="keyword"
						placeholder="그룹 명 검색" aria-label="Search"
						aria-describedby="basic-addon2">
					<div class="input-group-append">
						<button class="btn btn-primary" type="submit">
							<i class="fas fa-search fa-sm"></i>
						</button>
					</div>
				</div>
			</form>
		</li>
	</ul>
</div>
<p class="mb-4">스터디에 참여할 그룹을 찾아보세요.</p>


<!-- 컴파일러가 C언어, 자바, 파이썬을 지원하므로 해당 언어들과 기타 그룹으로 분류해서 보여줌 (추후 수정 가능성) -->
<hr>
<div class="d-sm-flex align-items-center justify-content-between mb-4">
	<h5 class="h5 mb-0 text-gray-800">그룹 분류</h5>
</div>
<div class="row">
	<div class="col-xl-3 col-md-6 mb-4">
		<div class="card shadow border-left-primary">
			<a id="sortAction" href="openedGroups?category=C" style="text-decoration: none;">
				<div class="card-body sortscreen">
					<span style="background:#4e73df;"></span>
					<span style="background:#4e73df;"></span>
					<span style="background:#4e73df;"></span>
					<span style="background:#4e73df;"></span>
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="h5 mb-0 font-weight-bold text-gray-800">C언어</div>
						</div>
						<div class="col-auto">
							<div class="font-weight-bold text-primary mb-1">
								(
								<!-- C언어 그룹 수 -->
								<%
									List<GroupDTO> groupsC = HomeController.dao.getGroupDAO().selectGroupsC();
								out.println(groupsC.size());
								%>)
							</div>
						</div>
					</div>
				</div>
			</a>
		</div>
	</div>

	<div class="col-xl-3 col-md-6 mb-4">
		<div class="card shadow border-left-success">
			<a id="sortAction" href="openedGroups?category=Java" style="text-decoration: none;">
				<div class="card-body sortscreen">
					<span style="background:#1cc88a;"></span>
					<span style="background:#1cc88a;"></span>
					<span style="background:#1cc88a;"></span>
					<span style="background:#1cc88a;"></span>
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="h5 mb-0 font-weight-bold text-gray-800">Java</div>
						</div>
						<div class="col-auto">
							<div class="font-weight-bold text-primary mb-1">
								(
								<!-- Java 그룹 수 -->
								<%
									List<GroupDTO> groupsJava = HomeController.dao.getGroupDAO().selectGroupsJava();
								out.println(groupsJava.size());
								%>)
							</div>
						</div>
					</div>
				</div>
			</a>
		</div>
	</div>

	<div class="col-xl-3 col-md-6 mb-4">
		<div class="card shadow border-left-info">
			<a id="sortAction" href="openedGroups?category=Python" style="text-decoration: none;">
				<div class="card-body sortscreen">
					<span style="background:#36b9cc;"></span>
					<span style="background:#36b9cc;"></span>
					<span style="background:#36b9cc;"></span>
					<span style="background:#36b9cc;"></span>
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">Python</div>
						</div>
						<div class="col-auto">
							<div class="font-weight-bold text-primary mb-1">
								(
								<!-- Python 그룹 수 -->
								<%
									List<GroupDTO> groupsPython = HomeController.dao.getGroupDAO().selectGroupsPython();
									out.println(groupsPython.size());
								%>)
							</div>
						</div>
					</div>
				</div>
			</a>
		</div>
	</div>

	<div class="col-xl-3 col-md-6 mb-4">
		<div class="card shadow border-left-warning">
			<a id="sortAction" href="openedGroups?category=Etc" style="text-decoration: none;">
				<div class="card-body sortscreen">
					<span style="background:#f6c23e;"></span>
					<span style="background:#f6c23e;"></span>
					<span style="background:#f6c23e;"></span>
					<span style="background:#f6c23e;"></span>
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="h5 mb-0 font-weight-bold text-gray-800">기타</div>
						</div>
						<div class="col-auto">
							<div class="font-weight-bold text-warning mb-1">
								(
								<!-- 기타 그룹 수 -->
								<%
									List<GroupDTO> groupsEtc = HomeController.dao.getGroupDAO().selectGroupsEtc();
								out.println(groupsEtc.size());
								%>)
							</div>
						</div>
					</div>
				</div>
			</a>
		</div>
	</div>
</div>

<hr>
<div class="d-sm-flex align-items-center justify-content-between mb-4">
	<h5 class="h5 mb-0 text-gray-800">그룹 목록</h5>
</div>


<div class="row" id="groupList">
<%
	List<GroupDTO> groups = null;
	String kwd = request.getParameter("keyword");	//검색 키워드
	String category = request.getParameter("category");	//분류
	
	//검색했으면 검색 결과 출력
	if (kwd != null){
		groups = HomeController.dao.getGroupDAO().searchGroupsByName(kwd);
	}
	//선택한 분류에 따라 그룹 목록 다르게 출력
	else if (category == null){
		groups = HomeController.dao.getGroupDAO().selectGroups();	//그룹 목록 DB에서 불러오기
	} else if (category.equals("C")){
		groups = groupsC;
	} else if (category.equals("Java")){
		groups = groupsJava;
	} else if (category.equals("Python")){
		groups = groupsPython;
	} else {
		groups = groupsEtc;
	}
	//groups에 출력할 그룹 목록 담김
	
	//각 그룹에 대한 멘티 수를 저장할 배열
	int[] mentiCnts = new int[groups.size()];
	//멘티 수 구하기
	for (int i=0; i<groups.size(); i++){
		int groupId = groups.get(i).getGroupid();
		mentiCnts[i] = HomeController.dao.getGroupmateDAO().cntMenti(groupId);
	}
%>

<!-- jstl문 활용해서 groups에 실제 group, 멘티 수 넣어 줌 -->
<c:set var="groups" value="<%=groups%>"></c:set>
<c:set var="mentiCnts" value="<%=mentiCnts%>"></c:set>

<script type="text/javascript">
	var cntShowGroupIndex = 0;
	var group = new Array();
	var mentiCnt = new Array();
	
	/*group Array에 그룹 정보 저장*/
	<c:forEach items="${groups}" var="group">
		group.push({
			groupid: "${group.groupid}",
			name: "${group.name}",
			category: "${group.category}",
			intro: "${group.intro}",
			mentoid: "${group.mentoid}",
			maxperson: "${group.maxperson}"
		});
	</c:forEach>
	
	//mentiCnt Array에 멘티 수 저장
	<c:forEach items="${mentiCnts}" var="mentiCnt">
		mentiCnt.push({
			cnt: "${mentiCnt}"
		});
	</c:forEach>
	
	$(document).ready(function(){
		var showGroups = function(){
			for (var i = cntShowGroupIndex; i < cntShowGroupIndex+9; i++) {
				if (i >= group.length) // 읽어들인 크기보다 커지면
					break;
				
				$('<div class="col-lg-4"><a id="cardAction"><div class="card shadow mb-4"><div class="card-header py-3">'
						+'<h5 class="m-0 text-primary">'
						+'<span class="font-weight-500">'+group[i].name+'</span>'
						+'<div class="btn btn-warning btn-circle btn-sm" style="float: right;"'
						+'onclick="chkAbleToJoin(' + "'" + group[i].mentoid + "', '" + group[i].groupid + "'" + ')">'
						+'<img src="resources/img/right-arrow.png" style="width:100%"></h5></div>'
						+'<div class="card-body cardscreen">'
						+'<div class="introbottom">'
						+'<p class="introheader"><em>스터디 소개</em><p>'
						+'<p class="introheader">'+group[i].intro+'</p>'+'</div>'
						
						+'<p>과목 : '+group[i].category+'</p>'
						+'<p>멘토 : '+group[i].mentoid+'</p>'
						+'<p>인원 수 : '+mentiCnt[i].cnt+'/'+group[i].maxperson+'</p></div></a></div>').appendTo('#groupList');
			}
			cntShowGroupIndex += 9;
		};
		
		showGroups();
		
		
		//스크롤시 추가 로딩하는 부분
		$(window).scroll(function(){
			var documentHeight = $(document).height();
			var scrollHeight = $(window).scrollTop() + $(window).height();
			
			//if(scrollHeight == documentHeight){
			//if(documentHeight == scrollHeight){
			if(scrollHeight >= documentHeight){
				showGroups();
			}
		});
	});
	
	function chkAbleToJoin(mentoid, groupid){
	    if (confirm("그룹에 가입하시겠습니까?")) {
	    	location.href = "processJoinGroup?mentoid=" + mentoid + "&groupid=" + groupid;
	    }
	}
</script>
</div>

<!-- 그룹 개설 버튼, 화면 고정 -->
<a href="createGroupPage" class="btn btn-success btn-circle"
	style="position: fixed; right: 70px; bottom: 20px; width: 80px; height: 80px;
			box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3); z-index:2">
	<h1>+</h1>
</a>

<%@include file="/WEB-INF/views/menuPart2.jsp"%>