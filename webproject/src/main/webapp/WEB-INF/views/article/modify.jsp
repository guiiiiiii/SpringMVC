<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
<title>Write</title>
<link rel="stylesheet" type="text/css"
	href="../resources/css/modify.css">
<script type="text/javascript" src="/resources/js/validity.js"></script>
<script type="text/javascript" src="/resources/js/common.js"></script>
</head>
<script>
function unblock(){
	var file= document.querySelector(".hiddenfile");
	var btn=document.querySelector(".hiddenBtn");
	file.classList.toggle('hidden');
	btn.classList.toggle('hidden');
	
}
</script>

<div class="wrap_con_all">
	<div class="wrap_content">
		<form:form role='form' action='/article/modify' class='writeForm' enctype="multipart/form-data" method='post'>
			<input type='hidden' name='atc_seq'
				value='<c:out value="${article.atc_seq}"/>'>
			<input type='hidden' name='curPage'
				value='<c:out value="${page.curPage}"/>'>
			<input type='hidden' name='cntPerPage'
				value='<c:out value="${page.cntPerPage}"/>'>
			<input type='hidden' name='s_atc_type'
				value='<c:out value="${search.s_atc_type}"/>'>
			<input type='hidden' name='s_atc_title'
				value='<c:out value="${search.s_atc_title}"/>'>
			<input type='hidden' name='s_atc_writer'
				value='<c:out value="${search.s_atc_writer}"/>'>
			<input type='hidden' name='s_start_dt'
				value='<c:out value="${search.s_start_dt}"/>'>
			<input type='hidden' name='s_finish_dt'
				value='<c:out value="${search.s_finish_dt}"/>'>
				<input type='hidden' name='atc_writer'
				value='<c:out value="${article.atc_writer }"/>'>
			<div class="wrap_top_menu">
				<a class="back" id='modify_back'
					href='/article/list?&curPage=<c:out value="${page.curPage}"/>&cntPerPage=10
											&s_atc_type=<c:out value="${search.s_atc_type}"/>
											&s_atc_title=<c:out value="${search.s_atc_title}"/>
											&s_atc_writer=<c:out value="${search.s_atc_writer}"/>
											&s_start_dt=<c:out value="${search.s_start_dt}"/>
											&s_finish_dt=<c:out value="${search.s_finish_dt}"/>'>뒤로가기</a>
				<sec:authorize access="isAuthenticated()">

					<c:if test="${loginUserVO.user_id eq article.atc_writer }">
						<a class="delete"
							href='/article/delete?atc_seq=<c:out value="${article.atc_seq }"/>&curPage=<c:out value="${page.curPage}"/>&cntPerPage=10
											&s_atc_type=<c:out value="${search.s_atc_type}"/>
											&s_atc_title=<c:out value="${search.s_atc_title}"/>
											&s_atc_writer=<c:out value="${search.s_atc_writer}"/>
											&s_start_dt=<c:out value="${search.s_start_dt}"/>
											&s_finish_dt=<c:out value="${search.s_finish_dt}"/>'>
							삭제하기 </a>
					</c:if>

				</sec:authorize>
			</div>
			<div class="wrap_modify">

				<div class="wrap_title">
					<div class="title">제목</div>
					<div class="atc_title">
						<input name='atc_title'
							value='<c:out value="${article.atc_title}"/>' required='required' maxlength=16>
					</div>
				</div>

				<hr id="line" />

				<div class="wrap_writer">
					<div class="writer">작성자</div>
					<div class="atc_writer">${article.atc_writer}</div>
				</div>

				<hr id="line" />
				<div class="wrap_atc_file">
					<c:choose>
					<c:when test="${article.file_name !=null }">
						<div class="file"><input type="button" onclick="unblock();" value='파일 첨부'/></div>
						 <div class='hiddenBtn'><c:out value="${fn:substring(article.file_name, fn:indexOf(article.file_name,'_')+1, fn:length(article.file_name))}" /></div>
						<input id="file" type='file' name='file' class='hiddenfile hidden'>
					</c:when>
					<c:otherwise>
					<div class="file">파일 첨부</div>
					<input id="file" type='file' name='file' class='file'>
					</c:otherwise>
					</c:choose>
				</div>

				<div class="wrap_atc_content">
					<div class="txt_content">내용</div>
					<div class="atc_content">
						<textarea rows="30" cols="90" name='atc_content' id='atc_content'  required='required' maxlength=160><c:out value="${article.atc_content}" /></textarea>
						<sec:authorize access="isAuthenticated()">
							<c:if test="${loginUserVO.user_id eq article.atc_writer }">
								<div class="wrap_bottom_menu">
									<button type="submit" class='modifyhBtn'>수정하기</button>
									<button type="reset" class='resetBtn'>리셋</button>
								</div>
							</c:if>
						</sec:authorize>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>


