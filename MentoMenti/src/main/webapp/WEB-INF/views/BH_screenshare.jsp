<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	  <button type="button" class="btn btn-primary" onclick='createOffer()'>Create
  	 Offer</button>
  <input id="messageInput" type="text" class="form-control"
   placeholder="message">
  <button type="button" class="btn btn-primary" onclick='sendMessage()'>SEND</button>
	<script>
		var conn = new WebSocket('ws://localhost:8000/socket');
		var peerConnection;
		var dataChannel;
		var input = document.getElementById("messageInput");
		
		conn.onopen = function() {
			console.log("Connected to the signaling server");
			initialize();
		}
		
		conn.onmessage = function(msg) {
		    console.log("Got message", msg.data);
		    var content = JSON.parse(msg.data);
		    var data = content.data;
		    switch (content.event) {
		    // when somebody wants to call us
		    case "offer":
		        handleOffer(data);
		        break;
		    case "answer":
		        handleAnswer(data);
		        break;
		    // when a remote peer sends an ice candidate to us
		    case "candidate":
		        handleCandidate(data);
		        break;
		    default:
		        break;
		    }
		};
		
		function send(message) {
			conn.send(JSON.stringify(message));
		}
		
		function initialize() {
			var configuration = null;
			peerConnection = new RTCPeerConnection(configuration);
			
			peerConnection.onicecandidate = function(event) {
				if (event.candidate) {
					send({
						event : "candidate",
						data : event.candidate
					});
				}
			};
			
			dataChannel = peerConnection.createDataChannel("dataChannel", {
				reliable: true
			});
			
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
				dataChannel = event.channel;
			};
		
		}
		
		function createOffer() {
			// 오퍼 설정
			peerConnection.createOffer(function(offer) {
				send({
					event : "offer",
					data : offer
				});	
				peerConnection.setLocalDescription(offer); 
				// LocalDescription 설정 -> icecandidate 유발시킴
			}, function(error) {
				
			});	
		}
		
		function handleOffer(offer) {
			peerConnection.setRemoteDescription(new RTCSessionDescription(offer));
			peerConnection.createAnswer(function(answer) {
				peerConnection.setLocalDescription(answer);
				send({
					event : "answer",
					data : answer
				});
			}, function(error) {
				
			});	
		}
		
		function handleCandidate(candidate) {
			peerConnection.addIceCandidate(new RTCIceCandidate(candidate));
		};
		
		function handleAnswer(answer){
		    peerConnection.setRemoteDescription(new RTCSessionDescription(answer));
			console.log("Connection.");
		};
		
		function sendMessage() {
		    dataChannel.send(input.value);
		    input.value = "";
		}

	</script>
</body>
</html>