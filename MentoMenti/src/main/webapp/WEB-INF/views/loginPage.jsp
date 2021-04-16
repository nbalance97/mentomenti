<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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

<body class="sidebar-toggled" style="background: #002266">

	<div class="container">

		<div class="row justify-content-center">

			<div class="col-xl-10 col-lg-12 col-md-9">

				<div class="card o-hidden border-0 shadow-lg my-5">
					<div class="card-body p-0">
						<div class="row">
							<div class="col-lg-3"></div>
							<div class="col-lg-6">
								<div class="p-4">
									<!-- 로고 이미지 -->
									<div class="text-center">
										<img src="resources/img/logo3.png" style="width: 170px">
									</div>
								</div>

								<div class="p-3">
									<div class="text-center">
										<!--  <h1 class="h4 text-gray-900 mb-4">로그인</h1> -->
									</div>


									<!-- 로그인 폼 태그 -->
									<form class="user" action="processLogin" method="post">

										<%
											String mode = request.getParameter("mode"); //processLogin 결과 일치하는 계정이 없을 경우
										if (mode != null) {
										%>
										<div class="form-group text-center"
											style="text-align: center; color: red">아이디와 비밀번호를 다시
											확인해주세요</div>
										<%
											}
										%>

										<div class="form-group">
											<!-- 아이디 입력 -->
											<input type="text" class="form-control form-control-user"
												name="idInput" placeholder="아이디">
										</div>
										<div class="form-group">
											<!-- 비밀번호 입력 -->
											<input type="password" class="form-control form-control-user"
												name="pwInput" placeholder="비밀번호">
										</div>
										<div class="form-group">
											<!-- 아이디 저장 기능은 삭제할 수도 있음 -->
											<div class="custom-control custom-checkbox small">
												<input type="checkbox" class="custom-control-input">
												<label class="custom-control-label" for="customCheck">아이디
													저장하기</label>
											</div>
										</div>


										<input type="submit" class="btn btn-user btn-block"
											value="로그인" style="background: #002266; color: white">

										<hr>
									</form>
									<div class="text-center">
										<a class="small" href="#">아이디 찾기</a> <a class="small" href="#">비밀번호
											찾기</a> <a class="small" href="signup">회원가입</a>
									</div>
								</div>
							</div>
							<div class="col-lg-3"></div>
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



</body>
</html>