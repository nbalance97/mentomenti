package Mento.Menti.Project.dto;

import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class NotificationDTO {
	private int notificationid;
	private String receiverid;
	private String sendtime;
	private String content;
	private boolean isread;
}
