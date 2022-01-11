package com.company.board.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.board.domain.BoardVO;

@Repository("RegistrationDAO")
public class RegistrationDAOImpl implements RegistrationDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	@Override
	public void insertRegistration(BoardVO vo) {
		mybatis.insert("RegistrationDAO.insertRegistration",vo);
	}
	@Override
	public void updateRegistration(BoardVO vo) {
		mybatis.update("RegistrationDAO.updateRegistration",vo);
	}
	@Override
	public void deleteRegistration(BoardVO vo) {
		System.out.println("회원삭제다오임플");
		mybatis.delete("RegistrationDAO.deleteRegistration",vo);
	}
	@Override
	public BoardVO getRegistration(BoardVO vo) {
		return mybatis.selectOne("RegistrationDAO.getRegistration",vo);
	}
	// 회원가입 아이디 체크
	@Override
	public int idChk(String vo) throws Exception {
		int result = mybatis.selectOne("RegistrationDAO.idChk", vo);
		return result;
	}
	// 로그인 체크
	@Override
	public BoardVO idCheck(BoardVO vo) {
		return mybatis.selectOne("RegistrationDAO.idCheck", vo);
	}
	@Override
	public BoardVO memberLogin(BoardVO vo) {
		return null;
	}
	// 마이페이지 진입 페이지
	@Override
	public BoardVO myPagePass(BoardVO vo) {
		return null;
	}
	@Override
	public int passCheck(BoardVO vo) {
		return mybatis.selectOne("RegistrationDAO.passCheck",vo);
	}
}

	

