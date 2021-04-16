<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<style>
html, body{
		height: 100%;
	}
.share-screen {
	background-color: #000;
	height: 80%;
	overflow: auto;
}
</style>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="//cdn.webrtc-experiment.com/getScreenId.js"></script>
	<script src="//cdn.webrtc-experiment.com/screen.js"></script>
</head>
<body>
	<div id="share-screen" class="share-screen"></div>

	<script>
		document.getElementById("share-screen").onclick = function() {
			navigator.mediaDevices.getUserMedia({
				audio: true
			}).then(function(audioStream){
				//오디오 스트림을 얻어냄

				navigator.mediaDevices.getDisplayMedia({
					audio: true,
					video: true
				}).then(function(screenStream){
					//스크린 공유 스트림을 얻어내고 여기에 오디오 스트림을 결합함
					screenStream.addTrack(audioStream.getAudioTracks()[0]);
				}).catch(function(e){
					//error;
				});
			}).catch(function(e){
				//error;
			});
		};
	</script>
</body>
</html>