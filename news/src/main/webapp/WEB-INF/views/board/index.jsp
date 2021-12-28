<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/css/bootstrap.min.css" />" rel="stylesheet">
<title>GetBoardList</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script type="text/javascript">
//게시글 상세	
function fn_goDetail(board_seq) {
	$('[name=board_seq]').val(board_seq);
	$('#frm').attr('action','/board/getBoard').submit();
}
//이전 버튼 이벤트
//5개의 인자값을 가지고 이동 board/index 이동
//무조건 이전페이지 범위의 가장 앞 페이지로 이동
	function fn_prev(page, range, rangeSize) {
		var page = ((range - 2) * rangeSize) + 1;
		var range = range - 1;
	 	$('[name=page]').val(page);
		$('[name=range]').val(range);
		$('#frm').attr('action',"/board").submit();
	}
//페이지 번호 클릭
	function fn_pagination(page) {
		$('[name=page]').val(page);
		$('#frm').attr('action','/board').submit();
	}
	//다음 버튼 이벤트
	//다음 페이지 범위의 가장 앞 페이지로 이동
	function fn_next(page, range, rangeSize) {
		var page = parseInt((range * rangeSize)) + 1;
		var range = parseInt(range) + 1;
		$('[name=page]').val(page);
		$('[name=range]').val(range);
		$('#frm').attr('action',"/board").submit();
	}


/*e.preventDefault(); 는 버튼 고유의 기능을 막는 명령어 */ 
	// 검색
	// 검색

	function fn_search() {
		$('#frm').attr('action',"/board").submit();
	}

	//마이페이지 진입
	function fn_goUpdateForm() {
		/* $('[name=password]').val(password); */
		$('#frm').attr('action','/registration/mypage').submit();
	}
	function fn_go(url){
		$('#frm').attr('action',url).submit();
	}

</script>

</head>
<body>
	<form id="frm" method="post">
		<input type="hidden" name="board_seq" value="${search.board_seq }"/>
		<input type="hidden" name="page" value="${search.page }"/>
		<input type="hidden" name="range" value="${search.range }"/>
		<input type="hidden" name="rangeSize" value="${search.rangeSize }"/>
		<input type="hidden" name="listSize" value="${search.listSize }"/>
		
	<div class="container">
		<div class="jumbotron">
			<h1>board INDEX</h1>
			<p>views/board/index.jsp</p>
		</div>
		<c:if test="${sessionScope.userid == null }">
				<%
				response.sendRedirect("login");
				%>

		</c:if>
		<c:if test="${sessionScope.userid != null }">
			<a href="javascript:fn_go('/board/new');" class="btn btn-lg btn-primary">게시글 등록</a>
			<a href="javascript:fn_go('/registration/mypage');" class="btn btn-lg btn-primary">마이페이지</a>
			<a href="javascript:fn_go('/registration/logout');" class="btn btn-lg btn-primary">로그아웃</a>
			<a href="javascript:fn_go('/board');" class="cencle btn btn-lg btn-primary">홈</a> 
		</c:if>
	</div>
	<h1>게시글 목록</h1>
	<div class="panel panel-default">
		<div class="panel-body">
			<table class="table table-hover">
				<thead>
					<tr>
						<th>No.1</th>
						<th>제목</th>
						<th>작성일</th>
						<th>작성자</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${boardList }" var="board">
						<tr onclick="fn_goDetail('${board.board_seq}')">
							<td>${board.rnum}</td>
							<td>${board.title}</td>
							<td>${board.reg_dt}</td>
							<td>${board.reg_id}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
	<!-- pagination{s} -->

	<div id="paginationBox" class="pagination1">
		<ul class="pagination">

			<c:if test="${pagination.prev}">
				<li class="page-item"><a class="page-link" href="javascript:fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}');">이전</a></li>
			</c:if>

			<c:forEach begin="${pagination.startPage}"
				end="${pagination.endPage}" var="pageNum">

				<li
					class="page-item <c:out value="${pagination.page == pageNum ? 'active' : ''}"/> "><a
					class="page-link" href="javascript:fn_pagination('${pageNum}');">
						${pageNum} </a></li>
			</c:forEach>

			<c:if test="${pagination.next}">

				<li class="page-item"><a class="page-link" href="javascript:fn_next('${pagination.range}', '${pagination.range}', '${pagination.rangeSize}');">다음</a></li>
			</c:if>
		</ul>
	</div>
	<!-- pagination{e} -->
	
	<!-- search{s} -->
	<div class="form-group row justify-content-center">
		<div class="w100" style="padding-right: 10px">
			<select class="form-control form-control-sm" name="searchType"
				id="searchType">
				<option value="title" <c:if test="${search.searchType eq 'title' or empty search.searchType}">checked="true"</c:if>>제목</option>
				<option value="content" <c:if test="${search.searchType eq 'content'}">checked="true"</c:if>>본문</option>
				<option value="reg_id" <c:if test="${search.searchType eq 'reg_id'}">checked="true"</c:if>>작성자</option>
			</select>
		</div>
		<div class="w300" style="padding-right: 10px">
			<input type="text"
				value="${search.keyword}" class="form-control form-control-sm"
				name="keyword" id="keyword">
		</div>
		<div>
<!-- 			<button class="btn btn-sm btn-primary" name="btnSearch" -->
<!-- 				id="btnSearch">검색</button> -->
	 	  	<a href="javascript:fn_search();" class="btn btn-sm btn-primary">검색</a>
		</div>
	</div>
	<!-- search{e} -->
		</div>
	</div>
	</form>
</body>
</html>