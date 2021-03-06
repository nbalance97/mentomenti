<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>
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

<style>
#personalInfoTable {
	width:80%;
}

@media screen and (max-width:970px){
	#personalInfoTable{
		width:95%;
	}
}

.filebox input[type="file"] {
	display:none;
	width: 1px;
	height: 1px;
	padding: 0;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

.filebox .upload-name {
	padding: .5em .75em; /* label의 패딩값과 일치 */
	font-size: inherit;
	font-family: inherit;
	vertical-align: middle;
	background-color: #f5f5f5;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
	-webkit-appearance: none; /* 네이티브 외형 감추기 */
	-moz-appearance: none;
	appearance: none;
}
</style>
</head>

<script type="text/javascript">
	var isPwChecked = false;
	
	//비밀번호 확인
	function inputPwCheck(){
		isPwChecked = false;
	}
	
	function chkPw() {
		var pw1 = document.getElementById("new_pw_text").value;
		var pw2 = document.getElementById("pw_chk_text").value;
		var regPw = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{7,20}$/;
		
		if (pw1.length > 0) {	//비밀번호 변경 O
			if (pw1.length < 7 || pw1.length > 20)
				alert("비밀번호는 7~20글자 이내로 입력해주세요");
			else if(!regPw.test(pw1)){
				alert("비밀번호는 영문, 숫자, 특수문자의 조합이여야합니다.");
			}
			else if (pw1 != pw2)
				alert("변경할 비밀번호와 다릅니다. 다시 확인해주세요");
			else {
				alert("비밀번호 확인 완료");
				isPwChecked = true;
			}
		}
		//변경 안하는 경우에 alert 띄워야 할까..?	
	}

	//모든 조건을 만족했는지 확인 후 수정 완료
	function chkForm() {
		var form = document.changeForm;
		var nickname = document.getElementById("nickname_text").value; //닉네임
		var pw1 = document.getElementById("new_pw_text").value;	//변경할 비밀번호
		var pw2 = document.getElementById("pw_chk_text").value;	//변경할 비밀번호 확인
		var email = document.getElementById("email_text").value; //이메일
		var intro = document.getElementById("intro_text").value; //소개글
		
		var origin = document.getElementById("originNickUser").value;

		//닉네임 중복체크 여부 확인
		if(nickname!=origin){
			if(form.NickDuplication.value != "NickCheck"){
				alert("닉네임 중복체크를 해주세요.");
				return false;
			}
		}
		
		if (pw1.length > 0 || pw2.length > 0){	//비번 변경 시
			if(isPwChecked == false) {
				alert("비밀번호 확인을 해주세요");
				return;
			}
		} else {	//비번 변경 x
			isPwChecked == true
		}

		//이메일 형식 검사
		var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		if (!regExpEmail.test(email)) {
			alert("이메일 형식을 확인해주세요");
			return;
		}
		
		//소개글 길이 제한
		if (intro.length > 70){
			alert("소개글은 70글자 이하로 작성해주세요");
			return;
		}
		
		//소개글 엔터 포함 여부 검사
		if(intro.indexOf('\n') != -1){
			alert("소개글에 엔터를 입력할 수 없습니다.");
			return;
		}

		form.submit();
	}
	
	function inputNickCheck(){
		var nickChk = document.getElementById('NickDuplication');
		nickChk.value = "NickUncheck";
	}
	
	function confirmNick(){
		var nick = document.getElementById('nickname_text');
		var originNick = document.getElementById('originNickUser');
		if(nick.value==""){
			alert("닉네임을 입력해주세요.");
			return false;
		}
		else if(nick.value.length>9 || nick.value.length < 2){
			alert("닉네임은 2~9글자 이내로 입력해주세요.");
			return false;
		}
		url = "confirmNick_ch?nickname="+nick.value+"&origin="+originNick.value;
		open(url,"confirm",
		"left=500, top=200, toolbar=no, location=no, status=no, menubar=no, scrollbars=no,resizable=no, width=300, height=200");
	}
</script>

<%@include file="/WEB-INF/views/menuPart1.jsp"%>

<%
	String isPwChecked = (String) session.getAttribute("pwChk");

	if (id == null) { //로그인 안된 상태면 로그인 페이지로 이동
	response.sendRedirect("loginPage?mode=nidLogin");
	} else if (isPwChecked == null) {	//비밀번호 확인울 거치지 않고 접근 (url 수정을 통해 접근한 경우)
		response.sendRedirect("rejectedAccess?type=pwNotChecked");
	}
	else {
%>

<!-- 회원 정보 수정 페이지 -->
<div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800">회원 정보 수정</h1>
</div>

<div style="text-align: center">


	<!-- 프로필 이미지 -->
	
	<form action="processPersonalInfoChange?userid=<%=id%>" method="post" enctype="multipart/form-data" name="changeForm">
		<div class="filebox preview-image" style="text-align:center; margin-bottom:20px">
			<div class="profileImg rounded-circle" style="width:200px; height:200px; margin-bottom:30px;">
			<%
			File pngImg = new File("/root/user/"+id+".png");
			File jpgImg = new File("/root/user/"+id+".jpg");
			
			if (pngImg.exists()) {
			%>
				<div class="profileImg rounded-circle" style="width:200px; height:200px; margin-bottom:30px;">
					<img src="https://kgu.mentomenti.kro.kr/upload/<%=id%>.png" style="width:100%; height:100%; object-fit: cover;">
				</div>
			<%
			} else if (jpgImg.exists()){
			%>
				<div class="profileImg rounded-circle" style="width:200px; height:200px; margin-bottom:30px;">
					<img src="https://kgu.mentomenti.kro.kr/upload/<%=id%>.jpg" style="width:100%; height:100%; object-fit: cover;">
				</div>
			<%
			} else {	//기본 이미지
			%>
				<div class="profileImg rounded-circle" style="width:200px; height:200px; margin-bottom:30px;">
					<img src="resources/img/user/user.png" style="width:100%; height:100%; object-fit: cover;">
				</div>
			<%
				}
			%>
			</div>
			
			<!-- 프로필 사진 업로드 버튼 -->
			<input class="upload-name" value="파일선택" disabled="disabled">
			<label for="ex_filename" class="btn btn-success">업로드</label>
			<input type="file" id="ex_filename" class="upload-hidden" name="profileImg">
			<p style="font-size:14px;">※ png, jpg 파일만 업로드 가능합니다. ※</p>
			
			<!-- <label for="file" class="btn btn-success">프로필 등록</label> -->
			<!-- <input type="file" id="file" name="profileImg" style="display:none;"> -->
		</div>

		<%
		//세션에 등록된 아이디를 이용해 사용자 정보 가져오기
		UserDTO findUser = new UserDTO(null, null, null, null, null, null, null, false, null);
		findUser.setId(id);
		UserDTO loginUser = null;
		if (HomeController.dao.getUserDAO().searchUserById(findUser).size() > 0) {
			loginUser = HomeController.dao.getUserDAO().searchUserById(findUser).get(0);
		}
		%>
	
		<table class="table" id="personalInfoTable" style="margin: 0 auto;">
			<tr style="width: 50px">
				<td>이름</td>
				<td><input type="text" id="name_text"
					value=<%=loginUser.getName()%> disabled style="width: 60%" /></td>
			</tr>
			<tr>
				<td>아이디</td>
				<td><input type="text" id="id_text" value=<%=loginUser.getId() %>
					style="width: 60%" disabled />
			</tr>
			<tr>
				<td>닉네임</td>
				<td><input type="text" id="nickname_text" name="new_nickname" onkeydown="inputNickCheck()"
					value=<%=loginUser.getNickname()%> style="width: 60%" />
					<input type="button" onclick="confirmNick()"
					value="확인" class="btn btn-warning btn-sm" style="margin-left: 10px">
					<input type="hidden" id="NickDuplication" name="NickDuplication" value="NickUncheck">
					<%
						String searchNick = loginUser.getId();
						UserDTO user = new UserDTO(null, null, null, null, null, null, null, false, null);
						user.setId(searchNick);
						List<UserDTO> userAccount = HomeController.dao.getUserDAO().searchUserById(user);
						String originNick = userAccount.get(0).getNickname();
					%>
					<input type="hidden" id="originNickUser" name="originNickUser" value=<%=originNick%>>
					</td>
			</tr>
			<tr>
				<td>변경할 비밀번호</td>
				<td><input type="password" id="new_pw_text" name="new_pw" onkeydown="inputPwCheck()"
					style="width: 60%" /></td>
			</tr>
			<tr>
				<td>변경할 비밀번호 확인</td>
				<td><input type="password" id="pw_chk_text" onkeydown="inputPwCheck()"
					style="width: 60%" /> <input type="button" onClick="chkPw()"
					value="확인" class="btn btn-warning btn-sm" style="margin-left: 10px">
				</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="text" id="email_text" name="new_email"
					value=<%=loginUser.getEmail()%> style="width: 60%" /></td>
			</tr>
			<tr>
				<td>소개글</td>
				<td>
					<textarea id="intro_text" name="new_intro" rows="4" style="width: 80%; resize:none;"><%=loginUser.getIntro()%></textarea>
					(<strong id="intro_len">-</strong><span>/70자</span>)
				</td>
			</tr>
			<tr>
				<td></td>
				<td style="text-align: right;"><input type="button"
					onclick="chkForm()" value="완료" class="btn btn-primary"></td>
			</tr>
		</table>
	</form>
</div>

<c:set var="cur_pw" value="<%=userAccount.get(0).getPw()%>"></c:set>

<%
	}
%>

<%@include file="/WEB-INF/views/menuPart2.jsp"%>



<script type="text/javascript">

	//소개글 텍스트 입력할 때마다 글자 수 실시간 반영
    (function (window, $, undefined) {
    	//글자수 셀 대상, 글자수 표시 text
        var $intro_text = $('#intro_text'), $intro_len = $('#intro_len');

      	//실시간 글자수 세기
        $intro_text.keyup(function () {
            chkIntroLength(this);
        });
      
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
	
	
	//프로필 사진
    $(document).ready(function(){
    	var fileTarget = $('.filebox .upload-hidden');
    	fileTarget.on('change', function(){ // 값이 변경되면
    		if(window.FileReader){ // modern browser
    			var filename = $(this)[0].files[0].name;
    		} else { // old IE
    			var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출
    		}
    	
    		// 추출한 파일명 삽입
    		$(this).siblings('.upload-name').val(filename);
    	});
    	
    	var imgTarget = $('.preview-image .upload-hidden');
    	imgTarget.on('change', function(){
    		var parent = $(this).parent();
    		parent.children('.upload-display').remove();
    		parent.children('.profileImg').remove();
    		
    		if(window.FileReader){
    			if (!$(this)[0].files[0].type.match(/image\//)) return;
    			var reader = new FileReader();
    			reader.onload = function(e){
    				var src = e.target.result;
    				parent.prepend('<div class="upload-display profileImg rounded-circle" style="width:200px; height:200px; margin-bottom:30px;"><img src="'+src+'" style="width:100%; height:100%; object-fit: cover;"></div>');
    			}
    			reader.readAsDataURL($(this)[0].files[0]);
    		} else {
    			$(this)[0].select();
    			$(this)[0].blur();
    			var imgSrc = document.selection.createRange().text;
    			parent.prepend('<div class="upload-display profileImg rounded-circle" style="width:200px; height:200px; margin-bottom:30px;"><img src="'+src+'" style="width:100%; height:100%; object-fit: cover;"></div>');
    			
    			var img = $(this).siblings('.upload-display').find('img');
    			img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")";
    		}
    	});
    });
</script>