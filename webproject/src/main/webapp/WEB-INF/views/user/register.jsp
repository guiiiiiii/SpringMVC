<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<head>
<meta charset="UTF-8">
<title>Register</title>
<link rel="stylesheet" type="text/css"
	href="/resources/css/register.css">
<script type="text/javascript" src="/resources/js/validity.js"></script>
<script type="text/javascript" src="/resources/js/register.js"></script>
</head>

<div class="wrap_con_all">

	<div class="wrap_reg_header">
		<label class="txt_header">회원가입</label>
	</div>
	<div class="wrap_reg_form">
		<form:form id="regForm" method="post" action="/user/register">
			

			<div class="reg_row">
				<label class="txt_title">아이디<BR></label> <input class="input"
					placeholder="아이디 입력" required="required" type="text" maxlength="10"
					name="user_id" id="user_id" value='${regUserVO.user_id}'>
			</div>
			
			<c:if test="${regUserVO.user_id != null}">
				<div id="chk_row">
					<label id="chk_id">
						'${regUserVO.user_id}' 아이디가 이미 존재합니다.
					</label>
				</div>
			</c:if>

			<div class="reg_row">
				<label class="txt_title">비밀번호<BR></label> <input class="input"
					placeholder="비밀번호 입력" required="required" id="user_pw" value='${regUserVO.user_pw}'
					type="password" maxlength="20" name="user_pw">
			</div>

			<div class="reg_row">
				<label class="txt_title">비밀번호 재확인<BR></label> <input
					placeholder="비밀번호 입력" id="user_pw_confirm" class="input" value='${regUserVO.user_pw}'
					required="required" type="password" maxlength="20"
					name="reg_pw_confirm">

			</div>
			<div id="chk_row">
				<font id="chk_pw" size="2"></font>
			</div>

			<div class="reg_row">
				<label class="txt_title">이름<BR></label> <input class="input"
					placeholder="이름 입력" value='${regUserVO.user_name}'
					required="required" type="text" maxlength="20" name="user_name">
			</div>


			<div class="reg_row">
				<label class="txt_title">성별<BR></label> 
				<select class="select"
					required="required" name="user_gender">
					<option selected value="">성별을 선택하세요.</option>
					<option value="M">남자</option>
					<option value="W">여자</option>
				</select>
			</div>

			<div class="reg_row">
				<input id="submit" class="input_submit" type="submit" value="가입하기">
			</div>

		</form:form>
	</div>
</div>