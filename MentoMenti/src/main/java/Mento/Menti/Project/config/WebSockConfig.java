package Mento.Menti.Project.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import Mento.Menti.Project.handler.SocketHandler;

@Configuration
@EnableWebSocket
public class WebSockConfig implements WebSocketConfigurer {
	@Autowired
	SocketHandler socketHandler;
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		// TODO Auto-generated method stub
		registry.addHandler(socketHandler, "/chating");
	}

}
