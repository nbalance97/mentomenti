package Mento.Menti.Project.dao;

import java.util.List;

import Mento.Menti.Project.dto.CommentDTO;

public interface CommentDAO {
	List<CommentDTO> selectComments(int postid) throws Exception;
	void insertComment(CommentDTO comment) throws Exception;
}
