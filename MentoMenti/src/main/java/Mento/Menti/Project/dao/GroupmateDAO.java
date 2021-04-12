package Mento.Menti.Project.dao;

import java.util.List;

import Mento.Menti.Project.dto.GroupmateDTO;

public interface GroupmateDAO {
	List<GroupmateDTO> selectGroupmates() throws Exception;
}
