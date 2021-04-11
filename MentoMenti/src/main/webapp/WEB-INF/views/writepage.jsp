<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>MOCO</title>

<!-- Custom fonts for this template-->
<link href="resources/css/all.min.css" rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<%@include file="menuPart1.jsp"%>
		<style>form {margin-top : 100px;}</style>

	    <form>
        <div class="form-group">
              <label for="exampleFormControlInput1">제목</label>
            <input type="text" class="form-control" id="exampleFormControlInput1" name="title" >
          </div>
        <div class="form-group">
            <label for="exampleFormControlInput1">작성자</label>
            <input type="text" class="form-control" id="exampleFormControlInput1" name="crea_id">
          </div>
		<div class="form-group">
            <label for="exampleFormControlInput1">비밀번호</label>
            <input type="text" class="form-control" id="exampleFormControlInput1" name="crea_pw">
          </div>
          <div class="form-group">
            <label for="exampleFormControlTextarea1">내용</label>
            <textarea class="form-control" id="exampleFormControlTextarea1" name="contents" rows="10"></textarea>
          </div>
        <button type="submit" class="btn btn-info">등록하기</button>
        <button type="button" class="btn btn-secondary">목록으로</button>
    </form>

<%@include file="menuPart2.jsp"%>