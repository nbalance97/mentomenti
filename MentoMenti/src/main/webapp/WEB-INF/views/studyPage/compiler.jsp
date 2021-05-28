<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.WebCompiler.WebCompiler"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupmateDTO, Mento.Menti.Project.dao.GroupmateDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page import="java.util.List"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>practiceMento</title>
<link href="/resources/css/bootstrap.min.css" rel="stylesheet" />
<link href="/resources/css/defaultStudyPractice.css" rel="stylesheet"
	type="text/css">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link rel="stylesheet" type="text/css"
	href="/resources/css/codemirror.css">
<link rel="stylesheet" type="text/css"
	href="/resources/css/mdn-like.css">
<link rel="stylesheet" type="text/css" href="/resources/css/dracula.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- 파비콘 설정 -->
<link rel="shortcut icon" href="resources/img/logo3.png">
<link rel="icon" href="resources/img/logo3.png">

<script type="text/javascript" src="/resources/js/codemirror.js"></script>
<script src="/resources/js/python.js"></script>
<script src="/resources/js/clike.js"></script>

<style>
.coding {
	height: 90%;
	padding: 30px;
}

.compiler, .input, .result {
	height: 20%;
	float: left;
	width: 100%;
}

.compiler {
	height: 85%;
}

.compiler, .input {
	margin-bottom: 30px;
}

.codingFunc {
	width: 100%;
	height: 90%;
	float: right;
}

.execute {
	margin: 20px;
	float: right;
}

</style>
</head>
<script>
	
</script>
<body onresize="parent.resizeTo(500,700)" onload="parent.resizeTo(500,700)">
	<%
		request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	%>

	<div class="main">
		<div class="coding">
			<div class="codingFunc">
				<div class="languageSelect">
					<select id="selectpart" onchange="change_opt(this)">
						<option value="python">Python</option>
						<option value="C">C</option>
						<option value="java">java</option>
					</select>
				</div>
				<form name="compileView" style="width: 100%; height: 70%;"
					method="post" action="">
					<div class="compiler img-rounded" style="padding: 5px">
						<label>코드 작성</label>
						<textarea style="width: 100%; height: 100%;" name="CodeText"
							id="editor"></textarea>
					</div>
					<div class="input img-rounded" style="padding: 5px">
						<label> 입력값 </label>
						<textarea style="width: 100%; height: 100%;" name="InputText"
							id="input"></textarea>
					</div>
					<input type="button" class="btn"
						style="margin: 0px 10px; float: right;" value="실행"
						onclick="processCompile();">
				</form>

				<div class="result img-rounded" style="padding: 5px">
					<label>결과</label>
					<textarea style="width: 100%; height: 100%;" name="ResultText"
						id="result"></textarea>
				</div>
			</div>
		</div>
		<form name="tstform" method="post">
			<input type="hidden" id="src" name="src" />
		</form>
	</div>
	<!-- Library textarea에 적용하는 과정 -->
	<script>
		var settingFile = 'python';
		var set_mode = 'python';

		var textarea = document.getElementById('editor');
		var editor = CodeMirror.fromTextArea(textarea, {
			lineNumbers : true,
			lineWrapping : true,
			theme : "dracula",
			mode : "python",
			value : textarea.value,
		});

		var textarea2 = document.getElementById('result');
		var editor2 = CodeMirror.fromTextArea(textarea2, {
			lineNumbers : true,
			lineWrapping : true,
			mode : "python",
			theme : "dracula",
			value : textarea2.value
		});

		var textarea3 = document.getElementById('input');
		var editor3 = CodeMirror.fromTextArea(textarea3, {
			lineNumbers : true,
			lineWrapping : true,
			mode : "python",
			theme : "dracula",
			value : textarea3.value
		});

		editor.setSize("100%", "100%");
		editor2.setSize("100%", "100%");
		editor3.setSize("100%", "100%");

		function change_opt(e) {
			editor.setSize("0%", "0%"); // 0%에서 100%로 늘려줘야 점점 안커짐....,,,,,
			editor2.setSize("0%", "0%");
			editor3.setSize("0%", "0%");
			set_mode = e.value;

			if (e.value === "python") {
				settingFile = 'python';
			} else if (e.value === "C") {
				settingFile = "text/x-csrc";
			} else {
				settingFile = "text/x-java";
			}

			editor = CodeMirror.fromTextArea(textarea, {
				lineNumbers : true,
				lineWrapping : true,
				theme : "dracula",
				mode : settingFile,
				value : textarea.value,
			});

			editor2 = CodeMirror.fromTextArea(textarea2, {
				lineNumbers : true,
				lineWrapping : true,
				theme : "dracula",
				mode : settingFile,
				value : textarea2.value
			});

			editor3 = CodeMirror.fromTextArea(textarea3, {
				lineNumbers : true,
				lineWrapping : true,
				theme : "dracula",
				mode : settingFile,
				value : textarea3.value
			});

			editor.setSize("100%", "100%");
			editor2.setSize("100%", "100%");
			editor3.setSize("100%", "100%");

			console.log(e.value);
			if (e.value === "java") {
				editor.setValue("public class MentoMenti {\n\tpublic static void main(String args[]) {\n\n\t}\n}");
			}
		}

		function processCompile() {
			var total_data = {
				mode : set_mode,
				src : editor.getValue(),
				input : editor3.getValue(),
			};

			$.ajax({
				url : "https://kgu.mentomenti.kro.kr:8000/WebCompile",
				type : "POST",
				async : true,
				data : total_data,
				success : function(data) {
					editor2.setValue(data);
				}
			});
		}
	</script>
	<script>
	
	</script>
</body>
</html>