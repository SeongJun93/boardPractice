package com.company.board.service;

import java.util.List;

import com.company.board.domain.BoardVO;
import com.company.board.domain.Search;

public interface BoardService {
	void insertBoard(BoardVO vo);
	
	List<BoardVO> getBoardList(Search search) throws Exception;
	
	BoardVO getBoard(BoardVO vo);
	
	void updateBoard(BoardVO vo);

	void deleteBoard(BoardVO vo);
	
	public int getBoardListCnt(Search search) throws Exception;
	
	// ����������� ��й�ȣȮ��
	int BoardPagePassChk(BoardVO vo);
}
