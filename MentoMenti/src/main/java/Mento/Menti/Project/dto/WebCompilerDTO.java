package Mento.Menti.Project.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@NoArgsConstructor 
@AllArgsConstructor
@Getter
@Setter
@ToString
public class WebCompilerDTO {
	String mode;
	String src;
	String input;
}
