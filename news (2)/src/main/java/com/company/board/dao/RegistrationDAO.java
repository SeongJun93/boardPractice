package com.company.board.dao;

import com.company.board.domain.BoardVO;

public interface RegistrationDAO {
	
	void insertRegistration(BoardVO vo);
	void updateRegistration(BoardVO vo);
	void deleteRegistration(BoardVO vo);
	BoardVO getRegistration(BoardVO vo);
	
	// �α���
	BoardVO memberLogin(BoardVO vo);
	BoardVO idCheck(BoardVO vo);
	
	//���̵� �ߺ�üũ
	public int idChk(String vo) throws Exception;
	
	// ���������� ���� ��й�ȣ üũ
	BoardVO myPagePass(BoardVO vo);
	int passCheck(BoardVO vo);
}
