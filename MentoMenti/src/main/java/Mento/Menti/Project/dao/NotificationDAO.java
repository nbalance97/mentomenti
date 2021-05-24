package Mento.Menti.Project.dao;

import java.util.List;

import Mento.Menti.Project.dto.NotificationDTO;

public interface NotificationDAO {
	void insertNotification(NotificationDTO notification) throws Exception;
	List<NotificationDTO> selectNotifications(String receiverid) throws Exception;
	List<NotificationDTO> selectCurNotifications(String receiverid) throws Exception;
	void updateRead(int notificationid) throws Exception;
	int countNotRead(String receiverid) throws Exception;
	String selectReceiverid(int notificationid) throws Exception;
	void deleteNotification(int notificationid) throws Exception;
}
