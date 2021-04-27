package Mento.Menti.Project.dto;

import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class PostDTO {
	private int postid;
	private int groupid;
	private String userid;
	private String title;
	private String content;
	private String postdate;
	private int viewcount;
	private boolean is_notice;
}
