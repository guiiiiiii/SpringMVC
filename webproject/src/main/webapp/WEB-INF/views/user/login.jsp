<%@page import="com.neobns.domain.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" type="text/css" href="/resources/css/login.css">
</head>


<div class="wrap_con_all">

	<div class="wrap_login_header">
		<label class="txt_header">로그인</label>
	</div>
	<div class="wrap_login_form">
		<c:url value="/login" var="loginUrl" />
		<form:form id="loginForm" name="f" action="${loginUrl}" method="POST">

			<div class="err_row">
				<c:if test="${param.error != null}">
					<label class="txt_title">인증정보가 올바르지 않습니다.</label>
				</c:if>
				<c:if test="${param.logout != null}">
					<label class="txt_title">로그아웃 하였습니다.</label>
				</c:if>
				<c:if test="${param.adduser != null}">
					<label class="txt_title">가입 되었습니다.</label>
				</c:if>
			</div>
			<div class="login_row">
				<label class="txt_title">아이디<BR></label> <input class="input" id="user_id" required="required"
					type="text" name="user_id" maxlength="20">
			</div>

			<div class="login_row">
				<label class="txt_title">비밀번호<BR></label> <input class="input" id="user_pw" required="required"
					type="password" name="user_pw" maxlength="20">
			</div>


			<div class="login_row">
				<input class="input_submit" type="submit" value="로 그 인">
			</div>
		</form:form>
	</div>
</div>