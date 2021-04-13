package Mento.Menti.Project.dao;

import java.util.List;

import Mento.Menti.Project.dto.GroupDTO;

public interface GroupDAO {
	List<GroupDTO> selectGroups() throws Exception;
	List<GroupDTO> selectGroupsC() throws Exception;
	List<GroupDTO> selectGroupsJava() throws Exception;
	List<GroupDTO> selectGroupsPython() throws Exception;
	List<GroupDTO> selectGroupsEtc() throws Exception;
}
