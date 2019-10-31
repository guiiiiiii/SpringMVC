<%@page import="com.neobns.domain.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" type="text/css" href="/resources/css/list.css">
<script type="text/javascript" src="/resources/js/list.js"></script>
<script type="text/javascript" src="/resources/js/validity.js"></script>
<script type="text/javascript" src="/resources/js/common.js"></script>

<c:set var="URL" value="${pageContext.request.queryString}" />
<div class="wrap_con_all">
	<div class="wrap_content">
		<div class="wrap_con_all">
			<div class="wrap_con_header">
				<div class="wrap_con_header_title">
					<label>A R T I C L E</label>
					<hr class="line">
				</div>

				<div class="wrap_con_header_menu">
					<a class="article_type" href="/article/list"> <spring:message
							code="article.all" />
					</a>
					<c:forEach items="${article_type}" var="article_type">
						<a id='<c:out value="${article_type.code_nm }" />'
							class="article_type" href="#"> <c:choose>
								<c:when test="${fn:contains(URL,'lang=en')}">
									<c:out value="${article_type.code_en_nm }" />
								</c:when>
								<c:otherwise>
									<c:out value="${article_type.code_nm }" />
								</c:otherwise>
							</c:choose>
						</a>
					</c:forEach>


				</div>
			</div>

			<div class="wrap_content">
				<div class='board_name'>
					<c:choose>
						<c:when test="${search.s_atc_type eq 'CD0101' }">자유게시판</c:when>
						<c:when test="${search.s_atc_type eq 'CD0103' }">공지사항</c:when>
						<c:when test="${search.s_atc_type eq 'CD0104' }">자료실</c:when>
						<c:when test="${search.s_atc_type eq 'CD0102' }">질답게시판</c:when>
						<c:otherwise>전체</c:otherwise>
					</c:choose>
				</div>

				<input type='button' class='writeBtn'
					value='<spring:message code="article.writeBtn"/>'
					onclick="location.href='/article/write'">

				<div class="wrap_table">

					<table class='list'>
						<thead>
							<tr>
								<th class='list_th'>#번호</th>
								<th class='list_th'>제목</th>
								<th class='list_th'>작성자</th>
								<th class='list_th'>조회수</th>
							</tr>
						</thead>

						<c:forEach items="${list}" var="article">
							<tr class="list_tr">
								<td class="list_td"><c:out value="${article.atc_seq}" /></td>
								<td class="list_td"><a class='move'
									href='/article/detail?atc_seq=<c:out value="${article.atc_seq }"/>&curPage=<c:out value="${page.curPage}"/>&cntPerPage=10
											&s_atc_type=<c:out value="${search.s_atc_type}"/>
											&s_atc_title=<c:out value="${search.s_atc_title}"/>
											&s_atc_writer=<c:out value="${search.s_atc_writer}"/>
											&s_start_dt=<c:out value="${search.s_start_dt}"/>
											&s_finish_dt=<c:out value="${search.s_finish_dt}"/>
											&user_seq=<c:out value="${loginUserVO.user_seq }"/>'>
										<c:out value="${article.atc_title}" />
								</a></td>
								<td class="list_td"><c:out value="${article.atc_writer}" /></td>
								<td class="list_td"><c:out value="${article.atc_hits}" /></td>
							</tr>
						</c:forEach>

					</table>

					<!-- 페이지 -->
					<div class='pagination'>
						<ul class='pagination_ul'>
							<c:if test="${page.prev }">
								<li class='page_li' id='prev'><a
									href='/article/list?curPage=<c:out value="${page.startPage-1}"/>&cntPerPage=10
											&s_atc_type=<c:out value="${search.s_atc_type}"/>
											&s_atc_title=<c:out value="${search.s_atc_title}"/>
											&s_atc_writer=<c:out value="${search.s_atc_writer}"/>
											&s_start_dt=<c:out value="${search.s_start_dt}"/>
											&s_finish_dt=<c:out value="${search.s_finish_dt}"/>'>PREV</a></li>
							</c:if>

							<c:forEach var='num' begin='${page.startPage }'
								end='${page.endPage }'>
								<li class='page_li'><a id='page'
									href='/article/list?curPage=<c:out value="${num}"/>&cntPerPage=10
											&s_atc_type=<c:out value="${search.s_atc_type}"/>
											&s_atc_title=<c:out value="${search.s_atc_title}"/>
											&s_atc_writer=<c:out value="${search.s_atc_writer}"/>
											&s_start_dt=<c:out value="${search.s_start_dt}"/>
											&s_finish_dt=<c:out value="${search.s_finish_dt}"/>'>${num }</a></li>
							</c:forEach>

							<c:if test="${page.next }">
								<li class='page_li' id='next'><a
									href='/article/list?curPage=<c:out value="${page.endPage+1}"/>&cntPerPage=10
											&s_atc_type=<c:out value="${search.s_atc_type}"/>
											&s_atc_title=<c:out value="${search.s_atc_title}"/>
											&s_atc_writer=<c:out value="${search.s_atc_writer}"/>
											&s_start_dt=<c:out value="${search.s_start_dt}"/>
											&s_finish_dt=<c:out value="${search.s_finish_dt}"/>'>NEXT</a></li>
							</c:if>


						</ul>
					</div>
					<!-- 페이지 끝 -->


					<!-- 검색 끝 -->

					<!-- 상세검색 -->
					<div class='detailSearchForm'>
						<form:form class='detailSearchForm' id='detailSearch'
							action='/article/list' method='get'>
							<label>게시판</label>
							<select name='s_atc_type'>
								<option value=''>전체</option>
								<c:forEach items="${article_type}" var="article_type">
									<option value='<c:out value="${article_type.com_code }" />'
										<c:out value="${search.s_atc_type eq article_type.com_code ? 'selected' : '' }"/>><c:out
											value="${article_type.code_nm }" /></option>
								</c:forEach>
							</select>
							<br>
							<label>제목</label>
							<input type='text' placeholder='제목을 입력하세요'
								value='${search.s_atc_title}' name='s_atc_title'>
							<br>
							<label>작성자</label>
							<input type='text' placeholder='작성자를 입력하세요'
								value='${search.s_atc_writer}' name='s_atc_writer'>
							<br>
							<input type='date' name='s_start_dt'
								value='${search.s_start_dt }'>~ <input type='date'
								name='s_finish_dt' value='${search.s_finish_dt }'>
							<input type='hidden' name='curPage' value=1>
							<input type='hidden' name='cntPerPage'
								value='<c:out value="${page.cntPerPage }"/>'>
							<button type='submit' class='searchBtn' id='detailSearchBtn'>Go!</button>
						</form:form>

					</div>
					<!-- 상세검색 끝 -->



				</div>


			</div>

		</div>
	</div>

</div>