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

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<link href="resources/css/all.min.css" rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<%@include file="/WEB-INF/views/menuPart1.jsp"%>

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
				<td>
					<input type="text" name="groupName" id="name_text" style="width: 60%" />
				 	(<strong id="name_len">0</strong><span>/20자</span>)
				 </td>
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
				<td><select name="category" id="categorySelect" onChange="categoryChange()">
						<option value="C언어">C언어</option>
						<option value="Java">Java</option>
						<option value="Python">Python</option>
						<option value="기타">기타</option>
				</select> <input type="text" name="categoryText" id="category_text" placeholder="직접 입력"
					style="width: 40%" disabled />
			</tr>
			<tr>
				<td>소개글</td>
				<td>
					<textarea name="intro" id="intro_text" rows="4" style="width: 80%"></textarea>
				 	(<strong id="intro_len">0</strong><span>/100자</span>)
				</td>
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

<%@include file="/WEB-INF/views/menuPart2.jsp"%>


<script type="text/javascript">
	/*그룹 분류 '기타' 선택 시 직접 입력*/
	function categoryChange() {
		if (document.getElementById('categorySelect').value == "기타") {
			document.getElementById('category_text').disabled = false;
		} else {
			document.getElementById('category_text').value = ""
			document.getElementById('category_text').disabled = true;
		}
	}
	
	function chkInput(){
		var form = document.createGroupForm;
		var groupName = document.getElementById("name_text").value;
		var categoryText = document.getElementById("category_text");
		var category = categoryText.value;
		var intro = document.getElementById("intro_text").value;
		
		//그룹 명 길이 검사
		if(groupName.length < 5 || groupName.length > 20){
			alert("그룹 명은 5글자 이상, 20글자 이하로 작성해주세요");
			return;
		}
		
		//그룹 명에 [ 또는 ] 포함되어 있는지 검사
		if(groupName.indexOf('[') != -1 || groupName.indexOf(']') != -1){
			alert("그룹 명에는 [ 또는 ] 기호가 들어갈 수 없습니다.");
			return;
		}
		
		//그룹 분류 유효성 검사
		if((category.length < 4 || category.length > 15) && categoryText.disabled == false){
			alert("그룹 분류는 4글자 이상, 15글자 이하로 작성해주세요");
			return;
		}
		
		//소개글 길이 검사
		if(intro.length == 0){
			alert("그룹 소개글을 작성해주세요");
			return;
		}
		if(intro.length>100){
			alert("그룹 소개글은 100글자 이하로 작성해주세요");
			return;
		}
		
		//소개글 엔터 포함 여부 검사
		if(intro.indexOf('\n') != -1){
			alert("소개글에 엔터를 입력할 수 없습니다.");
			return;
		}
		
		form.submit();
	}
	
	//텍스트 입력할 때마다 글자 수 실시간 반영
    (function (window, $, undefined) {
    	//글자수 셀 대상, 글자수 표시 text
        var $name_text = $('#name_text'), $name_len = $('#name_len'),
        $intro_text = $('#intro_text'), $intro_len = $('#intro_len');

      //실시간 글자수 세기
        $name_text.keyup(function () {
            chkNameLength(this);
        });
        $intro_text.keyup(function () {
        	chkIntroLength(this);
        })

        function chkNameLength(objMsg) { //그룹 이름 길이 계산
            var pattern = /\r\n/gm;
            var vacuum_text;
            var vacuum_length;

            vacuum_text = $(objMsg).val();
            vacuum_length = lengthMsg($(objMsg).val());
            vacuum_text = vacuum_text.replace(pattern, '\n');
            $name_len.html(vacuum_text.length);//현재 글자수 반영
        }
        
        function chkIntroLength(objMsg) { //소개글 길이 계산
            var pattern = /\r\n/gm;
            var vacuum_text;
            var vacuum_length;

            vacuum_text = $(objMsg).val();
            vacuum_length = lengthMsg($(objMsg).val());
            vacuum_text = vacuum_text.replace(pattern, '\n');
            $intro_len.html(vacuum_text.length);//현재 글자수 반영
        }
        
        //텍스트 길이 계산
        function lengthMsg(obj_msg) {
            var nbytes = 0;
            var i;
            for (i = 0; i < obj_msg.length; i++) {
                var ch = obj_msg.charAt(i);
                if (encodeURIComponent(ch).length > 4) { // 한글일 경우
                    nbytes += 2;
                } else if (ch === '\n') { // 줄바꿈일 경우
                    if (obj_msg.charAt(i - 1) !== '\r') { // 하지만 밀려서 줄이 바뀐경우가 아닐때
                        nbytes += 1;
                    }
                } else { //나머지는 모두 1byte
                    nbytes += 1;
                }
            }
            return nbytes;
        }
    })(window, jQuery, undefined);
</script>