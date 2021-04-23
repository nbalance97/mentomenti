<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="resources/js/jquery.min.js"></script>
<html>
<head>
<title>Paint JS</title>

<script src="resources/js/painter_history.js"></script>
</head>
<style>
.canvas_div {
	width: 85%;
	height: 100%;
	float: left;
}

.canvas {
	outline: 2px dashed #92b0b3;
	outline-offset: -10px;
	text-align: center;
	transition: all .15s ease-in-out;
	background-color: aliceblue;
}

.controls {
	width: 15%;
	height: 100%;
	display: flex;
	flex-direction: column;
	align-items: center;
	float: right;
}

}
.controls_colors {
	display: flex;
}

.controls_color {
	width: 30px;
	height: 30px;
	border-radius: 25px;
	cursor: pointer;
	margin: 5px;
	box-shadow: 0 4px 6px rgba(50, 50, 93, 0.11), 0 1px 3px
		rgba(0, 0, 0, 0.08);
}

</style>
<body>
	<div class="canvas_div">
		<canvas id="canvas" class="canvas" width="720" height="720"></canvas>
	</div>

	<div class="controls">

		
		<div class="controls_colors" id="jsColors">
			<div class="controls_color" style="background-color: black" onclick="selectColor('black')"></div>
			<div class="controls_color" style="background-color: red"  onclick="selectColor('red')"></div>
			<div class="controls_color" style="background-color: #ff9500" onclick="selectColor('orange')"></div>
			<div class="controls_color" style="background-color: #ffcc00" onclick="selectColor('yellow')"></div>
			<div class="controls_color" style="background-color: #4cd963" onclick="selectColor('green')"></div>
			<div class="controls_color" style="background-color: #0579ff" onclick="selectColor('blue')"></div>
			<div class="controls_color" style="background-color: #5856d6" onclick="selectColor('purple')"></div>
		</div>
		<button onclick="selectTool('pencil')">펜</button>
		<button onclick="selectTool('line')">선</button>
		<button onclick="selectTool('ellipse')">원</button>
		<button onclick="selectTool('rect')">사각</button>
		<button onclick="undo()">뒤로</button>
		<button onclick="redo()">앞으로</button>
		<button onclick="initPage()">클리어</button>
	</div>
	
     <textarea id="history" cols="40" rows="37" style="display: none;"></textarea>
	<script src="resources/js/painter.js"></script>
	<script src="resources/js/drawengine.js"></script>
</body>

<script>
    // 이미지 drag&drop
    $('.canvas')
    .on("dragover", dragOver) // 이미지 들고 옴
    .on("dragleave", dragOver) // 이미지 나감
    .on("drop", uploadFiles); // 이미지 drop

  function dragOver(e){
    e.stopPropagation();
    e.preventDefault();
    if (e.type == "dragover") {
      $(e.target).css({
        "outline-offset": "-20px" //이미지 끌고 오면 안으로 움직임
      });
    } else {
        $(e.target).css({
        "outline-offset": "-10px"
      });
      }
  }

  function uploadFiles(e) {
      e.stopPropagation();
      e.preventDefault();
      dragOver(e);
    
      e.dataTransfer = e.originalEvent.dataTransfer;
      var files = e.target.files || e.dataTransfer.files;
      if (files.length > 1) {
          alert('한 개만 올리세요.');
          return;
      }
      if (files[0].type.match(/image.*/)) {
                  $(e.target).css({
              "background-image": "url(" + window.URL.createObjectURL(files[0]) + ")",
              "outline": "none",
              "background-size": "100% 100%"
          });
      }else{
        alert('이미지가 아닙니다.');
        return;
      }
  }
</script>

</html>