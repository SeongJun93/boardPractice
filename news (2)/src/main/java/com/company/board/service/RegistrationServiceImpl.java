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
		System.out.println("회원탈퇴서비스임플");
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

	// 회원가입 아이디 중복검사
	@Override
	public int idChk(String vo) throws Exception {
		int result = registrationDAO.idChk(vo);
		return result;
	}
	// 마이페이지 진입 패스워드 
	@Override
	public int myPagePassChk(BoardVO vo) {
		return registrationDAO.passCheck(vo);
	}
}
