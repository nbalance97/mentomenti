<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupmateDTO, Mento.Menti.Project.dao.GroupmateDAO"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page import="java.util.List"%>
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
			//그룹에 참여한 멘티 목록
			List<GroupmateDTO> groupmateList = HomeController.dao.getGroupmateDAO().selectMentiList(group.getGroupid());

			//자신이 개설 or 가입한 그룹 페이지에만 접근할 수 있도록
			boolean isMember = false;
			if(mentoid.equals(id)){
				isMember = true;
			}
			for(GroupmateDTO mentee:groupmateList){
				if(mentee.getId().equals(id)){
					isMember=true;
				}
			}
			if(!isMember || id==null){//서버연결 뭐시기 땜에 sendRedirect가 안먹힘,,,
				//response.sendRedirect("rejectedAccess?type=notMember");
				%>
				<div>잘못된접근인데 sendRedirect가 안됨 오류나ㅏㅁㅁㅇㅁㄴㅇ.</div>
				<%
			}
			
			//멘토아이디와 접속한 아이디 비교
			//True = 멘토, False = 멘티 확인
			if (mentoid.equals(id)){//멘토
				%>
				<%@include file="studyBottomMentor.jsp"%>
				<% 
			} else {//멘티인지 확인
				%>
				<%@include file="studyBottomMentee.jsp"%>
				<%
			}
			
		%>
	</div>
	
	  <script>
		var conn = new WebSocket('wss://kgu.mentomenti.kro.kr:8000/socket');
	    var myName = "<%=session.getAttribute("userID")%>" // 자기 id 저장
	    var mentoName = "<%=mentoid%>";
	    var myGroup = <%=groupid%>;
	    var myoffer;
		var myemoticon = "ques";
		var renegotiationflg = false;
		var v1 = document.getElementById("v1");
		var refreshTimer = setInterval("checkConnection()", 3000); // 3초간격으로 유저 확인
		
		var pc = {};
		var dc = {};
		var share = {};
		var audio_share = {};
		var emoticon = {};
		var available = false;
		
		function addVideo(id) {
			$('<video id="'+id+'" autoplay="true" width="1"></video>').appendTo('#screens');
			//$('#'+id).play;
		}
		
		function removeVideo(id) {
			$('#'+id).remove();
		}
		
		function addMemberToList(id, emot, idx) {
			if (id === myName) {
				$('<tr>'+
						'<td>'+idx+'</td>'+
						'<td>'+id+'</td>'+
						'<td></td>'+
						'<td></td>'+
				'</tr>').appendTo('#MemberTable');
				return;
			} 
			
			if (emot === "ques") {
				$('<tr>'+
						'<td>'+idx+'</td>'+
						'<td>'+id+'</td>'+
						'<td style="padding:5px;">'+'<i class="far fa-question-circle  fa-2x"></i></td>'+
						'<td style="padding:6px;"><button type="button" class="btn btn-info" style="padding:2px;" onclick="canvas(this)" value="'+id+'">이동</button></td>'+
				'</tr>').appendTo('#MemberTable');
			} else if (emot === "finish") {
				$('<tr>'+
						'<td>'+idx+'</td>'+
						'<td>'+id+'</td>'+
						'<td style="padding:5px;">'+'<i class="far fa-check-circle fa-2x "></i></td>'+
						'<td style="padding:6px;"><button type="button" class="btn btn-info" style="padding:2px;" onclick="canvas(this)" value="'+id+'">이동</button></td>'+
						'</tr>').appendTo('#MemberTable');
			} else if (emot === 'non-finish') {
				$('<tr>'+
						'<td>'+idx+'</td>'+
						'<td>'+id+'</td>'+
						'<td style="padding:5px;">'+'<i class="far fa-times-circle fa-2x "></i></td>'+
						'<td style="padding:6px;"><button type="button" class="btn btn-info" style="padding:2px;" onclick="canvas(this)" value="'+id+'">이동</button></td>'+
						'</tr>').appendTo('#MemberTable');
			} else if (emot === 'default') {
				$('<tr>'+
						'<td>'+idx+'</td>'+
						'<td>'+id+'</td>'+
						'<td style="padding:5px;">'+'<i class="far fa-circle fa-2x"></i></td>'+
						'<td style="padding:6px;"><button type="button" class="btn btn-info" style="padding:2px;" onclick="canvas(this)" value="'+id+'">이동</button></td>'+
						'</tr>').appendTo('#MemberTable');
			}
		}
		
		function canvas(btn){
			var url = "/canvas";
			var name = "canvas";
			var popupWidth = 1200;
			var popupHeight = 700;
			var popupX = (window.screen.width / 2) - (popupWidth / 2);
			var popupY = (window.screen.height / 2) - (popupHeight / 2);
			var option = "toolbar=no, location=no, status=no, scrollbars=no, resizable=no"
			myExternalWindow = window.open(url+'?my_id='+myName+'&your_id='+btn.value, name, option+ ', left='+ popupX + ', top='+ popupY);
			myExternalWindow.resizeTo(1200,700);
		}
		
		function checkConnection() {
			var idx = 1;
			$('#MemberTable *').remove(); // MemberTable 내부 전체 삭제
			addMemberToList(myName, myemoticon, idx++);
			for (var key in pc) {
				if (pc[key].connectionState === "disconnected" || pc[key].connectionState === "failed" // 유저 연결이 안되어 있는 경우 해당 유저 삭제 
						|| pc[key].connectionState === "closed") {
					delete(pc[key]);
					delete(dc[key]);
					delete(share[key]);
					delete(emoticon[key]);
					removeVideo(key);
				} else {
					addMemberToList(key, emoticon[key], idx++);
				}
			}
		}
		
		function changestatus(status) {
			myemoticon = status;
			for (var key in pc) {
				send({
					event : "changeStatus",
					data : status,
					from : myName,
					to : key
				});
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
			    case "stop_video":
			    	v1.srcObject = null;
			    	break;
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
			    	break;
			    case "changeStatus":
			    	emoticon[from] = data;
			    	renegotiationflg = false;
			    	break;
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
			
			/*peerConnection.ontrack = function(e) {
				if (e.track.kind === "video") 
					v1.srcObject = e.streams[0];
				else if (e.track.kind === "audio")
					
					
					
			}*/

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
			
			if (!renegotiationflg) {
				pc[name] = peerConnection; // pc 객체에 저장
				addVideo(name);
				pc[name].ontrack = function(e) {
					console.log(e);
					if (e.track.kind === "video") {
						v1.srcObject = e.streams[0];
						console.log(name, "Video");
					}
					else if (e.track.kind === "audio") {
						var targets = document.getElementById(name);
						targets.srcObject = e.streams[0];
						console.log(name, "Audio");
					}
				};
				emoticon[name] = "default";
			}
		}
		
		
		function handleOffer(from, target, offer) { 
			if (!renegotiationflg) {
				pc[from] = createPeerConnection(from);
				addVideo(from);
				pc[from].ontrack = function(e) {
					console.log(e);
					if (e.track.kind === "video") {
						v1.srcObject = e.streams[0];
						console.log(from, "Video");
					}
					else if (e.track.kind === "audio") {
						var targets = document.getElementById(from);
						targets.srcObject = e.streams[0];
						console.log(from, "Audio");
					}
				};
				emoticon[from] = "default";
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
			if (renegotiationflg) // renegitation 과정에서는 candidate 교환필요 x
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
		
		async function share_microphone() {
			navigator.mediaDevices.getUserMedia({
				audio: true
			}).then(function(audioStream){
				for (var key in pc) {
					renegotiationflg = true;
					(function (key){ // 클로저로 선언해야 제대로 맞추어서 들어감 .. ㅡㅡ
						pc[key].onnegotiationneeded = function() {
					    	pc[key].createOffer(async function(offer) { // offer 상대 peer에 전송
								await send({
									event : "rngt_offer",
									data : offer,
									from : myName,
									to : key
								});	
								pc[key].setLocalDescription(offer); 
								// LocalDescription 설정 -> icecandidate 유발시킴, 즉, candidate도 전송
							}, function(error) {
								
							});	
					    };
					    
					    //v1.srcObject = audioStream;
					    
					    if (key in audio_share) { // 이미 공유중인 상황이라면 제거 
					    	pc[key].removeTrack(audio_share[key]);
					    	delete(audio_share[key]);
					    }
					    else { // 공유중이지 않다면 새로 addTrack
							audioStream.getTracks().forEach((track) => {
								audio_share[key] = pc[key].addTrack(track, audioStream);
							}); 
					    }
					})(key);
				}
			}).catch(function(e){
				console.log(e);
			}); 
		}
		
		

		async function share_monitor() { 
			/*
			 최대 난제. 화면공유 시 renegotiation 해주어야 하는 문제
			 문제 해결 위해 rngt_offer로 offer 전달하면 renegotiation 해주도록 구현 
			*/
			navigator.mediaDevices.getDisplayMedia({
				video: true
			}).then(async function(screenStream){
				//스크린 공유 스트림을 얻어내고 여기에 오디오 스트림을 결합함
				//screenStream.addTrack(audioStream.getAudioTracks()[0]);
				v1.srcObject = screenStream;
				var obj_keys = Object.keys(pc);
				/* 화면 공유 중지 */
				screenStream.getVideoTracks()[0].addEventListener('ended', () => {
					for (var key in pc) {
						send({
							event : "stop_video",
							from : myName,
							to : key
						});
					}
				});
				
				
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

		}
	</script>
</body>
</html>