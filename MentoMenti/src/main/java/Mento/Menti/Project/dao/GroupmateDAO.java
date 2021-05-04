package Mento.Menti.Project.dao;

import java.util.List;

import Mento.Menti.Project.dto.GroupmateDTO;

public interface GroupmateDAO {
	List<GroupmateDTO> alreadyJoined(GroupmateDTO groupmate) throws Exception;
	void insertGroupmate(GroupmateDTO groupmate) throws Exception;
	int cntMenti(int groupid) throws Exception;
	List<GroupmateDTO> selectMentiList(int groupid) throws Exception;
	void leaveGroup(GroupmateDTO groupmate) throws Exception;
}
