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
                    <button id="share-screen" class="setup">Share Your Screen</button>
                </section>

                <!-- local/remote videos container -->
                <div id="videos-container"></div>

                <section id="unique-token" style="display: none; text-align: center; padding: 20px;"></section>
            </section>

            <script>
                // Muaz Khan     - https://github.com/muaz-khan
                // MIT License   - https://www.webrtc-experiment.com/licence/
                // Documentation - https://github.com/muaz-khan/WebRTC-Experiment/tree/master/Pluginfree-Screen-Sharing

                var config = {
                    // via: https://github.com/muaz-khan/WebRTC-Experiment/tree/master/socketio-over-nodejs
                    openSocket: function(config) {
                        var SIGNALING_SERVER = 'https://socketio-over-nodejs2.herokuapp.com:443/';

                        config.channel = config.channel || location.href.replace(/\/|:|#|%|\.|\[|\]/g, '');
                        var sender = Math.round(Math.random() * 999999999) + 999999999;

                        io.connect(SIGNALING_SERVER).emit('new-channel', {
                            channel: config.channel,
                            sender: sender
                        }); //난수 발생시켜 해당 방의 난수코드 생성

                        var socket = io.connect(SIGNALING_SERVER + config.channel);
                        socket.channel = config.channel;
                        socket.on('connect', function () {
                            if (config.callback) config.callback(socket);
                        });

                        socket.send = function (message) {
                            socket.emit('message', {
                                sender: sender,
                                data: message
                            });
                        };

                        socket.on('message', config.onmessage);
                    },
                    onRemoteStream: function(media) {
                        if(isbroadcaster) return;

                        var video = media.video;
                        videosContainer.insertBefore(video, videosContainer.firstChild);
                        //rotateVideo(video);

                        document.querySelector('.hide-after-join').style.display = 'none';
                    },
                    onRoomFound: function(room) {
                        if(isbroadcaster) return;

                        conferenceUI.joinRoom({
                            roomToken: room.roomToken,
                            joinUser: room.broadcaster
                        });

                        document.querySelector('.hide-after-join').innerHTML = '<img src="https://www.webrtc-experiment.com/images/key-press.gif" style="margint-top:10px; width:50%;" />'; //접속자 화면(대기 화면 출력)
                    },
                    /*
                    // 접속 시 출력 내용
                    onNewParticipant: function(numberOfParticipants) {
                        var text = numberOfParticipants + ' users are viewing your screen!';
                        
                        if(numberOfParticipants <= 0) {
                            text = '아직 참여자가 없습니다.';
                        }
                        else if(numberOfParticipants == 1) {
                            text = '참여자가 1명입니다.';
                        }

                        document.title = text;
                        showErrorMessage(document.title, 'green');
                    },
                    oniceconnectionstatechange: function(state) {
                        var text = '';

                        if(state == 'closed' || state == 'disconnected') {
                            text = '참가자 중 한명이 퇴장하였습니다.';
                            document.title = text;
                            showErrorMessage(document.title);
                        }

                        if(state == 'failed') {
                            text = '방화벽 규칙을 우회하지 못했습니다. 대상 사용자가 화면을받지 못한 것 같습니다. 페이지를 새로 고침하고 다시 시도하세요.';
                            document.title = text;
                            showErrorMessage(document.title);
                        }

                        if(state == 'connected' || state == 'completed') {
                            text = '참여 완료';
                            document.title = text;
                            showErrorMessage(document.title, 'green');
                        }

                        if(state == 'new' || state == 'checking') {
                            text = '접속 중...';
                            document.title = text;
                            showErrorMessage(document.title, 'green');
                        }
                    }*/
                };

                function showErrorMessage(error, color) {
                    var errorMessage = document.querySelector('#logs-message');
                    errorMessage.style.color = color || 'red';
                    errorMessage.innerHTML = error;
                    errorMessage.style.display = 'block';
                }

                function getDisplayMediaError(error) {
                    if (location.protocol === 'http:') {
                        showErrorMessage('HTTPS 에서만 실행하세요');
                    } else {
                        showErrorMessage(error.toString());
                    }
                }

                function captureUserMedia(callback) {
                    var video = document.createElement('video');
                    video.muted = true;
                    video.volume = 0;
                    try {
                        video.setAttributeNode(document.createAttribute('autoplay'));
                        video.setAttributeNode(document.createAttribute('playsinline'));
                        video.setAttributeNode(document.createAttribute('controls'));
                    } catch (e) {
                        video.setAttribute('autoplay', true);
                        video.setAttribute('playsinline', true);
                        video.setAttribute('controls', true);
                    }

                    if(navigator.getDisplayMedia || navigator.mediaDevices.getDisplayMedia) {
                        function onGettingSteam(stream) {
                            video.srcObject = stream;
                            videosContainer.insertBefore(video, videosContainer.firstChild);

                            addStreamStopListener(stream, function() {
                                location.reload();
                            });

                            config.attachStream = stream;
                            callback && callback();
                            //rotateVideo(video);

                            addStreamStopListener(stream, function() {
                                location.reload();
                            });

                           // showPrivateLink(); // 화면공유 후 나오는 링크.. 필요 없어 보임

                            document.querySelector('.hide-after-join').style.display = 'none';
                        }

                        if(navigator.mediaDevices.getDisplayMedia) {
                            navigator.mediaDevices.getDisplayMedia({video: true}).then(stream => {
                                onGettingSteam(stream);
                            }, getDisplayMediaError).catch(getDisplayMediaError);
                        }
                        else if(navigator.getDisplayMedia) {
                            navigator.getDisplayMedia({video: true}).then(stream => {
                                onGettingSteam(stream);
                            }, getDisplayMediaError).catch(getDisplayMediaError);
                        }
                    }
                    else {
                        if (DetectRTC.browser.name === 'Chrome') {
                            if (DetectRTC.browser.version == 71) {
                                showErrorMessage('chrome : // flags를 통해 "Experimental WebPlatform"플래그를 활성화하십시오.');
                            } else if (DetectRTC.browser.version < 71) {
                                showErrorMessage('chrome의 버전 업그레이드가 필요합니다.');
                            } else {
                                showErrorMessage('ios에서 크롬을 사용하고 있진 않으신가요?');
                            }
                        }

                        if (DetectRTC.browser.name === 'Firefox') {
                            showErrorMessage('Firefox의 업그레이드가 필요합니다.');
                        }

                        if (DetectRTC.browser.name === 'Edge') {
                            showErrorMessage('Edge의 업그레이드가 필요합니다.');
                        }

                        if (DetectRTC.browser.name === 'Safari') {
                            showErrorMessage('Safari에서는 아직 지원하지 않습니다.');
                        }
                    }
                }

                /* on page load: get public rooms */
                var conferenceUI = conference(config);

                /* UI specific */
                var videosContainer = document.getElementById("videos-container") || document.body;

                document.getElementById('share-screen').onclick = function() {
                    var roomName = document.getElementById('room-name') || { };
                    roomName.disabled = true;
                    captureUserMedia(function() {
                        conferenceUI.createRoom({
                            roomName: (roomName.value || 'Anonymous') + ' shared his screen with you'
                        });
                    });
                    this.disabled = true;
                };

               /*  화면공유 실행 시 비디오 회전.. 좀 쓸모 없음
               		function rotateVideo(video) {
                    video.style[navigator.mozGetUserMedia ? 'transform' : '-webkit-transform'] = 'rotate(0deg)';
                    setTimeout(function() {
                        video.style[navigator.mozGetUserMedia ? 'transform' : '-webkit-transform'] = 'rotate(360deg)';
                    }, 1000);
                }
               */

               /* 화면공유 후 나오는 링크..
               function showPrivateLink() {
                    var uniqueToken = document.getElementById('unique-token');
                    uniqueToken.innerHTML = '<a href="' + location.href + '" target="_blank">Copy & Share This Private Room Link</a>';
                    uniqueToken.style.display = 'block';
                }
               */

            </script>

            

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