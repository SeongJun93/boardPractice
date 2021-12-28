package com.company.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.board.dao.RegistrationDAO;
import com.company.board.domain.BoardVO;

@Service("RegistrationService")
public class RegistrationServiceImpl implements RegistrationService {
	
	@Autowired
	private RegistrationDAO registrationDAO;
	
	@Override
	public void insertRegistration(BoardVO vo) {
		registrationDAO.insertRegistration(vo);
	}
	@Override
	public void updateRegistration(BoardVO vo) {
		registrationDAO.updateRegistration(vo);
	}
	@Override
	public void deleteRegistration(BoardVO vo) {
		System.out.println("ȸ��Ż�𼭺�����");
		registrationDAO.deleteRegistration(vo);
	}
	@Override
	public BoardVO getRegistration(BoardVO vo) {
		return registrationDAO.getRegistration(vo);
	}
	
	
	
	@Override
	public BoardVO idCheck_Login(BoardVO vo) {
		return registrationDAO.idCheck(vo);
	}

	// ȸ������ ���̵� �ߺ��˻�
	@Override
	public int idChk(String vo) throws Exception {
		int result = registrationDAO.idChk(vo);
		return result;
	}
	// ���������� ���� �н����� 
	@Override
	public int myPagePassChk(BoardVO vo) {
		return registrationDAO.passCheck(vo);
	}
}
