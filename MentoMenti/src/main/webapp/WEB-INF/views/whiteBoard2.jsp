<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="resources/js/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<html>
<head>
<title>WhiteBoard</title>

</head>
<style>
.canvas_div {
	width: 85%;
	height: 100%;
	float: left;
	
}

.canvas {
	border:1px solid gray;
	outline: 2px dashed #92b0b3;
	outline-offset: -10px;
	text-align: center;
	transition: all .15s ease-in-out;
	background-color: aliceblue;
}

.palette {
	width: 15%;
	height: 100%;
	display: flex;
	flex-direction: column;
	align-items: center;
	float: right;
}

.row .btn {
	margin: 3px;
	font-size: small;
}

.p_color {
	width: 30px;
	height: 30px;
	margin: 3px;
	border-radius: 30px;
	cursor: pointer;
	box-shadow: 0 4px 6px rgba(50, 50, 93, 0.11), 0 1px 3px
		rgba(0, 0, 0, 0.08);
}

input[type=range] { 
	width:70%;
	background: transparent; 
}
</style>
<body>
	<div class="canvas_div">
		<!-- 캔버스 태그 특성상 동적으로 만들면 그림그린거 다 깨짐. 따라서 window.innerWidth, height 사용  -->
		<!-- painter.js 맨 아래 onLoadPage 함수  -->
		<canvas id="canvas" class="canvas"></canvas>
	</div>

	<div class="palette">
		<div class="column">
			<div class="row">
				<div class="p_color col-md-5" style="background-color: black"	onclick="selectColor('black')"></div>
				<div class="p_color col-md-5" style="background-color: red"	onclick="selectColor('red')"></div>
			</div>
			<div class="row">
				<div class="p_color col-md-5" style="background-color: #ff9500" onclick="selectColor('orange')"></div>
				<div class="p_color col-md-5" style="background-color: #ffcc00" onclick="selectColor('yellow')"></div>
			</div>
			<div class="row">
				<div class="p_color col-md-5" style="background-color: #4cd963" onclick="selectColor('green')"></div>
				<div class="p_color col-md-5" style="background-color: #0579ff" onclick="selectColor('blue')"></div>
			</div>
			<div class="row">
				<div class="p_color col-md-5" style="background-color: #5856d6" onclick="selectColor('purple')"></div>
				<div class="p_color col-md-5" style="background-color: deepPink" 	onclick="selectColor('deepPink')"></div>
			</div>
		
			<div class="row">
				<button class="btn btn-sm btn-outline-dark col-md-5" onclick="selectTool('pencil')">🖊︎</button>
				<button id="erase" class="btn btn-sm btn-outline-dark col-md-5">e</button>
			</div>
			
			<div class="row">
				<input id="slider1" class="form-range" type="range" min="1" max="20" value="3" onchange="lineWidth(this.value);" />
			</div>
			
			<div class="row">
				<button class="btn btn-sm btn-outline-success col-md-10"  onclick="clearPage()">메모🗑️</button>
			</div>
			<div class="row">
				<button class="btn btn-sm btn-outline-danger col-md-10" style="align-items:center;" onclick="deleteFiles()">🖼제거</button></div>
			</div>
	</div>

	<script src="resources/js/painter2.js"></script>
</body>

<script>

	// 이미지 drag&drop
	$('.canvas').on("dragover", dragOver) // 이미지 들고 옴
	.on("dragleave", dragOver) // 이미지 나감
	.on("drop", uploadFiles); // 이미지 drop

	function dragOver(e) {
		e.stopPropagation();
		e.preventDefault();
		if (e.type == "dragover") {
			$(e.target).css({
				"outline-offset" : "-20px", //이미지 끌고 오면 안으로 움직임
				"opacity":"0.5"
			});
		} else {
			$(e.target).css({
				"outline-offset" : "-10px",
				"opacity":"1"
			});
		}
	}

	function uploadFiles(e) { //이미지 업로드
		e.stopPropagation();
		e.preventDefault();
		dragOver(e);

		e.dataTransfer = e.originalEvent.dataTransfer;
		var files = e.target.files || e.dataTransfer.files;
		if (files.length > 1) {
			alert('한 번에 한 개만 올리세요.');
			return;
		}
		if (files[0].type.match(/image.*/)) {
			$(e.target).css(
					{
						"background-image" : "url("
								+ window.URL.createObjectURL(files[0]) + ")",
						"outline" : "none",
						"background-size" : "100% 100%"
					});
		} else {
			alert('이미지가 아닙니다.');
			return;
		}
	}
	
	function deleteFiles(){ // 이미지 제거
		if(confirm("이미지를 제거하시겠습니까?")==true){
			$('canvas').css(
				{
					'background-image':'url("")',
					"outline": "2px dashed #92b0b3",
					'outline-offset': '-10px',
					'text-align': 'center',
					'transition': 'all .15s ease-in-out'
				});
			}
		else return;
	}
	
	
</script>

</html>