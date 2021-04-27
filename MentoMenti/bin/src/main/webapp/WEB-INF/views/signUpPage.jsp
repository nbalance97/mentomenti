<!-- 오류처리 하나도안함,,, 해야함,,, ex아이디중복 내용없을시alert -->
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

</head>

<body class="sidebar-toggled" style="background:#002266">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-xl-10 col-lg-12 col-md-9">
                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <div class="row text-center">
                            <div class="col-lg-6" style="max-width: 100%; flex: 0 0 100%;">
                            	<div class="p-4">
                            		<!-- 로고 이미지 -->
                            		<div class="text-center"><img src="resources/img/logo3.png" style="width:170px"></div>
                            	</div>
                            	
                                <div class="p-3" style="text-align:center;">
                                    <!-- 회원가입 폼 태그 -->
                                    <form class="user" action="processSignUp" method="post" style="width:100%;">
                                    
                                    	<div style="float:left; width:45%;">
                                    			<div class="form-group" style="display:flex;">
                                        	<!-- 아이디 입력 -->
                                            		<input type="text" class="form-control form-control-user" name="idInput" placeholder="아이디">
                                        			<div style="float:right; width:20%; margin-left:3%; margin-top:1%; text-align:center;">
                                        				<button type="button" class="btn btn-primary">확인</button>
                                        			</div>
                                        		</div>
                                    		
                                        	<div class="form-group">
                                        	<!-- 비밀번호 입력 -->
                                            	<input type="text" class="form-control form-control-user" name="pwInput" placeholder="비밀번호">
                                        	</div>
                                        	<div class="form-group">
                                        		<input type="text" class="form-control form-control-user" name="nameInput" placeholder="이름">
                                        	</div>
                                        	<div class="form-group">
                                        		<input type="text" class="form-control form-control-user" name="nickInput" placeholder="닉네임">
                                        	</div>
                                    	</div>
                                    	<div style="float:right; width:45%;">
                                        	<div class="form-group" style="display:flex;">
                                        	<!-- <select class="form-control form-control-user" name="birthInput">
                                        		</select>
                                        		<select class="form-control form-control-user" name="birthInput">
                                        		</select>
                                        		<select class="form-control form-control-user" name="birthInput">
                                        		</select> -->
                                        	    <input type="text" class="form-control form-control-user" name="birthInput" placeholder="생일">
                                        	</div>
                                        	<div class="form-group" style="display:flex;">
                                        		<input type="text" class="form-control form-control-user" name="emailInput" placeholder="이메일">
                                        		<!-- <select class="form-control form-control-user" name="domainInput" placeholder="도메인">
                                        		</select> -->
                                        	</div>
                                        	<div class="form-group">
                                        		<textarea style="rows:100%; text-align:left;" class="form-control form-control-user" name="introInput" placeholder="소개말">안녕하세요!</textarea>
                                        	</div>
                                        </div>
                                    
                                        <input type="submit" class="btn btn-user btn-block" value="회원가입" style="background:#002266; color:white">
										<input type="button" class="btn btn-user btn-block" value="취소" onclick="location.href='loginPage' " style="background:#002266; color:white">
                                        <hr>
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



</body></html>