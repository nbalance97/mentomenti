package Mento.Menti.Project.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Getter
@Setter
public class commentDTO {
	private int commentid;
	private int postid;
	private String writerid;
	private String content;
	private String commentdate;
}
