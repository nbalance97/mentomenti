<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.WebCompiler.WebCompiler" %>
<%@ page
	import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupmateDTO, Mento.Menti.Project.dao.GroupmateDAO"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page import="java.util.List"%>
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
	function change_opt(e) {
		var groupid = document.getElementById("groupidValue").value;
		if (e.value == 'python') {
			window.location.href = 'practiceMento?groupid='+groupid+'&mode=python';
		} else if (e.value == 'C') {
			window.location.href = 'practiceMento?groupid='+groupid+'&mode=C';
		} else if (e.value == 'java') {
			var groupid_ = Integer.parseInt(request.getParameter("groupid"));
			window.location.href = 'practiceMento?groupid='+groupid+'&mode=java';
		}
	}
</script>
<body>
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
			if(!isMember || id == null){
				response.sendRedirect("rejectedAccess?type=notMember");
			}
			
			%>

	<% 
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8"); 
		String SRC = request.getParameter("CodeText"); // 코드와 입력값 받음
		String input = request.getParameter("InputText");
		String mode = request.getParameter("mode");
		String settingFile = null; // 설정된 파일명
		WebCompiler WC = WebCompiler.getInstance();
		
		if (mode == null) 
			mode = "python";
		
		if (mode.equals("python"))
			settingFile = "python";
		else if (mode.equals("C"))
			settingFile = "text/x-csrc";
		else if (mode.equals("java"))
			settingFile = "text/x-java";
		
		
		if (SRC != null)
			SRC.trim();
		if (input != null)
			input.trim();
		
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
						<option value="python" <%
							if (mode.equals("python"))
								out.println("selected");
						%>>Python</option>
						<option value="C" <%
							if (mode.equals("C"))
								out.println("selected");
						%>>C</option>
						<option value="java" <%
							if (mode.equals("java"))
								out.println("selected");
						%>>java</option>
					</select>
				</div>
				<form name="compileView" style="width:100%; height:70%;" method="post" action="./practiceMento?groupid=<%=groupid%>&mode=<%=mode%>">
					<div class="compiler img-rounded" style="padding:5px">
							<label>Code Input</label>
							<input type="submit" value="Execute">
							<textarea style="width:100%; height:100%;" name="CodeText" id="editor"><%
								/* 제출해도 사라지지 않도록 제출 시 제출한 코드 다시 롤백 */
								if (SRC != null)
									out.println(SRC);
								if (SRC == null && mode.equals("java")) {
									out.println(WC.getJavaDefault());
								}
							%></textarea> 
					</div>
			
					<div class="input img-rounded" style="padding:5px">
						<label>stdin : </label>
						<textarea style="width:100%; height:100%;" name="InputText" id="input"><%
								if (input != null) {
									out.println(input); // 사라지지 않게 처리
								}
							%></textarea>
					</div>
				</form>
			
				<div class="result img-rounded" style="padding:5px">
					<label>result : </label>
					<textarea style="width:100%; height:100%;" name="ResultText" id="result"><%
						if (SRC != null) {
							String temp = null;
							if (mode.equals("python")) {
								temp = WC.compilePython(SRC, input);
							} else if (mode.equals("C")) {
								temp = WC.compileC(SRC, input);
							} else if (mode.equals("java")) {
								temp = WC.compileJava(SRC, input);
							}
					
							if (temp != null) 
								out.println(temp);
							else
								out.println("에러 발생");
						}
					%></textarea>
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
		var textarea = document.getElementById('editor');
		var editor = CodeMirror.fromTextArea(textarea, {
			lineNumbers: true,
			lineWrapping: true,
			theme: "dracula",
			mode: "<%=settingFile%>",
			value: textarea.value,
		});
		
		var textarea2 = document.getElementById('result');
		var editor2 = CodeMirror.fromTextArea(textarea2, {
			lineNumbers: true,
			lineWrapping: true,
			theme: "dracula",
			value: textarea2.value
		});
		
		var textarea3 = document.getElementById('input');
		var editor3 = CodeMirror.fromTextArea(textarea3, {
			lineNumbers: true,
			lineWrapping: true,
			theme: "dracula",
			value: textarea3.value
		});
		
		editor.setSize("100%", "100%");
		editor2.setSize("100%", "100%");
		editor3.setSize("100%", "100%");
	</script>
	<script>
		var conn = new WebSocket('wss://kgu.mentomenti.kro.kr:8000/socket');
	    var myName = "<%=session.getAttribute("userID")%>" // 자기 id 저장
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
						'<td>'+'<i class="far fa-question-circle stateIcon fa-2x"></i></td>'+
						'<td><button type="button" class="btn btn-info" onclick="canvas(this)" value="'+id+'">이동</button></td>'+
				'</tr>').appendTo('#MemberTable');
			} else if (emot === "finish") {
				$('<tr>'+
						'<td>'+idx+'</td>'+
						'<td>'+id+'</td>'+
						'<td>'+'<i class="far fa-check-circle fa-2x emotion"></i></td>'+
						'<td><button type="button" class="btn btn-info" onclick="canvas(this)" value="'+id+'">이동</button></td>'+
						'</tr>').appendTo('#MemberTable');
			} else if (emot === 'non-finish') {
				$('<tr>'+
						'<td>'+idx+'</td>'+
						'<td>'+id+'</td>'+
						'<td>'+'<i class="far fa-times-circle fa-2x emotion"></i></td>'+
						'<td><button type="button" class="btn btn-info" onclick="canvas(this)" value="'+id+'">이동</button></td>'+
						'</tr>').appendTo('#MemberTable');
			} else if (emot === 'default') {
				$('<tr>'+
						'<td>'+idx+'</td>'+
						'<td>'+id+'</td>'+
						'<td>'+'<i class="far fa-circle fa-2x"></i></td>'+
						'<td><button type="button" class="btn btn-info" onclick="canvas(this)" value="'+id+'">이동</button></td>'+
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
					from : myName,
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
					from : myName,
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