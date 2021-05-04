<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="resources/js/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<html>
<head>
<title>WhiteBoard</title>

<script src="resources/js/painter_history.js"></script>
</head>
<style>
	.canvas_div {
		width: 85%;
		height: 100%;
		float: left;
		
	}

	.canvas {
		border:1px solid gray;
		outline: 2px dashed #92b0b3;
		outline-offset: -10px;
		text-align: center;
		transition: all .15s ease-in-out;
		background-color: aliceblue;
	}

	.palette {
		width: 15%;
		height: 100%;
		display: flex;
		flex-direction: column;
		align-items: center;
		float: right;
	}

	.row .btn {
		margin: 3px;
		font-size: small;
	}

	.p_color {
		width: 30px;
		height: 30px;
		margin: 3px;
		border-radius: 30px;
		cursor: pointer;
		box-shadow: 0 4px 6px rgba(50, 50, 93, 0.11), 0 1px 3px
			rgba(0, 0, 0, 0.08);
	}
</style>
<body>
  <%
  	session.setAttribute("my_id", "user"+Integer.toString((int)(Math.random() * 10000)));
  %>
  	<button onclick="shareBoard()">보드 공유하기</button>
  	<div class="canvas_div">
		<!-- 캔버스 태그 특성상 동적으로 만들면 그림그린거 다 깨짐. 따라서 window.innerWidth, height 사용  -->
		<!-- painter.js 맨 아래 onLoadPage 함수  -->
		<canvas id="canvas" class="canvas"></canvas>
	</div>

	<div class="palette">
		<div class="column">
			<div class="row">
				<div class="p_color col-md-5" style="background-color: black"	onclick="selectColor('black')"></div>
				<div class="p_color col-md-5" style="background-color: red"	onclick="selectColor('red')"></div>
			</div>
			<div class="row">
				<div class="p_color col-md-5" style="background-color: #ff9500" onclick="selectColor('orange')"></div>
				<div class="p_color col-md-5" style="background-color: #ffcc00" onclick="selectColor('yellow')"></div>
			</div>
			<div class="row">
				<div class="p_color col-md-5" style="background-color: #4cd963" onclick="selectColor('green')"></div>
				<div class="p_color col-md-5" style="background-color: #0579ff" onclick="selectColor('blue')"></div>
			</div>
			<div class="row">
				<div class="p_color col-md-5" style="background-color: #5856d6" onclick="selectColor('purple')"></div>
				<div class="p_color col-md-5" style="background-color: deepPink" 	onclick="selectColor('deepPink')"></div>
			</div>
		
			<div class="row">
				<button class="btn btn-sm btn-outline-dark col-md-5" onclick="selectTool('pencil')">🖊︎</button>
				<button class="btn btn-sm btn-outline-dark col-md-5" onclick="selectTool('line')">/</button>
			</div>
			<div class="row">
				<button class="btn btn-sm btn-outline-dark col-md-5" onclick="selectTool('ellipse')">◯</button>
				<button class="btn btn-sm btn-outline-dark col-md-5" onclick="selectTool('rect')">▯</button>
			</div>
			<div class="row">
				<button class="btn btn-sm btn-outline-dark col-md-5" onclick="undo()">↶</button>
				<button class="btn btn-sm btn-outline-dark col-md-5" onclick="redo()">↷</button>
			</div>
			<div class="row">
				<button class="btn btn-sm btn-outline-success col-md-10"  onclick="clearPage()">메모🗑️</button>
			</div>
			<div class="row">
				<button class="btn btn-sm btn-outline-danger col-md-10" style="align-items:center;" onclick="deleteFiles()">🖼제거</button></div>
			</div>
	</div>

	<textarea id="history" cols="40" rows="37" style="display: none;"></textarea>
	<script src="resources/js/painter.js"></script>
	<script src="resources/js/drawengine.js"></script>
  
  <script>
		var conn = new WebSocket('wss://kgu.mentomenti.kro.kr:8000/socket');
	    var myName = "<%=session.getAttribute("my_id")%>" // 자기 id 저장
	    var yourName = null;
	    var myCanvas = document.getElementById("canvas");
		var pc = {};
		var dc = {};
		var share = {};
		var renegotiationflg = false;
		
		function play() {
			v1.play();
		}
		
		conn.onopen = function() { // 소켓 열었을때
			console.log("Connected to the signaling server");
			console.log("Current User:" + myName);
			send({ // name을 server에 알려서 broadcast
				event: "namecall",
				data: myName 
			});
			//initialize();
		}
		
		conn.onmessage = function(msg) {
		    console.log("Got message", msg.data);
		    var content = JSON.parse(msg.data);
		    var from = content.from;
		    var data = content.data;
		    var to = content.to;

	    	if (content.event === "recv_paint" && content.to === myName){
		    	var x1 = content.x1;
		    	var x2 = content.x2;
		    	var y1 = content.y1;
		    	var y2 = content.y2;
		    	var color = content.color;
		    	var force = content.force;
		    	handlePaint(x1, y1, x2, y2, color, force);
		    	return;
	    	}
		    
		    if (content.event === "namecall" | content.to === myName) { 
			    switch (content.event) {
			    case "offer":
			        handleOffer(from, to, data);
			        break;
			    case "answer":
			        handleAnswer(from, to, data); 
			        break;
			    case "candidate":
			        handleCandidate(from, to, data); // candidate 저장
			        break;
			    case "namecall":
			    	renegotiationflg = false;
			    	createOffer(data);
			    	break;
			    default:
			        break;
			    }
		    }
		}
		
		async function handlePaint(x1, y1, x2, y2, color, force) { // painter.js와 연동되는 부분임
			  cvs.beginPath();
				  cvs.moveTo(x1, y1);
				  cvs.lineTo(x2, y2);
				  cvs.strokeStyle = color;
				  cvs.lineWidth = force;
				  cvs.lineCap = 'round';
				  cvs.stroke();
			  cvs.closePath();
		}
		
		function isOpen(ws) { 
			return ws.readyState === ws.OPEN; 
		}
		
		function send(message) {
			if (!isOpen(conn)) return;
			conn.send(JSON.stringify(message));
		}
		
		
		function createPeerConnection(target) {
			var configuration = {
				    "iceServers" : [ {
				        "url" : "stun:stun2.1.google.com:19302"
				    },
				    {
				 	"url" : "turn:kgu.mentomenti.kro.kr?transport=tcp",
				 	"username":"root",
				 	"credential":"1234"
				 }
				 ]
				};
			var peerConnection = new RTCPeerConnection(configuration);
			peerConnection.onicecandidate = function(event) { // Handler 등록
				if (renegotiationflg)
					return;
				if (event.candidate) {
					send({
						event : "candidate",
						data : event.candidate,
						from : myName,
						to : target
					});
				}
			}
			
			setDataChannel(peerConnection, target);
			return peerConnection;
		}
		
		function setDataChannel(peerConnection, target) {
			var dataChannel = peerConnection.createDataChannel("dataChannel", {
				reliable: true
			});
			
			dataChannel.onopen = function(event) {
				console.log("dataChannel successfully opened!");
				dataChannel.send("data");
			};
			
			dataChannel.onerror = function(error) {
				console.log("Error:", error);
			};
			
			dataChannel.onclose = function() {
				console.log("Data Channel is closed");
				delete(dc[target]);
			};
			
			dataChannel.onmessage = function(event) {
				console.log("Message:", event.data);
			};
			
			peerConnection.ondatachannel = function(event) {
				dc[target] = event.channel; 
			};
		}
		
		function createOffer(name) { // 상대방의 name으로 connection 생성
			var peerConnection = createPeerConnection(name);
			
			peerConnection.createOffer(async function(offer) { // offer 상대 peer에 전송
				await send({
					event : "offer",
					data : offer,
					from : myName,
					to : name
				});	
				peerConnection.setLocalDescription(offer); 
				// LocalDescription 설정 -> icecandidate 유발시킴, 즉, candidate도 전송
			}, function(error) {
				
			});	
			
			if (!renegotiationflg)
				pc[name] = peerConnection; // pc 객체에 저장
		}
		
		
		function handleOffer(from, target, offer) { 
			if (!renegotiationflg) {
				pc[from] = createPeerConnection(from);
			}
			var peerConnection = pc[from];
			peerConnection.setRemoteDescription(new RTCSessionDescription(offer)); // offer에 따라 RemoteDescription 설정
			peerConnection.createAnswer(function(answer) { // answer 만들어서 전송
				peerConnection.setLocalDescription(answer);
				send({
					event : "answer",
					data : answer,
					from : myName,
					to : from
				});
			}, function(error) {
				
			});	
		}
		
		function handleCandidate(from, to, candidate) {
			if (renegotiationflg)
				return;
			pc[from].addIceCandidate(new RTCIceCandidate(candidate));
		}
		
		function handleAnswer(from, to, answer){
		    pc[from].setRemoteDescription(new RTCSessionDescription(answer));
			console.log("Connection.");
		}
		
		function sendMessage() {
			var obj_keys = Object.keys(dc);
			for (var i = 0; i<obj_keys.length; i++) {
				dc[obj_keys[i]].send(input.value);
			}
			input.value = "";
		}
		
	</script>
</body>
</html>