<!--https://won-percent.tistory.com/50?category=1146251  -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<title>채팅</title>
<style>
html, body{
		height: 100%;
	}

.container{

	width: 100%;
	height: 100%;
}
.chating {
	background-color: #000;
	height: 80%;
	overflow: auto;
}

.chating p {
	color: #fff;
	text-align: left;
}

#yourMsg {
	display: none;
}
</style>
</head>

<script type="text/javascript">
	var ws;

	function wsOpen() {
		ws = new WebSocket("ws://" + location.host + "/chating");
		wsEvt();
	}

	function wsEvt() {
		ws.onopen = function(data) {
			//소켓이 열리면 초기화 세팅하기
		}

		ws.onmessage = function(data) {
			var msg = data.data;
			if (msg != null && msg.trim() != '') {
				$("#chating").append("<p>" + msg + "</p>");
			}
		}

		document.addEventListener("keypress", function(e) {
			if (e.keyCode == 13) { //enter press
				send();
			}
		});
	}

	function chatName() {
		var userName = $("#userName").val();
		if (userName == null || userName.trim() == "") {
			alert("사용자 이름을 입력해주세요.");
			$("#userName").focus();
		} else {
			wsOpen();
			$("#yourName").hide();
			$("#yourMsg").show();
		}
	}

	function send() {
		var uN = $("#userName").val();
		var msg = $("#chatting").val();
		ws.send(uN + " : " + msg);
		$('#chatting').val("");
	}
</script>
<body>
	<div id="container" class="container">
		<div id="chating" class="chating"></div>

		<div id="yourName">
			<table>
				<tr>
					<th><input class="form-control form-control-sm" type="text"	name="userName" id="userName"></th>
					<th><button class="btn btn-sm btn-primary" onclick="chatName()" id="startBtn">등록</button></th>
				</tr>
			</table>
		</div>
		<div id="yourMsg">
			<table>
				<tr>
					<th><input class="form-control form-control-sm" id="chatting" placeholder="보내실 메시지를 입력하세요."></th>
					<th><button class="btn btn-sm btn-primary" onclick="send()"	id="sendBtn">보내기</button></th>
				</tr>
			</table>
		</div>
	</div>
</body>
<script type="text/javascript">
$(function(){
	$('#userName').keydown(function(key){
		if(key.keyCode == 13){
			$('#userName').focus();
			chatName();
		}
	});
})
	$(function(){
		$('#sendBtn').keydown(function(key){
			if(key.keyCode == 13){
				$('#sendBtn').focus();
				send();
			}
		});
	})
	
</script>

</html>