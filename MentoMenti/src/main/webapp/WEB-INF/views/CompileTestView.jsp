<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.WebCompiler.WebCompiler" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="resources/css/codemirror.css">
	<link rel="stylesheet" type="text/css" href="resources/css/mdn-like.css">
	<link rel="stylesheet" type="text/css" href="resources/css/dracula.css">
	<script type="text/javascript" src="resources/js/codemirror.js"></script>
	<script src="resources/js/python.js"></script>
	<script src="resources/js/clike.js"></script>
</head>
<script>
	function change_opt(e) {
		if (e.value == 'python') {
			window.location.href = 'compiler?mode=python';
		} else if (e.value == 'C') {
			window.location.href = 'compiler?mode=C';
		}
	}
</script>

<body>
	<% 
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8"); 
		String SRC = request.getParameter("CodeText"); // 코드와 입력값 받음
		String input = request.getParameter("InputText");
		String mode = request.getParameter("mode");
		String settingFile = null; // 설정된 파일명
		if (mode == null) 
			mode = "python";
		
		if (mode.equals("python"))
			settingFile = "python";
		else if (mode.equals("C"))
			settingFile = "text/x-csrc";
		
		
		if (SRC != null)
			SRC.trim();
		if (input != null)
			input.trim();
		
	%>
	
	<!-- mode에 맞게 selected 되도록 설정 + 변경 시 redirect 설정 -->
	<select id="selectpart" onchange="change_opt(this)">
		<option value="python" <%
			if (mode.equals("python"))
				out.println("selected");
		%>>Python</option>
		<option value="C" <%
			if (mode.equals("C"))
				out.println("selected");
		%>>C</option>
	</select>	
	
	<!-- 소스코드 화면  -->
	<form name="compileView" method="post" action="./compiler?mode=<%=mode%>"> 
		<label>Code Input</label> <br>
		<textarea rows=30 cols=30 name="CodeText" id="editor"><%
			/* 제출해도 사라지지 않도록 제출 시 제출한 코드 다시 롤백 */
			if (SRC != null)
				out.println(SRC);
		%></textarea> <br>
		stdin : <br> <textarea rows=5 cols=5 name="InputText" id="input"><%
			if (input != null) {
				out.println(input); // 사라지지 않게 처리
			}
		%></textarea>
		<br>
		<input type="submit" value="Execute">
	</form>
	
	<hr>
	
	<!-- 결과 화면 -->
	<textarea rows=5 cols=5 name="ResultText" id="result"><%
		if (SRC != null) {
			WebCompiler WC = WebCompiler.getInstance();
			String temp = null;
			if (mode.equals("python")) {
				temp = WC.compilePython(SRC, input);
			} else if (mode.equals("C")) {
				temp = WC.compileC(SRC, input);
			}
			
			if (temp != null) 
				out.println(temp);
			else
				out.println("에러 발생");
		}
	%></textarea>
	
	<!-- Library textarea에 적용하는 과정 -->
	<script>
		var textarea = document.getElementById('editor');
		var editor = CodeMirror.fromTextArea(textarea, {
			lineNumbers: true,
			lineWrapping: true,
			theme: "dracula",
			mode: "<%=settingFile%>",
			value: textarea.value,
		});
		
		var textarea2 = document.getElementById('result');
		var editor2 = CodeMirror.fromTextArea(textarea2, {
			lineNumbers: true,
			lineWrapping: true,
			theme: "dracula",
			value: textarea2.value
		});
		
		var textarea3 = document.getElementById('input');
		var editor3 = CodeMirror.fromTextArea(textarea3, {
			lineNumbers: true,
			lineWrapping: true,
			theme: "dracula",
			value: textarea3.value
		});
		
		editor.setSize(500, 300);
		editor2.setSize(500, 100);
		editor3.setSize(500, 100);
	</script>

</body>
</html>