<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page pageEncoding="utf-8" session="false"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/css/bootstrap.min.css" />" rel="stylesheet">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>BoardInsert</title>

<script type="text/javascript">
//게시글 저장
/* function fn_goDetail(title,pass,userid,content) {
	$('[name=title]').val(title);
	$('[name=pass]').val(pass);
	$('[name=reg_id]').val(reg_id);
	$('[name=content]').val(content);
	$('#frm').attr('action','/regBoard').submit();
} */

function fn_InsertMember() {
	var param = {
		title:$('[name=title]').val(),
		reg_id:$('[name=reg_id]').val(),
		board_pw:$('[name=board_pw]').val(),
		content:$('[name=content]').val()
	}
	
	var isOk = fn_validate();
	
	if(isOk){
		$.ajax({
			url : "/regBoard",
			type : "post",
			data : JSON.stringify(param),
			contentType : "application/json; charset=utf-8",
			success : function(data){
				alert('게시글 등록이 완료되었습니다.');
				$('#frm').attr('action','/board').submit();
			}
		})
	}
}

function fn_validate(){
	if ($("[name=title]").val() == "") {
		alert("제목을 입력하세요.");
		$("[name=title]").focus();
		return false;
	}
	if ($("[name=board_pw]").val() == "") {
		alert("비밀번호 입력하세요.");
		$("[name=board_pw]").focus();
		return false;
	}	
	if ($("#content").val() == "") {
		alert("내용을 입력하세요.");
		$("#content").focus();
		return false;
	}
	return true;
}



function fn_cancle(){			
	$('#frm').attr('action','/board').submit();
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



</script>
</head>
<body>
    <div class="container">
        <div class="jumbotron">
            <h1>board NEW</h1>
            <p>views/board/new.jsp</p>
        </div>
        <div class="form-group form-group-lg">
            <label class="control-label">제목</label>
            <input name="title" type="text" class="form-control" maxlength="20" placeholder = "제목은 최대 20자입니다.">
        </div>
        <div class="form-group form-group-lg">
            <label class="control-label">작성자</label>
            <input disabled="disabled" name="reg_id" type="text" class="form-control" value="${registration.reg_id}">
        </div>
        <div class="form-group form-group-lg">
            <label class="control-label">PASS</label>
            <input name="board_pw" type="password" class="form-control" maxlength="4" placeholder = "제목은 최대 4자입니다.">
        </div>
        <div class="form-group form-group-lg">
            <label class="control-label">내용</label>
            <textarea id="content" name="content" class="form-control" maxlength="200" style="height:300px;"></textarea>
            <span style="color:#aaa;" id="counter">(0 / 최대 200자)</span>
        </div>
        <!-- <button type="submit" class="btn btn-lg btn-primary">전송</button> -->
     	<a href="javascript:fn_InsertMember();" class="btn btn-lg btn-primary">게시글 저장</a>
     	<a href="javascript:fn_cancle();" class="cencle btn btn-lg btn-danger">취소</a> 
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