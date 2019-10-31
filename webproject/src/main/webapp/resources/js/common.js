$(function() {
	
	$('#back').on('click',function(e){
		if($('#atc_title').val().length != 0 || $('#atc_content').val().length != 0){
			var result=confirm("작성된 글은 지워집니다! 확인을 누르면 돌아갑니다");
			if(result ==false) e.preventDefault();
		}
		else{
			alert("목록으로 돌아갑니다");
		}
	});
	
	$('#modify_back').on('click',function(e){
		var result=confirm("수정내역이 지워집니다! 정말로 돌아가시겠습니까?");
		if(result ==false) e.preventDefault();
		
	});
	
	$('.delete').on('click',function(e){
		var result=confirm("정말로 삭제하시겠습니까?");
		if(result == false) e.preventDefault();
	});
	
	
	
	$('#langchange').click(function(){
		var curUrl = $(location).attr('href');
		if (curUrl.search('lang=en') != -1) {
			curUrl=curUrl.replace("en", "ko");
		}
		else if (curUrl.search('lang=ko') != -1) {
			curUrl=curUrl.replace("ko", "en");
		}
		else if (curUrl.search('lang') == -1) {
			if(curUrl.length >40){
				curUrl=curUrl+"&lang=en";
			}else{
			curUrl=curUrl+"?lang=en";
			}
		}
		$('#langchange').attr("href",curUrl);
	});
	

});