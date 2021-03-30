<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="resources/css/codemirror.css">
	<link rel="stylesheet" type="text/css" href="resources/css/mdn-like.css">
	<script type="text/javascript" src="resources/js/codemirror.js"></script>
	<script src="resources/js/python.js"></script>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<form name="compileView" method="post" action="./Compile">
		<label>Code Input</label> <br>
		<textarea rows=30 cols=30 name="CodeText" id="editor"></textarea><br><br>
		<input type="submit" value="Execute">
	</form>
	
	<script>
		var textarea = document.getElementById('editor');
		var editor = CodeMirror.fromTextArea(textarea, {
			lineNumbers: true,
			lineWrapping: true,
			theme: "mdn-like",
			mode: "python",
			value: textarea.value
		});
	</script>

</body>
</html>