<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/css/bootstrap.min.css" />" rel="stylesheet">
<title>getBoard</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
		$.fn.serializeObject = function() {
			var o = {};
			var a = this.serializeArray();
			$.each(a, function() {
				if (o[this.name]) {
					if (!o[this.name].push) {
						o[this.name] = [o[this.name]];
					}
					o[this.name].push(this.value || '');
				} else {
					o[this.name] = this.value || '';
				}
			});
			return o;
		};


		function fn_goDeletePage() {
			if(confirm("정말삭제하시겠습니까?") == true){
				$('#frm').attr('action','/deleteBoardPage').submit();
			}else{
				return;
			}
		}
		/* function fn_goDeletePage(){
			$('#frm').attr('action','/deleteBoardPage').submit();
		} */
		
		
		function fn_goUpdateBoardPage(){
			$('#frm').attr('action','/updateBoardView').submit();
		}
		function fn_home(){			
			$('#frm').attr('action','/board').submit();
		}
</script>
</head>
<body>
<c:if test="${sessionScope.userid == null }">
		<%
		response.sendRedirect("login");
		%>
	</c:if>
	<div class="container">
		<div class="jumbotron">
			<h1>board getBoard</h1>
			<p>views/board/getBoard.jsp</p>
		</div>
	</div>
	<h1>게시글 상세</h1>
	<div class="panel panel-default">
		<div class="panel-body">
			<table class="table table-hover">
				<tbody>
					<tr>
						<th>제목</th>
						<td>${board.title}</td>
					</tr>
					<tr>
						<th>작성일</th>
						<td>${board.reg_dt}</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${board.reg_id}</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>${board.content}</td>
					</tr>
				</tbody>
			</table>
					<a href="javascript:fn_home()" class="btn btn-lg btn-primary">뒤로가기</a>
			<c:if test="${sessionScope.userid == board.reg_id }">
					<a href="javascript:fn_goUpdateBoardPage()" class="btn btn-lg btn-primary">게시글 수정</a>
					<a href="javascript:fn_goDeletePage()" class="btn btn-lg btn-danger">게시글 삭제</a>
					<!-- <a href="javascript:fn_goDeliteBoard()" class="btn btn-lg btn-danger">게시글 삭제</a> -->
				</c:if>
		</div>
	</div>
		<form id="frm" method="post">
		<input type="hidden" name="board_seq" value="${search.board_seq }"/>
		<input type="hidden" name="page" value="${search.page }"/>
		<input type="hidden" name="range" value="${search.range }"/>
		<input type="hidden" name="rangeSize" value="${search.rangeSize }"/>
		<input type="hidden" name="listSize" value="${search.listSize }"/>
		<input type="hidden" name="searchType" value="${search.searchType}"/>
		<input type="hidden" name="keyword" value="${search.keyword}"/>
		</form>
</body>
</html>