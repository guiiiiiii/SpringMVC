<%@page import="com.neobns.domain.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<link rel="stylesheet" type="text/css" href="/resources/css/list.css">


<div class="wrap_con_all">
	<div class="wrap_con_header">
		<div class="wrap_con_header_title">
			<label>A R T I C L E</label>
			<hr class="line">
		</div>
		<div class="wrap_con_header_menu">
			<a class="article_type" href="/article/type/all"> 전체 </a> <a
				class="article_type" href="/article/type/notice"> 공지사항 </a> <a
				class="article_type" href="/article/type/free"> 자유게시판 </a> <a
				class="article_type" href="/article/type/data"> 자료실 </a> <a
				class="article_type" href="/article/type/etc"> 기타 </a>
		</div>
	</div>

	<div class="wrap_content">
		<div class="wrap_table">
			<input type='button' value='글작성'
				onclick="location.href='/article/write'">
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
							href='/article/detail?atc_seq=<c:out value="${article.atc_seq }"/>&pageNum=<c:out value="${page.cri.pageNum}"/>&amount=10'>
								<c:out value="${article.atc_title}" />
						</a></td>
						<td class="list_td"><c:out value="${article.atc_writer}" /></td>
						<td class="list_td"><c:out value="${article.atc_hits}" /></td>
					</tr>
				</c:forEach>

			</table>
			<div class='pagination'>
				<ul class='pagination_ul'>
					<c:if test="${page.prev }">
						<li class='page_li'><a
							href='/article/list?pageNum=<c:out value="${page.startPage-1}"/>&amount=10'>PREV</a></li>
					</c:if>

					<c:forEach var='num' begin='${page.startPage }'
						end='${page.endPage }'>
						<li class='page_li'><a href="#"
							onClick="fn_paging('${num }')">${num }</a></li>
					</c:forEach>

					<c:if test="${page.next }">
						<li class='page_li'><a
							href='/article/list?pageNum=<c:out value="${page.endPage+1}"/>&amount=10'>NEXT</a></li>
					</c:if>

				</ul>
			</div>
		</div>

	</div>

</div>