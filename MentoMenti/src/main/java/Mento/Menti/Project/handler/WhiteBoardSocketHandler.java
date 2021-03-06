package Mento.Menti.Project.handler;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.HashMap;
import java.util.List;
import java.util.Map.Entry;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArrayList;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class WhiteBoardSocketHandler extends TextWebSocketHandler {
    List<WebSocketSession> sessions = new CopyOnWriteArrayList<>();
    HashMap<String, String> sessionMap = new HashMap<>();
    HashMap<String, String> targetMap = new HashMap<>();
    
    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message)
      throws InterruptedException, IOException {
    	/* JSON Parse */
    	JSONParser jsonParse = new JSONParser();
    	JSONObject jsonObj = null;
    	try {
			jsonObj = (JSONObject) jsonParse.parse(message.getPayload());
		} catch (ParseException e) {
			e.printStackTrace();
		}
    	
    	/* 내 이름-세션정보 hashmap, 내 이름-상대 이름 hashmap */
    	String event = (String)jsonObj.get("event");
    	
    	if (event.contentEquals("namecall")) {
    		String myName = (String)jsonObj.get("from");
    		String yourName = (String)jsonObj.get("to");
    		if (sessionMap.get(yourName) != null) { // 상대가 누군가랑 연결이 되어있으면 그게 자신인지 체크
    			if (targetMap.get(sessionMap.get(yourName)).contentEquals(myName)) {
    	    		sessionMap.put(myName, session.getId());
    	    		targetMap.put(session.getId(), yourName);
    			}
        		System.out.println(sessionMap);
        		System.out.println(targetMap);
     			return;
    		}
    		sessionMap.put(myName, session.getId());
    		targetMap.put(session.getId(), yourName);
    		System.out.println(sessionMap);
    		System.out.println(targetMap);
    		return;
    	}
    	
        for (WebSocketSession webSocketSession : sessions) {
            if (webSocketSession.isOpen() && !session.getId().equals(webSocketSession.getId())) { // 자기 말고 다른 세션들에게만 메세지 전송
            	synchronized(webSocketSession) { // 동기화 처리 하여 충돌 안나도록 함.
            		if (webSocketSession.getId().contentEquals(sessionMap.get(targetMap.get(session.getId()))))
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
                		if (webSocketSession.getId().contentEquals(sessionMap.get(targetMap.get(session.getId()))))
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
        Set<Entry<String, String>> keyset = sessionMap.entrySet();
        for (Entry<String, String> entry: keyset) {
        	if(entry.getValue().contentEquals(session.getId())) {
        		sessionMap.remove(entry.getKey());
        	}
        }
        targetMap.remove(session.getId());
        super.afterConnectionClosed(session, status);
    }
    
    
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessions.add(session);
    }
    
}
