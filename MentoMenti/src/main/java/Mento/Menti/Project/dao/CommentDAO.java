package Mento.Menti.Project.dao;

import java.util.List;

import Mento.Menti.Project.dto.CommentDTO;

public interface CommentDAO {
	List<CommentDTO> selectComments() throws Exception;
}
