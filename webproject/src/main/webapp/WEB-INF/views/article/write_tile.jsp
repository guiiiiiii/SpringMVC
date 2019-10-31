<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Write</title>
</head>
<body>

<h1>write</h1>

<form:form role='form' name='form' action='/article/write' method='post'  OnSubmit='return check()'>
	<select name='atc_type'>
		<option value='CD0101' selected>자유게시판</option>
		<option value='CD0102'>질답게시판</option>
		<option value='CD0103'>공지사항</option>
		<option value='CD0104'>자료실</option>
	</select> <br>
	<label>Title</label> 
		<input name='atc_title'> <br>
	<label>Textarea</label>
		<textarea rows="3" name='atc_content'></textarea><br>

	<label>Writer</label> 
		<input name='atc_writer'>
	<!-- value='<sec:authentication property="principal.username"/>' readonly="readonly"> -->
	<br>
	 <button type="submit">Submit Button</button>
     <button type="reset" >Reset Button</button>

</form:form>


<script>
function check(){
	with(document.form){
		if(atc_title.value.length==0){
			alert("제목을 입력해주세요");
			atc_title.focus();
			return false;
		}
		if(atc_content.value.length==0){
			alert("제목을 입력해주세요");
			atc_content.focus();
			return false;
		}
		
		document.form.submit();
	}
}
</script>