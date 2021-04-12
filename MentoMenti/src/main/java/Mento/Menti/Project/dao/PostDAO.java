package Mento.Menti.Project.dao;

import java.util.List;

import Mento.Menti.Project.dto.PostDTO;

public interface PostDAO {
	List<PostDTO> selectPosts() throws Exception;
}
