package com.company.board.domain;

//Search Ŭ������ Pagination Ŭ������ ��� �޾����Ƿ� ���� Pagination�� Ư���� �״�� ��� �� �� �ִ�.
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