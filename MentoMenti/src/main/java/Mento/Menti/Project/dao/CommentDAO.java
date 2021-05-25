package Mento.Menti.Project.dao;

import java.util.List;

import Mento.Menti.Project.dto.CommentDTO;
import Mento.Menti.Project.dto.PostDTO;

public interface CommentDAO {
	List<CommentDTO> selectComments(int postid) throws Exception;
	void insertComment(CommentDTO comment) throws Exception;
	void deleteComment(int commentid) throws Exception;
	List<CommentDTO> searchMyCommentsByUserId(String id) throws Exception;
	List<CommentDTO> selectAllComments() throws Exception;
	CommentDTO searchCommentByCommentId(int commentid) throws Exception;
	int countComment(int postid) throws Exception;
}
