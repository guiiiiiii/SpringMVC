$(function() {		
	$('#user_pw').keyup(function() {
		$('#chkNotice').html('');
		if ($('#user_pw_confirm').val() != "") {

			if ($('#user_pw').val() != $('#user_pw_confirm').val()) {
				$('#chk_pw').html('일치하지 않음<br><br>');
				$('#chk_pw').attr('color', '#ff0000');
				$('#submit').attr("disabled", "disabled");
			} else {
				$('#chk_pw').html('일치<br><br>');
				$('#chk_pw').attr('color', '#199894b3');
				$('#submit').removeAttr("disabled");
			}
		}
	});

	$('#user_pw_confirm').keyup(function() {
		if ($('#user_pw').val() != $('#user_pw_confirm').val()) {
			$('#chk_pw').html('일치하지 않음<br><br>');
			$('#chk_pw').attr('color', '#ff0000');
			$('#submit').attr("disabled", "disabled");
		} else {
			$('#chk_pw').html('일치<br><br>');
			$('#chk_pw').attr('color', '#199894b3');
			$('#submit').removeAttr("disabled");
		}
	});


});