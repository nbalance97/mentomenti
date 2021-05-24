var cvs;
var canvas;

var bufCanvas;
var bufCtx;

var commandHistory = [];
var redoHistory = [];


var paintMode = [
  "point",
  "line",
  "rect",
  "ellipse",
  "pencil_begin",
  "pencil_end"
];

var toolTable = {
  pencil: 0,
  line: 1,
  rect: 2,
  ellipse: 3
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
  point: pointMouseDown,
  line: lineMouseDown,
  rect: rectMouseDown,
  ellipse: ellipseMouseDown
};

var paintMouseUpAction = {
  point: pointMouseUp,
  line: lineMouseUp,
  rect: rectMouseUp,
  ellipse: ellipseMouseUp
};

var paintMouseMoveAction = {
  point: pointMouseMove,
  line: lineMouseMove,
  rect: rectMouseMove,
  ellipse: ellipseMouseMove
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
    R: 0,
    A: 0,
    B: 0,
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
        
        case "ellipse":
          newCommand +=
            this.X1.X +
            " " +
            this.X1.Y +
            " " +
            this.A +
            " " +
            this.B;
          break;
        
        case "rect":
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
  commandHistory.push(newColor.toCommand());
  addHistory(newColor.toCommand());
}

function selectTool(choosedTool) {
  console.log(choosedTool);
  if (choosedTool.indexOf("filled") != -1) {
    pos.filled = true;
  } else {
    pos.filled = false;
  }
  pos.update(toolTable[choosedTool]);
}

function pointMouseDown(event) {
  if (pos.isDraw) {
    return;
  }

  pos.isDraw = true;
  cvs.beginPath();
  cvs.strokeStyle = pos.color;
  var startPos = getMousePosition(event);
  cvs.moveTo(startPos.X, startPos.Y);
  cvs.stroke();
  pos.X = startPos.X;
  pos.Y = startPos.Y;

  var newPoint = drwaCommand();
  newPoint.mode = "pencil_begin";
  commandHistory.push(newPoint.toCommand());
  addHistory(newPoint.toCommand());
}

function pointMouseMove(event) { // 이부분 좀 수정함
  if (usage) {
	  return;
  }
  
  var currentPos = getMousePosition(event);
  cvs.lineTo(currentPos.X, currentPos.Y);
  cvs.lineWidth = 3;
  cvs.lineCap = 'round';
  cvs.stroke();

  var newPoint = drwaCommand();
  newPoint.mode = "line";
  newPoint.X1 = { X: pos.X, Y: pos.Y };
  newPoint.X2 = { X: currentPos.X, Y: currentPos.Y };
  commandHistory.push(newPoint.toCommand());
  addHistory(newPoint.toCommand());
  
  send({
	  event: "recv_paint",
	  x1: pos.X,
	  y1: pos.Y,
	  x2: currentPos.X,
	  y2: currentPos.Y,
	  force: cvs.lineWidth,
	  color: pos.color
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
  commandHistory.push(newPoint.toCommand());
  addHistory(newPoint.toCommand());
}

function lineMouseDown(event) {
  console.log("lineMouseDown");
  if (pos.isDraw) {
    return;
  }
  bufCtx.drawImage(canvas, 0, 0);
  var startPos = getMousePosition(event);
  pos.X = startPos.X;
  pos.Y = startPos.Y;
  pos.isDraw = true;
}

function lineMouseMove(event) {
  console.log("lineMouseMove");
  var currentPos = getMousePosition(event);
  cvs.beginPath();
  // Need a delay
  cvs.clearRect(0, 0, canvas.width, canvas.height);
  cvs.drawImage(bufCanvas, 0, 0);

  cvs.strokeStyle = pos.color;
  cvs.moveTo(pos.X, pos.Y);
  cvs.lineTo(currentPos.X, currentPos.Y);
  cvs.closePath();
  cvs.stroke();
}

function lineMouseUp(event) {
  if (!pos.isDraw) {
    return;
  }
  console.log("lineMouseUp");
  var currentPos = getMousePosition(event);
  bufCtx.beginPath();
  bufCtx.strokeStyle = pos.color;
  bufCtx.moveTo(pos.X, pos.Y);
  bufCtx.lineTo(currentPos.X, currentPos.Y);
  bufCtx.closePath();
  bufCtx.stroke();
  cvs.drawImage(bufCanvas, 0, 0);

  var newLine = drwaCommand();
  newLine.mode = "line";
  newLine.X1 = { X: pos.X, Y: pos.Y };
  newLine.X2 = { X: currentPos.X, Y: currentPos.Y };
  commandHistory.push(newLine.toCommand());
  addHistory(newLine.toCommand());

  pos.isDraw = false;
}


function rectMouseDown(event) {
  console.log("rectMouseDown");
  if (pos.isDraw) {
    return;
  }
  bufCtx.drawImage(canvas, 0, 0);
  pos.isDraw = true;
  var startPos = getMousePosition(event);
  pos.X = startPos.X;
  pos.Y = startPos.Y;
}

function rectMouseMove(event) {
  console.log("rectMouseMove");
  var currentPos = getMousePosition(event);
  cvs.beginPath();

  cvs.clearRect(0, 0, canvas.width, canvas.height);
  cvs.drawImage(bufCanvas, 0, 0);

  cvs.strokeStyle = "black";
  var box = {
    W: currentPos.X - pos.X,
    H: currentPos.Y - pos.Y
  };

  cvs.strokeRect(pos.X, pos.Y, box.W, box.H);

  if (pos.filled) {
    cvs.fillStyle = pos.color;
    cvs.fillRect(pos.X, pos.Y, box.W, box.H);
  }

  cvs.stroke();
  cvs.closePath();
  cvs.strokeStyle = pos.color;
}

function rectMouseUp(event) {
  if (pos.isDraw) {
    console.log("lineMouseUp");
    var currentPos = getMousePosition(event);
    bufCtx.beginPath();
    bufCtx.strokeStyle = pos.color;
    var box = {
      W: currentPos.X - pos.X,
      H: currentPos.Y - pos.Y
    };
    if (pos.filled) {
      bufCtx.fillStyle = pos.color;
      bufCtx.fillRect(pos.X, pos.Y, box.W, box.H);
    } else {
      bufCtx.strokeRect(pos.X, pos.Y, box.W, box.H);
    }
    bufCtx.closePath();
    bufCtx.stroke();

    cvs.clearRect(0, 0, canvas.width, canvas.height);
    cvs.drawImage(bufCanvas, 0, 0);

    var newRect = drwaCommand();
    newRect.mode = "rect";
    newRect.filled = pos.filled;
    newRect.X1 = { X: pos.X, Y: pos.Y };
    newRect.X2 = { X: currentPos.X, Y: currentPos.Y };
    commandHistory.push(newRect.toCommand());
    addHistory(newRect.toCommand());

    pos.isDraw = false;
  }
}


function ellipseMouseDown(event) {
  console.log("ellipseMouseDown");
  if (pos.isDraw) {
    return;
  }
  bufCtx.drawImage(canvas, 0, 0);
  pos.isDraw = true;
  var startPos = getMousePosition(event);
  pos.X = startPos.X;
  pos.Y = startPos.Y;
}

function ellipseMouseMove(event) {
  console.log("ellipseMouseMove");
  var currentPos = getMousePosition(event);
  cvs.beginPath();

  cvs.clearRect(0, 0, canvas.width, canvas.height);
  cvs.drawImage(bufCanvas, 0, 0);
  cvs.strokeStyle = "black";

  var ellipse = {
    X: Math.round((pos.X + currentPos.X) / 2),
    Y: Math.round((pos.Y + currentPos.Y) / 2),
    A: Math.round(Math.abs(currentPos.X - pos.X) / 2),
    B: Math.round(Math.abs(currentPos.Y - pos.Y) / 2)
  };

  cvs.ellipse(ellipse.X, ellipse.Y, ellipse.A, ellipse.B, 0, 0, 2 * Math.PI);

  if (pos.filled) {
    cvs.fillStyle = pos.color;
    cvs.fill();
  }

  cvs.closePath();
  cvs.stroke();
  cvs.strokeStyle = pos.color;
}

function ellipseMouseUp(event) {
  if (pos.isDraw) {
    console.log("ellipseMouseUp");
    var currentPos = getMousePosition(event);
    bufCtx.beginPath();
    bufCtx.strokeStyle = pos.color;
  var ellipse = {
    X: Math.round((pos.X + currentPos.X) / 2),
    Y: Math.round((pos.Y + currentPos.Y) / 2),
    A: Math.round(Math.abs(currentPos.X - pos.X) / 2),
    B: Math.round(Math.abs(currentPos.Y - pos.Y) / 2)
  };

    bufCtx.ellipse(ellipse.X, ellipse.Y, ellipse.A, ellipse.B, 0, 0, 2 * Math.PI);

    if (pos.filled) {
      bufCtx.fillStyle = pos.color;
      bufCtx.fill();
    }

    bufCtx.closePath();
    bufCtx.stroke();

    cvs.clearRect(0, 0, canvas.width, canvas.height);
    cvs.drawImage(bufCanvas, 0, 0);

    var newEllipse = drwaCommand();
    newEllipse.mode = "ellipse";
    newEllipse.filled = pos.filled;
    newEllipse.X1 = { X: ellipse.X, Y: ellipse.Y };
    newEllipse.A = ellipse.A;
    newEllipse.B = ellipse.B;
    commandHistory.push(newEllipse.toCommand());
    addHistory(newEllipse.toCommand());

    pos.isDraw = false;
  }
}

function addHistory(cmd) {
  var history = document.getElementById("history").value;
  history += cmd.trim() + "\n";
  //console.log(history);
  document.getElementById("history").value = history;
}

function clearCanvas() {
  console.log("clearCanvas()");
  cvs.clearRect(0, 0, canvas.width, canvas.height);
  bufCtx.clearRect(0, 0, canvas.width, canvas.height);
}

function initHistory() {
  commandHistory = [];
  redoHistory = [];

  document.getElementById("history").value = "";

  var newColor = drwaCommand();
  newColor.mode = "color";
  newColor.color = "red";
  commandHistory.push(newColor.toCommand());
  addHistory(newColor.toCommand());
}

function showHistory() {
  console.log("showHistory()");
  document.getElementById("history").style.display = "block";
}

function undo() {
  console.log("undo");

  if (commandHistory.length <= 1) {
    return;
  }

  var lastCommand = commandHistory.pop();
  redoHistory.push(lastCommand);

  if (lastCommand.trim() == "pencil_end") {
    console.log("Start remove pencil group");
    while (commandHistory.length > 1) {
       lastCommand = commandHistory.pop();
       lastCommand = lastCommand.trim();
       if (lastCommand.length == 0) {
         continue;
       }
       redoHistory.push(lastCommand);
       if (lastCommand.trim() == "pencil_begin") {
         break;
       }
    } 
  }

  var history = "";

  commandHistory.forEach(function (e) {
    history += e + "\n";
  });

  document.getElementById("history").value = history;
  clearCanvas();
  drawengine(canvas, cvs, bufCanvas, bufCtx, commandHistory);
}

function redo() {
  console.log("redo");

  if (redoHistory.length == 0) {
    return;
  }

  var lastCommand = redoHistory.pop();
  commandHistory.push(lastCommand);
  addHistory(lastCommand);

  if (lastCommand.trim() == "pencil_begin") {
    console.log("Start add pencil group");
    var history = "";
    while (redoHistory.length > 0) {
       lastCommand = redoHistory.pop();
       if (lastCommand.length == 0) {
          continue;
       }
       history += lastCommand.trim() + "\n";
       commandHistory.push(lastCommand);
       if (lastCommand.trim() == "pencil_end") {
         break;
       }
    } 
    addHistory(history);
  }

  clearCanvas();
  drawengine(canvas, cvs, bufCanvas, bufCtx, commandHistory);
}

function initPage() {
  console.log("initPage()");

  clearCanvas();
  initHistory();
}

function clearPage(){
	if(confirm("메모를 삭제합니다.")==true){
		console.log("initPage()");

  		clearCanvas();
  		initHistory();
	}
	else return;
}


function reDrawCanvas() {
  console.log("reDrawCanvas");
  clearCanvas();
  commandHistory = [];

  commandHistory = document.getElementById("history").value.split('\n');
  // console.log(commandHistory)

  drawengine(canvas, cvs, bufCanvas, bufCtx, commandHistory);
}

function onLoadPage() {
  canvas = document.getElementById("canvas");
  cvs = canvas.getContext("2d");
  
  cvs.canvas.width  = window.innerWidth*0.85;
  cvs.canvas.height = window.innerHeight*0.995;

  bufCanvas = document.createElement("canvas");
  bufCanvas.width = canvas.width;
  bufCanvas.height = canvas.height;
  bufCtx = bufCanvas.getContext("2d");

  canvas.addEventListener("mousedown", mouseListener);
  canvas.addEventListener("mousemove", mouseListener);
  canvas.addEventListener("mouseout", mouseListener);
  canvas.addEventListener("mouseup", mouseListener);

  initPage();
}

window.onload = onLoadPage();