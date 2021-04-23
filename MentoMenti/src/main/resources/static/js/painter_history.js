var textareaList = ["history"];

      function clearText(idOfTextArea) {
        document.getElementById(idOfTextArea).value = "";
      }

      function SaveAsTxt() {
        var fileName = document.getElementById("title").value;
        if (fileName.length == 0) {
          fileName = "image";
        }
        fileName += ".txt";

        var preData = 'version: V0.617a1\n';
        var postData =  preData + document.getElementById("history").value;

        var link = document.createElement("a");
        link.setAttribute("download", fileName);
        link.setAttribute(
          "href",
          "data:" +
            "application/[txt]" +
            ";charset=utf-8," +
            encodeURIComponent(postData)
        );
        link.click();
      }

      function SaveAsJson() {
        console.log("SaveAsJson");
        var fileName = document.getElementById("title").value;
        if (fileName.length == 0) {
          fileName = "imsge";
        }

        fileName += ".json";

        var preData = {'version':'V0.617a1'};
        textareaList.forEach(function(e) {
          preData[e] = document.getElementById(e).value;
        });

        var jsonData = JSON.stringify(preData);

        var link = document.createElement("a");
        var file = new Blob([jsonData], { type: "text/plain" });
        link.href = URL.createObjectURL(file);
        link.download = fileName;
        link.click();
      }

      function isJsonFile(filename) {
        var ridx = filename.lastIndexOf(".");
        var extension = filename.substring(ridx + 1);

        console.log(extension);

        if (extension.length != 4 || extension.toLowerCase() != "json") {
          return false;
        }
        return true;
      }

      function isTextFile(filename) {
        var ridx = filename.lastIndexOf(".");
        var extension = filename.substring(ridx + 1);

        console.log(extension);

        if (extension.length != 3 || extension.toLowerCase() != "txt") {
          return false;
        }
        return true;
      }


      function loadFile() {
        var loadFile = document.getElementById("load_filename");
        var file = loadFile.files[0];
          
        if (!file) {
          return;
        }

        var fileName = document.getElementById("load_filename").value;
        var ridx = fileName.lastIndexOf("\\");

        fileName = fileName.substring(ridx + 1);

        if (isJsonFile(fileName)) {
          LoadJson(file, fileName);
        } else if(isTextFile(fileName)) {
          LoadText(file, fileName);
        } 
      }

      function LoadJson(file, fileName) {
        document.getElementById("title").value = fileName;

        var reader = new FileReader();
        reader.onload = function(e) {
          var contents = e.target.result;
          displayLoadJsonData(contents);
        };
        reader.readAsText(file);
      }

      function displayLoadJsonData(contents) {
        var noteData = JSON.parse(contents);

        var version = noteData['version'];
        console.log(version);
        document.getElementById('history').value = noteData['history'];
        reDrawCanvas();
      }

      function LoadText(file, fileName) {
        document.getElementById("title").value = fileName;

        var reader = new FileReader();
        reader.onload = function(e) {
          var contents = e.target.result;
          displayLoadTextData(contents);
        };
        reader.readAsText(file);
      }

      function displayLoadTextData(contents) {
        var noteData = contents.split('\n');
        var history = "";
         
        noteData.forEach(function (e){
          if (e[0] != 'v') {
            history += e + "\n";
          }
        }); 
        document.getElementById('history').value = history;
        reDrawCanvas();
      }
