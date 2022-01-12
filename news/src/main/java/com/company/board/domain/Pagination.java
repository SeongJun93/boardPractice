package com.company.board.domain;
public class Pagination {

	private int listSize = 10; // �ʱⰪ���� ��ϰ����� 10���� ���� �� �������� ������ ����Ʈ�� ����

	private int rangeSize = 10; // �ʱⰪ���� ������������ 5�� ���� �� ������ ������ ������ �������� ����

	private int page = 1; // �������� ������ ��ȣ

	private int range = 1; // �� ������ ���� ���� ��ȣ

	private int listCnt; // ��ü ���ù��� ����

	private int pageCnt; // ��ü ������ ������ ����

	private int startPage; // �� ������ ���� ���� ��ȣ

	private int startListNum; // �Խ��� ���۹�ȣ

	private int endPage; // �� ������ ���� �� ��ȣ

	private boolean prev; // ���� ������

	private boolean next; // ���� ������

	public int getRangeSize() {

		return rangeSize;

	}

	public int getPage() {

		return page;

	}

	public void setPage(int page) {

		this.page = page;

	}

	public int getRange() {

		return range;

	}

	public void setRange(int range) {

		this.range = range;

	}

	public int getStartPage() {

		return startPage;

	}

	public void setStartPage(int startPage) {

		this.startPage = startPage;

	}

	public int getEndPage() {

		return endPage;

	}

	public void setEndPage(int endPage) {

		this.endPage = endPage;

	}

	public boolean isPrev() {

		return prev;

	}

	public void setPrev(boolean prev) {

		this.prev = prev;

	}

	public boolean isNext() {

		return next;

	}

	public void setNext(boolean next) {

		this.next = next;

	}

	public int getListSize() {

		return listSize;

	}

	public void setListSize(int listSize) {

		this.listSize = listSize;

	}

	public int getListCnt() {

		return listCnt;

	}

	public void setListCnt(int listCnt) {

		this.listCnt = listCnt;

	}

	public int getStartListNum() {

		return startListNum;

	}

	// ù��° ���� page �� ���� ������ ����, �ι�° ���� range �� ���� ������ ���� ����, ����° ���� listCnt�� �Խù��� �� ����
	// ����¡ �ҽ� ù��°�� �����ؾ��� �� ��ü�Խù� �� ���� ������ ������ ��ȣ,������ ����
	public void pageInfo(int page, int range, int listCnt) {

		this.page = page;

		this.range = range;

		this.listCnt = listCnt;

		// ��ü ��������
		// ��ü ������ ���� = �� �Խñ� ���� / ������ �Խñ� ����
		this.pageCnt = (int) Math.ceil((double) listCnt / listSize);
		
		// ���� ������
		// �� ������ ���� ���� ��ȣ = (�� ������ ���� ���� ��ȣ  - 1) * �ʱⰪ ����¡ ����+1
		// 1/11/21/31/41 ......
		this.startPage = (range - 1) * rangeSize + 1;
		
		// �� ������
		// �� ������ ���� �� ��ȣ = �� ������ ���� ���� ��ȣ * �ʱⰪ ����¡ ����
		// 10/20/30/40 ......
		this.endPage = range * rangeSize;

		// �Խ��� ���۹�ȣ
		// �Խ��� ���� ��ȣ = (�������� ������ ��ȣ - 1) * ���ñ� �� ����
		// �Խ����� 0�� ���� ���� �ڿ���
		this.startListNum = (page - 1) * listSize;

		// ���� ��ư ����
		// ���׿����� 
		// ���� = ���������� ���� == 1 ? Ʈ��     :  ���� 
		// ���� �������� 1�ϰ�� 1�� Ʈ���̸� false �����̸� ������ư ��ȯ
		this.prev = range == 1 ? false : true;

		// ���� ��ư ����
		// ���׿�����
		//    ����=�������� ���� �� ��ȣ>���������� ?  ��    :  ����
		this.next = endPage > pageCnt ? false : true;
		if (this.endPage > this.pageCnt) {
			this.endPage = this.pageCnt;
			this.next = false;
		}
	}
}