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
<title>Delete boardPage</title>
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
function fn_cancle(){			
	$('#frm').attr('action','/board/getBoard').submit();
}

function fn_goDeleteBoard(){
	var pwd = $('[name=board_pw]').val();
	var seq = $('[name=board_seq]').val();
	if(pwd==""){
		alert("패스워드를 입력하세요.")
		/* document.form.password.focus(); */
		return;
	}
	var param = {
		board_seq:seq
		,board_pw:pwd
	}
	$.ajax({
	url : "/boardDelete/confirmpwd",
	type : "post",
	data : JSON.stringify(param),
	contentType : "application/json; charset=utf-8",
	success : function(data){
		if(data.resultCode == '0000'){
			alert("게시글이 삭제되었습니다.");
			$('#frm').attr('action','/board').submit();
		}else if(data.resultCode == '9999'){
			alert("비밀번호가 일치하지 않습니다..");
		}
	}
})
}
</script>
</head>
<body>
<div class="container">
		<div class="jumbotron">
			<h1>Delete boardPage</h1>
			<p>views/board/deleteBoardPage.jsp</p>
		</div>
	</div>
	<div class="panel panel-default">
		<div class="panel-body">
				<div>
					<input name="board_pw" id="board_pw" type="password" class="form-control" placeholder="게시물 비밀번호를 입력하세요" maxlength="4">
				</div>
				<div>
					<a href="javascript:fn_goDeleteBoard();" class="btn btn-lg btn-primary">게시물 삭제</a> 
					<a href="javascript:fn_cancle();" class="cencle btn btn-lg btn-danger">취소</a> 
				<!-- 	<button class="cencle btn btn-lg btn-danger" type="button">취소</button> -->
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
	</div>
</body>
</html>