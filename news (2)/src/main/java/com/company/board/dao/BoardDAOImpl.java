package com.company.board.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.board.domain.BoardVO;
import com.company.board.domain.Search;

@Repository("boardDAO")
public class BoardDAOImpl implements BoardDAO{
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	@Override
	public void insertBoard(BoardVO vo) {
		mybatis.insert("BoardDAO.insertBoard",vo);
	}
	@Override
	public List<BoardVO> getBoardList(Search search) throws Exception{
		return mybatis.selectList("BoardDAO.getBoardList",search);
		//return mybatis.selectList("BoardDAO.getBoardList");
	}
	@Override
	public BoardVO getBoard(BoardVO vo) {
		return mybatis.selectOne("BoardDAO.getBoard",vo);
	}
	@Override
	public void updateBoard(BoardVO vo) {
		mybatis.update("BoardDAO.updateBoard",vo);
	}
	@Override
	public void deleteBoard(BoardVO vo) {
		mybatis.delete("BoardDAO.deleteBoard",vo);
	}
	@Override

	public int getBoardListCnt(Search search) throws Exception {
		return mybatis.selectOne("BoardDAO.getBoardListCnt",search);
	}
	// 마이페이지 진입 페이지
		@Override
		public BoardVO getBoardPageDelete(BoardVO vo) {
			return null;
		}
		@Override
		public int BoardPagePassChk(BoardVO vo) {
			return mybatis.selectOne("BoardDAO.BoardPagePassChk",vo);
		}
}