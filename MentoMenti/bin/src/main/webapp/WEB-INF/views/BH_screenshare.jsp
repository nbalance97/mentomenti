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
  <button type="button" class="btn btn-primary" onclick="share_monitor()">share monitor</button>
  <button type="button" class="btn btn-primary" onclick="play()">show</button>
  
  <!-- 비디오 표시부 -->
  <video id="v1" autoplay="true" width="800px"></video> 
  
  <script>
		var conn = new WebSocket('wss://kgu.mentomenti.kro.kr:8000/socket');
	    var myName = "<%=session.getAttribute("my_id")%>" // 자기 id 저장
		var dataChannel;
	    var myoffer;
		var input = document.getElementById("messageInput");
		var v1 = document.getElementById("v1");
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
			    case "rngt_offer":
			    	renegotiationflg = true;
			    	handleOffer(from, to, data);
			    default:
			        break;
			    }
		    }
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
			
			peerConnection.ontrack = function(e) {
				console.log("Track 추적");
				v1.srcObject = e.streams[0];
			}

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
		

		async function share_monitor() { 
			/*
			 최대 난제. 화면공유 시 renegotiation 해주어야 하는 문제
			 문제 해결 위해 rngt_offer로 offer 전달하면 renegotiation 해주도록 구현 
			*/
			navigator.mediaDevices.getUserMedia({
				audio: true
			}).then(function(audioStream){
				//오디오 스트림을 얻어냄
				navigator.mediaDevices.getDisplayMedia({
					audio: true,
					video: true
				}).then(async function(screenStream){
					//스크린 공유 스트림을 얻어내고 여기에 오디오 스트림을 결합함
					screenStream.addTrack(audioStream.getAudioTracks()[0]);
					v1.srcObject = screenStream;
					var obj_keys = Object.keys(pc);
					for (var i = 0; i<obj_keys.length; i++) {
						renegotiationflg = true;
						(function (i){ // 클로저로 선언해야 제대로 맞추어서 들어감 .. ㅡㅡ
							console.log(i);
						    pc[obj_keys[i]].onnegotiationneeded = function() {
						    	pc[obj_keys[i]].createOffer(async function(offer) { // offer 상대 peer에 전송
									await send({
										event : "rngt_offer",
										data : offer,
										from : myName,
										to : obj_keys[i]
									});	
									pc[obj_keys[i]].setLocalDescription(offer); 
									// LocalDescription 설정 -> icecandidate 유발시킴, 즉, candidate도 전송
								}, function(error) {
									
								});	
						    };
							
						    if (obj_keys[i] in share)
						    	screenStream.getTracks().forEach((track) =>{
						    		share[obj_keys[i]].replaceTrack(track);
						    	});
						    else {
								screenStream.getTracks().forEach((track) => {
									share[obj_keys[i]] = pc[obj_keys[i]].addTrack(track, screenStream);
								});
						    }
						})(i);
					}
					
				}).catch(function(e){
					//error;
				});
			}).catch(function(e){
				//error;
			}); 
		}

	</script>
</body>
</html>
