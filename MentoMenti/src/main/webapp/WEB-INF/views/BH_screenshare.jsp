<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>

<html>
<style>
html, body{
		height: 100%;
	}
.share-screen {
	background-color: #000;
	height: 80%;
	overflow: auto;
}
</style>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
  <%
  	session.setAttribute("my_id", "user"+Integer.toString((int)(Math.random() * 10000)));
  %>
  <button type="button" class="btn btn-primary" onclick='createOffer()'>Create
  	 Offer</button>
  <input id="messageInput" type="text" class="form-control"
   placeholder="message">
  <button type="button" class="btn btn-primary" onclick='sendMessage()'>SEND</button>
  
  <script>
		var conn = new WebSocket('ws://localhost:8000/socket');
	    var myName = "<%=session.getAttribute("my_id")%>" // 자기 id 저장
		var dataChannel;
	    var myoffer;
		var input = document.getElementById("messageInput");
		var pc = {};
		var dc = {};
		
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
		    
		    if (content.event == "namecall" | content.to == myName) { 
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
			    	createOffer(data);
			    default:
			        break;
			    }
		    }
		};
		
		function isOpen(ws) { 
			return ws.readyState === ws.OPEN; 
		}
		
		function send(message) {
			if (!isOpen(conn)) return;
			conn.send(JSON.stringify(message));
		}
		
		
		function createPeerConnection(target) {
			var configuration = null;
			var peerConnection = new RTCPeerConnection(configuration);
			peerConnection.onicecandidate = function(event) { // Handler 등록
				if (event.candidate) {
					send({
						event : "candidate",
						data : event.candidate,
						from : myName,
						to : target
					});
				}
			};
			
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
			};
			
			dataChannel.onmessage = function(event) {
				console.log("Message:", event.data);
			};
			
			peerConnection.ondatachannel = function(event) {
				dc[target] = event.channel; // dataChannel 설정 시에  해당 channel 저장
			};
		}
		
		function createOffer(name) {
			var peerConnection = createPeerConnection(name); // 새로운 연결 생성
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
			pc[name] = peerConnection;
		}
		
		function handleOffer(from, target, offer) {
			pc[from] = createPeerConnection(from);
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
			pc[from].addIceCandidate(new RTCIceCandidate(candidate));
		};
		
		function handleAnswer(from, to, answer){
		    pc[from].setRemoteDescription(new RTCSessionDescription(answer));
			console.log("Connection.");
		};
		
		function sendMessage() {

		}

	</script>
</body>
</html>