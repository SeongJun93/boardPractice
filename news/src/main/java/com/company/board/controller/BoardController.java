package com.company.board.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.company.board.domain.BoardVO;
import com.company.board.domain.Search;
import com.company.board.service.BoardService;
import com.company.board.service.RegistrationService;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;
	@Autowired
	private RegistrationService registrationservice;
	
	@RequestMapping(value = "/board", method = RequestMethod.POST)
	public String getBoardList(Model model, Search vo) throws Exception {
		int listCnt = boardService.getBoardListCnt(vo);	
		vo.pageInfo(vo.getPage(), vo.getRange(), listCnt);
		model.addAttribute("pagination", vo);
		model.addAttribute("boardList", boardService.getBoardList(vo));
		model.addAttribute("search", vo);
		return "board/index";
	}
	
	@RequestMapping(value = "/board/new", method = RequestMethod.POST)
	public String newBoard(BoardVO vo,Search search, Model model,HttpSession session) {
		vo.setUserid(String.valueOf(session.getAttribute("userid")));
		BoardVO result = registrationservice.getRegistration(vo);
		model.addAttribute("registration",result);
		model.addAttribute("search",search);
		System.out.println("�Խñ��Է�������");
		return "board/new";
	}

	@ResponseBody
	@RequestMapping(value = "/regBoard", consumes = "application/json; charset=UTF-8", produces = MediaType.APPLICATION_JSON_VALUE+"; charset=utf-8")
	public Map<String,Object> insertBoard(@RequestBody BoardVO vo, HttpSession session) {
		Map<String,Object> resultMap=new HashMap<>();
		System.out.println("�Խñ�����");
		vo.setUserid(String.valueOf(session.getAttribute("userid")));
		boardService.insertBoard(vo);
		System.out.println("�Խñ�����Ϸ�");
		resultMap.put("resultCode","0000");
		return resultMap;
	}

	@RequestMapping(value = "/board/getBoard", method = RequestMethod.POST)
	public String getBoard(BoardVO vo, Model model,Search search) {
		model.addAttribute("board", boardService.getBoard(vo));
		model.addAttribute("search", search);
		System.out.println("�Խ��ǻ�");
		return "board/getBoard";
	}
	@RequestMapping(value="/deleteBoardPage", method = RequestMethod.POST)
	public String deleteBoardPage(BoardVO vo, Model model, Search search) {
		model.addAttribute("board",vo);
		model.addAttribute("search", search);
		System.out.println("����Ʈ ���������� �̵�");
		return "/board/deleteBoardPage";
	}
	//�Խñ� ����
	@ResponseBody
	@RequestMapping(value="/boardDelete/confirmpwd", consumes = "application/json; charset=UTF-8", produces = MediaType.APPLICATION_JSON_VALUE+"; charset=utf-8")
	public Map<String,Object> getMember(@RequestBody BoardVO vo,HttpSession session) {
		Map<String,Object> resultMap = new HashMap<String, Object>();
		System.out.println("ajax �Խ��� ���� ��й�ȣȮ��");
		int result = boardService.BoardPagePassChk(vo);
		if(result > 0) {
			boardService.deleteBoard(vo);
			System.out.println("�Խñ� ��й�ȣȮ��");
			resultMap.put("resultCode", "0000");
		}else {								
			System.out.println("��й�ȣ�Է½���");
			resultMap.put("resultCode", "9999");
		}
		return resultMap;
	}

	 @RequestMapping(value = "/updateBoardView", method = RequestMethod.POST) 
	 public String updateBoardView(BoardVO vo, Model model,Search search) {
		BoardVO result = boardService.getBoard(vo);
		model.addAttribute("board", result);
		model.addAttribute("search", search);
	 	System.out.println("�Խñ������ҷ�����"); 
	 	return "board/updateBoardView"; 
	 }
	 
	 
	/// �Խñ� ����
	@ResponseBody
	@RequestMapping(value = "/updateBoard", consumes = "application/json; charset=UTF-8", produces = MediaType.APPLICATION_JSON_VALUE+"; charset=utf-8")
	public Map<String,Object> updateBoard(@RequestBody BoardVO vo, HttpSession session) {
		Map<String, Object> resultMap = new HashMap<>();
		System.out.println("�Խ��Ǽ���");
		boardService.updateBoard(vo);
		System.out.println("�Խ��Ǽ����Ϸ�");
		resultMap.put("resultCode","0000");
		return resultMap;
	}
	
	@RequestMapping(value = "/board/deleteBoard" , method = RequestMethod.POST, produces = MediaType.TEXT_PLAIN_VALUE+"; charset=utf-8")
	public String deleteBoard(BoardVO vo,Search search,Model model) {
		boardService.deleteBoard(vo);
		System.out.println("�Խ��ǻ���");
		model.addAttribute("search",search);
		return "board/index";
	}
	

}
