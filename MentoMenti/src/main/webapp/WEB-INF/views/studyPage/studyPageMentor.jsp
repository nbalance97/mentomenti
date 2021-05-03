<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet" />
<link href="/resources/css/defaultStudyPractice.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>StudyPage_Mento</title>
<style>
	.screen{
		float:left;
		width:100%;
		height:90%;
		background:black;
	}
</style>
</head>
<body>
	<%
  		session.setAttribute("my_id", "user"+Integer.toString((int)(Math.random() * 10000)));
  	%>
  	

	<!-- 사이드바=채팅 & 멘티리스트 -->
	<%@include file="studySidebar.jsp"%>
	
	<div class="main">
		<!-- 화면공유  -->
		<%@include file="studyPageScreen.jsp"%>
		<!-- 수업페이지 기능모음 메뉴 -->
		<%
			//방만들기 클릭시 class대한 세션설정 필요?
			//클래스아이디 받아오기
			//해당 클래스아이디의 그룹아이디 찾기 -> grouppage에서 그룹 아이디 보내도록 했음
			int groupid = Integer.parseInt(request.getParameter("groupid"));
			GroupDTO group = HomeController.dao.getGroupDAO().searchGroupByGroupid(groupid);
			//해당 그룹의 멘토아이디 받아오기
			String mentoid = group.getMentoid();
			
			String id = (String)session.getAttribute("userID");	//세션에서 접속한 아이디 받아오기 
			
			if (id == null) { // id null값이면 튕겨나가도록
				response.sendRedirect("https://kgu.mentomenti.kro.kr");
			}
			
			System.out.println(id);
			
			//멘토아이디와 접속한 아이디 비교
			//True = 멘토, False = 멘티 확인
			if (mentoid.equals(id)){
				//멘토
			} else {
				//멘티인지 확인
			}
			
		%>
		<%@include file="studyBottomMentor.jsp"%>
	</div>
	
	  <script>
		var conn = new WebSocket('wss://kgu.mentomenti.kro.kr:8000/socket');
	    var myName = "<%=session.getAttribute("userID")%>" // 자기 id 저장
	    var myGroup = <%=groupid%>;
		var dataChannel;
	    var myoffer;
		var pc = {};
		var dc = {};
		var share = {};
		var renegotiationflg = false;
		var v1 = document.getElementById("v1");
		var refreshTimer = setInterval("checkConnection()", 3000); // 3초간격으로 유저 확인
		
		function addMemberToList(id, idx) {
			$('<tr>'+
			'<td>'+idx+'</td>'+
			'<td>'+id+'</td>'+
			'<td>'+'<i class="far fa-question-circle stateIcon fa-2x"></i></td>'+
			'<td><button type="button" class="btn btn-info">이동</button></td>'+
			'</tr>').appendTo('#MemberTable');
		}
		
		function checkConnection() {
			var idx = 1;
			$('#MemberTable *').remove(); // MemberTable 내부 전체 삭제
			addMemberToList(myName, idx++);
			for (var key in pc) {
				if (pc[key].connectionState === "disconnected" || pc[key].connectionState === "failed" // 유저 연결이 안되어 있는 경우 해당 유저 삭제 
						|| pc[key].connectionState === "closed") {
					delete(pc[key]);
					delete(dc[key]);
					delete(share[key]);
				} else {
					addMemberToList(key, idx++);
				}
			}
		}
		
		conn.onopen = function() { // 소켓 열었을때
			console.log("Connected to the signaling server");
			console.log("Current User:" + myName);
			send({ // name을 server에 알려서 broadcast
				event: "namecall",
				data: myName,
				group: myGroup
			});
			//initialize();
		}
		
		conn.onmessage = function(msg) {
		    console.log("Got message", msg.data);
		    var content = JSON.parse(msg.data);
		    var from = content.from;
		    var data = content.data;
		    var to = content.to;
		    
		    // 그룹의 새멤버 or 자신에게 향하는 패킷만 처리
		    if ((content.event === "namecall" && content.group === myGroup) | content.to === myName) { 
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
		
		function checkMember() {
			
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
				//dc[obj_keys[i]].send(input.value);
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
							
						    if (obj_keys[i] in share) // 이미 공유중인 상황이라면 replace
						    	screenStream.getTracks().forEach((track) =>{
						    		share[obj_keys[i]].replaceTrack(track);
						    	}); 
						    else { // 공유중이지 않다면 새로 addTrack
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