package Mento.Menti.Project.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
@NoArgsConstructor 
@AllArgsConstructor
@Getter
@Setter
public class UserDTO {
	private String id;
	private String pw;
	private String birth;
	private String joindate;
	private String email;
	private String name;
	private String nickname;
	private boolean is_admin;
	private String intro;
}
