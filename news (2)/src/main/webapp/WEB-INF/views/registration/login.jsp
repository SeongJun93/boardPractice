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


function fn_login(){
	if(document.form.userid.value==""){
		alert("ID를 입력하세요.")
		document.form.userid.focus();
		return ;
	}
	if(document.form.password.value==""){
		alert("패스워드를 입력하세요.")
		document.form.password.focus();
		return ;
	}
	var param = {
		userid:$('[name=userid]').val(),
		password:$('[name=password]').val()
	}
	
	$.ajax({
		url : "/loginAction",
		type : "post",
		data : JSON.stringify(param),
		contentType : "application/json; charset=utf-8",
		success : function(data){
			if(data.resultCode == '0000'){
				$('[name=form]').attr('action','/board').submit();
			}else if(data.resultCode == '9999'){
				alert("계정 정보가 일치하지 않습니다.");
			}
		}
	})
}
function fn_goJoin(){
	$('[name=form]').attr('action','/registration/join').submit();
}
</script>
</head>
<body>
<c:if test="${sessionScope.userid != null }">
		<%
		response.sendRedirect("board");
		%>
	</c:if>
    <div class="container">
        <div class="jumbotron">
            <h1>login</h1>
            <p>views/registration/login.jsp</p>
        </div>
        <form name="form" method="post">
            <div class="form-group form-group-lg">
                <label class="control-label">ID</label>
                <input name="userid" id="userid" type="text" class="form-control" maxlength="16">
            </div>
            <div class="form-group form-group-lg">
                <label class="control-label">PASS</label>
                <input name="password" id="password" type="password" class="form-control" maxlength="16">
            </div>
            <a href="javascript:fn_goJoin();" class="btn btn-lg btn-primary">회원가입</a>
            <a href="javascript:fn_login();" class="btn btn-lg btn-primary">Login</a>
        </form>
    </div>
</body>
</html>