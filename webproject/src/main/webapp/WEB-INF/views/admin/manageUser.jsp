<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/resources/js/list.js"></script>
<script type="text/javascript" src="/resources/js/validity.js"></script>
<script type="text/javascript" src="/resources/js/common.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/list.css">
</head>
<body>
	<table class='list'>
		<thead>
			<tr>
				<th class='list_th'>#${page.curPage} <spring:message code="user.num"/></th>
				<th class='list_th'><spring:message code="user.id"/></th>
				<th class='list_th'><spring:message code="user.name"/></th>
				<th class='list_th'><spring:message code="user.gender"/></th>
				<th class='list_th'><spring:message code="user.state"/></th>
				<th class='list_th'><spring:message code="user.role"/></th>
			</tr>
		</thead>
		<c:forEach items="${user_list}" var="user">
			<tr class="list_tr">
				<td class="list_td"><c:out value="${user.user_seq}" /></td>
				<td class="list_td"><c:out value="${user.user_id}" /></td>
				<td class="list_td"><c:out value="${user.user_name}" /></td>
				<td class="list_td"><c:out value="${user.user_gender}" /></td>
				<td class="list_td"><a href='/admin/manageUser?curPage=<c:out value="${page.curPage}"/>
											&s_user_id=<c:out value="${search.s_user_id}"/>
											&s_user_name=<c:out value="${search.s_user_name}"/>
											&s_user_gender=<c:out value="${search.s_user_gender}"/>
											&s_user_use_state=<c:out value="${search.s_user_use_state}"/>
											&s_start_dt=<c:out value="${search.s_start_dt}"/>
											&s_finish_dt=<c:out value="${search.s_finish_dt}"/>
											&user_seq=<c:out value="${user.user_seq}"/>
											&user_use_state=<c:out value="${user.user_use_state}" />&change'>
				<c:out value="${user.user_use_state}" /></a></td>
				<td class="list_td">
					<c:choose>
					<c:when test="${user.user_authority eq 'ROLE_USER' }">
						<spring:message code="role.user"/></c:when>
					<c:otherwise><spring:message code="role.admin"/></c:otherwise>
					</c:choose>
				</td>	
			</tr>
		</c:forEach>
	</table>

	<div class='pagination'>
		<ul class='pagination_ul' style="list-style: none">
			<c:if test="${page.prev}">
				<li class='page_li' style="float: left; margin: 10px;"><a
					href='/admin/manageUser?curPage=<c:out value="${page.startPage-1}"/>&cntPerPage=10
											&s_user_id=<c:out value="${search.s_user_id}"/>
											&s_user_name=<c:out value="${search.s_user_name}"/>
											&s_user_gender=<c:out value="${search.s_user_gender}"/>
											&s_user_use_state=<c:out value="${search.s_user_use_state}"/>
											&s_start_dt=<c:out value="${search.s_start_dt}"/>
											&s_finish_dt=<c:out value="${search.s_finish_dt}"/>
											'>PREV</a></li>
			</c:if>

			<c:forEach var='num' begin='${page.startPage }'
				end='${page.endPage }'>
				<li class='page_li' style="float: left; margin: 10px;"><a
					href="/admin/manageUser?&curPage=<c:out value="${num}"/>&cntPerPage=10
											&s_user_id=<c:out value="${search.s_user_id}"/>
											&s_user_name=<c:out value="${search.s_user_name}"/>
											&s_user_gender=<c:out value="${search.s_user_gender}"/>
											&s_user_use_state=<c:out value="${search.s_user_use_state}"/>
											&s_start_dt=<c:out value="${search.s_start_dt}"/>
											&s_finish_dt=<c:out value="${search.s_finish_dt}"/>
											"><c:out
							value="${num}" /></a></li>

			</c:forEach>

			<c:if test="${page.next }">
				<li class='page_li' style="float: left; margin: 10px;"><a
					href='/admin/manageUser?curPage=<c:out value="${page.endPage+1}"/>&cntPerPage=10
											&s_user_id=<c:out value="${search.s_user_id}"/>
											&s_user_name=<c:out value="${search.s_user_name}"/>
											&s_user_gender=<c:out value="${search.s_user_gender}"/>
											&s_user_use_state=<c:out value="${search.s_user_use_state}"/>
											&s_start_dt=<c:out value="${search.s_start_dt}"/>
											&s_finish_dt=<c:out value="${search.s_finish_dt}"/>
											'>NEXT</a></li>
			</c:if>


		</ul>
	</div>
		<br><br>
	
	<form:form action='/admin/manageUser' id='detailSearch'  method='get'>
		<spring:message code="user.id"/><input type='text' name='s_user_id' value='${search.s_user_id}'><br>
		<spring:message code="user.name"/><input type='text' name='s_user_name' value='${search.s_user_name}'>
		<br><br>
		<label><spring:message code="user.gender"/></label><br>
		<spring:message code="btn.choice"/>:<br>
		<input type='radio' name='s_user_gender' value='M' <c:out value="${search.s_user_gender eq 'M' ? 'checked=checked' : '' }"/>><spring:message code="gender.male"/>
		<input type='radio' name='s_user_gender' value='W' <c:out value="${search.s_user_gender eq 'W' ? 'checked=checked' : '' }"/>><spring:message code="gender.female"/>
		<input type='radio' name='s_user_gender' value='' <c:out value="${search.s_user_gender eq '' ? 'checked=checked' : '' }"/>><spring:message code="choice.non"/><br><br>
		<label><spring:message code="user.state"/></label><br>
		<spring:message code="btn.choice"/>:<br>
		<input type='radio' name='s_user_use_state' value='Y' <c:out value="${search.s_user_use_state eq 'Y' ? 'checked=checked' : '' }"/>><spring:message code="state.active"/>
		<input type='radio' name='s_user_use_state' value='N'<c:out value="${search.s_user_use_state eq 'N' ? 'checked=checked' : '' }"/>><spring:message code="state.nonactive"/>
		<input type='radio' name='s_user_use_state' value='' <c:out value="${search.s_user_use_state eq '' ? 'checked=checked' : '' }"/>><spring:message code="choice.non"/><br><br>
		<label><spring:message code="user.regdt"/></label><br>
		<input type='date' name='s_start_dt' value='${search.s_start_dt }'>~ <input type='date' name='s_finish_dt' value='${search.s_finish_dt }'>
		<input type='hidden' name='curPage' value=1>
		<input type='hidden' name='cntPerPage' value='<c:out value="${page.cntPerPage }"/>'>
		
		<button type='submit'><spring:message code="btn.search"/></button>
	</form:form>
	
	
</body>
</html>