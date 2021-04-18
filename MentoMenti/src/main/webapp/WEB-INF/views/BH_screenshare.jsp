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
	<video id="cam" controls preload="metadata" autoplay></video>

</body>
</html>