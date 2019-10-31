<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<head>
<meta charset="UTF-8">
<title>${article.atc_title}</title>
<link rel="stylesheet" type="text/css" href="/resources/css/detail.css">
<script type="text/javascript" src="/resources/js/common.js"></script>
   <script>
   function button_click(){
	   var form=document.querySelector(".form");
	   var name=form.querySelector(".name");
	   var path=form.querySelector(".path");
	   name=encodeURIComponent(name.value);
	   path=encodeURIComponent(path.value);
	   location.href="/article/download?file_name="+name+"&file_path="+path;
   }
   </script>
</head>

<div class="wrap_con_all">
	<div class="wrap_content">
		<div class="wrap_top_menu">
			<a class="back" href='/article/list?&curPage=<c:out value="${page.curPage}"/>&cntPerPage=10
											&s_atc_type=<c:out value="${search.s_atc_type}"/>
											&s_atc_title=<c:out value="${search.s_atc_title}"/>
											&s_atc_writer=<c:out value="${search.s_atc_writer}"/>
											&s_start_dt=<c:out value="${search.s_start_dt}"/>
											&s_finish_dt=<c:out value="${search.s_finish_dt}"/>'>뒤로가기</a>
			<sec:authorize access="isAuthenticated()">
				<c:if test="${loginUserVO.user_id eq article.atc_writer }">
					<a class="modify" href='/article/modify?atc_seq=<c:out value="${article.atc_seq }"/>&curPage=<c:out value="${page.curPage}"/>&cntPerPage=10
											&s_atc_type=<c:out value="${search.s_atc_type}"/>
											&s_atc_title=<c:out value="${search.s_atc_title}"/>
											&s_atc_writer=<c:out value="${search.s_atc_writer}"/>
											&s_start_dt=<c:out value="${search.s_start_dt}"/>
											&s_finish_dt=<c:out value="${search.s_finish_dt}"/>'>
						수정하기
					</a>
					<a class="delete" href='/article/delete?atc_seq=<c:out value="${article.atc_seq }"/>&curPage=<c:out value="${page.curPage}"/>&cntPerPage=10
											&s_atc_type=<c:out value="${search.s_atc_type}"/>
											&s_atc_title=<c:out value="${search.s_atc_title}"/>
											&s_atc_writer=<c:out value="${search.s_atc_writer}"/>
											&s_start_dt=<c:out value="${search.s_start_dt}"/>
											&s_finish_dt=<c:out value="${search.s_finish_dt}"/>'>
						삭제하기
					</a>
				</c:if>
			</sec:authorize>
		</div>
		<div class="wrap_article">
			<div class="wrap_con_top">
				<div class="wrap_atc_title">
					<c:out value="${article.atc_title}" />
					<span id="atc_type">/ <c:out value="${article.atc_type}" /></span>
				</div>
				<div class="wrap_atc_reg_dt">
					<span id="atc_reg_dt">조회수 <c:out value="${article.atc_hits}" /></span>
					<span id="atc_reg_dt"><c:out value="${article.atc_reg_dt}" /></span>
				</div>
			</div>
			<hr id="line" />
			<div class="wrap_con_middle">
				<div class="wrap_atc_writer">
					<c:out value="${article.atc_writer}" />
				</div>
				<form action="" method="" class='form'>
    				<input type="hidden" name="file_name" class='name' value="${article.file_name}">
   					<input type="hidden" name="file_path" class='path' value="${article.file_path }">
				</form>
				<div class="wrap_atc_file">
					<label>첨부파일</label>&nbsp;&nbsp;&nbsp;
					<button onclick="button_click();"><c:out value="${fn:substring(article.file_name, fn:indexOf(article.file_name,'_')+1, fn:length(article.file_name))}" /></button>
				</div>
			</div>

			<div class="wrap_atc_content">
				<textarea id="text" rows="10" cols="100" readonly='readonly'><c:out value="${article.atc_content}" /></textarea>
			</div>

		</div>
	</div>
</div>