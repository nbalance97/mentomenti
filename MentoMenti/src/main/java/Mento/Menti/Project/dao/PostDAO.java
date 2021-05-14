package Mento.Menti.Project.dao;

import java.util.List;

import Mento.Menti.Project.dto.GroupDTO;
import Mento.Menti.Project.dto.PostDTO;

public interface PostDAO {
	List<PostDTO> selectPosts() throws Exception;
	List<PostDTO> selectGeneralNotices() throws Exception;
	List<PostDTO> selectGeneralPosts() throws Exception;
	List<PostDTO> selectGroupNotices(int groupid) throws Exception;
	List<PostDTO> selectGroupPosts(int groupid) throws Exception;
	
	List<PostDTO> searchGeneralNotices(String kwd) throws Exception;
	List<PostDTO> searchGeneralPosts(String kwd) throws Exception;
	
	void insertGeneralNotice(PostDTO notice) throws Exception;
	void insertGeneralPost(PostDTO post) throws Exception;
	
	List<PostDTO> searchByPostId(int postid) throws Exception;
	void updateViewcount(int postid) throws Exception;
	
	boolean isNotice(int postid) throws Exception;
	
	void deletePost(int postid) throws Exception;
	
	List<PostDTO> curGeneralNotices(int num) throws Exception;
	List<PostDTO> curGeneralPosts(int num) throws Exception;
	
	List<PostDTO> curGroupNotices(int groupid) throws Exception;
	List<PostDTO> curGroupPosts(int groupid) throws Exception;
	
	void updatePost(PostDTO post) throws Exception;
	
	List<PostDTO> searchMyPostsByUserId(String id) throws Exception;
	
	void insertGroupNotice(PostDTO notice) throws Exception;
	void insertGroupPost(PostDTO post) throws Exception;
	
	List<PostDTO> searchGroupNotices(PostDTO notice) throws Exception;
	List<PostDTO> searchGroupQnA(PostDTO qna) throws Exception;
}
