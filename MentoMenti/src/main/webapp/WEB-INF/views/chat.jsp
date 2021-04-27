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

<!-- chat.css 로 style 분리 -->
<link rel="stylesheet" href="resources/css/chat.css">

<title>채팅</title>

</head>

<script type="text/javascript">
	var ws;

	function wsOpen() {
		ws = new WebSocket("wss://" + location.host + "/chating");
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
						$("#chating").append(
								"<div class='me-box'><p class='me'>나 : "
										+ d.msg + "</p></div>");
					} else {
						$("#chating").append(
								"<div class='other-box'><p class='others'>"
										+ d.userName + " : " + d.msg
										+ "</p></div>");
					}
				} else {
					console.warn("unknown type!");
				}				
				$('#chating').scrollTop($('#chating')[0].scrollHeight);
				 //채팅 늘어날 때마다 자동으로 스크롤 내림
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

	function _send() {
		var option = {
			type : "message",
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
		<div id="chating" class="chating" onscroll="chat_on_scroll()"></div>

		<div id="yourName" class="row">
			<div class="col-md-9">
				<input class="form-control form-control-sm" type="text"	name="userName" id="userName">
			</div>
			<div class="col-md-2">
				<button class="btn btn-sm btn-warning" onclick="chatName()"	id="startBtn">등록</button>
			</div>

		</div>
		<div id="yourMsg" class="row">
			<div class="col-md-9">
				<input class="form-control form-control-sm" id="chatting"
						placeholder="보내실 메시지를 입력하세요.">
			</div>
			<div class="col-md-2">
				<button class="btn btn-sm btn-warning" onclick="send()"	id="sendBtn">
					<i class="far fa-paper-plane"></i>
				</button>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	// Enter 입력 인식	
	$(function() {
		$('#userName').keydown(function(key) {
			if (key.keyCode == 13) {
				$('#userName').focus();
				chatName();
			}
		});
	})
	$(function() {
		$('#sendBtn').keydown(function(key) {
			if (key.keyCode == 13) {
				$('#sendBtn').focus();
				send();
			}
		});
	})
</script>

</html>