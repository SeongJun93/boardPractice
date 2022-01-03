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
<title>BoardInsert</title>
<style type="text/css">
</style>
<script type="text/javascript">
var id_chk = RegExp(/^[A-Za-z0-9_\-]{8,16}$/);
// 영문 대문자와 소문자, 숫자, 특수문자를 하나 이상 포함하여 8~16자가 되는지 검사
var pass_chk = RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,16}$/);
// 이메일 형식에 맞게 썻는지 검사 ex)aa01@aa.aa
var emailCheck = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
// 01로 시작하여 그 다음은 0,1,7,9 중 하나와 매칭되는지 체크한뒤 8~9자리인지 검사
var phonNumberCheck = RegExp(/^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/);

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

$(document).ready(function() {
	// 유저아이디 정규식
	$('#userid').on('keyup', function() {
		var isAvailable = false;
		isAvailable = fn_check_id();
		if(isAvailable){
			$('#id_check').text('사용가능합니다');
			$('#id_check').css('color', 'green');
			$('#submit').attr("disabled",false);
			$('#idChk').attr("disabled",false);
		}else{
			$('#id_check').text('ID는 8이상 16자 이하 영어,숫자 만 가능합니다');
			$('#id_check').css('color', 'red');
			$('#submit').attr("disabled",true);
			$('#idChk').attr("disabled",true);
		}
	});

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

        if($('#password').val() != $('#password_chk').val()){
          $('#pass_recheck').html('비밀번호를 다시 확인해주세요.');
          $('#pass_recheck').css('color', 'red');
          $('#submit').attr("disabled",true);
        } else{
          $('#pass_recheck').html('비밀번호가 일치합니다.');
          $('#pass_recheck').css('color', 'green');
          $('#submit').attr("disabled",false);
        }

    });
});
	
	//핸드폰번호 입력 숫자만
	//핸드폰번호 정규식
	$('#pnum').on("keyup", function() {
		var isAvailable = false;
		isAvailable = fn_check_pnum();
		if(isAvailable){
			$('#pnum_check').text('사용가능합니다');
			$('#pnum_check').css('color', 'green');
			$('#submit').attr("disabled",false);
		}else{
			$('#pnum_check').text('앞은 항상 01입니다.8~9자리숫자를 입력해주세요');
			$('#pnum_check').css('color', 'red');
			$('#submit').attr("disabled",true);
		}
	})
			
	//이메일 양식 정규식
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
	
	// 공백방지
	$("#submit").on("click", function() {
		var isUsable = true;
		isUsable = fn_check_id();
		if(!isUsable){
			alert('ID를 확인해주세요.');
			return;
		}
		isUsable = fn_check_pwd();
		if(!isUsable){
			alert('패스워드를 확인해주세요.');
			return;
		}
		isUsable = fn_check_pnum();
		if(!isUsable){
			alert('휴대폰번호를 확인해주세요.');
			return;
		}
		isUsable = fn_check_email();
		if(!isUsable){
			alert('이메일주소를 확인해주세요.');
			return;
		}
			
		if ($("#name").val() == "") {
			alert("성명을 입력해주세요.");
			$("#name").focus();
			return false;
		}
		
		var idChkVal = $("#idChk").val();
		if (idChkVal == "N") {
			alert("중복확인 버튼을 눌러주세요.");
			return false;
		} else if (idChkVal == "Y") {
			alert("회원가입이 완료되었습니다.")
			$("#regForm").attr("action","/registration").attr('method','post').submit();
		}
	});
})
		
	var fn_check_id = function(){
		if(id_chk.test($('#userid').val())){
			return true;
		} else {
			return false;
		}
	}
		
	var fn_check_pwd = function(){
		if(pass_chk.test($('#password').val())){
			return true;
		} else {
			return false;
		}
	}
	
	var fn_check_pnum = function(){
		if(phonNumberCheck.test($('#pnum').val())){
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

		// 취소
	function fn_cancle(){
// 		$('#regForm').attr('action','/registration/login').attr('method','get').submit();
		location.href="/registration/login";
	}
	
	// 아이디 중복검사
	function fn_idChk(){
		$.ajax({
			url : "/registration/idChk",
			type : "post",
			contentType : "json/application;",
			data : $("#userid").val(),
			success : function(data){
				if(data == 1){
					alert("중복된 아이디입니다.");
				}else if(data == 0){
					$("#idChk").attr("value", "Y");
					alert("사용가능한 아이디입니다.");
				}
			}
		})
	}
</script>
</head>
<body>
	<div class="container">
		<div class="jumbotron">
			<h1>board NEW</h1>
			<p>views/registration/join.jsp</p>
		</div>
		<form id="regForm" method="post">
			<div class="form-group form-group-lg">
				<label class="control-label">ID</label> 
				<input name="userid" id="userid" type="text" class="form-control" maxlength="16" required onkeyup="this.value=this.value.replace(/[^a-z0-9]/gi,'');">
				<div class="invalid" id="id_check"></div>
				<button class="idChk" type="button" id="idChk" onclick="fn_idChk();" value="N">중복확인</button>
			</div>
			<div class="result">
			</div>
			<div class="form-group form-group-lg">
				<label class="control-label">PASS</label> 
				<input name="password" id="password" type="password" class="form-control" maxlength="16" required>
				<div class="invalid" id="pass_check"></div>
			</div>
			<div class="form-group form-group-lg">
				<label class="control-label">PASS CHECK</label> 
				<input name="password_chk" id="password_chk" type="password" class="form-control" maxlength="16" required>
				<div class="invalid" id="pass_recheck"></div>
			</div>
			<div class="form-group form-group-lg">
				<label class="control-label">이름</label> 
				<input name="name" id="name" type="text" class="form-control" maxlength="5">
			</div>
			
			
			
			
			
			<div class="form-group form-group-lg" style="float:none; margin:0 auto">
				<label class="control-label">핸드폰번호</label> 
				<select class="form-control" style="width:50%;">
					<option>010</option>
					<option>011</option>
					<option>017</option>
				</select>
				<input name="pnum" id="pnum" id="pnum" type="text" class="form-control" 
				maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" style="width: 50%;">
				<input name="pnum" id="pnum" id="pnum" type="text" class="form-control"
				maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" style="width: 50%;">
				<div class="valid" id="pnum_check"></div>
			</div>
			
			
			
			
			
			<!-- <div class="form-group form-group-lg">
				<label class="control-label">핸드폰번호</label> 
				<input name="pnum" id="pnum" id="pnum" type="text" class="form-control" maxlength="11" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
				<div class="valid" id="pnum_check"></div>
			</div> -->
			<div class="form-group form-group-lg">
				<label class="control-label">이메일</label> 
				<input name="email" id="email" type="text" class="form-control" maxlength="20">
				<div class="valid" id="email_check"></div>
			</div>
				<button type="submit" id="submit" class="btn btn-lg btn-primary">전송</button>
				<a href="javascript:fn_cancle();" class="cencle btn btn-lg btn-danger">취소</a> 	
		</form>
	</div>
</body>
</html>