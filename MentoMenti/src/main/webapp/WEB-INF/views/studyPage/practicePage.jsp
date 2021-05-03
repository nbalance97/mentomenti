<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.WebCompiler.WebCompiler" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8"> 
	<title>practicePage</title>
	<link href="/resources/css/bootstrap.min.css" rel="stylesheet" />
	<link href="/resources/css/defaultStudyPractice.css" rel="stylesheet" type="text/css">
	
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/codemirror.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/mdn-like.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/dracula.css">
	<script type="text/javascript" src="/resources/js/codemirror.js"></script>
	<script src="/resources/js/python.js"></script>
	<script src="/resources/js/clike.js"></script>
	
	<style>
	.coding{
		height:90%;
		padding:30px;
	}
	.problemImg{
		height:100%;
		float:left;
		width:49%;
		border-style:dotted;
	}
	.codingFunc{
		width:50%;
		height:100%;
		float:right;
	}
	
	.compileForm{
		width:100%;
		height:70%;
	}
	.compiler, .input, .result{
		height:20%;
		width:100%;
		float:left;
	}
	.compiler{
		height:50%;
	}
	.compiler, .input{
		margin-bottom:30px;
	}
	.execute{
		margin:20px;
		float: right;
	}
	</style>
</head>
<script>
	function change_opt(e) {
		if (e.value == 'python') {
			window.location.href = 'practice?mode=python';
		} else if (e.value == 'C') {
			window.location.href = 'practice?mode=C';
		} else if (e.value == 'java') {
			window.location.href = 'practice?mode=java';
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
		WebCompiler WC = WebCompiler.getInstance();
		
		if (mode == null) 
			mode = "python";
		
		if (mode.equals("python"))
			settingFile = "python";
		else if (mode.equals("C"))
			settingFile = "text/x-csrc";
		else if (mode.equals("java"))
			settingFile = "text/x-java";
		
		
		if (SRC != null)
			SRC.trim();
		if (input != null)
			input.trim();
		
	%>
	<%@include file="studySidebar.jsp"%>
	<div class="main">
			<!-- mode에 맞게 selected 되도록 설정 + 변경 시 redirect 설정 -->
		<div class="coding">
			<div class="problemImg shadow img-rounded">
				<h1>문제를 게시해주세요</h1>
			</div>
			<div class="codingFunc">
				<form class="compileForm" name="compileView" method="post" action="./practice?mode=<%=mode%>">
					<div class="languageSelect">
								<select id="selectpart" onchange="change_opt(this)">
									<option value="python" <%
										if (mode.equals("python"))
											out.println("selected");
									%>>Python</option>
									<option value="C" <%
										if (mode.equals("C"))
											out.println("selected");
									%>>C</option>
									<option value="java" <%
										if (mode.equals("java"))
											out.println("selected");
									%>>java</option>
								</select>
					</div>
					
					<div class="compiler">
							<label>Code Input</label>
							<input type="submit" value="Execute">
							
							<textarea style="width:100%; height:100%;" name="CodeText" id="editor"><%
								/* 제출해도 사라지지 않도록 제출 시 제출한 코드 다시 롤백 */
								if (SRC != null)
									out.println(SRC);
								if (SRC == null && mode.equals("java")) {
									out.println(WC.getJavaDefault());
								}
							%></textarea> 
					</div>
			
					<div class="input">
						<label>stdin : </label>
						<textarea style="width:100%; height:100%;" name="InputText" id="input"><%
								if (input != null) {
									out.println(input); // 사라지지 않게 처리
								}
							%></textarea>
					</div>
				</form>
				<div class="result">
					<label>result : </label>
					<textarea style="width:100%; height:100%;" name="ResultText" id="result"><%
						if (SRC != null) {
							String temp = null;
							if (mode.equals("python")) {
								temp = WC.compilePython(SRC, input);
							} else if (mode.equals("C")) {
								temp = WC.compileC(SRC, input);
							} else if (mode.equals("java")) {
								temp = WC.compileJava(SRC, input);
							}
					
							if (temp != null) 
								out.println(temp);
							else
								out.println("에러 발생");
						}
					%></textarea>
				</div>
			</div>
		</div>
		<%@include file="practiceBottomMentee.jsp"%>
	</div>
	
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
		
		editor.setSize("100%", "100%");
		editor2.setSize("100%", "100%");
		editor3.setSize("100%", "100%");
	</script>
</body>
</html>