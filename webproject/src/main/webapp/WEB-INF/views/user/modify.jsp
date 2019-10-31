<%@page import="com.neobns.domain.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/validity.js"></script>
<head>
<meta charset="UTF-8">
<title>정보 수정</title>
<link rel="stylesheet" type="text/css"
	href="../resources/css/user_modify.css">

</head>
<div class="wrap_con_all">
	<div class="wrap_content">
		<div class="wrap_top_menu">
			<a class="back"
				href='/article/list'>뒤로가기</a>
		</div>
		<form:form id="modifyForm" method="post" action="/user/modify">

			<div class="wrap_modify">
				<c:if test="${param.error != null}">
					<p>현재 패스워드가 일치하지 않습니다.</p>
				</c:if>

				<div class="modify_row">
					<div class="modify_title">아이디</div>
					<div class="user_id">${loginUserVO.user_id}</div>
				</div>
				<div class="modify_row">
					<div class="modify_title">현재 패스워드</div>
					<div class="user_pw">
						<input class="input" type="password" id='cur_user_pw' maxlength="20"
							name="cur_user_pw">
					</div>
				</div>

				<div class="modify_row">
					<div class="modify_title">변경 패스워드</div>
					<div class="modify_pw">
						<input class="input" type="password" maxlength="20" id= 'user_pw' name="user_pw">
					</div>
				</div>

				<div class="modify_row">
					<div class="modify_title">변경 패스워드 확인</div>
					<div class="modify_pw">
						<input class="input" type="password" maxlength="20"
							name="reg_pw_confirm" id='pw_confirm'>
					</div>
				</div>

				<div class="modify_row">
					<div class="modify_title">이름</div>
					<div class="modify_pw">
						<input class="input" type="text" maxlength="20" name="user_name"
							value="${loginUserVO.user_name}">
					</div>
				</div>

				<div class="modify_row">
					<div class="modify_title">성별</div>
					<div class="modify_pw">
						<select class="select" name="user_gender">
							<c:if test="${loginUserVO.getUser_gender() eq 'M'}">
								<option value="M" selected="selected">남자</option>
								<option value="W">여자</option>
							</c:if>
							<c:if test="${loginUserVO.getUser_gender() eq 'W'}">

								<option value="M">남자</option>
								<option value="W" selected="selected">여자</option>
							</c:if>

						</select>
					</div>
				</div>
				<div class="wrap_bottom_menu">
					<input class="input_submit" type="submit" value="수정하기">
				</div>

			</div>
		</form:form>
	</div>
</div>
</body>
</html>