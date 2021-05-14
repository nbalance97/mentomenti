var cvs;
var canvas;

var bufCanvas;
var bufCtx;


var drawingMode="draw";
document.getElementById("erase").onclick = function () {
	drawingMode = "eraser";
  //console.warn(drawingMode);
};

var paintMode = [
  "point",
  "line",
  "pencil_begin",
  "pencil_end"
];

var toolTable = {
  pencil: 0,
  eraser: 1
};
/*
var pointShape = {
  mouseDown: pointMouseDown,
  mouseMove: pointMouseMove,
  mouseUp: pointMouseUp
};

var shapeList = [pointShape]; 
*/

var paintMouseDownAction = {
  point: pointMouseDown
};

var paintMouseUpAction = {
  point: pointMouseUp
};

var paintMouseMoveAction = {
  point: pointMouseMove
};

var pos = {
  isDraw: false,
  color: "red",
  colorIdx: 0,
  drawMode: 0,
  filled: false,
  mouseDownAction: paintMouseDownAction[paintMode[0]],
  mouseUpAction: paintMouseUpAction[paintMode[0]],
  mouseMoveAction: paintMouseMoveAction[paintMode[0]],
  x: 0,
  y: 0,
  update: function (drawMode) {
    this.drawMode = drawMode;
    this.mouseDownAction = paintMouseDownAction[paintMode[drawMode]];
    this.mouseUpAction = paintMouseUpAction[paintMode[drawMode]];
    this.mouseMoveAction = paintMouseMoveAction[paintMode[drawMode]];
  }
};

function point() {
  return {
    X: 0,
    Y: 0
  };
}

function drwaCommand() {
  return {
    mode: paintMode[0],
    color: "white",
    filled: false,
    X1: point(),
    X2: point(),
    X3: point(),
    lines: [],
    toCommand: function () {
      console.log("toCommand");
      var newCommand = this.mode + " ";
      switch (this.mode) {
        case "color":
          newCommand += this.color;
          break;
        case "pencil_begin":
        case "pencil_end":
          break;
        case "point":
        case "line":
          newCommand +=
            this.X1.X +
            " " +
            this.X1.Y +
            " " +
            this.X2.X +
            " " +
            this.X2.Y;
          break;
        
        default:
          break;
      }

      console.log("toCommand: " + newCommand);
      return newCommand;
    }
  };
}

function getMousePosition(event) {
  var x = event.pageX - canvas.offsetLeft;
  var y = event.pageY - canvas.offsetTop;
  return { X: x, Y: y };
}

function mouseListener(event) {
  switch (event.type) {
    case "mousedown":
      if (!pos.isDraw) {
        pos.mouseDownAction(event);
      }
      break;
    case "mousemove":
      if (pos.isDraw) {
        pos.mouseMoveAction(event);
      }
      break;
    case "mouseup":
    case "mouseout":
      if (pos.isDraw) {
        pos.mouseUpAction(event);
      }
      break;
  }
}

function selectColor(choosedColor) {
  console.log("selectColor:" + choosedColor);
  var colorTableIdx = {
    black: 0,
	red: 1,
    orange: 2,
    yellow: 3,
    green: 4,
    blue: 5,
    purple: 6,
    deepPink:7
  };
  pos.color = choosedColor;
  pos.colorIdx = colorTableIdx[choosedColor];

  var newColor = drwaCommand();
  newColor.mode = "color";
  newColor.color = choosedColor;
}

function selectTool(choosedTool) {
  console.log(choosedTool);
  drawingMode = "draw";
   pos.update(toolTable[choosedTool]);
}

function pointMouseDown(event) {
  if (pos.isDraw) {
    return;
  }

  pos.isDraw = true;
  // https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/globalCompositeOperation << 이 페이지 참조
  cvs.globalCompositeOperation = drawingMode === "draw" ? "source-over" : "destination-out";  // draw일 때 원래 있던 것 위에 계속 쌓음, eraser일 때 새로운 것과 겹치지 않게 유지(투명하게). 즉 지우는 것처럼 '보임'
  
  cvs.beginPath();
  cvs.strokeStyle = pos.color;
  var startPos = getMousePosition(event);
  cvs.moveTo(startPos.X, startPos.Y);
  cvs.stroke();
  pos.X = startPos.X;
  pos.Y = startPos.Y;

  var newPoint = drwaCommand();
  newPoint.mode = "pencil_begin";
}



function pointMouseMove(event) { // 이부분 좀 수정함
  var currentPos = getMousePosition(event);
  var lWidth=document.getElementById('slider1'); //slider의 value 가져와서 펜 굵기로 사용
  cvs.lineTo(currentPos.X, currentPos.Y);
  cvs.lineWidth = lWidth.value;
  cvs.lineCap = 'round';
  cvs.stroke();

  var newPoint = drwaCommand();
  newPoint.mode = "line";
  newPoint.X1 = { X: pos.X, Y: pos.Y };
  newPoint.X2 = { X: currentPos.X, Y: currentPos.Y };
  
  send({ //여기에 drawingMode 추가하면 될듯
	  event: "recv_paint",
	  x1: pos.X,
	  y1: pos.Y,
	  x2: currentPos.X,
	  y2: currentPos.Y,
	  force: cvs.lineWidth,
	  color: pos.color,
  });
  
  pos.X = currentPos.X;
  pos.Y = currentPos.Y;
}

function pointMouseUp(event) {
  if (!pos.isDraw) {
    return;
  }

  pos.isDraw = false;
  cvs.closePath();

  var newPoint = drwaCommand();
  newPoint.mode = "pencil_end";
}

function handleStart(event) {
	if (pos.isDraw) {
		return;
	}

	pos.isDraw = true;
	// https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/globalCompositeOperation
	// << 이 페이지 참조
	cvs.globalCompositeOperation = drawingMode === "draw" ? "source-over"
			: "destination-out"; // draw일 때 원래 있던 것 위에 계속 쌓음, eraser일 때 새로운
									// 것과 겹치지 않게 유지(투명하게). 즉 지우는 것처럼 '보임'

	var touches = event.touches;

	for (var i = 0; i < touches.length; i++) {
		cvs.beginPath();
		cvs.strokeStyle = pos.color;

		cvs.moveTo(touches[i].clientX, touches[i].clientY);
		cvs.stroke();
		pos.X = touches[i].clientX;
		pos.Y = touches[i].clientY;
	}

	var newPoint = drwaCommand();
	newPoint.mode = "pencil_begin";
}


function handleMove(event) { // 이부분 좀 수정함
	  var currentPos = getMousePosition(event);
	  var lWidth=document.getElementById('slider1'); //slider의 value 가져와서 펜 굵기로 사용
	  var touches = event.touches;
	  for (var i = 0; i < event.touches.length; i++) {
		  cvs.lineTo(touches[i].clientX, touches[i].clientY);
		  cvs.lineWidth = lWidth.value;
		  cvs.lineCap = 'round';
		  cvs.stroke();
	
		  var newPoint = drwaCommand();
		  newPoint.mode = "line";
		  newPoint.X1 = { X: pos.X, Y: pos.Y };
		  newPoint.X2 = { X: touches[i].clientX, Y: touches[i].clientY };
		  
		  send({ //여기에 drawingMode 추가하면 될듯
			  event: "recv_paint",
			  x1: pos.X,
			  y1: pos.Y,
			  x2: touches[i].clientX,
			  y2: touches[i].clientY,
			  force: cvs.lineWidth,
			  color: pos.color
		  });
		  
		  pos.X = touches[i].clientX;
		  pos.Y = touches[i].clientY;
	  }
}

function handleEnd(event) {
	  if (!pos.isDraw) {
	    return;
	  }

	  pos.isDraw = false;
	  cvs.closePath();

	  var newPoint = drwaCommand();
	  newPoint.mode = "pencil_end";
}

function clearCanvas() {
  console.log("clearCanvas()");
  cvs.clearRect(0, 0, canvas.width, canvas.height);
  bufCtx.clearRect(0, 0, canvas.width, canvas.height);
}

function initPage() {
  console.log("initPage()");

  clearCanvas();
}

function clearPage(){
	if(confirm("메모를 삭제합니다.")==true){
		console.log("initPage()");
  		clearCanvas();
	}
	else return;
}

function onLoadPage() {
  canvas = document.getElementById("canvas");
  cvs = canvas.getContext("2d");
  
  cvs.canvas.width  = window.innerWidth*0.75;
  cvs.canvas.height = window.innerHeight*0.995;

  bufCanvas = document.createElement("canvas");
  bufCanvas.width = canvas.width;
  bufCanvas.height = canvas.height;
  bufCtx = bufCanvas.getContext("2d");

  canvas.addEventListener("mousedown", mouseListener);
  canvas.addEventListener("mousemove", mouseListener);
  canvas.addEventListener("mouseout", mouseListener);
  canvas.addEventListener("mouseup", mouseListener);
  
  canvas.addEventListener("touchstart", handleStart);
  canvas.addEventListener("touchend", handleEnd);
  canvas.addEventListener("touchmove", handleMove);

  initPage();
}

window.onload = onLoadPage();