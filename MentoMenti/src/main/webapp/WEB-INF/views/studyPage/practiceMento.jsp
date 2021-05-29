<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.WebCompiler.WebCompiler" %>
<%@ page
	import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupmateDTO, Mento.Menti.Project.dao.GroupmateDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page import="java.util.List"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8"> 
	<title>practiceMento</title>
	<link href="/resources/css/bootstrap.min.css" rel="stylesheet" />
	<link href="/resources/css/defaultStudyPractice.css" rel="stylesheet" type="text/css">
	
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/codemirror.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/mdn-like.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/dracula.css">
	<!-- 파비콘 설정 -->
	<link rel="shortcut icon" href="resources/img/logo3.png">
	<link rel="icon" href="resources/img/logo3.png">

	<script type="text/javascript" src="/resources/js/codemirror.js"></script>
	<script src="/resources/js/python.js"></script>
	<script src="/resources/js/clike.js"></script>
	
	<style>
	.coding{
		height:90%;
		padding:30px;
	}
	.compiler, .input, .result{
		height:20%;
		float:left;
		width:99%;
	}
	.compiler{
		height:50%;
	}
	.compiler, .input{
		margin-bottom:30px;
	}
	.problemImg{
		height:82vh;
		float:left;
		width:48%;
		border:1px solid gray;
		background:white;
	}
	.codingFunc{
		width:48%;
		height:90%;
		float:right;
	}
	.execute{
		margin:20px;
		float: right;
	}
	.screen{
		float:left;
		width:100%;
		height:90%;
		background:black;
		positon :relative;
	}
	.share_imag{
		width:100px;
		height:100px;
		background:white;
		position: absolute;
		top:0;
		right:50px;
		z-index:10;
	}
	</style>
</head>
<script>
</script>
<body>
			<%
			PrintWriter pw = response.getWriter();
			//방만들기 클릭시 class대한 세션설정 필요?
			//클래스아이디 받아오기
			//해당 클래스아이디의 그룹아이디 찾기 -> grouppage에서 그룹 아이디 보내도록 했음
			int groupid = Integer.parseInt(request.getParameter("groupid"));
			GroupDTO group = HomeController.dao.getGroupDAO().searchGroupByGroupid(groupid);
			//해당 그룹의 멘토아이디 받아오기
			String mentoid = group.getMentoid();
			String id = (String)session.getAttribute("userID");	//세션에서 접속한 아이디 받아오기 
			//접속아이디의 닉네임 가져오기
			String nick = HomeController.dao.getUserDAO().selectNicknameById(id);
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
			if(!isMember || id.equals(null)){//서버연결 뭐시기 땜에 sendRedirect가 안먹힘,,,
				//response.sendRedirect("rejectedAccess?type=notMember");
				pw.print("<script>alert('해당그룹에 가입하지 않았습니다.');</script>");
				pw.print("<script>window.location='main'</script>"); //자신의 그룹 목록 페이지로 이동
			}
			
			%>

	<% 
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8"); 
		
	%>
	
	<div class="main">
		<%@include file="studyPageScreen.jsp"%>
		<% 
		
			if (mentoid.equals(id)){//멘토 화면
				%>
				<%@include file="practiceBottomMentor.jsp"%>
				<% 
			} else {//멘티 화면
				%>
				<%@include file="practiceBottomMentee.jsp"%>
				<%
			}
			
		%>
	</div>
	<%@include file="studySidebar.jsp"%>
	<!-- Library textarea에 적용하는 과정 -->
	<script>
		var conn = new WebSocket('wss://kgu.mentomenti.kro.kr:8000/socket');
	    var myName = "<%=session.getAttribute("userID")%>" // 자기 id 저장
	    var myNick = "<%=nick%>";
	    var myGroup = <%=groupid%>;
		var dataChannel;
	    var myoffer;

		var refreshTimer = setInterval("checkConnection()", 3000); // 3초간격으로 유저 확인
		var image = document.getElementById("prob_image");
		var myemoticon = "default";
		
		var flg = {};
		var pc = {};
		var dc = {};
		var audio_share = {};
		var emoticon = {};
		
		var mic_stream = null;
		var mic_status = false;
		
		function addVideo(id) {
			$('<video id="'+id+'" autoplay="true" width="1"></video>').appendTo('#savetemp');
			//$('#'+id).play;
		}
		
		function removeVideo(id) {
			$('#'+id).remove();
		}
		
		function addMemberToList(id, emot, idx) {
			var tag = '';
			tag = tag + '<tr>';
			tag = tag + '<td>'+idx+'</td>';
			tag = tag + '<td>'+id+'</td>';//아이디->닉네임으로 변경
			if (emot === "ques")
				tag = tag + '<td style="padding:5px;">'+'<i class="far fa-question-circle  fa-2x"></i></td>';
			else if (emot === "finish")
				tag = tag + '<td style="padding:5px;">'+'<i class="far fa-check-circle fa-2x "></i></td>';
			else if (emot === 'non-finish')
				tag = tag + '<td style="padding:5px;">'+'<i class="far fa-times-circle fa-2x "></i></td>';
			else if (emot === 'default')
				tag = tag + '<td style="padding:5px;">'+'<i class="far fa-circle fa-2x"></i></td>';
			
			if (id !== myNick)
				tag = tag + '<td style="padding:6px;"><button type="button" class="btn btn-info" style="padding:2px;" onclick="canvas(this)" value="'+id+'">이동</button></td></tr>';
			else
				tag = tag + '<td></td></tr>'	
			
			$(tag).appendTo('#MemberTable');
			return;
		}
		
		function canvas(btn){
			var url = "/canvas";
			var name = "canvas";
			var popupWidth = 1200;
			var popupHeight = 700;
			var popupX = (window.screen.width / 2) - (popupWidth / 2);
			var popupY = (window.screen.height / 2) - (popupHeight / 2);
			var option = "toolbar=no, location=no, status=no, scrollbars=no, resizable=no"
			myExternalWindow = window.open(url+'?my_id='+myNick+'&your_id='+btn.value, name, option+ ', left='+ popupX + ', top='+ popupY);
			myExternalWindow.resizeTo(1200,700);
		}
		
		function checkConnection() {
			var idx = 1;
			$('#MemberTable *').remove(); // MemberTable 내부 전체 삭제
			addMemberToList(myNick, myemoticon, idx++);
			for (var key in pc) {
				addMemberToList(key, emoticon[key], idx++);
			}
		}
		
		
		function changestatus(status) {
			myemoticon = status;
			for (var key in pc) {
				send({
					event : "changeStatus",
					data : status,
					from : myNick,
					to : key
				});
			}
		}
		
		conn.onopen = function() { // 소켓 열었을때
			console.log("Connected to the signaling server");
			console.log("Current User:" + myName);
			send({ // name을 server에 알려서 broadcast
				event: "namecall",
				data: myNick,
				group: myGroup,
				mode: "practice"
			});
			//initialize();
		}
		
		conn.onmessage = function(msg) {
		    //console.log("Got message", msg.data);
		    var content = JSON.parse(msg.data);
		    var from = content.from;
		    var data = content.data;
		    var to = content.to;
		    
		    // 그룹의 새멤버 or 자신에게 향하는 패킷만 처리
		    if ((content.event === "namecall" && content.group === myGroup) | content.to === myNick) { 
			    switch (content.event) {
			    case "offer":
			        handleOffer(from, to, data, false);
			        break;
			        
			    case "answer":
			        handleAnswer(from, to, data, false); 
			        break;
			        
			    case "candidate":
			        handleCandidate(from, to, data); // candidate 저장
			        break;
			        
			    case "namecall":
			    	if (content.mode === "study")
			    		break;
			    	
			    	if (pc[data] !== undefined || dc[data] !== undefined || audio_share[data] !== undefined || 
			    			 emoticon[data] !== undefined) {
			    		removeConnection(data);
			    	}
			    	
			    	flg[data] = false;
			    	createOffer(data);
			    	break;
			    	
			    case "rngt_offer":
			    	flg[from] = true;
			    	handleOffer(from, to, data, true);
			    	break;
			    	
			    case "changeStatus":
			    	if (emoticon[from] !== undefined)
			    		emoticon[from] = data;
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
		
		function removeConnection(target) {
			if (pc[target] !== undefined) {
				pc[target].close();
				delete(pc[target]);
			}
			
			if (dc[target] !== undefined)
				delete(dc[target]);
			
			if (emoticon[target] !== undefined)
				delete(emoticon[target]);
			
			if (flg[target] !== undefined)
				delete(flg[target]);
			
			if (audio_share[target] !== undefined)
				delete(audio_share[target]);
			
			if (document.getElementById(target) !== null)
				removeVideo(target);
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
				if (event.candidate) {
					send({
						event : "candidate",
						data : event.candidate,
						from : myNick,
						to : target
					});
				}
			}
			
			peerConnection.onconnectionstatechange = function(event) {
				  switch(peerConnection.connectionState) {
				      case "connected":
				      	if (flg[target] === false) {
				    	console.log("[onconnectionstatechange]" + target + "에게 연결되었으니 공유");
						if (mic_status)
						       shareMicById(target);
				        } 
				        flg[target] = true;
				        break;
				        
					    case "disconnected":
					    	break;
					    	
					    case "failed":
				    	case "closed":
					    	console.log(peerConnection.connectionState);
							removeConnection(target);
				       		break;
				  }
			}
			
			flg[target] = false; // renegotiation flg false
			setDataChannel(peerConnection, target);
			return peerConnection;
		}
		
		function setDataChannel(peerConnection, target) {
			var dataChannel = peerConnection.createDataChannel("dataChannel", {
				reliable: true
			});
			
			dataChannel.onopen = function(event) {
				console.log("dataChannel successfully opened!");
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
				var arrayBuffer = event.data;
				var url = URL.createObjectURL(new Blob([arrayBuffer]));
				image.src = url;
			};
			
			peerConnection.ondatachannel = function(event) {
				dc[target] = event.channel; // datachannel 따로 저장
			};
		}
		
		function createOffer(name) { // 상대방의 name으로 connection 생성
			var peerConnection = createPeerConnection(name);
			
			peerConnection.createOffer(async function(offer) { // offer 상대 peer에 전송
				await send({
					event : "offer",
					data : offer,
					from : myNick,
					to : name
				});	
				peerConnection.setLocalDescription(offer); 
				// LocalDescription 설정 -> icecandidate 유발시킴, 즉, candidate도 전송
			}, function(error) {
				
			});	
			
			pc[name] = peerConnection; // pc 객체에 저장
			addVideo(name);
			pc[name].ontrack = function(e) {
				console.log(e);
				if (e.track.kind === "audio") {
					var targets = document.getElementById(name);
					targets.srcObject = e.streams[0];
					console.log(name, "Audio");
				}
			};

			emoticon[name] = "default";
		}
		
		
		function handleOffer(from, target, offer, renegotiationflg) { 
			if (!renegotiationflg) {
				pc[from] = createPeerConnection(from);
				addVideo(from);
				pc[from].ontrack = function(e) {		
					if (e.track.kind === "audio") {
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
					from : myNick,
					to : from
				});
			}, function(error) {
				
			});	
		}
		
		function handleCandidate(from, to, candidate) {
			if (flg[from]) // renegitation 과정에서는 candidate 교환필요 x
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
		
		async function setMicStream() {
			if (mic_stream !== null) {
				return mic_stream;
			}
			
			return navigator.mediaDevices.getUserMedia({
				audio: true
			}).then(function(audioStream){
				mic_stream = audioStream;
			});
		}
		
		async function removeMicById(id) {
			 if (mic_status == true) {
				 	if (id in audio_share) { 
				    	pc[id].removeTrack(audio_share[id]);
				    	delete(audio_share[id]);
				 	}
			 }
		}
		
		async function shareMicById(id) {
			if (pc[id] === undefined || mic_stream === null || pc[id].connectionState !== "connected") {
				console.log("mic stream이 없거나 pc[id]가 정의되지 않음.");
				return;
			}
			if (audio_share[id] !== undefined) {
				console.log("audio가 이미 공유되고 있음.");
				return;
			}
			
			pc[id].onnegotiationneeded = function() {
			    	pc[id].createOffer(async function(offer) { // offer 상대 peer에 전송
						await send({
							event : "rngt_offer",
							data : offer,
							from : myNick,
							to : id
						});	
						pc[id].setLocalDescription(offer); 
						// LocalDescription 설정 -> icecandidate 유발시킴, 즉, candidate도 전송
					}, function(error) {
						
					});	
			 };
			    
		    //v1.srcObject = audioStream;
			mic_stream.getTracks().forEach((track) => {
				audio_share[id] = pc[id].addTrack(track, mic_stream);
			}); 
		}
		
		async function share_microphone() {
			if (mic_status === true) {
				for (var key in pc) {
					removeMicById(key);
				}
			} else {
				setMicStream().then(function() {
					for (var key in pc) {
						shareMicById(key);
					}
				});
			}
			mic_status = !mic_status;
		}
	</script>
</body>
</html>