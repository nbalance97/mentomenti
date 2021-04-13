package Mento.Menti.Project.dao;

import java.util.List;

import Mento.Menti.Project.dto.UserDTO;

public interface UserDAO {
	List<UserDTO> selectUsers() throws Exception;
	void insertUsers(UserDTO user) throws Exception;
}
