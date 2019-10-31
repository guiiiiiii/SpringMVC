package com.neobns.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class SearchUserVO{
	private String s_user_id;
	private String s_user_name;
	private String s_user_gender;
	private String s_user_use_state;
	private String s_start_dt;
	private String s_finish_dt;
	
	public String getListLink() {
		UriComponentsBuilder builder= UriComponentsBuilder.fromPath("")
				.queryParam("s_user_id", this.getS_user_id())
				.queryParam("s_user_name", this.getS_user_name())
				.queryParam("s_user_gender", this.getS_user_gender())
				.queryParam("s_user_use_state", this.getS_user_use_state())
				.queryParam("s_start_dt", this.getS_start_dt())
				.queryParam("s_finish_dt", this.getS_finish_dt());
		
		return builder.toUriString();
	}
}