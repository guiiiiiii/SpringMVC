function form_validation(form){
	
}

//아이디 유효성 검사
function checkId(inputId){
	var idReg = /^[A-za-z0-9]{4,10}/g;
	var result=0;
		if(!idReg.test(inputId)){
			alert("아이디는 영문자와 숫자를 포함한 4~10자리여야 합니다");
			result=1;
		}else if(inputId.indexOf(" ")>=0){
			alert("아이디에는 공백을 사용할 수 없습니다.");
			result=1;
		}else if(inputId.toLowerCase().indexOf("admin")>=0 ||inputId.toLowerCase().indexOf("user")>=0){
			alert("해당 단어는 아이디로 사용할 수 없습니다");
			result=1;
		}
		return result;
	}

//비밀번호 유효성 검사
function checkPwd(inputPwd){
	var result=0;
	var pwReg = /^[A-za-z0-9]{8,20}/g;
	if(!pwReg.test(inputPwd)){
		alert("비밀번호는 영문자와 숫자만 사용한 8~20자리여야 합니다");
		result=1;
	}else if(/(\w)\1\1\1/.test(inputPwd)){
		alert("같은 문자를 4번이상 연속하여 사용할 수 없습니다");
		result=1;
	}
	return result;
}

//글작성 내 태그사용 검사
function checkContentField(inputContent){
	var scriptText = /(<([^>]+)>)/ig;
	var newtext = inputContent.replace(scriptText,'');
	return newtext;
}
//첨부파일 검사
function checkFileField(filename,filesize){
	var result=0;
	var maxSize = 5242880;
	var ext=filename.split(".").pop().toLowerCase();
	if(ext=='exe' || ext=='jsp' ||ext=='sh'){
		alert("해당 확장자를 가진 파일은 업로드할 수 없습니다");
		result=1;
	}
	if(filesize > maxSize){
		alert("첨부할 수 있는 용량을 초과하였습니다");
		result=1;
	}
	return result;
}



$(function() {
	var idReg = /^[A-za-z0-9]{4,10}/g;
	var pwReg = /^[A-za-z0-9]{8,20}/g;
	var nmReg = /^[가-힣]+$/;
	var scriptText = /(<([^>]+)>)/ig;

	
	$('#regForm').submit(function(){
		
		if($('#user_id').val().length!=0){
			if(checkId($('#user_id').val())!=0){
				$('#user_id').focus();
				return false;
			}
		}
		if($('#user_pw').val().length!=0){
			if(checkPwd($('#user_pw').val())!=0){
				$('#user_pw').focus();
				return false;
			}
		}
		if($('#user_id').val()==$('#user_pw').val()){
			alert("아이디와 비밀번호는 일치할 수 없습니다");
			$('#user_id').focus();
			return false;
		}
		if($('[name="user_name"]').val().length<2){
			alert("이름은 두 자 이상 입력해야 합니다");
			return false;
		}
		return false;
	});
	
	$('#modifyForm').submit(function(){
		if($('#cur_user_pw').val()==$('#user_pw').val()){
			alert("같은 비밀번호로 변경할 수 없습니다");
			return false;
		}
		if($('#user_pw').val().length!=0){
			if(checkPwd($('#user_pw').val())!=0){
				$('#user_pw').focus();
				return false;
			}
		}
		if($('#user_pw').val()!=$('#pw_confirm').val()){
			alert("정보가 일치하지 않습니다");
			$('#pw_confirm').empty();
			$('#pw_confirm').focus();
			return false;
		}
		
		
		return true;
	});

	
	
	
	//수정 및 작성 폼 검사
	$('.writeForm').submit(function(){
		var maxSize = 5242880;
		
		if($('#atc_content').val().length!=0){
			var newcontent=checkContentField($('#atc_content').val());
			$('#atc_content').val(newcontent);
		}
		
		if($('#file').val().length!=0){
			if(checkFileField($('#file').val(),$('#file').size())!=0){
				return false;
			}
		}
		return true;
	
	});

});