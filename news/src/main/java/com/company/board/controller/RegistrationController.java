package com.company.board.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.company.board.domain.BoardVO;
import com.company.board.service.RegistrationService;

@Controller
public class RegistrationController {

	@Autowired
	private RegistrationService registrationService;

	@RequestMapping(value = "/registration/login")
	public String login() {
		System.out.println("로그인입력");
		return "registration/login";
	}
	@RequestMapping(value = "/registration/join", method = RequestMethod.POST)
	public String join() {
		System.out.println("회원가입페이지이동");
		return "registration/join";
	}
	@RequestMapping(value="/registration/mypage")
	public String mypage() {
		System.out.println("마이페이지이동");
		return "registration/mypage";
	}
	// 회원정보수정페이지 // 회원정보 불러오기
	@RequestMapping(value="/registration/MypageMain")
	public String MyPageMain(BoardVO vo,  Model model, HttpSession session) {
		vo.setUserid(String.valueOf(session.getAttribute("userid")));
		BoardVO result = registrationService.getRegistration(vo);
		model.addAttribute("registration", result);
		System.out.println("MypageMain,회원정보불러오기");
		return "/registration/MypageMain";
	}
	

	// 회원가입완료
		@RequestMapping(value = "/registration", method = RequestMethod.POST)
		public String insertRegistration(BoardVO vo) throws Exception {
			try {
				registrationService.insertRegistration(vo);
			} catch (Exception e) {
				throw new RuntimeException();
			}
			System.out.println("회원저장");
			return "registration/login";
		}
	
	@ResponseBody
	@RequestMapping(value="/registration/confirmpwd", consumes = "application/json; charset=UTF-8", produces = MediaType.APPLICATION_JSON_VALUE+"; charset=utf-8")
	public Map<String,Object> getMember(@RequestBody BoardVO vo,HttpSession session) {
		Map<String,Object> resultMap = new HashMap<String, Object>();
		System.out.println("ajax 비밀번호확인");
		vo.setUserid(String.valueOf(session.getAttribute("userid")));
		int result = registrationService.myPagePassChk(vo);
		if(result <= 0) {
			System.out.println("비밀번호입력실패");
			resultMap.put("resultCode", "9999");
		}else {								
			System.out.println("계정비밀번호확인");
			resultMap.put("resultCode", "0000");
		}
		return resultMap;
	}
	//회원삭제 비밀번호 확인
	@ResponseBody
	@RequestMapping(value = "/MypageMain/deleteRegistrationConfirmpwd",consumes = "application/json; charset=UTF-8", produces = MediaType.APPLICATION_JSON_VALUE+"; charset=utf-8")
	public Map<String,Object> deleteRegistrationConfirmpwd(@RequestBody BoardVO vo,HttpSession session) {
		Map<String,Object> resultMap = new HashMap<String, Object>();
		vo.setUserid(String.valueOf(session.getAttribute("userid")));
		int result = registrationService.myPagePassChk(vo);
		if(result <= 0) {
			System.out.println("비밀번호입력실패");
			resultMap.put("resultCode", "9999");
		}else {								
			System.out.println("계정비밀번호확인");
			resultMap.put("resultCode", "0000");
		}
		session.invalidate();
		return resultMap;
	}
	

	// 회원정보수정
	@ResponseBody
	@RequestMapping(value = "/updateRegistration", consumes = "application/json; charset=UTF-8", produces = MediaType.APPLICATION_JSON_VALUE+"; charset=utf-8")
	public Map<String, Object> updateMember(@RequestBody BoardVO vo, HttpSession session) {
		Map<String, Object> resultMap = new HashMap<>();
		System.out.println("회원정보수정");
		registrationService.updateRegistration(vo);
		System.out.println("회원정보수정완료");
		resultMap.put("resultCode","0000");
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value="/loginAction", consumes = "application/json; charset=UTF-8", produces = MediaType.APPLICATION_JSON_VALUE+"; charset=utf-8")
	public Map<String, Object> login(@RequestBody BoardVO vo, HttpSession session) {
	 	Map<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("login시작");
		BoardVO result = registrationService.idCheck_Login(vo);
		if(result == null || result.getUserid() == null) {
			System.out.println("로그인실패");
			resultMap.put("resultCode", "9999");
		}else {
			System.out.println("[ "+ result.getUserid()+" ] 로그인성공");
			resultMap.put("resultCode", "0000");
			session.setAttribute("sessionTime", new Date().toLocaleString());
			session.setAttribute("userid", result.getUserid());
		}
		return resultMap;
	}

	@RequestMapping("/registration/logout")
	public String logout(BoardVO vo, HttpSession session) {
		System.out.println("로그아웃");
		session.invalidate();
		return "registration/login";
	}
	
	//회원가입아이디체크
	@ResponseBody
	@RequestMapping("/registration/idChk")
	public int idChk(@RequestBody String param) throws Exception {
		int result = registrationService.idChk(param);
		return result;
	}

	@RequestMapping(value = "/MypageMain/deleteRegistration", method = RequestMethod.POST)
	public String deleteRegistration(BoardVO vo,HttpSession session) {
		registrationService.deleteRegistration(vo);
		session.invalidate();
		System.out.println("회원삭제");
		return "registration/login";
	}

	
}
