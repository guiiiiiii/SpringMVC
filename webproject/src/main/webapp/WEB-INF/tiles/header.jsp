<%@page import="com.neobns.domain.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
	
<link rel="stylesheet" type="text/css" href="../resources/css/common.css">
<link rel="stylesheet" type="text/css" href="../resources/css/home.css">

<div class="header_top_menu">
				<div class="header_title"><a href="/"><spring:message code="site.title"/></a>
					${pageContext.request.contextPath} / ${LoginVO.user_id }</div>
				<sec:authorize access="isAnonymous()">
					<div class="header_menu">
						<a class="btn" href="/user/login"><spring:message code="user.login"/></a> <a class="btn"
							href="/user/register"><spring:message code="user.reg"/></a> 
					</div>
				</sec:authorize>
				
				<sec:authorize access="isAuthenticated()">
					<div class="header_menu">
						<form:form action="${pageContext.request.contextPath}/logout"
							method="POST">
							<input type="submit" class="btn" value='<spring:message code="user.logout"/>' />
						</form:form>

						<a class="btn" href="/user/modify"><spring:message code="user.modify"/></a>

						<sec:authorize access="hasRole('ROLE_ADMIN')">
							<a class="btn" href="/admin/manageUser"><spring:message code="user.manage"/></a>
						</sec:authorize>


					</div>

				</sec:authorize>
			</div>