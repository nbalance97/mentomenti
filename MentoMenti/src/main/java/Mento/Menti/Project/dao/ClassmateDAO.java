package Mento.Menti.Project.dao;

import java.util.List;

import Mento.Menti.Project.dto.ClassmateDTO;

public interface ClassmateDAO {
	List<ClassmateDTO> selectClassmates() throws Exception;
}
