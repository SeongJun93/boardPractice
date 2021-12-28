	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page pageEncoding="utf-8" session="false"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/css/bootstrap.min.css" />" rel="stylesheet">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>MypageMain</title>
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
		
		function fn_UpdateMember() {
			var param = {
				email:$('[name=email]').val(),
				password:$('[name=password]').val()
			}
			
			$.ajax({
				url : "/updateRegistration",
				type : "post",
				data : JSON.stringify(param),
				contentType : "application/json; charset=utf-8",
				success : function(data){
					alert('변경이 완료되었습니다.');
					$('[name=form]').attr('action','/board').submit();
				}
			})
		}
		function fn_cancle(){			
			$('[name=form]').attr('action','/board').submit();
		}
		function fn_goDeliteForm() {
			if(confirm("정말삭제하시겠습니까?") == true){
				$('#frm').attr('action','/MypageMain/deleteRegistration?userid=${registration.userid}').submit();
			}else{
				return;
			}
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
			<h1>registration MypageMain</h1>
			<p>views/registration/mypageMain.jsp</p>
		</div>
	</div>
	<h1>마이페이지</h1>
	<div>
	<form name="form" method="post">
			<div class="form-group form-group-lg">
				<label class="control-label">아이디</label>
				<input disabled="disabled" name="userid" class="form-control" value="${registration.userid }">
			</div>
			<div class="form-group form-group-lg">
				<label class="control-label">가입일</label>
				<input disabled="disabled" name="reg_date" type="text" class="form-control" value="${registration.reg_date}">
			</div>
			<div class="form-group form-group-lg">
				<label class="control-label">e-mail</label>
				<input name="email" type="text" class="form-control" value="${registration.email}">
			</div>
			<div class="form-group form-group-lg">
				<label class="control-label">비밀번호</label> 
				<input name="password" type="password" class="form-control" value="${registration.password}">
			</div>
					<a href="javascript:fn_UpdateMember();" class="btn btn-lg btn-primary">회원정보변경</a>
					<a href="javascript:fn_cancle();" class="cencle btn btn-lg btn-primary">취소</a> 
					<a href="javascript:fn_goDeliteForm()" class="btn btn-lg btn-danger">탈퇴</a>
		</form>
		<form id="frm" method="post" >
		<input type="hidden" name="userid" value="${registration.userid }"/>
		<input type="hidden" name="reg_date" value="${registration.reg_date }"/>
		<input type="hidden" name="email" value="${registration.email }"/>
		<input type="hidden" name="password" value="${registration.password }"/>
		</form>
	</div>
</body>
</html>