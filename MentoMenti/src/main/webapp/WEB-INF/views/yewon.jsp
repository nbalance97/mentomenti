
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
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>

</head>



<%@include file="menuPart1.jsp"%>

<div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800">개설된 그룹</h1>
	<ul class="navbar-nav ml-auto">
		<li>
			<form
				class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
				<div class="input-group">
					<input type="text" class="form-control border-0 small"
						placeholder="검색" aria-label="Search"
						aria-describedby="basic-addon2">
					<div class="input-group-append">
						<button class="btn btn-primary" type="button">
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

<div class="row">
	<div class="col-xl-3 col-md-6 mb-4">
		<div class="card border-left-primary shadow h-100 py-2">
			<a href="openedGroups?category=C" style="text-decoration: none;">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="h5 mb-0 font-weight-bold text-gray-800">C언어 그룹</div>
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
		<div class="card border-left-success shadow h-100 py-2">
			<a href="openedGroups?category=Java" style="text-decoration: none;">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="h5 mb-0 font-weight-bold text-gray-800">Java 그룹</div>
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
		<div class="card border-left-info shadow h-100 py-2">
			<a href="openedGroups?category=Python" style="text-decoration: none;">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">Python
								그룹</div>
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
		<div class="card border-left-warning shadow h-100 py-2">
			<a href="openedGroups?category=Etc" style="text-decoration: none;">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="h5 mb-0 font-weight-bold text-gray-800">기타 그룹</div>
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




<div class="d-sm-flex align-items-center justify-content-between mb-4">
	<h5 class="h5 mb-0 text-gray-800">그룹 목록</h5>
</div>

<!-- 그룹 목록 -->
<div class="row" id="groupList">

<%
	List<GroupDTO> groups = HomeController.dao.getGroupDAO().selectGroups();
	boolean showAll = false;	//DB에 저장된 그룹 전체를 목록에 불러왔는지
	int cntShowGroupIndex = 0;	//지금까지 출력한 그룹의 인덱스 저장
	int i = 0;	//for문에서 사용할 변수
%>

<!-- jstl문 활용해서 groups에 실제 group 넣어 줌 -->
<c:set var="groups" value="<%=groups%>"></c:set> 

<script type="text/javascript">
	var cntShowGroupIndex = 0;
	var group = new Array();
	
	/* jstl문 활용해서 group Array에 넣어준 다음에 활용~~*/
	<c:forEach items="${groups}" var="group">
		group.push({
			name: "${group.name}",
			category: "${group.category}",
			intro: "${group.intro}",
			mentoid: "${group.mentoid}",
			maxperson: "${group.maxperson}"
		});
	</c:forEach>
	
	$(document).ready(function(){
		var testFunc = function(){
			for (var i = cntShowGroupIndex; i < cntShowGroupIndex+9; i++) {
				if (i >= group.length) // 읽어들인 크기보다 커지면
					break;
				
				$('<div class="col-lg-4"><div class="card shadow mb-4"><div class="card-header py-3">'
						+'<h5 class="m-0 font-weight-bold text-primary">'+group[i].name
						+'<a href="#" class="btn btn-warning btn-circle btn-sm" style="float: right"><i class="fas fa-check"></i></a></h5></div>'
						+'<div class="card-body">'
						+'<p>과목 : '+group[i].name+'</p>'
						+'<p>설명 : '+group[i].intro+'</p>'
						+'<p>멘토 : '+group[i].mentoid+'</p>'
						+'<p>인원 수 : '+'(현재 인원수)/'+group[i].maxperson+'</p></div></div>').appendTo('#groupList');
			}
			
			cntShowGroupIndex += 9;
			alert(cntShowGroupIndex);
		};
		
		testFunc();
		
		
		//스크롤시 추가 로딩하는 부분
		$(window).scroll(function(){
			var scrollHeight = $(window).scrollTop() + $(window).height();
			var documentHeight = $(document).height();
			
			if(scrollHeight == documentHeight){
				testFunc();
			}
		});
});
</script>


<!--
<script type="text/javascript">
	$(document).ready(function(){
		var appendDocument = function(){
			for(var i=0; i<9; i++){
				$('<div class="col-lg-4"><div class="card shadow mb-4"><div class="card-header py-3">'
						+'<h5 class="m-0 font-weight-bold text-primary">'+'그룹 이름'
						+'<a href="#" class="btn btn-warning btn-circle btn-sm" style="float: right"><i class="fas fa-check"></i></a></h5></div>'
						+'<div class="card-body">'
						+'<p>과목 : '+'C언어'+'</p>'
						+'<p>설명 : '+'병훈짱이 캐리하는 그룹입니다'+'</p>'
						+'<p>멘토 : '+'이병훈'+'</p>'
						+'<p>인원 수 : '+'5/10'+'</p></div></div>').appendTo('#groupList');
			}
		};
		appendDocument();
	
		$(window).scroll(function(){
			var scrollHeight = $(window).scrollTop() + $(window).height();
			var documentHeight = $(document).height();
			
			if(scrollHeight == documentHeight){
				appendDocument();
			}
		});
	});
</script>
-->

</div>



<!-- 그룹 개설 버튼, 화면 고정 -->
<a href="createGroupPage" class="btn btn-success btn-circle"
	style="position: fixed; right: 70px; bottom: 20px; width: 70px; height: 70px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3)">
	<h1>+</h1>
</a>

<%@include file="menuPart2.jsp"%>