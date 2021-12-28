<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/css/bootstrap.min.css" />" rel="stylesheet">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>mypage</title>

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
			$('[name=form]').attr('action','/board').submit();
		}
		
	function fn_goUpdateMemberPage(){
			var pwd = $('[name=password]').val();
			if(pwd==""){
				alert("패스워드를 입력하세요.")
				document.form.password.focus();
				return;
			}
			var param = {
				password:pwd
			}
			$.ajax({
			url : "/registration/confirmpwd",
			type : "post",
			data : JSON.stringify(param),
			contentType : "application/json; charset=utf-8",
			success : function(data){
				if(data.resultCode == '0000'){
					$('[name=form]').attr('action','/registration/MypageMain').submit();
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
			<h1>registration mypage</h1>
			<p>views/registration/mypage.jsp</p>
		</div>
	</div>
	<h1>마이페이지 비밀번호 입력</h1>
	<div class="panel panel-default">
		<div class="panel-body">
			<form name=form method="post">
				<div>
					<input name="password" id="password" type="password" class="form-control" maxlength="16" placeholder="계정비밀번호를 입력하세요">
				</div>
				<div>
					<a href="javascript:fn_goUpdateMemberPage();" class="btn btn-lg btn-primary">회원정보변경</a> 
					<a href="javascript:fn_cancle();" class="cencle btn btn-lg btn-danger">취소</a> 
				<!-- 	<button class="cencle btn btn-lg btn-danger" type="button">취소</button> -->
				</div>
			</form>
		</div>
	</div>
	
<!--  		<form id="frm" method="post">
		<input type="hidden" name="password" value=""/>
		</form> -->
</body>
</html>