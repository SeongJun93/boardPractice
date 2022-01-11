package com.company.board.service;

import com.company.board.domain.BoardVO;



public interface RegistrationService {
	
	void insertRegistration(BoardVO vo);
	
	void updateRegistration(BoardVO vo);
	
	void deleteRegistration(BoardVO vo);
	
	BoardVO getRegistration(BoardVO vo);
	
	//로그인 회원정보 조회 로그인
	public BoardVO idCheck_Login( BoardVO vo);
	
	//회원가입 아이디 중복검사
	public int idChk(String vo) throws Exception;
	
	//회원정보 수정 비밀번호
	public int myPagePassChk(BoardVO vo);
}

