<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<title>Insert title here</title>
<style>
	body{
		margin:0;
		padding:0;
	}
	.canvas_div{
		width:75%;
		height:100vh;
		float:left;
	}
	.canvas {
		border:1px solid gray;
		outline: 2px dashed #92b0b3;
		outline-offset: -10px;
		text-align: center;
		transition: all .15s ease-in-out;
		background-color: aliceblue;
	}
	
	
	.tool{
		width:25%;
		height:50vh;
		display:flex;
		float:right;
		text-align:center;
	}
	.palette {
		text-align:center;
		margin-top:20px;
		width:  100%;
		height: 100%;
	}
	.colo{
		margin-bottom:10px;
		width:100%;
		float:left;
	}
	.column1{
		width:50%;
		float:left;
	}
	.column2{
		width:50%;
		float:right;
	}
	.column3{
		height:100%;
		width:100%;
	}
	.kit{
		height:100%;
		width:50%;
		margin:0 auto;
	}
	
	.p_color {
	
		margin:0 auto;
		width: 150px;
		height: 30px;
		margin-bottom: 5px;
		border-radius: 30px;
		cursor: pointer;
		box-shadow: 0 4px 6px rgba(50, 50, 93, 0.11), 0 1px 3px
			rgba(0, 0, 0, 0.08);
	}
	
	input[type=range] { 
		width:90%;
		margin:0 auto;
		background: transparent; 
	}
	
	.codeBox{
		background:#422351;
		width:25%;
		height:50vh;
		float:right;
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
				<h1>Palette</h1>
				<div class="colo">
				<input type="file" onchange="uploadFile(this);" />
				<div class="column1">
					<div class="row_">
						<div class="p_color" style="background-color: black"	onclick="selectColor('black')"></div>
						<div class="p_color" style="background-color: red"	onclick="selectColor('red')"></div>
					</div>
					<div class="row_">
						<div class="p_color" style="background-color: #ff9500" onclick="selectColor('orange')"></div>
						<div class="p_color" style="background-color: #ffcc00" onclick="selectColor('yellow')"></div>
					</div>
				</div>
				<div class="column2">
					<div class="row_">
						<div class="p_color" style="background-color: #4cd963" onclick="selectColor('green')"></div>
						<div class="p_color" style="background-color: #0579ff" onclick="selectColor('blue')"></div>
					</div>
					<div class="row_">
						<div class="p_color" style="background-color: #5856d6" onclick="selectColor('purple')"></div>
						<div class="p_color" style="background-color: deepPink" 	onclick="selectColor('deepPink')"></div>
					</div>
				</div>
				</div>
				<div class="column3">
				<div class="kit">
					<div class="row_">
						<button class="btn btn-sm btn-outline-dark col-md-5" onclick="selectTool('pencil')">🖊︎</button>
						<button id="erase" class="btn btn-sm btn-outline-dark col-md-5">e</button>
					</div>
					
					<div class="row_">
						<input id="slider1" class="form-range" type="range" min="1" max="20" value="3" onchange="lineWidth(this.value);" />
					</div>
					
					<div class="row_">
						<button class="btn btn-sm btn-outline-success col-md-10"  onclick="clearPage()">메모🗑️</button>
					</div>
					<div class="row_">
						<button class="btn btn-sm btn-outline-danger col-md-10" style="align-items:center;" onclick="deleteFiles()">🖼제거</button>
					</div>
				</div>
				</div>
			</div>
		</div>
		<!-- 코드 영역 -->
		<div class="codeBox">
			<textarea style="resize: none; width:100%; height:100%;"></textarea>
		</div>
	</div>
		<script src="/resources/js/painter2.js"></script>
  <script>
		var conn = new WebSocket('wss://localhost:8000/WBsocket');
	    var myName = '<%=request.getParameter("my_id")%>'; // 자기 id 저장
	    var yourName = '<%=request.getParameter("your_id")%>';
	    var myCanvas = document.getElementById("canvas");
	    var myCtx = myCanvas.getContext("2d");
	    var image = new Image();
		
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
			//initialize();
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
		    
			// 어차피 나중가면 from, to는 자동으로 정해지는 거니깐..
		    //  && content.to === myName
	    	if (content.event === "recv_paint"){
		    	var x1 = content.x1;
		    	var x2 = content.x2;
		    	var y1 = content.y1;
		    	var y2 = content.y2;
		    	var color = content.color;
		    	var force = content.force;
		    	var erase = content.erase;
		    	handlePaint(x1, y1, x2, y2, color, force, erase);
		    	return;
	    	}
			
		}
		
		async function handlePaint(x1, y1, x2, y2, color, force, erase) { // painter.js와 연동되는 부분임
			  cvs.beginPath();
				  cvs.moveTo(x1, y1);
				  cvs.lineTo(x2, y2);
				  cvs.strokeStyle = color;
				  cvs.lineWidth = force;
				  cvs.lineCap = 'round';
				  cvs.stroke();
				  cvs.globalCompositeOperation = erase;
			  cvs.closePath();
		}
		
		function isOpen(ws) { 
			return ws.readyState === ws.OPEN; 
		}
		
		function send(message) {
			if (!isOpen(conn)) return;
			conn.send(JSON.stringify(message));
		}
		
	</script>
</body>
</html>