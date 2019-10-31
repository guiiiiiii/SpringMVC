$(function() {
	$('#자유게시판').attr("href","/article/list?s_atc_type=CD0101")
	$('#공지사항').attr("href","/article/list?s_atc_type=CD0103")
	$('#자료실').attr("href","/article/list?s_atc_type=CD0104")
	$('#질답게시판').attr("href","/article/list?s_atc_type=CD0102")

	$('#showBtn').click(function(){
		$('#detailSearch').toggle();
		$('[name="form"]').toggle();
	});

	
});