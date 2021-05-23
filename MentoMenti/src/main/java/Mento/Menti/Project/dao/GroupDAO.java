package Mento.Menti.Project.dao;

import java.util.List;

import Mento.Menti.Project.dto.GroupDTO;

public interface GroupDAO {
	List<GroupDTO> selectGroups() throws Exception;
	List<GroupDTO> selectGroupsC() throws Exception;
	List<GroupDTO> selectGroupsJava() throws Exception;
	List<GroupDTO> selectGroupsPython() throws Exception;
	List<GroupDTO> selectGroupsEtc() throws Exception;
	
	void insertGroup(GroupDTO group) throws Exception;
	
	List<GroupDTO> searchMentoGroupsByUserId(String id) throws Exception;
	List<GroupDTO> searchJoinGroupsByUserId(String id) throws Exception;
	List<GroupDTO> searchGroupsByName(String kwd) throws Exception;
	
	GroupDTO searchGroupByGroupid(int groupid) throws Exception;
	
	void deleteGroup(int groupid) throws Exception;
	
	int[] searchMentoGroupIdsByUserId(String id) throws Exception;
}
