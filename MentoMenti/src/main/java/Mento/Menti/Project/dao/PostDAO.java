package Mento.Menti.Project.dao;

import java.util.List;

import Mento.Menti.Project.dto.PostDTO;

public interface PostDAO {
	List<PostDTO> selectPosts() throws Exception;
	List<PostDTO> selectGeneralNotices() throws Exception;
	List<PostDTO> selectGeneralPosts() throws Exception;
	List<PostDTO> selectGroupNotices() throws Exception;
	List<PostDTO> selectGroupPosts() throws Exception;
	
	List<PostDTO> searchGeneralNotices(String kwd) throws Exception;
	List<PostDTO> searchGeneralPosts(String kwd) throws Exception;
}
