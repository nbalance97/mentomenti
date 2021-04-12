package Mento.Menti.Project.dao;

import java.util.List;

import Mento.Menti.Project.dto.GroupDTO;

public interface GroupDAO {
	List<GroupDTO> selectGroups() throws Exception;
}
