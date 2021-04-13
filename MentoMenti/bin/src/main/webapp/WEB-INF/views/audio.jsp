<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html id="home">

    <head>
        <script>
            if(!location.hash.replace('#', '').length) {
                location.href = location.href.split('#')[0] + '#' + (Math.random() * 100).toString().replace('.', '');
                location.reload();
            }
        </script>
        
        <title>목소리 공유</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
        <link rel="author" type="text/html" href="https://plus.google.com/+MuazKhan">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <link rel="stylesheet" href="https://www.webrtc-experiment.com/style.css">
        
        <style>
            audio {
                -moz-transition: all 1s ease;
                -ms-transition: all 1s ease;
                
                -o-transition: all 1s ease;
                -webkit-transition: all 1s ease;
                transition: all 1s ease;
                vertical-align: top;
            }

            input {
                border: 1px solid #d9d9d9;
                border-radius: 1px;
                font-size: 2em;
                margin: .2em;
                width: 70%;
            }

            .setup {
                border-bottom-left-radius: 0;
                border-top-left-radius: 0;
                font-size: 102%;
                height: 47px;
                margin-left: -9px;
                margin-top: 8px;
                position: absolute;
            }

            p { padding: 1em; }

            li {
                border-bottom: 1px solid rgb(189, 189, 189);
                border-left: 1px solid rgb(189, 189, 189);
                padding: .5em;
            }
        </style>
        <script>
            document.createElement('article');
        </script>
    </head>

    <body>
        <article>
          
            <table class="visible">
                <tr>
                    <td style="text-align: right;">
                        <input type="text" id="conference-name" placeholder="Broadcast Name">
                    </td>
                    <td>
                        <button id="start-conferencing">시작</button>
                    </td>
                </tr>
            </table>
            <table id="rooms-list" class="visible"></table>

            <table class="visible">
                <tr>
                    <td style="text-align: center;">
                        <h2>
                            <strong>Private Broadcast</strong> ?? <a href="" target="_blank" title="Open this link in new tab. Then your broadcasting room will be private!"><code><strong id="unique-token">#123456789</strong></code></a>
                        </h2>
                    </td>
                </tr>
            </table>

            <div id="participants"></div>

            <script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
            <script src="https://www.webrtc-experiment.com/socket.io.js"> </script>
            <script src="https://www.webrtc-experiment.com/RTCPeerConnection-v1.5.js"> </script>
            <script src="https://www.webrtc-experiment.com/audio-broadcast/broadcast.js"> </script>
            <script src="resources/js/audioUi.js"> </script>
        </article>
        <!-- commits.js is useless for you! -->
        <script src="https://www.webrtc-experiment.com/commits.js" async> </script>
    </body>
</html>