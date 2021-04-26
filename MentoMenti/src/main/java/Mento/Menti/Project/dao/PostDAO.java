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
	
	void insertGeneralNotice(PostDTO notice) throws Exception;
	void insertGeneralPost(PostDTO notice) throws Exception;
	
	List<PostDTO> searchByPostId(int postid) throws Exception;
	void updateViewcount(int postid) throws Exception;
	
	boolean isNotice(int postid) throws Exception;
	
	void deletePost(int postid) throws Exception;
}
