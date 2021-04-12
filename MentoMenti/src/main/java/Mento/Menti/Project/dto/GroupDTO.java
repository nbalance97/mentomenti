package Mento.Menti.Project.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Getter
@Setter
public class GroupDTO {
	private int groupid;
	private String name;
	private String mentoid;
	private int maxperson;
	private String category;
	private String intro;
}
