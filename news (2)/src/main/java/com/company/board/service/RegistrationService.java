package com.company.board.service;

import com.company.board.domain.BoardVO;



public interface RegistrationService {
	
	void insertRegistration(BoardVO vo);
	
	void updateRegistration(BoardVO vo);
	
	void deleteRegistration(BoardVO vo);
	
	BoardVO getRegistration(BoardVO vo);
	
	//�α��� ȸ������ ��ȸ �α���
	public BoardVO idCheck_Login( BoardVO vo);
	
	//ȸ������ ���̵� �ߺ��˻�
	public int idChk(String vo) throws Exception;
	
	//ȸ������ ���� ��й�ȣ
	public int myPagePassChk(BoardVO vo);
}

