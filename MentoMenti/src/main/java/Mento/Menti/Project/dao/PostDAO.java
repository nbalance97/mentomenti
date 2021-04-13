package Mento.Menti.Project.dao;

import java.util.List;

import Mento.Menti.Project.dto.PostDTO;

public interface PostDAO {
	List<PostDTO> selectPosts() throws Exception;
	List<PostDTO> selectGeneralNotice() throws Exception;
	List<PostDTO> selectGeneralPost() throws Exception;
	List<PostDTO> selectGroupNotice() throws Exception;
	List<PostDTO> selectGroupPost() throws Exception;
}
