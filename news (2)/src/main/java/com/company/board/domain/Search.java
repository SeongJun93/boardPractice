package com.company.board.domain;

//Search 클래스가 Pagination 클래스를 상속 받았으므로 기존 Pagination의 특성을 그대로 사용 할 수 있다.
public class Search extends Pagination{

	private String searchType;
	private String keyword;	
	private String board_seq;	

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getBoard_seq() {
		return board_seq;
	}

	public void setBoard_seq(String board_seq) {
		this.board_seq = board_seq;
	}
}