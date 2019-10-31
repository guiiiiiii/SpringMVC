<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<head>
<meta charset="UTF-8">
<title>Write</title>
<link rel="stylesheet" type="text/css" href="../resources/css/write.css">
<script type="text/javascript" src="/resources/js/validity.js"></script>
<script type="text/javascript" src="/resources/js/common.js"></script>

</head>



<div class="wrap_con_all">
	<div class="wrap_content">
		<form:form role='form' name='form' class='writeForm'
			action='/article/write' method='post' enctype="multipart/form-data">

			<div class="wrap_top_menu">
				<a class="back" id='back'
					href='/article/list?&curPage=<c:out value="${page.curPage}"/>&cntPerPage=10&s_atc_type=<c:out value="${search.s_atc_type}"/>
											&s_atc_title=<c:out value="${search.s_atc_title}"/>
											&s_atc_writer=<c:out value="${search.s_atc_writer}"/>
											&s_start_dt=<c:out value="${search.s_start_dt}"/>
											&s_finish_dt=<c:out value="${search.s_finish_dt}"/>'>뒤로가기</a>
			</div>
			<div class="wrap_modify">
				<div class="wrap_type">
					<div class="type">게시물 유형</div>
					<select name='atc_type' class='select'>
						<c:forEach items="${article_type}" var="article_type">
							<c:choose>
								<c:when
									test="${article_type.com_code eq 'CD0103' || article_type.com_code eq 'CD0104'}">
									<sec:authorize access="hasRole('ROLE_ADMIN')">
										<option value=<c:out value="${article_type.com_code }"/>><c:out
												value="${article_type.code_nm }" /></option>
									</sec:authorize>
								</c:when>
								<c:otherwise>
									<option value=<c:out value="${article_type.com_code }"/>><c:out
											value="${article_type.code_nm }" /></option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</div>

				<hr id="line" />

				<div class="wrap_title">
					<div class="title">제목</div>
					<div class="atc_title">
						<input id="atc_title" name='atc_title' required="required"
							maxlength=15>
							<c:out value='${result }'/>
					</div>
				</div>

				<hr id="line" />

				<div class="wrap_writer">
					<div class="writer">작성자</div>
					<input class="atc_writer" name='atc_writer' readonly="readonly"
						value=<c:out value="${loginUserVO.user_id}"/>>
				</div>

				<hr id="line" />
				<div class="wrap_atc_file">
					<div class="file">파일 첨부</div>
					<input id="file" type='file' name='file' class='file'>
				</div>

				<div class="wrap_atc_content">
					<div class="txt_content">내용</div>
					<div class="atc_content">
						<textarea rows="25" cols="90" id='atc_content' name='atc_content'
							maxlength=160 required="required"></textarea>
						<div class="wrap_bottom_menu">
							<button type="submit" class='writehBtn'>작성하기</button>
							<button type="reset" class='resetBtn'>리셋</button>
						</div>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>