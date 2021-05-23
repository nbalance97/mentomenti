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
			<!-- mode에 맞게 selected 되도록 설정 + 변경 시 redirect 설정 -->
		<div class="coding">
			<div class="problemImg shadow img-rounded">
				<img id="prob_image" src="resources/img/fileupload_default.png" style="width:100%; height:100%; object-fit: contain;"></img> 
			</div>
			<div class="codingFunc">
				<div class="languageSelect">
					<select id="selectpart" onchange="change_opt(this)">
						<option value="python">Python</option>
						<option value="C">C</option>
						<option value="java">java</option>
					</select>
				</div>
				<form name="compileView" style="width:100%; height:70%;" method="post" action="">
					<div class="compiler img-rounded" style="padding:5px">
							<label>Code Input</label>
							<input type="button" value="Execute" onclick="processCompile();">
							<textarea style="width:100%; height:100%;" name="CodeText" id="editor"></textarea> 
					</div>
			
					<div class="input img-rounded" style="padding:5px">
						<label>stdin : </label>
						<textarea style="width:100%; height:100%;" name="InputText" id="input"></textarea>
					</div>
				</form>
			
				<div class="result img-rounded" style="padding:5px">
					<label>result : </label>
					<textarea style="width:100%; height:100%;" name="ResultText" id="result"></textarea>
				</div>
			</div>
		</div>
		<% 
			//멘토아이디와 접속한 아이디 비교
			//True = 멘토, False = 멘티 확인
			if (mentoid.equals(id)){//멘토
				%>
				<%@include file="practiceBottomMentor.jsp"%>
				<% 
			} else {//멘티인지 확인
				%>
				<%@include file="practiceBottomMentee.jsp"%>
				<%
			}
			
		%>
	</div>
	<%@include file="studySidebar.jsp"%>
	<!-- Library textarea에 적용하는 과정 -->
	<script>
		var settingFile = 'python';
		var set_mode = 'python';
	
		var textarea = document.getElementById('editor');
		var editor = CodeMirror.fromTextArea(textarea, {
			lineNumbers: true,
			lineWrapping: true,
			theme: "dracula",
			mode: "python",
			value: textarea.value,
		});
		
		var textarea2 = document.getElementById('result');
		var editor2 = CodeMirror.fromTextArea(textarea2, {
			lineNumbers: true,
			lineWrapping: true,
			mode: "python",
			theme: "dracula",
			value: textarea2.value
		});
		
		var textarea3 = document.getElementById('input');
		var editor3 = CodeMirror.fromTextArea(textarea3, {
			lineNumbers: true,
			lineWrapping: true,
			mode: "python",
			theme: "dracula",
			value: textarea3.value
		});
		
		editor.setSize("100%", "100%");
		editor2.setSize("100%", "100%");
		editor3.setSize("100%", "100%");
		
		function change_opt(e) {
			editor.setSize("0%", "0%"); // 0%에서 100%로 늘려줘야 점점 안커짐....,,,,,
			editor2.setSize("0%", "0%");
			editor3.setSize("0%", "0%");
			set_mode = e.value;
			
			if (e.value == "python") {
				settingFile = 'python';
			} else if (e.value === "C") {
				settingFile = "text/x-csrc";
			} else {
				settingFile = "text/x-java";
			}
			
			editor = CodeMirror.fromTextArea(textarea, {
				lineNumbers: true,
				lineWrapping: true,
				theme: "dracula",
				mode: settingFile,
				value: textarea.value,
			});
			
			editor2 = CodeMirror.fromTextArea(textarea2, {
				lineNumbers: true,
				lineWrapping: true,
				theme: "dracula",
				mode: settingFile,
				value: textarea2.value
			});
			
			editor3 = CodeMirror.fromTextArea(textarea3, {
				lineNumbers: true,
				lineWrapping: true,
				theme: "dracula",
				mode: settingFile,
				value: textarea3.value
			});
			
			editor.setSize("100%", "100%");
			editor2.setSize("100%", "100%");
			editor3.setSize("100%", "100%");	
		}
		
		function processCompile() {
			var total_data = {
				mode: set_mode,
				src: editor.getValue(),
				input: editor3.getValue(),
			};
			
			$.ajax({
		        url: "https://kgu.mentomenti.kro.kr:8000/WebCompile",
		        type: "POST",
		        async: true,
		        data: total_data,
		        success: function(data) {
		            editor2.setValue(data);
		        }
		    });
		}
	</script>
	<script>
		var conn = new WebSocket('wss://kgu.mentomenti.kro.kr:8000/socket');
	    var myName = "<%=session.getAttribute("userID")%>" // 자기 id 저장
	    var myNick = "<%=nick%>";
	    var myGroup = <%=groupid%>;
		var dataChannel;
	    var myoffer;

		var refreshTimer = setInterval("checkConnection()", 3000); // 3초간격으로 유저 확인
		var image = document.getElementById("prob_image");
		var myemoticon = "ques";
		
		var pc = {};
		var dc = {};
		var share = {};
		var emoticon = {};
		
		function addMemberToList(id, emot, idx) {
			if (id === myNick) {
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
						'<td style="padding:5px;">'+'<i class="far fa-question-circle fa-2x"></i></td>'+
						'<td style="padding:6px;"><button type="button" class="btn btn-info" style="padding:2px;" onclick="canvas(this)" value="'+id+'">이동</button></td>'+
				'</tr>').appendTo('#MemberTable');
			} else if (emot === "finish") {
				$('<tr>'+
						'<td>'+idx+'</td>'+
						'<td>'+id+'</td>'+
						'<td style="padding:5px;">'+'<i class="far fa-check-circle fa-2x"></i></td>'+
						'<td style="padding:6px;"><button type="button" class="btn btn-info" style="padding:2px;" onclick="canvas(this)" value="'+id+'">이동</button></td>'+
						'</tr>').appendTo('#MemberTable');
			} else if (emot === 'non-finish') {
				$('<tr>'+
						'<td>'+idx+'</td>'+
						'<td>'+id+'</td>'+
						'<td style="padding:5px;">'+'<i class="far fa-times-circle fa-2x"></i></td>'+
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
		
		function uploadFile(inputElement) {
			var file = inputElement.files[0];
			var reader = new FileReader();
			reader.onloadend = function() {
				//Data : reader.result;
				arrayBuffer = reader.result;
				for (var key in dc)
					dc[key].send(arrayBuffer);
				
				var url = URL.createObjectURL(new Blob([arrayBuffer]));
				image.src = url;
			}
			reader.readAsArrayBuffer(file);
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
				if (pc[key].connectionState === "disconnected" || pc[key].connectionState === "failed" // 유저 연결이 안되어 있는 경우 해당 유저 삭제 
						|| pc[key].connectionState === "closed") {
					delete(pc[key]);
					delete(dc[key]);
					delete(share[key]);
					delete(emoticon[key]);
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
		    if ((content.event === "namecall" && content.group === myGroup) | content.to === myNick) { 
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
				if (event.candidate) {
					send({
						event : "candidate",
						data : event.candidate,
						from : myNick,
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
			emoticon[name] = "default";
		}
		
		
		function handleOffer(from, target, offer) { 
			pc[from] = createPeerConnection(from);
			emoticon[from] = "default";
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
	</script>
</body>
</html>