<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script><!-- 제이쿼리가 안불러져서 추가 -->

<title>Insert title here</title>
<style>
	body{
		margin:0;
		padding:0;
		overflow:hidden;
	}
	.canvas_div{
		width:75%;
		height:100vh;
		float:left;
		overflow:hidden;
	}
	.canvas {
		/*border:1px solid gray;
		outline: 2px dashed #92b0b3;
		outline-offset: -10px;*/
		text-align: center;
		transition: all .15s ease-in-out;
		background-color: aliceblue;
	}
	
	
	.tool{
		width:25%;
		height:100vh;
		float:right;
		text-align:center;
		border:1px solid gray;
	}
	.codeBox{
		background:#422351;
		width:25%;
		height:50vh;
		float:right;
	}
	.palette {
		text-align:center;
		margin-top:10px;
		width:  100%;
		height: 100%;
		padding-top:20px;
	}
	.colo{
		margin-bottom:20px;
		width:100%;
		float:left;
	}
	.column1{
		width:50%;
		display:block;
		float:left;
	}
	.column2{
		width:50%;
		display:block;
		float:right;
	}
	.column3{
		height:50%;
		width:100%;
	}
	
	.kit{
		height:50%;
		width:75%;
		margin:0 auto;
	}
	
	.way{
		/*height:50%;*/
		/*width:135%;*/
		margin:0 auto;
	}
	
	.p_color {
		margin:0 auto;
		width: 100px;
		height: 30px;
		margin-bottom: 10px;
		border-radius: 30px;
		cursor: pointer;
		box-shadow: 0 4px 6px rgba(50, 50, 93, 0.11), 0 1px 3px
			rgba(0, 0, 0, 0.08);
	}
	
	input[type=range] { 
		width:100%;
		margin:0 auto;
		background: transparent; 
	}
	
	.canvas_icon{
		padding-bottom:3px;
		width:20px;
	}
	
	.active{
		background: #007bff !important;
	}
	
	.btn-box{
		margin:20px;
	}
	
</style>
</head>

<body onresize="parent.resizeTo(1200,700)" onload="parent.resizeTo(1200,700)">
	<div class="fullScreen">
		<!-- 그림그리는 영역 -->
		<div class="canvas_div">
			<canvas id="canvas" class="canvas"></canvas>
		</div>
		<!-- 캔버스 도구 -->
		<div class="tool">
			<div class="palette">
				<div class="colo">
					<div class="column1">
							<div class="p_color" style="background-color: black"	onclick="selectColor('black')"></div>
							<div class="p_color" style="background-color: red"	onclick="selectColor('red')"></div>
							<div class="p_color" style="background-color: #ff9500" onclick="selectColor('orange')"></div>
							<div class="p_color" style="background-color: #ffcc00" onclick="selectColor('yellow')"></div>
					</div>
					<div class="column2">
							<div class="p_color" style="background-color: #4cd963" onclick="selectColor('yellowgreen')"></div>
							<div class="p_color" style="background-color: #0579ff" onclick="selectColor('blue')"></div>
							<div class="p_color" style="background-color: purple" onclick="selectColor('purple')"></div>
							<div class="p_color" style="background-color: deepPink" 	onclick="selectColor('deepPink')"></div>
					</div>
				</div>
				<div class="kit">
					<div class="btn-box">
						<button class="btn btn-outline-primary canvasfn active" onclick="selectTool('pencil')"><img class="canvas_icon" alt="" src="resources/img/canvas/pen.png"></button>
						<button id="erase" class="btn btn-outline-primary canvasfn"><img class="canvas_icon" alt="" src="resources/img/canvas/eraser.png"></button>					
						<button class="btn btn-outline-danger"  onclick="clearPage()"><img class="canvas_icon" alt="" src="resources/img/canvas/trash.png"></button>
					</div>	
						<input id="slider1" class="form-range" type="range" min="1" max="20" value="3" onchange="lineWidth(this.value);" />
						<input id="input-file" class="btn" type="file" style="margin-top:10px; width:100%;" onchange="uploadFile(this);" />
					<div style="position:relative; width:100%; height:100%;"><img src="resources/img/logo3.png" style="position:absolute; margin:0 auto; top: 50%; left: 50%; transform: translate(-50%, -50%); width:170px;"></div>
				</div>
			</div>
		</div>
	</div>
	<%
		String src = request.getParameter("src");
		if (src == null) 
			src = "";
	%>
	<script src="/resources/js/painter2.js"></script>
  <script>
		var conn = new WebSocket('wss://kgu.mentomenti.kro.kr:8000/WBsocket');
	    var myName = '<%=request.getParameter("my_id")%>'; // 자기 id 저장
	    var yourName = '<%=request.getParameter("your_id")%>';
	    var myCanvas = document.getElementById("canvas");
	    var myCtx = myCanvas.getContext("2d");
	    var mysrc = '<%=src%>';
	    var image = new Image();
	    var usage = false;
		
	    image.onload = function() {
			myCtx.drawImage(image, 0, 0);
		}
		
		
		function uploadFile(inputElement) {
			var file = inputElement.files[0];
			var reader = new FileReader();
			reader.onloadend = function() {
				arrayBuffer = reader.result;
				conn.send(arrayBuffer);
				var url = URL.createObjectURL(new Blob([arrayBuffer]));
				image.src = url;
			}
			reader.readAsArrayBuffer(file);
		}
		
		conn.onopen = function() { // 소켓 열었을때
			console.log("Connected to the signaling server");
			console.log("Current User:" + myName);
			send({ // name을 server에 알려서 broadcast
				event: "namecall",
				from: myName,
				to: yourName
			});
			console.log(yourName);
		}
		
		conn.onmessage = function(msg) {
		    console.log("Got message", msg.data);
		    var temp = msg.data;
		    
		    if (temp instanceof Blob) {
			    var url = URL.createObjectURL(new Blob([msg.data]));
			    image.src = url;
			    return;
		    }
		    
		    var content = JSON.parse(msg.data);
		    var from = content.from;
		    var data = content.data;
		    var to = content.to;
		  
	    	if (content.event === "recv_paint"){
		    	var x1 = content.x1;
		    	var x2 = content.x2;
		    	var y1 = content.y1;
		    	var y2 = content.y2;
		    	var color = content.color;
		    	var force = content.force;
		    	var penMode = content.penMode;
		    	handlePaint(x1, y1, x2, y2, color, force, penMode);
		    	return;
	    	}
	    	
	    	if (content.event === "recv_start") {
	    		usage = true;
	    	}
	    	
	    	if (content.event === "recv_finish") {
	    		usage = false;
	    	}
			
	    	if(content.event === "recv_clear") {
	    		var isClear = content.isClear;
	    		clearBoard(isClear);
	    		return;
	    	}
	    	
	    	if (content.event === "code") {
	    		document.getElementById("codearea").value = data;
	    	}
			
		}
		
		async function handlePaint(x1, y1, x2, y2, color, force, penMode) { // painter.js와 연동되는 부분임
			  cvs.beginPath();
				  cvs.moveTo(x1, y1);
				  cvs.lineTo(x2, y2);
				  cvs.strokeStyle = color;
				  cvs.lineWidth = force;
				  cvs.lineCap = 'round';
				  cvs.stroke();
				  cvs.globalCompositeOperation = penMode;
			  cvs.closePath();
		}
		
		async function clearBoard(isClear){
			if (isClear == 1)
				cvs.clearRect(0, 0, canvas.width, canvas.height);
			else
				return;
			
		}
		
		
		function isOpen(ws) { 
			return ws.readyState === ws.OPEN; 
		}
		
		function send(message) {
			if (!isOpen(conn)) return;
			conn.send(JSON.stringify(message));
		}
		
		// 펜, 지우개 클릭시 클릭색 유지
  		$('.canvasfn').click(function() {
  			$('.canvasfn').removeClass('active');
  			$(this).addClass('active');
  		});
	</script>
</body>
</html>