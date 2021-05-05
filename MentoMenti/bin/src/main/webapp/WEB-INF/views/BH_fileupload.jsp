<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="/upload" enctype="multipart/form-data">
	    <input multiple type="file" name="files">
	    <button>submit</button>
	</form>
</body>
</html>