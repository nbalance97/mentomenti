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
        socket.on('connect', function() {
            if (config.callback) config.callback(socket);
        });

        socket.send = function(message) {
            socket.emit('message', {
                sender: sender,
                data: message
            });
        };

        socket.on('message', config.onmessage);
    },
    onRemoteStream: function(media) {
        if (isbroadcaster) return;

        var video = media.video;
        videosContainer.insertBefore(video, videosContainer.firstChild);
        //rotateVideo(video);

        document.querySelector('.hide-after-join').style.display = 'none';
    },
    onRoomFound: function(room) {
        if (isbroadcaster) return;

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

    if (navigator.getDisplayMedia || navigator.mediaDevices.getDisplayMedia) {
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

        if (navigator.mediaDevices.getDisplayMedia) {
            navigator.mediaDevices.getDisplayMedia({
                video: true,
                audio: true
            }).then(stream => {
                onGettingSteam(stream);
            }, getDisplayMediaError).catch(getDisplayMediaError);
        } else if (navigator.getDisplayMedia) {
            navigator.getDisplayMedia({
                video: true,
                audio: true
            }).then(stream => {
                onGettingSteam(stream);
            }, getDisplayMediaError).catch(getDisplayMediaError);
        }
    } else {
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
    var roomName = document.getElementById('room-name') || {};
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