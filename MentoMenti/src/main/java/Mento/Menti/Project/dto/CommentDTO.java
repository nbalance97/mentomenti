package Mento.Menti.Project.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
@NoArgsConstructor 
@AllArgsConstructor
@Getter
@Setter
public class CommentDTO {
	private int commentid;
	private int postid;
	private String writerid;
	private String content;
	private String commentdate;
}
