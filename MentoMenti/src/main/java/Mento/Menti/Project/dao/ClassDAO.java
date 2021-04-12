package Mento.Menti.Project.dao;

import java.util.List;

import Mento.Menti.Project.dto.ClassDTO;

public interface ClassDAO {
	List<ClassDTO> selectClasses() throws Exception;
}
