package com.company.board.dao;

import com.company.board.domain.BoardVO;

public interface RegistrationDAO {
	
	void insertRegistration(BoardVO vo);
	void updateRegistration(BoardVO vo);
	void deleteRegistration(BoardVO vo);
	BoardVO getRegistration(BoardVO vo);
	
	// 로그인
	BoardVO memberLogin(BoardVO vo);
	BoardVO idCheck(BoardVO vo);
	
	//아이디 중복체크
	public int idChk(String vo) throws Exception;
	
	// 마이페이지 진입 비밀번호 체크
	BoardVO myPagePass(BoardVO vo);
	int passCheck(BoardVO vo);
}
