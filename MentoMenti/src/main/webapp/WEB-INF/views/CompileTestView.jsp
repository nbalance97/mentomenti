<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.FileWriter, java.io.Reader" %>
<%@ page import="java.io.InputStream, java.io.InputStreamReader, java.io.BufferedReader" %>
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
</head>
<body>
	<% 
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8"); 
		String code = request.getParameter("CodeText");
	%>
	
	<form name="compileView" method="post" action="./compiler">
		<label>Code Input</label> <br>
		<textarea rows=30 cols=30 name="CodeText" id="editor"><%
			/* 제출해도 사라지지 않도록 제출 시 제출한 코드 다시 롤백 */
			if (code != null)
				out.println(code);
		%></textarea>
		<br><br>
		<input type="submit" value="Execute">
	</form>
	
	<hr>
	<textarea rows=5 cols=5 name="ResultText" id="result"><%
		if (code != null) {
	 		FileWriter fw = new FileWriter("C:/Temp/MentoMenti.py");
	 		fw.write(code);
	 		fw.flush();
	 		fw.close();
	 		
	 		/* 저장한 코드로 python 컴파일 및 결과를 BufferedReader로 가져옴 */
	 		String cmd = "python C:/Temp/MentoMenti.py";
	 		Process process = Runtime.getRuntime().exec(cmd);
	 		BufferedReader br = new BufferedReader(new InputStreamReader(process.getInputStream()));
	 		String line;
	 		StringBuffer result = new StringBuffer();
	 		while ((line = br.readLine()) != null) {
	 			result.append(line);
	 			result.append("\n");
	 		}
	 		
	 		out.println(result);
		}
	%></textarea>
	<!-- Library textarea에 적용하는 과정 -->
	<script>
		var textarea = document.getElementById('editor');
		var editor = CodeMirror.fromTextArea(textarea, {
			lineNumbers: true,
			lineWrapping: true,
			theme: "dracula",
			mode: "python",
			value: textarea.value
		});
		
		var textarea2 = document.getElementById('result');
		var editor2 = CodeMirror.fromTextArea(textarea2, {
			lineNumbers: true,
			lineWrapping: true,
			theme: "mdn-like",
			value: textarea2.value
		});
	</script>

</body>
</html>