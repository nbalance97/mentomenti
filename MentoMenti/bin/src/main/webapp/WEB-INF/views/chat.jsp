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

.chating .me {
	color: #F6F6F6;
	text-align: right;
}

.chating .others {
	color: #FFE400;
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
				var d = JSON.parse(msg);
				if (d.type == "getId") { // 세션에 id 등록하는 과정인지
					var si = d.sessionId != null ? d.sessionId : "";
					if (si != '') {
						$("#sessionId").val(si);
					}
				} else if (d.type == "message") {
					if (d.sessionId == $("#sessionId").val()) {
						$("#chating").append("<p class='me'>나 :" + d.msg + "</p>");
					} else {
						$("#chating").append("<p class='others'>" + d.userName + " :" + d.msg + "</p>");
					}
				} else {
					console.warn("unknown type!");
				}
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
		var option = {
			type: "message",
			sessionId : $("#sessionId").val(),
			userName : $("#userName").val(),
			msg : $("#chatting").val()
		}
		
		ws.send(JSON.stringify(option));
		$('#chatting').val("");
	}
</script>
<body>
	<div id="container" class="container">
		<!-- 세션값 확인용 변수같이 쓰는 sessionId -->
		<input type="hidden" id="sessionId" value=""> 
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