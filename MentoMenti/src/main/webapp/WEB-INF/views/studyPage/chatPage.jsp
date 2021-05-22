<!-- https://deveric.tistory.com/18 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chatting</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>


<style type="text/css">

	html,body{
		height: 100%;
	}

	#messageWindow{
		background: black;
		color: greenyellow;
	}
	
	/*채팅 입력창*/
	#inputMessage{
		width:80%;
		height:50%;
	}
	
	/*채팅 전송 버튼*/
	#btn-submit{
		background: #5587ED;
		color:white;
		width:18%;
		height:50%;
		border:none;
		border-radius:3px;
	}
	
	/*채팅 부분 전체 div*/
	#main-container{
		width:100%;
		height:100%;
		display: inline-block;
		
	}
	
	/*채팅 내역 부분 전체 div*/
	#chat-container{
		vertical-align: bottom;
		border: 1px solid black;
		margin:5px;
		height:100%;
		overflow: scroll;
		overflow-x:hidden;
		background: #F7F7F7;
	}
	
	/*받은 채팅 내용 부분*/
	.chat{
		font-size: 1.0em;
		color:black;
		margin: 5px;
		min-height: 20px;
		padding: 5px;
		/*min-width: 50px;*/
		text-align: left;
        height:auto;
        word-break : break-all;
        background: #D9E5FF;
        width:auto;
        display:inline-block;
        border-radius: 10px 10px 10px 10px;
	}
	
	.notice{
		color:#607080;
		font-weight: bold;
		border : none;
		text-align: center;
		background-color: #9bbbd4;
		display: block;
	}

	/*보낸 채팅 내용 부분*/
	.my-chat{
		text-align: left;
		background: #E0E0E0;
		border-radius: 10px 10px 10px 10px;
	}
	
	/*채팅 메세지 입력 부분 div*/
	#bottom-container{
		margin:10px;
	}
	
	/*채팅 시간 감싸는 div*/
	.chat-info{
		color:#556677;
		font-size: 10px;
		text-align: right;
		padding: 5px;
		padding-top: 0px;

	}
	
	/*받은 채팅 내용, 시간 포함하는 div*/
	.chat-box{
		text-align:left;
		margin-left:5px;
	}
	
	/*보낸 채팅 내용, 시간 포함하는 div*/
	.my-chat-box{
		text-align: right;
		margin-right:5px;
	}
	/*받은 채팅 유저 아이디div*/
	.userId{
		margin-left:8px;
	}
	
</style>
</head>


<body>
	<div id="main-container">
		<div id="chat-container"></div>
		<div id="bottom-container">
			<input id="inputMessage" type="text">
			<input id="btn-submit" type="submit" value="전송" >
		</div>
	</div>
</body>


<script type="text/javascript">
	var textarea = document.getElementById("messageWindow");
	var inputmsg = document.getElementById("inputMessage");
	
	var webSocket = new WebSocket("wss://kgu.mentomenti.kro.kr:8000/chating"); 
	var inputMessage = document.getElementById('inputMessage');
	var btn_submit = document.getElementById("btn-submit");
	
	webSocket.onerror = function(e){
		_onError(e);
	};
	webSocket.onopen = function(e){
		_onOpen(e);
	};
	webSocket.onmessage = function(e){
		_onMessage(e);
	};
	
	
	function _onMessage(e){
		var chatMsg = e.data;
		console.log(chatMsg);
		var date = new Date();
		var dateInfo = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
		var idx = chatMsg.indexOf("/");
		var groupid = chatMsg.substring(0, idx); // groupid
		var nextidx = chatMsg.indexOf("/", idx+1);
		var senderid = chatMsg.substring(idx+1, nextidx); // 보낸 상대방 id
		var Msg = chatMsg.substring(nextidx+1); // 실제 메세지
		
		if (groupid != myGroup)
			return;
		
		if(chatMsg.substring(0,6) === 'server'){
			var $chat = $("<div class='chat notice'>" + chatMsg + "</div>");
			$('#chat-container').append($chat);
		}else{
			var $chat = $("<div id='other' class='chat-box'><div class='userId'>"+senderid+"</div><div class='chat'>" + Msg + "</div><div class='chat-info chat-box'>"+ dateInfo +"</div></div>");
			$('#chat-container').append($chat);
		}
		
		
		$('#chat-container').scrollTop($('#chat-container')[0].scrollHeight+20);
	}
	
	function _onOpen(e){
		
	}
	
	function _onError(e){
		alert(e.data);
	}
	
	function _send(){
		var chatMsg = inputMessage.value;
		if(chatMsg === ''){
			return;
		}
		var date = new Date();
		var dateInfo = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
		var $chat = $("<div class='my-chat-box'><div class='chat my-chat'>" + chatMsg + "</div><div class='chat-info'>"+ dateInfo +"</div></div>");
		$('#chat-container').append($chat);
		//$('.chat-box').hide();
		webSocket.send(myGroup + "/" + myNick + "/" + chatMsg);
		inputMessage.value = "";
		$('#chat-container').scrollTop($('#chat-container')[0].scrollHeight+20);
	}
	
	btn_submit.onclick = function(e) {
		_send();
	};
	
	inputmsg.onkeydown = function(key){
		if(key.keyCode == 13){
			inputmsg.focus();
			_send();
		}
	};
</script>
</html>