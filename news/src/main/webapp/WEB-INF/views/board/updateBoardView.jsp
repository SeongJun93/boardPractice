<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page pageEncoding="utf-8" session="false"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/css/bootstrap.min.css" />" rel="stylesheet">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>BoardUpdate</title>
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
	function fn_goUpdateForm() {
		var param = {
			title:$('[name=title]').val(),
			board_pw:$('[name=board_pw]').val(),
			content:$('[name=content]').val(),
			board_seq:$('[name=board_seq]').val()
		}
		$.ajax({
			url : "/updateBoard",
			type : "post",
			data : JSON.stringify(param),
			contentType : "application/json; charset=utf-8",
			success : function(data){
				alert('변경이 완료되었습니다.');
				$('[name=form]').attr('action','/board/getBoard').submit();
				
				}
		})
	}
	$(document).ready(function() {
	    $('#content').on('keyup', function() {
	        $('#counter').html("("+$(this).val().length+" / 200)");
	 
	        if($(this).val().length > 200) {
	            $(this).val($(this).val().substring(0, 100));
	            $('#counter').html("(200 / 200)");
	        }
	    });
	});
	
	function fn_goBack(){
		$('#frm').attr('action','/board').submit();
	}
</script>
</head>
<body>
	<div class="container">
		<div class="jumbotron">
			<h1>board Update</h1>
			<p>views/board/updateBoard.jsp</p>
		</div>
		<form name="form" method="post">
			<input type="hidden" name="board_seq" value="${board.board_seq}"/>
			<input type="hidden" name="board_pw" value="${board.board_pw}"/>
			<div class="form-group form-group-lg">
				<label class="control-label">제목</label> <input maxlength="20" name="title" type="text" class="form-control" value="${board.title}" placeholder = "제목은 최대 20자입니다.">
			</div>
<!--  			<div class="form-group form-group-lg">
 				<label class="control-label">비밀번호</label>  <input name="board_pw" type="password" class="form-control" maxlength="4" placeholder = "제목은 최대 4자입니다.">
 			</div> -->
<%-- 			<div class="form-group form-group-lg">
				<label class="control-label">작성자</label> <input name="reg_id"
					type="text" class="form-control" value="${registration.reg_id}">
			</div> --%>
			<div class="form-group form-group-lg">
				<label class="control-label">내용</label> 
				<textarea id="content" name="content" class="form-control" style="height:300px;" maxlength="200">${board.content}</textarea>
				<span style="color:#aaa;" id="counter">(0 / 최대 200자)</span>
			</div>
			<a href="javascript:fn_goUpdateForm()" class="btn btn-lg btn-primary">글수정</a>
			<a href="javascript:fn_goBack()" class="btn btn-lg btn-primary">뒤로가기</a>
			
		</form>
			<form id="frm" method="post">
				<input type="hidden" name="board_seq" value="${search.board_seq }"/>
				<input type="hidden" name="page" value="${search.page }"/>
				<input type="hidden" name="range" value="${search.range }"/>
				<input type="hidden" name="rangeSize" value="${search.rangeSize }"/>
				<input type="hidden" name="listSize" value="${search.listSize }"/>
				<input type="hidden" name="searchType" value="${search.searchType}"/>
				<input type="hidden" name="keyword" value="${search.keyword}"/>
			</form>
	</div>
</body>
</html>