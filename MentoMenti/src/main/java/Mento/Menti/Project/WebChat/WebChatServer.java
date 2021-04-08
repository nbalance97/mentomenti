package Mento.Menti.Project.WebChat;


import java.io.IOException;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;


@ServerEndpoint("/webChatServer") // 클라이언트에서 서버로 접속할 주소. WebSocket 주소 맨 끝에 붙여주면 됨
public class WebChatServer extends HttpServlet {
	private static Map<Session,String> users = Collections.synchronizedMap(new HashMap<Session, String>());
	
	@OnMessage
	public void onMsg(String message, Session session) throws IOException{
		String userName = users.get(session);
		System.out.println(userName + " : " + message);
		
		synchronized (users) {
			Iterator<Session> it = users.keySet().iterator();
			while(it.hasNext()){
				Session currentSession = it.next();
				if(!currentSession.equals(session)){
					currentSession.getBasicRemote().sendText(userName + " : " + message);
				}
			}
		}
		
	}
	
	@OnOpen
	public void onOpen(Session session) throws IOException{
		System.out.println(session);
		String userName = "user" + (int)(Math.random()*100);
		users.put(session, userName);
		sendNotice(userName + "님이 입장하셨습니다. 현재 사용자 " + users.size() + "명");
	}
	
	
	public void sendNotice(String message) throws IOException{
		String userName = "server";
		System.out.println(userName + " : " + message);
		
		synchronized (users) {
			Iterator<Session> it = users.keySet().iterator();
			while(it.hasNext()){
				Session currentSession = it.next();
				currentSession.getBasicRemote().sendText(userName + " : " + message);
			}
		}
	}

	@OnClose
	public void onClose(Session session) throws IOException{
		String userName = users.get(session);
		users.remove(session);
		sendNotice(userName + "님이 퇴장하셨습니다. 현재 사용자 " + users.size() + "명");
	}

}