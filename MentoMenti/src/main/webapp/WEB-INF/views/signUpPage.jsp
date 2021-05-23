<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>MOCO_SIGNUP</title>

    <link href="resources/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
    <link href="resources/css/sb-admin-2.min.css" rel="stylesheet">
      <!-- JS, Popper.js, and jQuery -->
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
    integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
    crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
    integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
    crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
    integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
    crossorigin="anonymous"></script>
<style>
	@media screen and (max-width:995px){
		.leftSigninfo{
			width:100% !important;
			float:auto;
		}
		.rightSigninfo{
			width:100% !important;
			float:auto;
		}
	}
</style>
</head>
<body class="sidebar-toggled" style="background:#002266;">
	
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-xl-10 col-lg-12 col-md-9">
                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <div class="row text-center">
                            <div class="col-lg-6" style="max-width: 100%; flex: 0 0 100%;">
                            	<div class="p-4">
                            		<!-- 로고 이미지 -->
                            		<div class="text-center"><a href="/main"><img src="resources/img/logo3.png" style="width:170px"></a></div>
                            	</div>
                            	
                                <div class="p-3" style="text-align:center;">
                                    <!-- 회원가입 폼 태그 -->
                                    <form class="user" name="signupForm" action="processSignUp" method="post" style="width:100%;">
                                    	<div class="leftSigninfo" style="float:left; width:45%;">
                                    			<div class="form-group" style="display:flex;">
                                        	<!-- 아이디 입력 -->
                                            		<input type="text" class="form-control form-control-user" name="id" id="id" onkeydown="inputIdCheck()" placeholder="아이디">
                                        			<div style="float:right; width:20%; margin-left:3%; margin-top:1%; text-align:center;">
                                        				<input type="button" class="btn btn-primary" value="확인" onclick="confirmId(this.form)">
                                        				<input type="hidden" name="idDuplication" value="idUncheck">
                                        			</div>
                                        		</div>
                                    		<div style="font-size:12px;">※비밀번호는 숫자, 영어, 특수문자를 포함한 7글자이상으로 입력해주세요.</div>
                                        	<div class="form-group" style="display:flex;">
                                        	<!-- 비밀번호 입력 -->
                                            	<input type="password" class="form-control form-control-user" name="pw" id="pw" placeholder="비밀번호">
                                            	<input type="password" class="form-control form-control-user" name="pw_check" id="pw_check" placeholder="비밀번호확인">
                                        	</div>
                                        	<!-- 이름 입력 -->
                                        	<div class="form-group">
                                        		<input type="text" class="form-control form-control-user" name="name" id="name" placeholder="이름">
                                        	</div>
                                        	<!-- 닉네임 입력 -->
                                        	<div class="form-group" style="display:flex;">
                                        		<input type="text" class="form-control form-control-user" name="nickname" id="nickname" onkeydown="inputNickCheck()" placeholder="닉네임">
                                        		<div style="float:right; width:20%; margin-left:3%; margin-top:1%; text-align:center;">
                                        			<input type="button" class="btn btn-primary" value="확인" onclick="confirmNick(this.form)">
                                        			<input type="hidden" name="NickDuplication" value="NickUncheck">
                                        		</div>
                                        	</div>                                     
                                    	</div>
                                    	<div class="rightSigninfo" style="float:right; width:45%;">
                                        	<div class="form-group" style="margin-top:1%; display:flex;">
                                        		<div style="margin-top:2%;">생</div>
                                        		<div style="margin-top:2%;">일</div>
                                        		<div>&nbsp;</div>
                                        		<select name="year" id="year" title="년도" class="custom-select" onChange=setMonthBox()></select>
												<select name="month" id="month" title="월" class="custom-select" onChange="setDay()"></select>
												<select name="day" id="day" title="일" class="custom-select"></select>
                                        	</div>
                                        	<div class="form-group" style="display:flex;">
                                        		<input type="text" style="margin-top:2%; border-radius:50px; height:50px; font-size:12px;" class="form-control " name="email1" id="email1" placeholder="이메일">
                                        		<div>&nbsp;</div>
                                        		<h5 style="margin-top:5%;">@</h5>
                                        		<div>&nbsp;</div>
                                        		<input type="text" style="margin-top:2%; border-radius:50px; height:50px; font-size:12px;" class="form-control " name="email2" id="email2">
                                        		<select class="form-control" style="margin-top:2%; border-radius:50px; height:50px; font-size:12px;"  name="email_select" id="email_select" onChange="checkemailaddy();">
                                        			<option value="1" selected>직접입력</option>
    												<option value="naver.com">naver.com</option>
    												<option value="kyonggi.ac.kr">kyonggi.ac.kr</option>
    												<option value="hanmail.com">hanmail.com</option>
    												<option value="gmail.com">gmail.com</option>
                                        		</select>
                                        	</div>
                                        	<div class="form-group">
                                        		<textarea style="rows:100%; text-align:left;" class="form-control form-control-user" name="intro" placeholder="소개말을 넣어주세요"></textarea>
                                        	</div>                                        
                                        </div>
                                      <div style="float:right; width:100%;">
                                      	<input type="button" class="btn btn-user btn-block" value="취소" onclick="location.href='loginPage' " style="margin-bottom:3%;float:left; display: inline; width : 45%; background:#002266; color:white">                                    
                                    	<input type="button" class="btn btn-user btn-block" value="회원가입" onclick="checkSignup()" style="margin-top:0; float:right; display: inline; width : 45%; background:#002266; color:white;">                                                                              	
                                     </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <script src="js/sb-admin-2.min.js"></script>

	<script>
  		$(document).ready(function () {
    		setDateBox();
  		});
  		
  		function f_leapyear(yy)  //윤달 계산
  		{
  		 if (yy%4==0 && yy%100!=0 || yy%400==0)
  			return 1;
  		 else
  			return 0;
  		}
  		function setDay(){
  			var day;
  			var leafday;
    		var select_year = document.getElementById("year").value;
  			var select_month = document.getElementById("month").value;
  			var leafplus = f_leapyear(select_year);
  			
  			if(select_month == 1 || select_month == 3 || select_month == 5 || select_month == 7 ||
  					select_month == 8 || select_month == 10 || select_month == 12){
  				leafday = 31;
  			}else if(select_month == 4 || select_month == 6 || select_month == 9 || select_month == 11){
  				leafday = 30;
  			}else if(select_month == 2){
  				leafday = 28 + leafplus;
  			}
  			
  			$('#day').children('option:not(:first)').remove();
  		 	for (var i = 1; i <= leafday; i++) {
      			$("#day").append("<option value='" + i + "'>" + i + " 일" + "</option>");
    		}
    		
  		}
  		
  		function setMonthBox(){
  			$('#day').children('option:not(:first)').remove();
  			$('#month').children('option:not(:first)').remove();
  			for (var i = 1; i <= 12; i++) {
      			$("#month").append("<option value='" + i + "'>" + i + " 월" + "</option>");
    		}
  		}

  		// select box 연도 , 월 표시
  		function setDateBox() {
    		var dt = new Date();
    		var year = "";
   		    var com_year = dt.getFullYear();
   		    
   			 $("select option[value*='head_explain']").prop('disabled',true);

    		// 발행 뿌려주기
    		$("#year").append("<option value='' disabled selected hidden>년</option>");

    		// 올해 기준으로 -100년부터 올해까지를 보여준다.
    		for (var y = (com_year - 100); y <= (com_year); y++) {
      			$("#year").append("<option value='" + y + "'>" + y + " 년" + "</option>");
    		}
    		
    		// 월 뿌려주기(1월부터 12월)
    		var month;
    		$("#month").append("<option value='' disabled selected hidden>월</option>");
    		//for (var i = 1; i <= 12; i++) {
      		//	$("#month").append("<option value='" + i + "'>" + i + " 월" + "</option>");
    		//}

    		// 일 뿌려주기(1일부터 31일)
    		var day;
    		$("#day").append("<option value='' disabled selected hidden>일</option>");
   		    //for (var i = 1; i <= 31; i++) {
      		//	$("#day").append("<option value='" + i + "'>" + i + " 일" + "</option>");
    		//}

  		}
  		
  		function checkemailaddy(){
          	if (email_select.value == '1') {
              email2.readOnly = false;
              email2.value = '';
              email2.focus();
          	}
          	else {
              email2.readOnly = true;
              email2.value = email_select.value;
          	}
   		}
  		
		function checkSignup(){
			var form = document.signupForm;
			//아이디
			if(form.idDuplication.value != "idCheck"){
				alert("아이디 중복체크를 해주세요.");
				return false;
			}
			//비번
			var regPw = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{7,20}$/;
			if(form.pw.value==""){
				alert("비밀번호를 입력해주세요.");
				form.pw.focus();
				return false;
			}
			else if(form.pw.value.length>20 || form.pw.value.length<7){
				alert("비밀번호는 7~20자 이내로 입력가능합니다.");
				form.pw.focus();
				return false;
			}
			else if(!regPw.test(form.pw.value)){
				alert("비밀번호는 영문, 숫자, 특수문자의 조합이여야합니다.");
				form.pw.focus();
				return false;
			}
			//return false 존재 -> else if 필요x
			if(form.pw.value!=form.pw_check.value){
				alert("비밀번호를 확인해주세요");
				form.pw.focus();
				return false;
			}
			//이름
			if(form.name.value==""){
				alert("이름을 입력해주세요.");
				form.name.focus();
				return false;
			}
			else if(form.name.value.length>20){
				alert("이름은 20글자 이내로 입력가능합니다.");
				form.name.focus();
				return false;
			}
			//닉네임
			if(form.NickDuplication.value != "NickCheck"){
				alert("닉네임 중복체크를 해주세요.");
				return false;
			}
			//생년월일
			if(form.year.value=="" || form.month.value=="" || form.day.value==""){
				alert("생년월일을 확인해주세요.");
				return false;
			}
			
			//이메일_공백 및 양식체크
			var regEmail1 = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])/i;
			var regEmail2 = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			if(form.email1.value=="" || form.email2.value=="" 
					|| !regEmail1.test(form.email1.value) || !regEmail2.test(form.email2.value)){
				alert("이메일을 확인해주세요.");
				form.email1.focus();
				return false;
			}
			alert("회원가입 성공!");
			form.submit();
		}
		
		function inputIdCheck(){
			document.signupForm.idDuplication.value="idUncheck";
		}
		
		function confirmId(){
			var form = document.signupForm;
			if(form.id.value==""){
				alert("아이디를 입력해주세요.");
				form.id.focus();
				return false;
			}
			else if(form.id.value.length>20 || form.id.value.length<4){
				alert("아이디는 4~20글자 이내로 입력가능합니다.");
				form.id.focus();
				return false;
			}
			url = "confirmId?id="+form.id.value;
			open(url,"confirm",
					"left=500, top=200, toolbar=no, location=no, status=no, menubar=no, scrollbars=no,resizable=no, width=300, height=200");
		}
		
		function inputNickCheck(){
			document.signupForm.NickDuplication.value="NickUncheck";
		}
		
		function confirmNick(){
			var form = document.signupForm;
			if(form.nickname.value==""){
				alert("닉네임을 입력해주세요.");
				form.nickname.focus();
				return false;
			}
			else if(form.nickname.value.length>20 || form.nickname.value.length<2){
				alert("닉네임은 2~20글자 이내로 입력가능합니다.");
				form.nickname.focus();
				return false;
			}
			url = "confirmNick?nickname="+form.nickname.value;
			open(url,"confirm",
			"left=500, top=200, toolbar=no, location=no, status=no, menubar=no, scrollbars=no,resizable=no, width=300, height=200");
		}
		
</script>

</body>
</html>