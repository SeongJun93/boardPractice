package com.company.board.dao;

import java.util.List;

import com.company.board.domain.BoardVO;
import com.company.board.domain.Search;

public interface BoardDAO {
	void insertBoard(BoardVO vo);
	
	List<BoardVO> getBoardList(Search search) throws Exception;
	
	BoardVO getBoard(BoardVO vo);
	
	void updateBoard(BoardVO vo);

	void deleteBoard(BoardVO vo);
	
	public int getBoardListCnt(Search search) throws Exception;
	
	// �Խ��� ���� ��й�ȣ Ȯ��
	BoardVO getBoardPageDelete(BoardVO vo);
	int BoardPagePassChk(BoardVO vo);
}
