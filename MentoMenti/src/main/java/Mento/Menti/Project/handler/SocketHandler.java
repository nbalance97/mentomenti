package Mento.Menti.Project.handler;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class SocketHandler extends TextWebSocketHandler {
   
   List<WebSocketSession> sessions = new ArrayList<WebSocketSession>(); //웹소켓 세션을 담아둘 맵
  
   
   @SuppressWarnings("unchecked")
   @Override
   public void afterConnectionEstablished(WebSocketSession session) throws Exception {
       //소켓 연결시
       super.afterConnectionEstablished(session);
       sessions.add(session);
   }
   
   @Override
   public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
       //소켓 종료시
       sessions.remove(session);
       super.afterConnectionClosed(session, status);
   }
   
   @Override
   public void handleTextMessage(WebSocketSession session, TextMessage message) {
       //메시지 발송시 받게 됨 (send() 호출시)
       String msg = message.getPayload();
       for(WebSocketSession s : sessions) {
           try {
        	   if (s.getId() != session.getId())
        		   s.sendMessage(message);
           } catch (Exception e) {
               e.printStackTrace();
           }
       }
   }
}

/*
HashMap<String, WebSocketSession> sessionMap = new HashMap<>(); //웹소켓 세션을 담아둘 맵

private static JSONObject jsonToObjectParser(String jsonStr) {
	   JSONParser parser = new JSONParser();
	   JSONObject obj = null;
	   try {
		   obj = (JSONObject) parser.parse(jsonStr);
	   } catch (Exception e) {
		   System.out.println("JSONToObjectParser Error");
		   e.printStackTrace();
	   }
	   return obj;
}

@SuppressWarnings("unchecked")
@Override
public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    //소켓 연결시
    super.afterConnectionEstablished(session);
    sessionMap.put(session.getId(), session);
    JSONObject obj = new JSONObject();
    obj.put("type", "getId");
    obj.put("sessionId", session.getId());
    session.sendMessage(new TextMessage(obj.toJSONString()));
    System.out.println(obj.toJSONString());
}

@Override
public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
    //소켓 종료시
    sessionMap.remove(session.getId());
    super.afterConnectionClosed(session, status);
}



@Override
public void handleTextMessage(WebSocketSession session, TextMessage message) {
    //메시지 발송시 받게 됨 (send() 호출시)
    String msg = message.getPayload();
    System.out.println(msg);
    JSONObject obj = jsonToObjectParser(msg);
    for(String key : sessionMap.keySet()) {
        WebSocketSession wss = sessionMap.get(key);
        try {
            wss.sendMessage(new TextMessage(obj.toJSONString()));
        }catch(Exception e) {
            e.printStackTrace();
        }
    }
}
*/
