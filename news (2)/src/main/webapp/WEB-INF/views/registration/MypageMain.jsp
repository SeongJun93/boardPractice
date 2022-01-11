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
//영문 대문자와 소문자, 숫자, 특수문자를 하나 이상 포함하여 8~16자가 되는지 검사
var pass_chk = RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,16}$/);	
//이메일 형식에 맞게 썻는지 검사 ex)aa01@aa.aa
var emailCheck = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);

/* $(document).ready(function() {
	$('a[href="#"]').click(function(ignore) {
		 ignore.preventDefault();
}); */

$(document).ready(function() {
	// 비밀번호 정규식
	$('#password').on('keyup', function() {
		var isAvailable = false;
		isAvailable = fn_check_pwd();
		if(isAvailable){
			$('#pass_check').text('사용가능합니다');
			$('#pass_check').css('color', 'green');
			$('#submit').attr("disabled",false);
		}else{
			$('#pass_check').text('영문 대문자와 소문자, 숫자, 특수문자를 하나 이상 포함하여 8~16자가 되어야 합니다.');
			$('#pass_check').css('color', 'red');
			$('#submit').attr("disabled",true);
		
		}
	});
	// 비밀번호 체크
	$(function(){
	    $('#password').keyup(function(){
	      $('#pass_recheck').html('');
	    });
	
	    $('#password_chk').keyup(function(){
	        if($('#password').val() == $('#password_chk').val()){
	          $('#pass_recheck').html('비밀번호가 일치합니다.');
	          $('#pass_recheck').css('color', 'green');
	          $('#submit').attr("disabled",false);
	        } else{
	          $('#pass_recheck').html('비밀번호를 다시 확인해주세요.');
	          $('#pass_recheck').css('color', 'red');
	          $('#submit').attr("disabled",true);
	        }
	    });
	});
	$('#email').on('keyup', function() {
		var isAvailable = false;
		isAvailable = fn_check_email();
		if(isAvailable){
			$('#email_check').text('사용가능합니다');
			$('#email_check').css('color', 'green');
			$('#submit').attr("disabled",false);
		}else{
			$('#email_check').text('양식에 맞게 입력해주세요. ex)aa01@aa.aa');
			$('#email_check').css('color', 'red');
			$('#submit').attr("disabled",true);
		}
	});
});

var fn_check_pwd = function(){
	if(pass_chk.test($('#password').val())){
		return true;
	} else {
		return false;
	}
}
var fn_check_email = function(){
	if(emailCheck.test($('#email').val())){
		return true;
	} else {
		return false;
	}
}


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
		
	 	/* function fn_goDeliteForm() {
			if(confirm("정말삭제하시겠습니까?") == true){
				$('#frm').attr('action','/MypageMain/deleteRegistration').submit();
			}else{
				return;
			}
		}  */
		////test
		function fn_goDeliteForm() {
			var pwd = $('[name=password]').val();
			var id = $('[name=userid]').val();
			if(pwd==""){
				alert("패스워드를 입력하세요.")
				/* document.form.password.focus(); */
				return;
			}
			var param = {
				password:pwd
				,userid:id
			}
			$.ajax({
			url : "/MypageMain/deleteRegistrationConfirmpwd",
			type : "post",
			data : JSON.stringify(param),
			contentType : "application/json; charset=utf-8",
			success : function(data){
				if(data.resultCode == '0000'){
					alert("이용해주셔서 감사합니다.")
					$('[name=form]').attr('action','/MypageMain/deleteRegistration').submit();
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
			<h1>registration MypageMain</h1>
			<p>views/registration/mypageMain.jsp</p>
		</div>
	</div>
	<h1>마이페이지</h1>
	<div>
	<form name="form" method="post">
	<input type="hidden" name="userid" value="${registration.userid }"/>
			<div class="form-group form-group-lg">
				<label class="control-label">아이디</label>
				<input disabled="disabled" name="userid" class="form-control" value="${registration.userid }">
			</div>
			<div class="form-group form-group-lg">
				<label class="control-label">가입일</label>
				<input disabled="disabled" name="reg_date" type="text" class="form-control" value="${registration.reg_date}">
			</div>
	<%-- 		<div class="form-group form-group-lg">
				<label class="control-label">e-mail</label>
				<input name="email" type="text" class="form-control" value="${registration.email}">
			</div> --%>
			<div class="form-group form-group-lg">
				<label class="control-label">이메일</label> 
				<input name="email" id="email" type="text" class="form-control" maxlength="20" value="${registration.email}">
				<div class="valid" id="email_check"></div>
			</div>
			<div class="form-group form-group-lg">
				<label class="control-label">PASS</label> 
				<input name="password" id="password" type="password" class="form-control" maxlength="16" value="" required>
				<div class="invalid" id="pass_check"></div>
			</div>
			<!-- <div class="form-group form-group-lg">
				<label class="control-label">PASS CHECK</label> 
				<input name="password_chk" id="password_chk" type="password" class="form-control" maxlength="16" required>
				<div class="invalid" id="pass_recheck"></div>
			</div> -->
					<a href="javascript:fn_UpdateMember();" class="btn btn-lg btn-primary" id="submit">회원정보변경</a>
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