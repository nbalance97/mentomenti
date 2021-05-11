package Mento.Menti.Project.handler;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class WhiteBoardSocketHandler extends TextWebSocketHandler {
    List<WebSocketSession> sessions = new CopyOnWriteArrayList<>();
    
    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message)
      throws InterruptedException, IOException {
        for (WebSocketSession webSocketSession : sessions) {
            if (webSocketSession.isOpen() && !session.getId().equals(webSocketSession.getId())) { // 자기 말고 다른 세션들에게만 메세지 전송
            	synchronized(webSocketSession) { // 동기화 처리 하여 충돌 안나도록 함.
            		webSocketSession.sendMessage(message);
            	}
            }
        }
    }
    
    @Override
    public void handleBinaryMessage(WebSocketSession session, BinaryMessage message) {
    	ByteBuffer byteBuffer = message.getPayload();
    	for (WebSocketSession webSocketSession : sessions) {
            if (webSocketSession.isOpen() && !session.getId().equals(webSocketSession.getId())) { // 자기 말고 다른 세션들에게만 메세지 전송
            	synchronized(webSocketSession) { // 동기화 처리 하여 충돌 안나도록 함.
            		try {
						webSocketSession.sendMessage(new BinaryMessage(byteBuffer));
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
            	}
            }
    	}
    }
    
    

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessions.remove(session);
        super.afterConnectionClosed(session, status);
    }
    
    
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessions.add(session);
    }
}
