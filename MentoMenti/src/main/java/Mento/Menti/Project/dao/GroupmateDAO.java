package Mento.Menti.Project.dao;

import java.util.List;

import Mento.Menti.Project.dto.GroupmateDTO;

public interface GroupmateDAO {
	List<GroupmateDTO> selectGroupmates() throws Exception;
	List<GroupmateDTO> alreadyJoined(GroupmateDTO groupmate) throws Exception;
	void insertGroupmate(GroupmateDTO groupmate) throws Exception;
	int cntMenti(int groupid) throws Exception;
}
