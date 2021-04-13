<!--https://www.webrtc-experiment.com/Pluginfree-Screen-Sharing  -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
        <title>화면공유</title>

        <script>
            if(!location.hash.replace('#', '').length) {
                location.href = location.href.split('#')[0] + '#' + (Math.random() * 100).toString().replace('.', '');
                location.reload();
            }
        </script>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
        <link rel="author" type="text/html" href="https://plus.google.com/+MuazKhan">
        <meta name="author" content="Muaz Khan">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

        <link rel="stylesheet" href="https://www.webrtc-experiment.com/style.css">

      
        <script>
            document.createElement('article');
            document.createElement('footer');
        </script>

        <!-- scripts used for screen-sharing -->
        <script src="https://www.webrtc-experiment.com/socket.io.js"> </script>
        <script src="https://www.webrtc-experiment.com/DetectRTC.js"></script>
        <script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
        <script src="https://www.webrtc-experiment.com/CodecsHandler.js"></script>
        <script src="https://www.webrtc-experiment.com/BandwidthHandler.js"></script>
        <script src="https://www.webrtc-experiment.com/IceServersHandler.js"></script>
        <script src="https://www.webrtc-experiment.com/Pluginfree-Screen-Sharing/conference.js"> </script>
    </head>

    <body>
        <article>

            <h2 style="display: block;text-align: center;border:0;margin-bottom:0;">사랑합니다 <a href="https://www.webrtc-experiment.com/">WebRTC</a>!</h2>
			
			<!-- 현재 방 코드 -->
			<script type="text/javascript">
				var myPage = location.href.split('#');
				document.write(myPage[1]);
			</script>
			
            <section id="logs-message" class="experiment" style="display: none;text-align: center;font-size: 1.5em;line-height: 2;color: red;">WebRTC getDisplayMedia API.</section>

            <!-- just copy this <section> and next script -->
            <section class="experiment">
                <section class="hide-after-join" style="text-align: center;">                    
                    <input type="text" id="room-name" placeholder="Enter " style="width: 80%; text-align: center; display: none;">
                    <button id="share-screen" class="setup">화면공유</button>
                </section>

                <!-- local/remote videos container -->
                <div id="videos-container"></div>

                <section id="unique-token" style="display: none; text-align: center; padding: 20px;"></section>
            </section>
			
			<!-- 화면공유 기능 js 분리 -->
            <script src="resources/js/screenShare.js"></script>
       

            <section class="experiment"><small id="send-message"></small></section>

        </article>


                <!-- commits.js is useless for you! -->
        <script src="https://www.webrtc-experiment.com/commits.js" async> </script>
    </body>
    <style>
            video {
                -moz-transition: all 1s ease;
                -ms-transition: all 1s ease;

                -o-transition: all 1s ease;
                -webkit-transition: all 1s ease;
                transition: all 1s ease;
                vertical-align: top;
                width: 100%;
            }

            input {
                border: 1px solid #d9d9d9;
                border-radius: 1px;
                font-size: 2em;
                margin: .2em;
                width: 30%;
            }

            select {
                border: 1px solid #d9d9d9;
                border-radius: 1px;
                height: 50px;
                margin-left: 1em;
                margin-right: -12px;
                padding: 1.1em;
                vertical-align: 6px;
                width: 18%;
            }

            .setup {
                border-bottom-left-radius: 0;
                border-top-left-radius: 0;
                font-size: 1.5em;
                margin-bottom: 20px;
                margin-top: 20px;
                border-radius: 5px;
            }

            p { padding: 1em; }

            li {
                border-bottom: 1px solid rgb(189, 189, 189);
                border-left: 1px solid rgb(189, 189, 189);
                padding: .5em;
            }
    </style>
</html>