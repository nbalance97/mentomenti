package Mento.Menti.Project.handler;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.BinaryWebSocketHandler;

@Component
public class BinarySocketHandler extends BinaryWebSocketHandler {
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>(); //웹소켓 세션을 담아둘 맵
	
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
    	System.out.println("socket closed" + status);
        sessions.remove(session);
        super.afterConnectionClosed(session, status);
    }
    
    
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessions.add(session);
    }
	
	@Override
    public void handleBinaryMessage(WebSocketSession session, BinaryMessage message) {
		ByteBuffer byteBuffer = message.getPayload();
		System.out.println("??");
        try {
            for(WebSocketSession s : sessions) {
            	if (s.getId() != session.getId())
             		s.sendMessage(new BinaryMessage(byteBuffer));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
